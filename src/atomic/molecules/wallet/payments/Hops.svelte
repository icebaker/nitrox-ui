<script>
  import NumberAtom from '../../../atoms/Number.svelte';
  import PercentageAtom from '../../../atoms/Percentage.svelte';
  import MilliSatsAtom from '../../../atoms/MilliSats.svelte';
  import ShortenerAtom from '../../../atoms/Shortener.svelte';
  import NodeAtom from '../../../atoms/Node.svelte';

  export let payment;
  export let purpose = undefined;

  const node = (hop) => {
    if (hop.channel.exit) {
      return hop.channel.exit;
    } else if (hop.channel.entry && purpose !== 'rebalance' && purpose !== 'self-payment') {
      return hop.channel.entry;
    } else {
      return hop.channel.target;
    }
  };
</script>

<table class="table text-center table-hover">
  <thead>
    <tr>
      <th scope="col">Hop</th>
      <th scope="col">Channel</th>
      <th scope="col">Node</th>
      <th scope="col">Amount</th>
      <th scope="col">Fee</th>
      <th scope="col">PPM</th>
    </tr>
  </thead>
  <tbody>
    {#each payment.hops as hop}
      <tr>
        <td><i class={`bi bi-${hop.hop}-circle hop`} /></td>
        <td><ShortenerAtom hash={hop.channel.id} /></td>
        <td><NodeAtom node={node(hop)} /></td>
        <td><MilliSatsAtom milli={hop.amount.millisatoshis} /></td>
        <td><MilliSatsAtom milli={hop.fee.millisatoshis} as="milli" /></td>
        <td><NumberAtom value={hop.fee.parts_per_million} round={true} /></td>
      </tr>
    {/each}
  </tbody>
</table>
