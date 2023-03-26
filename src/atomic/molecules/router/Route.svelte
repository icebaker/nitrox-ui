<script>
  import CopyableAtom from '../../atoms/Copyable.svelte';
  import Simulation from './Simulation.svelte';
  import Hops from './Hops.svelte';

  export let route;

  let state = 'closed';

  const toggleState = () => {
    state = state === 'closed' ? 'open' : 'closed';
  };
</script>

<Simulation simulation={route.simulation} />

<button on:click={toggleState} type="button" class="btn btn-outline-secondary btn-sm">
  {#if state === 'closed'}
    <i class="bi bi-chevron-bar-down" />
  {:else}
    <i class="bi bi-chevron-bar-up" />
  {/if}
</button>

{#if state !== 'closed'}
  <Hops hops={route.path} />
  <div class="bash">
    <CopyableAtom content={route.lighstorm} />
  </div>
{/if}

<style>
  .bash {
    margin-top: -1.5em;
    margin-bottom: 1.8em;
  }
</style>
