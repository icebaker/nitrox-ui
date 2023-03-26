<script>
  import { onMount } from 'svelte';

  export let direction;

  let iconElement;

  onMount(() => {
    if (iconElement) new bootstrap.Tooltip(iconElement);
  });

  let cssClass = undefined;
  let label = undefined;

  switch (direction) {
    case 'in':
      label = 'in';
      cssClass = 'bi-box-arrow-in-down-right text-success-emphasis';
      break;
    case 'out':
      label = 'out';
      cssClass = 'bi-box-arrow-up-right text-danger-emphasis';
      break;
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
      data-bs-title={label}
    />
  {/if}
</span>
