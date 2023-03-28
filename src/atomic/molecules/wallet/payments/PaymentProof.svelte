<script>
  import { onMount } from 'svelte';

  import TimeAtom from '../../../atoms/Time.svelte';
  import NodeAtom from '../../../atoms/Node.svelte';
  import Copyable from '../../../atoms/Copyable.svelte';

  import MilliSatsAtom from '../../../atoms/MilliSats.svelte';
  import ThroughAtom from '../../../atoms/payments/Through.svelte';
  import HowAtom from '../../../atoms/payments/How.svelte';
  import AmountAtom from '../../../atoms/invoice/AmountKind.svelte';
  import PurposeAtom from '../../../atoms/payments/Purpose.svelte';

  export let payment;
  export let modalElement;

  let proofElement;
  let copyState = 'waiting';

  $: {
    if (payment) copyState = 'waiting';
  }

  onMount(() => {
    if (proofElement) {
      new bootstrap.Tooltip(proofElement);
      const clipboard = new ClipboardJS(proofElement, { container: modalElement });

      clipboard.on('success', function () {
        copyState = 'done';
        setTimeout(() => {
          copyState = 'waiting';
        }, 1500);
      });
    }
  });
</script>

<table class="table table-hover text-start">
  <tbody>
    <tr>
      <th scope="col" class="text-end">At</th>
      <td><TimeAtom at={payment.at} /></td>
      <th scope="col" class="text-end">Purpose</th>
      <td><PurposeAtom purpose={payment.purpose} label={true} /></td>
    </tr>
    <tr>
      <th scope="col" class="text-end">Amount</th>
      <td><MilliSatsAtom milli={payment.amount.millisatoshis} /></td>
      <th scope="col" class="text-end">How</th>
      <td><HowAtom how={payment.how} label={true} /></td>
    </tr>
    <tr>
      <th scope="col" class="text-end">Destination</th>
      <td><NodeAtom node={payment.to.channel.target} /></td>
      <th scope="col" class="text-end">Through</th>
      <td><ThroughAtom through={payment.through} label={true} /></td>
    </tr>
  </tbody>
</table>

{#if payment.how === 'with-invoice'}
  <div class="invoice">
    <Copyable
      label="Invoice Code"
      content={payment.invoice.code}
      {modalElement}
      caption="invoice code"
    />
  </div>
{/if}

<p>
  After completing a payment, the seller may ask for a "proof of payment" or "preimage." Here it is:
</p>

<div class="proof">
  <Copyable
    label="Proof"
    content={payment.secret.proof}
    cssClass="text-success"
    {modalElement}
    caption="preimage proof of payment"
  />
</div>

<div class="alert alert-warning text-center" role="alert">
  Share this code only with the person you paid, as sharing with others might lead to loss of funds
  or unauthorized access to your payment details.
</div>

<style>
  p {
    padding: 1em;
  }

  .alert {
    margin: 0 1em 0.6em 1em;
  }

  .proof,
  .invoice {
    padding: 0 1em;
    margin-bottom: 1.8em;
  }

  .invoice {
    margin-top: 2em;
    margin-bottom: 0.8em;
  }
</style>
