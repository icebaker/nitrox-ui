<script>
  import TimeAtom from '../../atoms/Time.svelte';
  import NodeAtom from '../../atoms/Node.svelte';
  import MilliSatsAtom from '../../atoms/MilliSats.svelte';
  import NumberAtom from '../../atoms/Number.svelte';
  import ShortenerAtom from '../../atoms/Shortener.svelte';

  import FilterableData from '../../molecules/FilterableData.svelte';
</script>

<FilterableData
  service="nitrox-node"
  path="/forwards"
  filterable={false}
  filter="limit:5"
  seconds={1}
  let:data
>
  <table class="table text-center table-hover">
    <thead>
      <tr>
        <th scope="col">At</th>
        <th scope="col">Amount</th>
        <th scope="col">PPM</th>
        <th scope="col">
          In
          <i class="bi bi-box-arrow-in-down-right direction text-success-emphasis" />
        </th>
        <th scope="col">
          <i class="bi bi-box-arrow-up-right direction text-warning-emphasis" />
          Out
        </th>
      </tr>
    </thead>
    <tbody>
      {#each data.items as forward (`forward-${forward._key}`)}
        <tr>
          <td class="text-nowrap"><TimeAtom at={forward.at} /></td>
          <td><MilliSatsAtom milli={forward.out.amount.millisatoshis} /></td>
          <td><NumberAtom value={forward.fee.parts_per_million} round={true} /></td>
          <td>
            <NodeAtom node={forward.in.channel.partner.node} short={22} />
          </td>
          <td>
            <NodeAtom node={forward.out.channel.partner.node} short={22} />
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
