<script>
  import Cookies from 'js-cookie';

  import TimeAtom from '../../atoms/Time.svelte';
  import NodeAtom from '../../atoms/Node.svelte';
  import MilliSatsAtom from '../../atoms/MilliSats.svelte';
  import NumberAtom from '../../atoms/Number.svelte';
  import EmptyAtom from '../../atoms/Empty.svelte';
  import ShortenerAtom from '../../atoms/Shortener.svelte';
  import FleetingDetails from '../../molecules/fleeting/Details.svelte';

  import Liquidity from '../../atoms/Liquidity.svelte';

  import FilterableData from '../../molecules/FilterableData.svelte';

  import Modal from '../../molecules/Modal.svelte';
  import RemoveConnection from '../../molecules/connections/Remove.svelte';
  import Connection from '../../molecules/connections/Connection.svelte';

  let fleetingModal = undefined;
  let removeModal = undefined;
  let connectionModal = undefined;

  const removeConnection = (connection, reload) => {
    if (removeModal) removeModal.open({ connection: connection, callback: reload });
  };

  const inspectConnection = (connection) => {
    if (connectionModal) connectionModal.open(connection);
  };

  const switchConnection = (connectionId) => {
    Cookies.set('connection', connectionId);
    window.location.reload();
  };

  const openError = (error) => {
    if (fleetingModal) fleetingModal.open({ error: error });
  };
</script>

<FilterableData
  service="nitrox-connector"
  path="/connections"
  filterable={false}
  seconds={30}
  let:data
  let:reload
>
  <div slot="data">
    {#if !data.default && data.items.length === 0}
      <EmptyAtom
        message="Establish multiple connections to your nodes and effortlessly switch between them."
      />
    {:else}
      <table class="table text-center table-hover">
        <thead>
          <tr>
            <th scope="col">Name</th>
            <th scope="col">Config</th>
            <th scope="col">Address</th>
            <th scope="col">Node</th>
            <th scope="col">Network</th>
            <th scope="col">Public Key</th>
            <th width="1" scope="col" />
            <th width="1" scope="col" />
            <th width="1" scope="col" />
            <th width="1" scope="col" />
          </tr>
        </thead>
        <tbody>
          {#if data.default}
            <tr>
              <td class="fst-italic">default</td>
              <td>ENV</td>
              <td>{data.default.state.address}</td>
              {#if data.default.error}
                <td colspan="3" class="text-end">
                  <code>{data.default.error.class}</code>
                  | <span class="text-danger-emphasis">Error</span>
                </td>
              {:else}
                <td><NodeAtom node={data.default.node} /></td>
                <td>
                  {#if data.default.node}
                    {data.default.node.platform.blockchain}/{data.default.node.platform.network}
                  {/if}
                </td>
                <td>
                  {#if data.default.node}
                    <ShortenerAtom hash={data.default.node.public_key} limit={30} />
                  {/if}
                </td>
              {/if}
              <td>
                {#if data.default.error}
                  <button
                    on:click={openError(data.default.error)}
                    type="button"
                    class="btn btn-outline-secondary btn-sm"
                  >
                    <i class="bi bi-bug" />
                  </button>
                {/if}
              </td>
              <td>
                <button
                  on:click={inspectConnection(data.default)}
                  type="button"
                  class="btn btn-outline-secondary btn-sm"
                >
                  <i class="bi bi-gear-fill" />
                </button>
              </td>
              <td>
                <button
                  on:click={switchConnection(data.default.id)}
                  type="button"
                  class="btn btn-outline-success btn-sm"
                >
                  <i class="bi bi-arrow-right-circle" />
                </button>
              </td>
              <td>
                <button type="button" disabled="true" class="btn btn-outline-secondary btn-sm">
                  <i class="bi bi-trash3" />
                </button>
              </td>
            </tr>
          {/if}
          {#each data.items as connection (`connection-${connection._key}}`)}
            <tr>
              <td>{connection.config.name}</td>
              <td>{connection.config.kind}</td>
              <td>{connection.state ? connection.state.address : connection.config.address}</td>
              {#if connection.error}
                <td colspan="3" class="text-end">
                  <code>{connection.error.class}</code>
                  | <span class="text-danger-emphasis">Error</span>
                </td>
              {:else}
                <td><NodeAtom node={connection.node} /></td>
                <td>
                  {connection.node.platform.blockchain}/{connection.node.platform.network}
                </td>
                <td>
                  <ShortenerAtom hash={connection.node.public_key} limit={30} />
                </td>
              {/if}
              <td>
                {#if connection.error}
                  <button
                    on:click={openError(connection.error)}
                    type="button"
                    class="btn btn-outline-secondary btn-sm"
                  >
                    <i class="bi bi-bug" />
                  </button>
                {/if}
              </td>
              <td>
                <button
                  on:click={inspectConnection(connection)}
                  type="button"
                  class="btn btn-outline-secondary btn-sm"
                >
                  <i class="bi bi-gear-fill" />
                </button>
              </td>
              <td>
                <button
                  on:click={switchConnection(connection.id)}
                  type="button"
                  class="btn btn-outline-success btn-sm"
                >
                  <i class="bi bi-arrow-right-circle" />
                </button>
              </td>
              <td>
                <button
                  on:click={removeConnection(connection, reload)}
                  type="button"
                  class="btn btn-outline-danger btn-sm"
                >
                  <i class="bi bi-trash3" />
                </button>
              </td>
            </tr>
          {/each}
        </tbody>
      </table>
    {/if}

    {#if data.default && data.items.length === 0}
      <EmptyAtom
        message="Establish multiple connections to your nodes and effortlessly switch between them."
      />
    {/if}
  </div>
</FilterableData>

<Modal title="Are you sure?" size="md" bind:this={removeModal} let:data>
  {#if data !== undefined}
    <RemoveConnection connection={data.connection} callback={data.callback} />
  {/if}
</Modal>

<Modal title="Connection Details" size="xl" bind:this={connectionModal} let:data>
  {#if data !== undefined}
    <Connection connection={data} />
  {/if}
</Modal>

<Modal title="Connection Error" size="lg" bind:this={fleetingModal} let:data>
  {#if data !== undefined}
    <FleetingDetails fleeting={data} />
  {/if}
</Modal>

<style>
  .direction {
    margin: 0 0.6em;
  }

  .in {
    padding-right: 2em;
  }

  .out {
    padding-left: 2em;
  }
</style>
