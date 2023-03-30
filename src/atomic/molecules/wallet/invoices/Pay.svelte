<script>
  import Cookies from 'js-cookie';

  import { onMount } from 'svelte';
  import { nanoid } from 'nanoid';

  import CopyableAtom from '../../../atoms/Copyable.svelte';
  import Success from '../../../atoms/states/Success.svelte';
  import FlowError from '../../../atoms/states/flow/Error.svelte';
  import FlowPending from '../../../atoms/states/flow/Pending.svelte';
  import FlowLoading from '../../../atoms/states/flow/Loading.svelte';
  import NumberAtom from '../../../atoms/Number.svelte';

  import PaymentProof from '../payments/PaymentProof.svelte';

  import HorizontalInvoice from './HorizontalInvoice.svelte';

  import Nitrox from '../../../../components/nitrox';

  export let at;
  export let modalElement = undefined;

  export let callback = undefined;

  let state = undefined;

  const paymentTemplate = {
    code: undefined,
    message: null,
    amount: {
      millisatoshis: undefined
    },
    fee: {
      maximum: { millisatoshis: 0 }
    }
  };

  let newPayment = JSON.parse(JSON.stringify(paymentTemplate));

  let idempotencyKey = undefined;

  let flowState = undefined;

  const prepare = () => {
    newPayment = JSON.parse(JSON.stringify(paymentTemplate));
    state = 'prepare';
    flowState = undefined;
  };

  $: {
    if (at) prepare();
  }

  let baseUrl = undefined;

  const submitForm = async () => {
    if (state === 'prepare') {
      await decodeInvoice();
    } else if (state === 'decoded') {
      await payInvoice();
    }
  };

  let decodedInvoice = undefined;

  const decodeInvoice = async () => {
    if (baseUrl === undefined) {
      baseUrl = `${await Nitrox.service('send')}`;
    }

    state = 'loading';

    const headers = {
      'Content-Type': 'application/json',
      'Nitrox-Connection-Id': Cookies.get('connection')
    };

    const response = await fetch(`${baseUrl}/invoices/${newPayment.code}`, {
      method: 'GET',
      headers: headers
    });

    if(![200, 201].includes(response.status)) {
        state = 'decodeError';
    } else {
      decodedInvoice = await response.json();

      if (decodedInvoice.amount && decodedInvoice.amount.millisatoshis !== 0) {
        newPayment.amount.millisatoshis = decodedInvoice.amount.millisatoshis;
      } else {
        newPayment.amount.millisatoshis = null;
        decodedInvoice.amount = null;
      }

      idempotencyKey = nanoid(20);

      state = 'decoded';
    }
  };

  const payInvoice = async () => {
    if (baseUrl === undefined) {
      baseUrl = `${await Nitrox.service('send')}`;
    }
    state = 'loading';

    if (newPayment.amount.millisatoshis !== null) {
      newPayment.amount.millisatoshis = parseInt(newPayment.amount.millisatoshis, 10);
    }

    if (decodedInvoice.amount !== null) {
      newPayment.amount = null;
    }

    if (newPayment.fee.maximum.millisatoshis !== null) {
      newPayment.fee.maximum.millisatoshis = parseInt(newPayment.fee.maximum.millisatoshis, 10);
    }

    const headers = {
      'Content-Type': 'application/json',
      'Idempotency-Key': idempotencyKey,
      'Nitrox-Connection-Id': Cookies.get('connection')
    };

    const body = { invoice: newPayment };

    const response = await fetch(`${baseUrl}/invoices/pay`, {
      method: 'PUT',
      headers: headers,
      body: JSON.stringify(body)
    });

    if(![200, 201].includes(response.status)) {
      state = 'pending';
    } else {
      const result = await response.json();

      const sleep = (s) => new Promise((r) => setTimeout(r, s * 1000));

      const startedAt = performance.now();
      const seconds = 5;

      while (state === 'loading' && performance.now() - startedAt < seconds * 1000) {
        const response = await fetch(`${baseUrl}/invoices/pay/state`, {
          method: 'GET',
          headers: headers
        });

        if(![200, 201].includes(response.status)) {
          state = 'pending';
        } else {
          flowState = await response.json();

          if (flowState.state === 'pending') {
            await sleep(0.25);
          } else {
            state = flowState.state;
          }
        }
      }

      if (state === 'loading') state = 'pending';
    }

    if(callback) callback();
  };

  let previousCode = newPayment.code;

  const onCodeKeyUp = () => {
    if (previousCode !== newPayment.code) {
      if (newPayment.code && newPayment.code.replace('lightning:', '').length > 200) {
        decodeInvoice();
      } else {
        state = 'prepare';
      }
      previousCode = newPayment.code;
    }
  };

  let ppm = null;

  const updatePPM = (amount, fee) => {
    if (amount === null || amount === '' || amount === 0 || amount === '0') {
      return null;
    }

    if (fee === null || fee === '' || fee === 0 || fee === '0') {
      return 0;
    }

    return (parseFloat(parseInt(fee, 10)) / parseFloat(parseInt(amount, 10))) * 1000000.0;
  };

  const onMaximumFeeUpdate = () => {
    ppm = updatePPM(newPayment.amount.millisatoshis, newPayment.fee.maximum.millisatoshis);
  };
</script>

{#if state === 'loading'}
  <div class="state">
    <FlowLoading fleeting={flowState} message="Processing payment..." />
  </div>
{:else if state === 'pending'}
  <div class="state">
    <FlowPending
      fleeting={flowState}
      message="Payment is still in progress..."
      instruction="Please check your Send list in a few moments."
    />
  </div>
{:else if state === 'success'}
  <div class="state">
    <Success message="Invoice successfully paid!" />

    <PaymentProof payment={flowState.success.result} {modalElement} />
  </div>
{:else if state === 'decodeError'}
  <div class="state">
    <FlowError message="Unable to decode invoice. Please ensure it's valid." />

    {#if newPayment.code}
      <div class="copyable">
        <CopyableAtom cssClass="text-danger" content={newPayment.code} {modalElement} />
      </div>
    {/if}

    <div class="text-center border-top actions">
      <button on:click={prepare} type="submit" class="btn btn-primary">Try Again</button>
    </div>
  </div>
{:else if state === 'error'}
  <div class="state">
    <FlowError
      fleeting={flowState}
      message="Sorry, your payment failed."
      instruction="Check your Send list for more information about the error."
    />
  </div>
{:else if state === 'prepare' || state === 'decoded'}
  <form on:submit|preventDefault={submitForm}>
    {#if state === 'prepare'}
      <div class="mb-3">
        <label for="code" class="form-label">Code</label>
        <input
          tabindex="1"
          on:keyup={onCodeKeyUp}
          bind:value={newPayment.code}
          placeholder="lnbc20m1pv..."
          type="text"
          class="form-control"
          id="code"
          aria-describedby="codeHelp"
        />
        <div id="codeHelp" class="form-text">
          The Invoice Code, which is a unique identifier similar to <code
            >lnbc20m1pv...qqdhhwkj<code />.
          </code>
        </div>
      </div>
    {:else if state === 'decoded'}
      <HorizontalInvoice invoice={decodedInvoice} modalElement={modalElement} />

      <div class="row">
        <div class="col">
          <div class="mb-3">
            <label for="millisatoshis" class="form-label">Amount</label>
            <div class="input-group mb-3">
              <input
                tabindex="2"
                disabled={decodedInvoice.amount !== null}
                on:keyup={onMaximumFeeUpdate}
                on:change={onMaximumFeeUpdate}
                bind:value={newPayment.amount.millisatoshis}
                placeholder="1000"
                type="text"
                class="form-control"
                id="millisatoshis"
                aria-describedby="millisatoshisHelp"
              />
              {#if newPayment.amount.millisatoshis}
                <span class="input-group-text" id="basic-addon2">
                  <NumberAtom value={newPayment.amount.millisatoshis} round={true} />
                </span>
              {/if}
            </div>
            <div id="millisatoshisHelp" class="form-text">
              The amount in <strong>millisatoshis</strong> that you intend to pay for the invoice.
            </div>
          </div>
          <div class="mb-3">
            <label for="message" class="form-label">Message</label>
            <input
              tabindex="4"
              bind:value={newPayment.message}
              type="text"
              class="form-control"
              id="message"
              aria-describedby="messageHelp"
            />
            <div id="messageHelp" class="form-text">
              Allows you to attach an optional message to your payment, which can be read by the
              person receiving the payment.
            </div>
          </div>
        </div>
        <div class="col">
          <div class="mb-3">
            <label for="maximumFee" class="form-label">Maximum Fee</label>

            <div class="input-group mb-3">
              <input
                tabindex="3"
                bind:value={newPayment.fee.maximum.millisatoshis}
                placeholder="1000"
                on:keyup={onMaximumFeeUpdate}
                on:change={onMaximumFeeUpdate}
                type="text"
                class="form-control"
                id="maximumFee"
                aria-describedby="maximumFeeHelp"
              />
              <span class="input-group-text" id="basic-addon2">
                {#if ppm !== null}<NumberAtom value={ppm} round={true} />{:else}0{/if}&nbsp;PPM
              </span>
            </div>
            <div id="maximumFeeHelp" class="form-text">
              Indicates the maximum amount in <strong>millisatoshis</strong> that you are willing to
              pay as a transaction fee. PPM stands for "parts per million," which is a common measure
              used for calculating fees.
            </div>
          </div>
        </div>
      </div>
    {/if}
    {#if state !== 'decoded'}
      <div class="text-center border-top actions">
        <button tabindex="5" type="submit" class="btn btn-primary">Decode</button>
      </div>
    {:else}
      <div class="text-center border-top actions">
        <button tabindex="5" type="submit" class="btn btn-primary">Pay Invoice</button>
      </div>
    {/if}
  </form>
{/if}

<style>
  /*.state {
  margin-bottom: 1.6em;
}*/

  .actions {
    padding-top: 1em;
  }

  .copyable {
    margin-bottom: 1em;
  }
</style>
