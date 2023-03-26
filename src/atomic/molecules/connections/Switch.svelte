<script>
  import Cookies from 'js-cookie';

  import TimeAtom from '../../atoms/Time.svelte';
  import NodeAtom from '../../atoms/Node.svelte';
  import MilliSatsAtom from '../../atoms/MilliSats.svelte';
  import NumberAtom from '../../atoms/Number.svelte';
  import ShortenerAtom from '../../atoms/Shortener.svelte';

  import FilterableData from '../../molecules/FilterableData.svelte';

  const switchConnection = (connectionId) => {
    Cookies.set('connection', connectionId);
    window.location.reload();
  };
</script>

<FilterableData
  service="nitrox-connector"
  path="/connections"
  lean={true}
  filterable={false}
  seconds={30}
  let:data
>
  <table slot="data" class="table text-center table-hover">
    <thead>
      <tr>
        <th scope="col">Name</th>
        <th scope="col">Address</th>
        <th scope="col">Node</th>
        <th scope="col" />
      </tr>
    </thead>
    <tbody>
      {#if data.default}
        <tr>
          <td class="fst-italic">default</td>
          <td>{data.default.state.address}</td>
          <td>
            {#if data.default.error}
              <code>{data.default.error.class}</code>
            {:else}
              <NodeAtom node={data.default.node} />
            {/if}
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
        </tr>
      {/if}
      {#each data.items as connection (`connection-${connection._key}}`)}
        <tr>
          <td>{connection.config.name}</td>
          <td>{connection.state ? connection.state.address : connection.config.address}</td>
          <td>
            {#if connection.error}
              <code>{connection.error.class}</code>
            {:else}
              <NodeAtom node={connection.node} />
            {/if}
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
        </tr>
      {/each}
    </tbody>
  </table>
</FilterableData>

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
