<script>
  import PortsToggler from '../../molecules/status/PortsToggler.svelte';

  import TimeAtom from '../../atoms/Time.svelte';

  import NumberAtom from '../../atoms/Number.svelte';

  import FilterableData from '../../molecules/FilterableData.svelte';
</script>

<FilterableData service="nitrox-monitor" path="/services" filterable={false} seconds={1} let:data>
  <table class="table text-center table-hover">
    <thead>
      <tr>
        <th scope="col" colspan="3" />
        <th scope="col" colspan="3">Synchronous</th>
        <th scope="col" colspan="3">Asynchronous</th>
        <th scope="col" />
      </tr>
      <tr>
        <th scope="col">Service</th>
        <th scope="col">Uptime</th>
        <th scope="col">Last</th>
        <th scope="col" class="border-start">Last</th>
        <th scope="col">In</th>
        <th scope="col">Out</th>
        <th scope="col" class="border-start">Last</th>
        <th scope="col">In</th>
        <th scope="col">Out</th>
        <th scope="col" class="border-start" />
      </tr>
    </thead>
    <tbody>
      {#each data as report (`report-${report._key}`)}
        <tr>
          {#if report.status}
            <td class="text-info">{report.discovery.service}</td>
          {:else}
            <td class="text-danger-emphasis" title={report.error}>{report.discovery.service}</td>
          {/if}
          {#if report.status}
            <td class="text-nowrap"><TimeAtom at={report.status.boot} /></td>
            <td class="text-nowrap"><TimeAtom at={report.status.last} /></td>

            <PortsToggler {report} />
          {:else}
            <td colspan="9" class="text-danger-emphasis fst-italic">
              {report.error}
            </td>
          {/if}
        </tr>
      {/each}
    </tbody>
  </table>
</FilterableData>

<style>
</style>
