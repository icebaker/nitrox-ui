<script>
  import { onMount } from 'svelte';

  export let purpose;

  let iconElement;

  onMount(() => {
    if (iconElement) new bootstrap.Tooltip(iconElement);
  });

  let cssClass = undefined;
  let label = undefined;

  switch (purpose) {
    case 'self-payment':
      label = 'self-payment';
      cssClass = 'bi-arrow-left-right text-danger-emphasis';
      break;
    case 'rebalance':
      label = 'rebalance';
      cssClass = 'bi-arrow-clockwise text-success-emphasis';
      break;
    case 'payment':
      label = 'payment';
      cssClass = 'bi-wallet2 text-warning-emphasis';
      break;
    case 'peer-to-peer':
      label = 'peer to peer';
      cssClass = 'bi-water text-primary-emphasis';
      break;
  }
</script>

<span>
  {#if cssClass === undefined}
    <code>{purpose}</code>
  {:else}
    <i
      bind:this={iconElement}
      class={`bi ${cssClass}`}
      data-bs-toggle="tooltip"
      data-bs-title={label}
    />
  {/if}
</span>
