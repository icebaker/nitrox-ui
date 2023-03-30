<script>
  export let fleeting = undefined;
  export let message = undefined;
  export let instruction = undefined;

  import Table from '../../..//molecules/fleeting/Table.svelte';
</script>

<div class="error text-center">
  <i class="bi bi-emoji-frown text-danger-emphasis" />
  <p class="message text-danger-emphasis">
    {message}
  </p>

  {#if fleeting}
    <Table {fleeting} at={false} />
  {/if}

  {#if instruction}
    <p class="instruction">
      {instruction}
    </p>
  {/if}
</div>

<style>
  .error {
    padding: 1em;
  }
  .error i.bi {
    font-size: 2em;
  }

  .error p.message {
    margin-top: 0.6em;
    margin-bottom: 1em;
    font-size: 1.1em;
  }

  .error p.instruction {
    margin-top: 2.2em;
  }
</style>
