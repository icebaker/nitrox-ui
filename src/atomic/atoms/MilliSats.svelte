<script>
  import { onMount } from 'svelte';

  import Presenter from '../../helpers/presenter.js';

  export let milli;
  export let as = 'satoshis';
  export let short = true;
  export let colors = false;
  export let average = false;

  let cssClass = 'value';

  if (colors && milli >= 0.0) {
    cssClass = 'value font-monospace text-success';
  } else if (colors) {
    cssClass = 'value font-monospace text-danger';
  }

  let averageElement = undefined;

  onMount(() => {
    if (averageElement) new bootstrap.Tooltip(averageElement);
  });
</script>

{#if average}
  <span bind:this={averageElement} data-bs-toggle="tooltip" data-bs-title="average">
    <span class="average text-secondary" title="average">~</span><span class={cssClass}>
      {#if as === 'satoshis'}
        {Presenter.shortMoney(milli / 1000.0)}
        <span class="unit font-monospace text-secondary">sat</span>
      {:else}
        {Presenter.number(milli)} <span class="unit font-monospace text-secondary">msat</span>
      {/if}
    </span>
  </span>
{:else}
  <span class={cssClass}>
    {#if as === 'satoshis'}
      {#if short}
        {Presenter.shortMoney(milli / 1000.0)}
        <span class="unit font-monospace text-secondary">sat</span>
      {:else}
        {Presenter.number(milli / 1000.0)}
        <span class="unit font-monospace text-secondary">sat</span>
      {/if}
    {:else}
      {Presenter.number(milli)} <span class="unit font-monospace text-secondary">msat</span>
    {/if}
  </span>
{/if}

<style>
  .average {
    font-size: 0.9em;
  }

  .unit {
    font-size: 0.9em;
  }
</style>
