<script>
  import TimeAtom from '../../atoms/Time.svelte';

  import NumberAtom from '../../atoms/Number.svelte';

  export let report;

  let state = 'closed';

  const toggleState = () => {
    state = state === 'closed' ? 'open' : 'closed';
  };
</script>

{#if state === 'closed'}
  <td class="border-start"><TimeAtom at={report.status.ports.http.summary.last} /></td>
  <td><NumberAtom value={report.status.ports.http.summary.in.count} /></td>
  <td><NumberAtom value={report.status.ports.http.summary.out.count} /></td>

  <td class="border-start"><TimeAtom at={report.status.ports.redpanda.summary.last} /></td>
  <td><NumberAtom value={report.status.ports.redpanda.summary.in.count} /></td>
  <td><NumberAtom value={report.status.ports.redpanda.summary.out.count} /></td>
{:else}
  {#if report.status.ports.http.out.length + report.status.ports.http.in.length === 0}
    <td colspan="3" class="border-start"> - </td>
  {:else}
    <td colspan="3" class="border-start">
      <table class="table text-center table-hover">
        <thead>
          <tr>
            <th scope="col">path</th>
            <th scope="col">count</th>
            <th scope="col">~ms</th>
          </tr>
        </thead>
        <tbody>
          {#each [...report.status.ports.http.in, ...report.status.ports.http.out, ...report.status.ports.grpc.out] as request (`request-${request.count}-${request.service}-${request.time.average}-${request.direction}-${request.path}`)}
            <tr>
              <td class="text-start">
                {#if request.direction === 'in'}
                  <i class="bi bi-box-arrow-in-right direction text-success-emphasis" />
                {:else}
                  <i class="bi bi-box-arrow-up-right direction text-warning-emphasis" />
                {/if}
                {#if request.service}
                  <code>{request.service}</code>
                  {request.path}
                {:else}
                  {request.path}
                {/if}
              </td>
              <td><NumberAtom value={request.count} /></td>
              <td><NumberAtom value={request.time.average * 1000.0} /></td>
            </tr>
          {/each}
        </tbody>
      </table>
    </td>
  {/if}
  {#if report.status.ports.redpanda.out.length + report.status.ports.redpanda.in.length === 0}
    <td colspan="3" class="border-start"> - </td>
  {:else}
    <td colspan="3" class="border-start">
      <table class="table text-center table-hover">
        <thead>
          <tr>
            <th scope="col">topic</th>
            <th scope="col">count</th>
            <th scope="col">~ms</th>
          </tr>
        </thead>
        <tbody>
          {#each [...report.status.ports.redpanda.in, ...report.status.ports.redpanda.out] as request (`topic-${request.count}-${request.time.average}-${request.direction}-${request.path}`)}
            <tr>
              <td class="text-start text-nowrap">
                {#if request.direction === 'in'}
                  <i class="bi bi-box-arrow-in-down-right direction text-success-emphasis" />
                {:else}
                  <i class="bi bi-box-arrow-up-right direction text-warning-emphasis" />
                {/if}
                <code>{request.path}</code>
              </td>
              <td><NumberAtom value={request.count} /></td>
              <td><NumberAtom value={request.time.average * 1000.0} /></td>
            </tr>
          {/each}
        </tbody>
      </table>
    </td>
  {/if}
{/if}
<td class="border-start">
  <button on:click={toggleState} type="button" class="btn btn-outline-secondary btn-sm">
    {#if state === 'closed'}
      <i class="bi bi-chevron-bar-down" />
    {:else}
      <i class="bi bi-chevron-bar-up" />
    {/if}
  </button>
</td>

<style>
  .direction {
    margin: 0 0.2em 0 0;
  }
</style>
