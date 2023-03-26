<script>
  import Payments from '../../../atomic/organisms/wallet/payments/Payments.svelte';

  import PayInvoice from '../../../atomic/molecules/wallet/invoices/Pay.svelte';
  import Modal from '../../../atomic/molecules/Modal.svelte';

  let payInvoiceModal = undefined;

  const payInvoice = () => {
    if (payInvoiceModal === undefined) return;

    payInvoiceModal.open(Date.now());
  };
</script>

<div class="container">
  <h1>Send</h1>

  <div class="actions">
    <button on:click={payInvoice} type="button" class="btn btn-primary">Pay Invoice</button>

    <Modal title="Pay Invoice" size="lg" bind:this={payInvoiceModal} let:data>
      <PayInvoice at={data} />
    </Modal>
  </div>

  <Payments />
</div>

<style>
  h1 {
    margin-top: -1.4em;
    margin-bottom: 1em;
  }

  .container {
    margin-bottom: 4em;
  }

  .actions {
    margin-bottom: -2em;
  }
</style>
