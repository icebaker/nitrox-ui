<script>
  import Invoices from '../../../atomic/organisms/wallet/invoices/Invoices.svelte';
  import CreateInvoice from '../../../atomic/molecules/wallet/invoices/Create.svelte';
  import Modal from '../../../atomic/molecules/Modal.svelte';

  let invoiceModal = undefined;

  const createInvoice = () => {
    if (invoiceModal === undefined) return;

    invoiceModal.open(Date.now());
  };
</script>

<div class="container">
  <h1>Receive</h1>

  <div class="actions">
    <button on:click={createInvoice} type="button" class="btn btn-primary">Create Invoice</button>

    <Modal title="New Invoice" size="lg" bind:this={invoiceModal} let:data>
      <CreateInvoice at={data} />
    </Modal>
  </div>

  <Invoices />
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
