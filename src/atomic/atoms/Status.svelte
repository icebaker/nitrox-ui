<script>
  import { onMount } from 'svelte';

  export let title;
  export let health;

  let circleElement;

  const cssClass = health ? 'circle text-bg-success' : 'circle text-bg-danger';

  onMount(() => {
    if (circleElement) {
      new bootstrap.Tooltip(circleElement);
    }
  });
</script>

<span bind:this={circleElement} data-bs-toggle="tooltip" data-bs-title={title} class={cssClass} />

<style>
  .circle {
    display: inline-block;
    border-radius: 50%;
    width: 0.5em;
    height: 0.5em;
    vertical-align: middle;
    margin: 0 0.4em;
  }
</style>
