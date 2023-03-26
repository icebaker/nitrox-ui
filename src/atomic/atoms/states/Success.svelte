<script>
  export let message = undefined;
</script>

<div class="success text-center">
  <i class="bi bi-check-circle-fill text-success" />
  <p class="text-success-emphasis">
    {message}
  </p>
</div>

<style>
  .success {
    padding: 2em;
  }
  .success i.bi {
    font-size: 2em;
  }

  .success p {
    margin-top: 1em;
    font-size: 1.1em;
  }
</style>
