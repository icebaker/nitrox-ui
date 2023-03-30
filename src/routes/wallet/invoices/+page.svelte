<script>
  import Invoices from '../../../atomic/organisms/wallet/invoices/Invoices.svelte';
  import CreateInvoice from '../../../atomic/molecules/wallet/invoices/Create.svelte';
  import Modal from '../../../atomic/molecules/Modal.svelte';

  let invoiceModal = undefined;

  let invoicesComponent = undefined;

  const createInvoice = () => {
    if (invoiceModal === undefined) return;

    invoiceModal.open(Date.now());
  };

  const reload = () => {
    if(invoicesComponent) invoicesComponent.reload();
  }
</script>

<div class="container">
  <h1>Receive</h1>

  <div class="actions">
    <button on:click={createInvoice} type="button" class="btn btn-primary">Create Invoice</button>
  </div>

  <Invoices bind:this={invoicesComponent} />
</div>

<Modal title="New Invoice" size="lg" bind:this={invoiceModal} let:data let:modalElement>
  <CreateInvoice at={data} {modalElement} callback={reload} />
</Modal>

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
