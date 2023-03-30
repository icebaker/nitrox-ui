<script>
  import { onMount } from 'svelte';

  export let layer;
  export let label = false;

  let iconElement;

  onMount(() => {
    if (iconElement) new bootstrap.Tooltip(iconElement);
  });

  let cssClass = undefined;
  let labelText = undefined;

  $: {
    switch (layer) {
      case 'bitcoin':
        labelText = 'Bitcoin';
        cssClass = 'bi-currency-bitcoin text-warning';
        break;
      case 'lightning':
        labelText = 'Lightning';
        cssClass = 'bi-lightning text-primary';
        break;
    }
  }
</script>

<span>
  {#if cssClass === undefined}
    <code>{layer}</code>
  {:else}
    <i
      bind:this={iconElement}
      class={`bi ${cssClass}`}
      data-bs-toggle="tooltip"
      data-bs-title={labelText}
    />
    {#if label}<span>&nbsp;{labelText}</span>{/if}
  {/if}
</span>
