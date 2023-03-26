<script>
  import { onMount } from 'svelte';

  import Presenter from '../../helpers/presenter.js';

  export let value;

  export let colors = false;
  export let round = false;
  export let average = false;

  let cssClass = '';

  if (colors && value >= 0.0) {
    cssClass = 'text-success';
  } else if (colors) {
    cssClass = 'text-danger';
  }

  let presentValue = undefined;

  const updatePresentValue = () => {
    presentValue = round ? Math.round(value) : value;
  };

  let tooltipElement = undefined;

  onMount(() => {
    updatePresentValue();
    if (tooltipElement) new bootstrap.Tooltip(tooltipElement);
  });

  $: {
    if (value !== undefined) updatePresentValue();
  }
</script>

{#if average}
  <span bind:this={tooltipElement} data-bs-toggle="tooltip" data-bs-title="average">
    <span class="average text-secondary" title="average">~</span><span class={cssClass}>
      {Presenter.number(presentValue)}
    </span>
  </span>
{:else}
  <span bind:this={tooltipElement} data-bs-toggle="tooltip" data-bs-title={Presenter.number(value)}>
    <span class={cssClass}>{Presenter.number(presentValue)}</span>
  </span>
{/if}

<style>
  .average {
    font-size: 0.9em;
  }
</style>
