<script>
  import { onMount } from 'svelte';

  export let through;

  let iconElement;

  onMount(() => {
    if (iconElement) new bootstrap.Tooltip(iconElement);
  });

  let cssClass = undefined;
  let label = undefined;

  switch (through) {
    case 'keysend':
      label = 'keysend';
      cssClass = 'bi-key text-primary';
      break;
    case 'amp':
      label = 'amp';
      cssClass = 'bi-diagram-3 text-info';
      break;
    case 'non-amp':
      label = 'non-amp';
      cssClass = 'bi-receipt-cutoff text-warning-emphasis';
      break;
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
      data-bs-title={label}
    />
  {/if}
</span>
