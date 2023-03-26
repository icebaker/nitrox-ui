<script>
  import TimeAtom from '../../atoms/Time.svelte';
  import NodeAtom from '../../atoms/Node.svelte';
  import MilliSatsAtom from '../../atoms/MilliSats.svelte';
  import NumberAtom from '../../atoms/Number.svelte';
  import ShortenerAtom from '../../atoms/Shortener.svelte';
  import ErrorReasonAtom from '../../atoms/ErrorReason.svelte';

  import FilterableData from '../../molecules/FilterableData.svelte';
</script>

<FilterableData
  service="nitrox-failures"
  path="/forwards/by-channel"
  filterable={true}
  filter="hours-ago:12"
  example="peer:false hours-ago:24"
  seconds={1}
  let:data
>
  <table class="table text-center table-hover">
    <thead>
      <tr>
        <th scope="col">Count</th>
        <th scope="col">Last</th>
        <th scope="col">
          <i class="bi bi-box-arrow-up-right direction text-warning-emphasis" />
          Out
        </th>
        <th scope="col">Reason</th>
        <th scope="col">Amount</th>
        <th scope="col">PPM</th>
      </tr>
    </thead>
    <tbody>
      {#each data.items as group (`forward-${group._key}-${group.last_at}`)}
        <tr>
          <td><NumberAtom value={group.analysis.count} /></td>
          <td class="text-nowrap"><TimeAtom at={group.last_at} /></td>
          <td>
            <NodeAtom node={group.out.partner.node} />
          </td>
          <td><ErrorReasonAtom error={group.reason} /></td>
          <td>
            <MilliSatsAtom milli={group.analysis.averages.amount.millisatoshis} average={true} />
          </td>
          <td>
            <NumberAtom
              value={group.analysis.averages.fee.parts_per_million}
              average={true}
              round={true}
            />
          </td>
        </tr>
      {/each}
    </tbody>
  </table>
</FilterableData>

<style>
  .direction {
    margin: 0 0.3em;
  }
</style>
