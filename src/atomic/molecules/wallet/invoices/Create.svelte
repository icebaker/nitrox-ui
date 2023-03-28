<script>
  import Cookies from 'js-cookie';

  import { nanoid } from 'nanoid';

  import Success from '../../../atoms/states/Success.svelte';
  import FlowError from '../../../atoms/states/flow/Error.svelte';
  import FlowPending from '../../../atoms/states/flow/Pending.svelte';
  import FlowLoading from '../../../atoms/states/flow/Loading.svelte';

  import Nitrox from '../../../../components/nitrox';

  export let at;
  export let openAmount = false;

  let state = undefined;

  const invoiceTemplate = {
    description: { memo: null },
    payable: 'once',
    amount: { millisatoshis: null },
    expires_in: { hours: 24 }
  };

  let newInvoice = JSON.parse(JSON.stringify(invoiceTemplate));

  let idempotencyKey = undefined;

  let flowState = undefined;

  const prepare = () => {
    newInvoice = JSON.parse(JSON.stringify(invoiceTemplate));
    idempotencyKey = nanoid(20);
    state = 'prepare';
    flowState = undefined;
  };

  $: {
    if (at) prepare();
  }

  let baseUrl = undefined;

  const createInvoice = async () => {
    if (baseUrl === undefined) {
      baseUrl = `${await Nitrox.service('receive')}`;
    }
    state = 'loading';

    if (openAmount) {
      newInvoice.amount.millisatoshis = null;
    } else {
      newInvoice.amount.millisatoshis = parseInt(newInvoice.amount.millisatoshis, 10);
    }

    newInvoice.expires_in.hours = parseInt(newInvoice.expires_in.hours, 10);

    const headers = {
      'Content-Type': 'application/json',
      'Idempotency-Key': idempotencyKey,
      'Nitrox-Connection-Id': Cookies.get('connection')
    };

    const body = { invoice: newInvoice };

    const response = await fetch(`${baseUrl}/invoices`, {
      method: 'PUT',
      headers: headers,
      body: JSON.stringify(body)
    });

    const result = await response.json();

    const sleep = (s) => new Promise((r) => setTimeout(r, s * 1000));

    const startedAt = performance.now();
    const seconds = 5;

    while (state === 'loading' && performance.now() - startedAt < seconds * 1000) {
      const response = await fetch(`${baseUrl}/invoices/state`, {
        method: 'GET',
        headers: headers
      });

      flowState = await response.json();

      if (flowState.state === 'pending') {
        await sleep(0.25);
      } else {
        state = flowState.state;
      }
    }

    if (state === 'loading') state = 'pending';
  };

  let previousValue = null;

  const openAmountChanged = (e) => {
    if (!openAmount) {
      previousValue = newInvoice.amount.millisatoshis;
      newInvoice.amount.millisatoshis = null;
    } else {
      newInvoice.amount.millisatoshis = previousValue;
    }
  };
</script>

{#if state === 'loading'}
  <div class="state">
    <FlowLoading fleeting={flowState} message="Creating invoice..." />
  </div>
{:else if state === 'pending'}
  <div class="state">
    <FlowPending
      fleeting={flowState}
      message="Creation is still in progress..."
      instruction="Please check your Receive list in a few moments."
    />
  </div>
{:else if state === 'success'}
  <div class="state">
    <Success message="Invoice successfully created!" />
  </div>
{:else if state === 'error'}
  <div class="state">
    <FlowError
      fleeting={flowState}
      message="Sorry, your payment failed."
      instruction="Check your Send list for more information about the error."
    />
  </div>
{:else if state === 'prepare'}
  <form on:submit|preventDefault={createInvoice}>
    <div class="row">
      <div class="col">
        <div class="mb-3">
          <label for="description" class="form-label">Description</label>
          <input
            bind:value={newInvoice.description.memo}
            placeholder="Coffee"
            type="text"
            class="form-control"
            id="description"
            aria-describedby="descriptionHelp"
          />
          <div id="descriptionHelp" class="form-text">
            An optional brief description to help both you and the payer identify what this invoice
            is about.
          </div>
        </div>
        <div class="mb-3">
          <label for="millisatoshis" class="form-label">Amount</label>
          <input
            disabled={openAmount}
            bind:value={newInvoice.amount.millisatoshis}
            placeholder={openAmount ? '-' : 1000}
            type="text"
            class="form-control"
            id="millisatoshis"
            aria-describedby="millisatoshisHelp"
          />

          <div class="form-check open-amount">
            <input
              on:change={openAmountChanged}
              bind:checked={openAmount}
              class="form-check-input"
              type="checkbox"
              value=""
              id="openAmount"
            />
            <label class="form-check-label" for="openAmount"> Open Amount </label>
          </div>
          <div id="millisatoshisHelp" class="form-text">
            Amount you will receive in <strong>millisatoshis</strong> for the Invoice. If "Open Amount"
            is selected, the payer will decide how much to pay.
          </div>
        </div>
      </div>
      <div class="col">
        <div class="mb-3">
          <label for="millisatoshis" class="form-label" aria-describedby="payableHelp">
            Payable
          </label>

          <div class="form-check">
            <input
              bind:group={newInvoice.payable}
              value="once"
              id="once"
              name="once"
              class="form-check-input"
              type="radio"
            />
            <label class="form-check-label" for="once"> Once </label>
          </div>
          <div class="form-check">
            <input
              bind:group={newInvoice.payable}
              value="indefinitely"
              id="indefinitely"
              name="indefinitely"
              class="form-check-input"
              type="radio"
            />
            <label class="form-check-label" for="indefinitely"> Indefinitely </label>
          </div>

          <div id="payableHelp" class="form-text">
            If "Indefinitely" is selected, the invoice can be paid by multiple people multiple
            times. If "Once" is selected, the invoice can only be paid one time.
          </div>
        </div>
        <div class="mb-3">
          <label for="millisatoshis" class="form-label">Expires In</label>
          <input
            bind:value={newInvoice.expires_in.hours}
            placeholder="24"
            type="text"
            class="form-control"
            id="hours"
            aria-describedby="hoursHelp"
          />

          <div id="hoursHelp" class="form-text">
            Number of <strong>hours</strong> until the invoice expires. After it expires, it will no
            longer be possible to pay.
          </div>
        </div>
      </div>
    </div>
    <div class="text-center border-top actions">
      <button type="submit" class="btn btn-primary">Create</button>
    </div>
  </form>
{/if}

<style>
  .mb-3 {
    /*  padding-bottom: .0em;*/
  }

  .actions {
    padding-top: 1em;
  }

  .open-amount {
    padding-top: 0.2em;
  }
</style>
