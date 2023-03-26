<script>
  import { onMount } from 'svelte';

  export let state;

  let iconElement;

  let cssClass = undefined;
  let label = undefined;

  onMount(() => {
    if (cssClass !== undefined && iconElement) new bootstrap.Tooltip(iconElement);
  });

  switch (state) {
    case 'open':
      label = 'open';
      cssClass = 'bi-circle text-warning';
      break;
    case 'settled':
      label = 'settled';
      cssClass = 'bi-check-lg text-success';
      break;
    case 'canceled':
      label = 'canceled';
      cssClass = 'bi-x-square text-danger-emphasis';
      break;
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
      data-bs-title={label}
    />
  {/if}
</span>
