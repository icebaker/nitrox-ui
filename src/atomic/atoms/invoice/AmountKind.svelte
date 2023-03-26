<script>
  import { onMount } from 'svelte';

  export let amount;

  let iconElement;

  onMount(() => {
    if (iconElement) new bootstrap.Tooltip(iconElement);
  });

  let cssClass = undefined;
  let label = undefined;

  switch (amount) {
    case 'open':
      label = 'open';
      cssClass = 'bi-braces-asterisk text-danger-emphasis';
      break;
    case 'fixed':
      label = 'fixed';
      cssClass = 'bi-123 text-info';
      break;
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
      data-bs-title={label}
    />
  {/if}
</span>
