<script>
  import TimeAtom from '../../atoms/Time.svelte';

  export let fleeting;
  export let colspan = 1;
  export let opener;
</script>

<tr>
  <td class={fleeting.state === 'error' ? 'text-danger-emphasis' : 'text-warning-emphasis'}>
    <TimeAtom at={fleeting.at} />
  </td>
  <td {colspan} class="text-end">
    {#if fleeting.state === 'error'}
      <span class="text-danger-emphasis"><code>{fleeting.error.class}</code></span>
      |
      <span class="text-danger-emphasis">Error</span>
    {:else if fleeting.state === 'pending'}
      <span class="text-warning-emphasis">Pending</span>
    {:else}
      <code>{fleeting.state}</code>
    {/if}
    | <code>{fleeting.idempotency_key}</code>
  </td>
  <td>
    {#if fleeting.state === 'error'}
      <button
        on:click={opener(fleeting, 'error')}
        type="button"
        class="btn btn-outline-secondary btn-sm"
      >
        <i class="bi bi-bug" />
      </button>
    {:else}
      <button
        on:click={opener(fleeting, 'pending')}
        type="button"
        class="btn btn-outline-secondary btn-sm"
      >
        <i class="bi bi-info-lg" />
      </button>
    {/if}
  </td>
</tr>
