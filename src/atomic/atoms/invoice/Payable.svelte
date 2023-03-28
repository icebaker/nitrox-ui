<script>
  import { onMount } from 'svelte';

  export let payable;
  export let label = false;

  let iconElement;

  onMount(() => {
    if (iconElement) new bootstrap.Tooltip(iconElement);
  });

  let cssClass = undefined;
  let labelText = undefined;

  $: {
    switch (payable) {
      case 'indefinitely':
        labelText = 'Indefinitely';
        cssClass = 'bi-infinity text-warning';
        break;
      case 'once':
        labelText = 'Once';
        cssClass = 'bi-1-square text-info';
        break;
    }
  }
</script>

<span>
  {#if cssClass === undefined}
    <code>{payable}</code>
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
