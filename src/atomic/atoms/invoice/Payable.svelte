<script>
  import { onMount } from 'svelte';

  export let payable;

  let iconElement;

  onMount(() => {
    if (iconElement) new bootstrap.Tooltip(iconElement);
  });

  let cssClass = undefined;
  let label = undefined;

  switch (payable) {
    case 'indefinitely':
      label = 'indefinitely';
      cssClass = 'bi-infinity text-warning';
      break;
    case 'once':
      label = 'once';
      cssClass = 'bi-1-square text-info';
      break;
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
      data-bs-title={label}
    />
  {/if}
</span>
