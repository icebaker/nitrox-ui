<script>
  import { onMount } from 'svelte';

  export let layer;

  let iconElement;

  onMount(() => {
    if (iconElement) new bootstrap.Tooltip(iconElement);
  });

  let cssClass = undefined;
  let label = undefined;

  switch (layer) {
    case 'bitcoin':
      label = 'bitcoin';
      cssClass = 'bi-currency-bitcoin text-warning';
      break;
    case 'lightning':
      label = 'lightning';
      cssClass = 'bi-lightning text-primary';
      break;
  }
</script>

<span>
  {#if cssClass === undefined}
    <code>{layer}</code>
  {:else}
    <i
      bind:this={iconElement}
      class={`bi ${cssClass}`}
      data-bs-toggle="tooltip"
      data-bs-title={label}
    />
  {/if}
</span>
