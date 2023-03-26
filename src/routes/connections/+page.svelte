<script>
  import Connections from '../../atomic/organisms/connections/Connections.svelte';

  import CreateConnection from '../../atomic/molecules/connections/Create.svelte';
  import Modal from '../../atomic/molecules/Modal.svelte';

  let connectionModal = undefined;

  const createConnection = () => {
    if (connectionModal === undefined) return;

    connectionModal.open(Date.now());
  };
</script>

<div class="container">
  <h1>Connections</h1>

  <div class="actions">
    <button on:click={createConnection} type="button" class="btn btn-primary"
      >Create Connection</button
    >

    <Modal title="New Connection" size="lg" bind:this={connectionModal} let:data>
      <CreateConnection at={data} />
    </Modal>
  </div>

  <Connections />
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
