<script>
  import TimeAtom from '../../atoms/Time.svelte';

  export let fleeting;
  export let at = true;
</script>

<table class="table table-hover text-start">
  <tbody>
    {#if at && fleeting.at}
      <tr>
        <th scope="col" class="text-end">At</th>
        <td><TimeAtom at={fleeting.at} /></td>
      </tr>
    {/if}
    {#if fleeting.topic}
      <tr>
        <th scope="col" class="text-end">Topic</th>
        <td><code>{fleeting.topic}</code></td>
      </tr>
    {/if}
    {#if fleeting.idempotency_key}
      <tr>
        <th scope="col" class="text-end text-nowrap">Idempotency Key</th>
        <td><code>{fleeting.idempotency_key}</code></td>
      </tr>
    {/if}
    {#if fleeting.error}
      <tr>
        <th scope="col" class="text-end">Error</th>
        <td><code>{fleeting.error.class}</code></td>
      </tr>
      <tr>
        <th scope="col" class="text-end">Message</th>
        <td><code>{fleeting.error.message}</code></td>
      </tr>
    {/if}
  </tbody>
</table>
