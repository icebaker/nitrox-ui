<script>
  export let fleeting = undefined;
  export let message = undefined;
  export let instruction = undefined;

  import Table from '../../..//molecules/fleeting/Table.svelte';
</script>

<div class="pending text-center">
  <i class="bi bi-hourglass-split text-warning-emphasis" />
  <p class="message text-warning-emphasis">
    {message}
  </p>

  <Table {fleeting} at={false} />

  <p class="instruction">
    {instruction}
  </p>
</div>

<style>
  .pending {
    padding: 1em;
  }
  .pending i.bi {
    font-size: 2em;
  }

  .pending p.message {
    margin-top: 0.6em;
    margin-bottom: 1em;
    font-size: 1.1em;
  }

  .pending p.instruction {
    margin-top: 2.2em;
  }
</style>
