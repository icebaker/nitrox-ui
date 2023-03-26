<script>
  export let message = undefined;
  export let instruction = undefined;
</script>

<div class="empty text-center">
  <i class="bi bi-list-ul text-secondary-emphasis" />
  <p class="message text-secondary-emphasis">
    {message}
  </p>

  {#if instruction}
    <p class="instruction">
      {instruction}
    </p>
  {/if}
</div>

<style>
  .empty {
    padding: 1em;
    margin-top: 12em;
  }
  .empty i.bi {
    font-size: 2em;
  }

  .empty p.message {
    margin-top: 0.6em;
    margin-bottom: 1em;
    font-size: 1.4em;
  }

  .empty p.instruction {
    margin-top: 2.2em;
  }
</style>
