<script>
  import { onMount, onDestroy } from 'svelte';

  export let content;
  export let modalElement = undefined;
  export let label = undefined;
  export let caption = '';
  export let cssClass = '';

  let element;
  let copyState = 'waiting';

  $: {
    if (content) copyState = 'waiting';
  }

  let clipboard;

  onMount(() => {
    if (element) {
      new bootstrap.Tooltip(element);

      if (modalElement) {
        clipboard = new ClipboardJS(element, { container: modalElement });
      } else {
        clipboard = new ClipboardJS(element);
      }

      clipboard.on('success', function () {
        copyState = 'done';
        setTimeout(() => {
          copyState = 'waiting';
        }, 1500);
      });
    }
  });

  onDestroy(() => {
    clipboard.destroy();
  });
</script>

<div class="input-group">
  {#if label}
    <span class="input-group-text">{label}</span>
  {/if}
  <input
    type="text"
    class={`form-control text-center ${cssClass}`}
    aria-label={caption}
    value={content}
    readonly
  />
  <button
    bind:this={element}
    data-bs-toggle="tooltip"
    data-bs-title="copy to clipboard"
    aria-label={`copy ${caption} to clipboard`}
    data-clipboard-text={content}
    class={`btn ${copyState === 'waiting' ? 'btn-outline-secondary' : 'btn-success'}`}
    type="button"
  >
    {#if copyState == 'waiting'}
      <i class="bi bi-clipboard" />
    {:else}
      <i class="bi bi-check-circle-fill" />
    {/if}
  </button>
</div>
