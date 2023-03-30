<script>
  import { onMount } from 'svelte';

  export let through;
  export let label = false;

  let iconElement;

  onMount(() => {
    if (iconElement) new bootstrap.Tooltip(iconElement);
  });

  let cssClass = undefined;
  let labelText = undefined;

  $: {
    switch (through) {
      case 'keysend':
        labelText = 'Keysend';
        cssClass = 'bi-key text-primary';
        break;
      case 'amp':
        labelText = 'AMP';
        cssClass = 'bi-diagram-3 text-info';
        break;
      case 'non-amp':
        labelText = 'Non-AMP';
        cssClass = 'bi-receipt-cutoff text-warning-emphasis';
        break;
    }
  }
</script>

<span>
  {#if cssClass === undefined}
    <code>{through}</code>
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
