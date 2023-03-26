<script>
  import { onMount } from 'svelte';

  export let how;

  let iconElement;

  onMount(() => {
    if (iconElement) new bootstrap.Tooltip(iconElement);
  });

  let cssClass = undefined;
  let label = undefined;

  switch (how) {
    case 'spontaneously':
      label = 'spontaneously';
      cssClass = 'bi-stars text-warning-emphasis';
      break;
    case 'with-invoice':
      label = 'with-invoice';
      cssClass = 'bi-receipt text-success-emphasis';
      break;
    case 'forwarding':
      label = 'forwarding';
      cssClass = 'bi-forward text-info-emphasis';
      break;
    case 'opening-channel':
      label = 'opening-channel';
      cssClass = 'bi-node-plus-fill text-success';
      break;
    case 'closing-channel':
      label = 'closing-channel';
      cssClass = 'bi-node-minus-fill text-danger';
      break;
  }
</script>

<span>
  {#if cssClass === undefined}
    <code>{how}</code>
  {:else}
    <i
      bind:this={iconElement}
      class={`bi ${cssClass}`}
      data-bs-toggle="tooltip"
      data-bs-title={label}
    />
  {/if}
</span>
