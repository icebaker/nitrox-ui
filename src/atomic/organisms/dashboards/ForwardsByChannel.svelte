<script>
  import TimeAtom from '../../atoms/Time.svelte';
  import NodeAtom from '../../atoms/Node.svelte';
  import MilliSatsAtom from '../../atoms/MilliSats.svelte';
  import NumberAtom from '../../atoms/Number.svelte';
  import ShortenerAtom from '../../atoms/Shortener.svelte';
  import ErrorReasonAtom from '../../atoms/ErrorReason.svelte';

  import FilterableData from '../../molecules/FilterableData.svelte';

  export let direction;
</script>

<FilterableData
  service="nitrox-node"
  path={`/forwards/by-channel-${direction}`}
  filterable={true}
  filter="hours-ago:12"
  example="hours-ago:24"
  seconds={1}
  let:data
>
  <table class="table text-center table-hover">
    <thead>
      <tr>
        <th scope="col">Count</th>
        <th scope="col">Last</th>
        <th scope="col">
          {#if direction == 'in'}
            <i class="bi bi-box-arrow-in-down-right direction text-success-emphasis" />
            In
          {:else}
            <i class="bi bi-box-arrow-up-right direction text-warning-emphasis" />
            Out
          {/if}
        </th>
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
            <NodeAtom
              node={group.channel.partner ? group.channel.partner.node : undefined}
              short={22}
            />
          </td>
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
