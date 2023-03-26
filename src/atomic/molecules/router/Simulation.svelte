<script>
  import NumberAtom from '../../atoms/Number.svelte';
  import PercentageAtom from '../../atoms/Percentage.svelte';
  import MilliSatsAtom from '../../atoms/MilliSats.svelte';
  import ShortenerAtom from '../../atoms/Shortener.svelte';
  import NodeAtom from '../../atoms/Node.svelte';

  export let simulation;
</script>

<div class="hops">
  {#each simulation.hops as hop, i}
    {#if i !== 0}
      <i class="bi bi-arrow-bar-right" />
    {/if}
    <div class="node border">
      <NodeAtom node={hop.channel.partner.node} underline={false} color="text-secondary" />
      |
      <span>
        <span class="text-danger-emphasis">
          <MilliSatsAtom milli={hop.fee.base.millisatoshis} as="milli" />
        </span>
        +
        <span class="text-danger">
          <NumberAtom value={hop.fee.rate.parts_per_million} />
        </span>
      </span>
    </div>
  {/each}
  <div class="node border">
    <!--     <span class="text-secondary">
      <NumberAtom value={simulation.amount.millisatoshis} />
    </span>
    <span class="text-secondary">|</span> -->
    <span class="text-danger" title={simulation.amount.millisatoshis}>
      <NumberAtom value={simulation.cost.parts_per_million} /> PPM
    </span>
  </div>
</div>

<style>
  .hops {
    margin: 1em;
    display: inline-block;
  }

  .node {
    padding: 1em;
    display: inline-block;
    margin: 0 1em;
  }
</style>
