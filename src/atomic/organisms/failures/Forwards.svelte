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
  path="/forwards"
  filterable={true}
  filter="limit:10"
  example="hours-ago:12 peer:false limit:10 htlc:2388"
  let:data
>
  <table class="table text-center table-hover">
    <thead>
      <tr>
        <th scope="col">HTLC</th>
        <th scope="col">At</th>
        <th scope="col">Reason</th>
        <th scope="col">Amount</th>
        <th scope="col">Fee</th>
        <th scope="col">PPM</th>
        <th scope="col">In</th>
        <th scope="col">In</th>
        <th scope="col">Out</th>
        <th scope="col">Out</th>
      </tr>
    </thead>
    <tbody>
      {#each data.items as forward_failure (`forward-${forward_failure._key}`)}
        <tr>
          <td><code>{forward_failure.htlc.id}</code></td>
          <td><TimeAtom at={forward_failure.at} /></td>
          <td><ErrorReasonAtom error={forward_failure.reason} /></td>
          <td><MilliSatsAtom milli={forward_failure.out.amount.millisatoshis} /></td>
          <td><MilliSatsAtom milli={forward_failure.fee.millisatoshis} as="milli" /></td>
          <td><NumberAtom value={forward_failure.fee.parts_per_million} round={true} /></td>
          <td><ShortenerAtom hash={forward_failure.in.channel.id} limit={12} /></td>
          <td>
            <NodeAtom node={forward_failure.in.channel.partner.node} />
            <i class="bi bi-box-arrow-in-down-right direction text-success-emphasis" />
          </td>
          <td>
            <i class="bi bi-box-arrow-up-right direction text-warning-emphasis" />
            <NodeAtom node={forward_failure.out.channel.partner.node} />
          </td>
          <td><ShortenerAtom hash={forward_failure.in.channel.id} limit={12} /></td>
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
