<script>
  import Loading from '../../../atoms/states/Loading.svelte';

  export let fleeting = undefined;
  export let message = undefined;
  export let instruction = undefined;

  import Table from '../../../molecules/fleeting/Table.svelte';
</script>

<div class="pending text-center">
  {#if fleeting}
    <div class="loading">
      <Loading css="text-info-emphasis" />
    </div>
    <p class="message text-info-emphasis">
      {message}
    </p>
  {:else}
    <div class="standalone-loading">
      <Loading />
    </div>
  {/if}

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
  .pending {
    padding: 1em;
  }

  .standalone-loading {
    margin-top: 0.8em;
  }

  .loading {
    margin-top: -2em;
    margin-bottom: -1em;
  }

  .pending i.bi {
    font-size: 2em;
  }

  .pending p.message {
    margin-bottom: 1em;
    font-size: 1.1em;
  }

  .pending p.instruction {
    margin-top: 2.2em;
  }
</style>
