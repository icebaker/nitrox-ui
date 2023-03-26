<script>
  export let css = '';
</script>

<div class={`loading ${css}`}>
  <div class="spinner-border" role="status">
    <span class="visually-hidden">Loading...</span>
  </div>
</div>

<style>
  .loading {
    text-align: center;
    padding: 2em;
  }
</style>
