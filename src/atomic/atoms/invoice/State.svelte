<script>
  import { onMount } from 'svelte';

  export let state;
  export let label = false;

  let iconElement;

  let cssClass = undefined;
  let labelText = undefined;

  onMount(() => {
    if (cssClass !== undefined && iconElement) new bootstrap.Tooltip(iconElement);
  });

  $: {
    switch (state) {
      case 'open':
        labelText = 'Open';
        cssClass = 'bi-circle text-warning';
        break;
      case 'settled':
        labelText = 'Settled';
        cssClass = 'bi-check-lg text-success';
        break;
      case 'canceled':
        labelText = 'Canceled';
        cssClass = 'bi-x-square text-danger-emphasis';
        break;
    }
  }
</script>

<span>
  {#if cssClass === undefined}
    <code>{state}</code>
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
