<script>
  import { nanoid } from 'nanoid';

  import Loading from '../../atoms/states/Loading.svelte';
  import Success from '../../atoms/states/Success.svelte';

  import Nitrox from '../../../components/nitrox';

  export let connection;
  export let callback = undefined;

  let state = undefined;

  let idempotencyKey = undefined;

  const prepare = () => {
    idempotencyKey = nanoid(20);
    state = 'prepare';
  };

  $: {
    if (connection) prepare();
  }

  let baseUrl = undefined;

  const removeConnection = async () => {
    if (baseUrl === undefined) {
      baseUrl = `${await Nitrox.service('connector')}`;
    }
    state = 'removing';

    const headers = {
      'Content-Type': 'application/json',
      'Idempotency-Key': idempotencyKey
    };

    const params = new URLSearchParams({
      name: connection.config.name
    });

    const response = await fetch(`${baseUrl}/connections?${params.toString()}`, {
      method: 'DELETE',
      headers: headers
    });

    state = 'removed';

    if (callback) callback();
  };
</script>

{#if state === 'removing'}
  <div class="state">
    <Loading />
  </div>
{:else if state === 'removed'}
  <div class="state">
    <Success message="Connection Removed Successfully!" />
  </div>
{:else if state === 'prepare'}
  <p class="text-center">The following connection will be removed:</p>

  <p class="text-center fs-3">{connection.config.name}</p>

  <div class="text-center border-top actions">
    <button type="submit" class="btn btn-danger" on:click={removeConnection}>Remove</button>
    <button type="submit" class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Cancel"
      >Cancel</button
    >
  </div>
{/if}

<style>
  .mb-3 {
    /*  padding-bottom: .0em;*/
  }

  .actions button {
    margin: 0 0.4em;
  }

  .actions {
    padding-top: 1em;
  }

  .tab-pane {
    padding-top: 1em;
  }
</style>
