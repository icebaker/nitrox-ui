<script>
  import { onMount } from 'svelte';

  export let how;
  export let label = false;

  let iconElement;

  onMount(() => {
    if (iconElement) new bootstrap.Tooltip(iconElement);
  });

  let cssClass = undefined;
  let labelText = undefined;

  $: {
    switch (how) {
      case 'spontaneously':
        labelText = 'Spontaneously';
        cssClass = 'bi-stars text-warning-emphasis';
        break;
      case 'with-invoice':
        labelText = 'With Invoice';
        cssClass = 'bi-receipt text-success-emphasis';
        break;
      case 'forwarding':
        labelText = 'Forwarding';
        cssClass = 'bi-forward text-info-emphasis';
        break;
      case 'opening-channel':
        labelText = 'Opening Channel';
        cssClass = 'bi-node-plus-fill text-success';
        break;
      case 'closing-channel':
        labelText = 'Closing Channel';
        cssClass = 'bi-node-minus-fill text-danger';
        break;
    }
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
      data-bs-title={labelText}
    />
    {#if label}<span>&nbsp;{labelText}</span>{/if}
  {/if}
</span>
