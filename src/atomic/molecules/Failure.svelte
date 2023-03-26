<script>
  import TimeAtom from '../atoms/Time.svelte';

  export let message;
  export let failure;

  let urlLabel;

  if (failure.url) {
    const url = new URL(failure.url);
    urlLabel = `${url.protocol}://${url.hostname}:${url.port}${url.pathname}`;
  }
</script>

<div class="error text-center">
  <i class="bi bi-emoji-frown text-danger-emphasis" />
  <p class="message text-danger-emphasis">
    {message}
  </p>

  <table class="table table-hover text-start">
    <tbody>
      <tr>
        <th scope="col" class="text-end">Error</th>
        <td><code>{`${failure.error}`.replace(/^error:\s*/i, '')}</code></td>
      </tr>
      {#if failure.response && failure.response.data && failure.response.data.error}
        {#if `${failure.error}`.replace(/^error:\s*/i, '') !== failure.response.data.error}
          <tr>
            <th scope="col" class="text-end">Exception</th>
            <td><code>{failure.response.data.error}</code></td>
          </tr>
        {/if}
        <tr>
          <th scope="col" class="text-end">Message</th>
          <td><code>{failure.response.data.message}</code></td>
        </tr>
      {/if}
      {#if failure.url}
        <tr>
          <th scope="col" class="text-end">URL</th>
          <td>
            <a href={failure.url} class="link-danger" target="_blank" rel="noopener noreferrer">
              {urlLabel}
            </a>
          </td>
        </tr>
      {/if}
    </tbody>
  </table>

  <div class="failure-at text-danger-emphasis">
    <TimeAtom at={failure.at} seconds={10} />
  </div>
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

  .failure-at {
    margin-top: 2.2em;
  }
</style>
