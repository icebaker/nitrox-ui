<script>
  import { onMount } from 'svelte';

  export let purpose;
  export let label = false;

  let iconElement;

  onMount(() => {
    if (iconElement) new bootstrap.Tooltip(iconElement);
  });

  let cssClass = undefined;
  let labelText = undefined;

  $: {
    switch (purpose) {
      case 'self-payment':
        labelText = ' Self-Payment';
        cssClass = 'bi-arrow-left-right text-danger-emphasis';
        break;
      case 'rebalance':
        labelText = 'Rebalance';
        cssClass = 'bi-arrow-clockwise text-success-emphasis';
        break;
      case 'payment':
        labelText = 'Payment';
        cssClass = 'bi-wallet2 text-warning-emphasis';
        break;
      case 'peer-to-peer':
        labelText = ' Peer-to-Peer';
        cssClass = 'bi-water text-primary-emphasis';
        break;
    }
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
      data-bs-title={labelText}
    />
    {#if label}<span>&nbsp;{labelText}</span>{/if}
  {/if}
</span>
