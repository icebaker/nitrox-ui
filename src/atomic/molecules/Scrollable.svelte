<script>
  import { onMount } from 'svelte';

  import PerfectScrollbar from 'perfect-scrollbar';
  import 'perfect-scrollbar/css/perfect-scrollbar.css';

  let container;

  onMount(() => {
    const ps = new PerfectScrollbar(container, {
      suppressScrollX: false
    });

    return () => {
      ps.destroy();
    };
  });
</script>

<div class="scrollable" bind:this={container}>
  <slot />
</div>

<style>
  .scrollable {
    /*  max-height: 200px;*/
    /*  overflow-x: hidden;*/
    overflow: hidden;
    position: relative;
  }
</style>
