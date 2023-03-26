<script>
  import Hops from './Hops.svelte';
  import FromTo from './FromTo.svelte';

  export let payment;

  let state = 'closed';

  const toggleState = () => {
    state = state === 'closed' ? 'open' : 'closed';
  };
</script>

<td valign="middle">
  <FromTo {payment} />
  {#if state !== 'closed'}
    <div class="hops border-top">
      <Hops {payment} purpose={payment.purpose} />
    </div>
  {/if}
</td><td>
  <button on:click={toggleState} type="button" class="btn btn-outline-secondary btn-sm">
    {#if state === 'closed'}
      <i class="bi bi-chevron-bar-down" />
    {:else}
      <i class="bi bi-chevron-bar-up" />
    {/if}
  </button>
</td>

<style>
  .hops {
    margin-top: 1.4em;
    padding-top: 0.6em;
  }
</style>
