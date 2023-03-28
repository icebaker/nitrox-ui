<script>
  import { onMount } from 'svelte';

  export let direction;
  export let label = false;

  let iconElement;

  onMount(() => {
    if (iconElement) new bootstrap.Tooltip(iconElement);
  });

  let cssClass = undefined;
  let labelText = undefined;

  $: {
    switch (direction) {
      case 'in':
        labelText = 'In';
        cssClass = 'bi-box-arrow-in-down-right text-success-emphasis';
        break;
      case 'out':
        labelText = 'Out';
        cssClass = 'bi-box-arrow-up-right text-danger-emphasis';
        break;
    }
  }
</script>

<span>
  {#if cssClass === undefined}
    <code>{direction}</code>
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
