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
  filterable={true}
  filter="limit:10"
  example="limit:10"
  let:data
>
  <table class="table text-center table-hover">
    <thead>
      <tr>
        <th scope="col">At</th>
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
      {#each data.items as forward (`forward-${forward._key}`)}
        <tr>
          <td><TimeAtom at={forward.at} /></td>
          <td><MilliSatsAtom milli={forward.out.amount.millisatoshis} /></td>
          <td><MilliSatsAtom milli={forward.fee.millisatoshis} as="milli" /></td>
          <td><NumberAtom value={forward.fee.parts_per_million} round={true} /></td>
          <td><ShortenerAtom hash={forward.in.channel.id} limit={12} /></td>
          <td>
            <NodeAtom node={forward.in.channel.partner.node} />
            <i class="bi bi-box-arrow-in-down-right direction text-success-emphasis" />
          </td>
          <td>
            <i class="bi bi-box-arrow-up-right direction text-warning-emphasis" />
            <NodeAtom node={forward.out.channel.partner.node} />
          </td>
          <td><ShortenerAtom hash={forward.in.channel.id} limit={12} /></td>
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
