<script>
  import NodeAtom from '../../../atoms/Node.svelte';

  export let payment;
</script>

<div class="row hops">
  <div class="col col-5 text-end">
    {#if payment.hops.length > 1}
      <span class="node"><NodeAtom node={payment.from.channel.exit} /></span>
      <i class="bi bi-box-arrow-up-right direction text-warning-emphasis" />
    {:else}
      <i class="bi bi-box-arrow-right direction text-warning-emphasis" />
    {/if}
  </div>
  <div class="col-1">
    <i class={`bi bi-${payment.hops.length}-circle hop`} />
  </div>
  <div class="col col-5 text-start">
    <i class="bi bi-box-arrow-in-down-right direction text-success-emphasis" />
    <span class="node"
      ><NodeAtom
        node={payment.to.channel.entry ? payment.to.channel.entry : payment.to.channel.target}
      /></span
    >
  </div>
</div>

<style>
  .hops .col {
    white-space: nowrap;
  }

  .hops .direction {
    margin: 0 0.4em;
  }
</style>
