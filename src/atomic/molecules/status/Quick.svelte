<script>
  import Status from '../../atoms/Status.svelte';

  import FilterableData from '../../molecules/FilterableData.svelte';
</script>

<div class="quick-status text-center">
  <FilterableData
    service="nitrox-monitor"
    path="/services"
    filterable={false}
    loader="discreet"
    lean={true}
    retry={false}
    seconds={1}
    let:data
    let:failure
  >
    <div slot="failure" />
    <!-- <Status slot="failure" title={`${failure.error} ${failure.url}`} health={false} /> -->

    <div slot="data">
      {#each data as report (`report-${report._key}`)}
        {#if report.status}
          <Status title={report.discovery.service} health={true} />
        {:else if report.discovery}
          <Status title={report.discovery.service} health={false} />
        {:else}
          <Status title="?" health={false} />
        {/if}
      {/each}
    </div>
  </FilterableData>
</div>

<style>
  .quick-status {
    margin-top: 0.4em;
    margin-bottom: -1em;
  }
</style>
