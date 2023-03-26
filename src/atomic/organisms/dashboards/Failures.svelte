<script>
  import TimeAtom from '../../atoms/Time.svelte';
  import NodeAtom from '../../atoms/Node.svelte';
  import MilliSatsAtom from '../../atoms/MilliSats.svelte';
  import NumberAtom from '../../atoms/Number.svelte';
  import ShortenerAtom from '../../atoms/Shortener.svelte';
  import ErrorReasonAtom from '../../atoms/ErrorReason.svelte';

  import FilterableData from '../../molecules/FilterableData.svelte';

  export let channelIn = true;
</script>

<FilterableData
  service="nitrox-failures"
  path="/forwards"
  filterable={false}
  filter="peer:false limit:5"
  seconds={1}
  let:data
>
  <table class="table text-center table-hover">
    <thead>
      <tr>
        <th scope="col">At</th>
        {#if channelIn}
          <th scope="col">
            In
            <i class="bi bi-box-arrow-in-down-right direction text-success-emphasis" />
          </th>
        {/if}
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
      {#each data.items as forward_failure (`forward-${forward_failure._key}`)}
        <tr>
          <td class="text-nowrap"><TimeAtom at={forward_failure.at} /></td>
          {#if channelIn}
            <td>
              <NodeAtom node={forward_failure.in.channel.partner.node} />
            </td>
          {/if}
          <td>
            <NodeAtom node={forward_failure.out.channel.partner.node} short={22} />
          </td>
          <td><ErrorReasonAtom error={forward_failure.reason} /></td>
          <td><MilliSatsAtom milli={forward_failure.out.amount.millisatoshis} /></td>
          <td><NumberAtom value={forward_failure.fee.parts_per_million} round={true} /></td>
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
