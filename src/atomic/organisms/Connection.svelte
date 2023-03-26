<script>
  import Cookies from 'js-cookie';

  import FilterableData from '../molecules/FilterableData.svelte';

  import NodeAtom from '../atoms/Node.svelte';

  import Modal from '../molecules/Modal.svelte';
  import SwitchConnection from '../molecules/connections/Switch.svelte';

  let switchModal = undefined;

  const switchConnection = (connection) => {
    if (switchModal) switchModal.open(connection);
  };

  let tooltipElement = undefined;

  const applyTooltip = () => {
    setTimeout(() => {
      if (tooltipElement) new bootstrap.Tooltip(tooltipElement);
    }, 0);
    return '';
  };

  let connection_id = Cookies.get('connection');

  if (connection_id) {
    connection_id = connection_id.replace(/@.*/, '');
  } else {
    connection_id = '';
  }
</script>

<FilterableData
  service="nitrox-connector"
  path="/nodes/myself"
  loader="discreet"
  filterable={false}
  lean={true}
  seconds={5 * 60}
  let:data={node}
>
  <div slot="failure" class="node error text-danger-emphasis font-monospace" let:failure>
    <div class="error text-center">
      <i class="bi bi-wifi-off text-danger-emphasis" />
      {connection_id}

      {#if connection_id}
        <p class="message fst-italic text-danger-emphasis">
          {failure.response.data.error}:
          {failure.response.data.message}
        </p>
      {:else}
        <p class="message">
          <a class="text-danger-emphasis" href="/connections">No connection configured yet.</a>
        </p>
      {/if}
    </div>
  </div>

  <div slot="data">
    <div class="node text-secondary font-monospace">
      <div class="version">
        {node.platform.lightning.implementation}
        {node.platform.lightning.version}
        {node.platform.blockchain}/{node.platform.network}
      </div>
      <div class="alias">
        <NodeAtom {node} small={false} color="link-secondary" underline={false} />
        <button
          on:click={switchConnection}
          type="button"
          bind:this={tooltipElement}
          data-bs-toggle="tooltip"
          data-bs-title={Cookies.get('connection')}
          class="btn btn-outline-info btn-sm"
        >
          <i class="bi bi-phone-flip" />
        </button>
      </div>
    </div>
    {applyTooltip()}
  </div>
</FilterableData>

<Modal title="Switch Connection" size="md" bind:this={switchModal}>
  <SwitchConnection />
</Modal>

<style>
  .node {
    /*  font-size: .9em;*/
    text-align: center;
  }

  .circle {
    display: inline-block;
    border-radius: 50%;
    width: 0.6em;
    height: 0.6em;
    border: 1px solid #888;
    vertical-align: middle;
    margin-right: 0.1em;
  }

  .alias {
    margin-top: 0.6em;
  }

  .alias a {
    text-decoration: none;
  }

  .alias a:hover {
    text-decoration: underline;
  }

  .error .message {
    font-size: 0.8em;
  }
</style>
