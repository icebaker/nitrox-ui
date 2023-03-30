<script>
  import { onMount } from 'svelte';

  export let amount;
  export let label = false;

  let iconElement;

  onMount(() => {
    if (iconElement) new bootstrap.Tooltip(iconElement);
  });

  let cssClass = undefined;
  let labelText = undefined;

  $: {
    switch (amount) {
      case 'open':
        labelText = 'Open';
        cssClass = 'bi-braces-asterisk text-danger-emphasis';
        break;
      case 'fixed':
        labelText = 'Fixed';
        cssClass = 'bi-123 text-info';
        break;
    }
  }
</script>

<span>
  {#if cssClass === undefined}
    <code>{amount}</code>
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
