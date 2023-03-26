<script>
  import NumberAtom from '../../atoms/Number.svelte';
  import PercentageAtom from '../../atoms/Percentage.svelte';
  import MilliSatsAtom from '../../atoms/MilliSats.svelte';
  import ShortenerAtom from '../../atoms/Shortener.svelte';
  import NodeAtom from '../../atoms/Node.svelte';

  export let hops;
</script>

<table class="table text-center table-hover">
  <thead>
    <tr>
      <th scope="col">Hop</th>
      <th scope="col">
        <i class="bi bi-box-arrow-up-right direction text-warning-emphasis" />
      </th>
      <th scope="col">Fee</th>
      <th scope="col">PPM</th>
      <th scope="col">Channel</th>
      <th scope="col">
        <i class="bi bi-box-arrow-in-down-right direction text-success-emphasis" />
      </th>
      <th scope="col">Fee</th>
      <th scope="col">PPM</th>
    </tr>
  </thead>
  <tbody>
    {#each hops as channel, i}
      <tr>
        <td><i class={`bi bi-${i}-circle hop`} /></td>
        <td><NodeAtom node={channel.partners[0].node} /></td>
        <td
          ><MilliSatsAtom
            milli={channel.partners[0].policy.fee.base.millisatoshis}
            as="milli"
          /></td
        >
        <td
          ><NumberAtom
            value={channel.partners[0].policy.fee.rate.parts_per_million}
            round={true}
          /></td
        >
        <td><ShortenerAtom hash={channel.id} /></td>
        <td><NodeAtom node={channel.partners[1].node} /></td>
        <td
          ><MilliSatsAtom
            milli={channel.partners[1].policy.fee.base.millisatoshis}
            as="milli"
          /></td
        >
        <td
          ><NumberAtom
            value={channel.partners[1].policy.fee.rate.parts_per_million}
            round={true}
          /></td
        >
      </tr>
    {/each}
  </tbody>
</table>

<style>
  table {
    margin-bottom: 4em;
  }
</style>
