<script>
  import { onMount } from 'svelte';

  export let content;

  let codeElement;

  onMount(() => {
    if (codeElement) {
      new bootstrap.Tooltip(codeElement);
      new ClipboardJS(codeElement);
    }
  });
</script>

<div class="input-group mb-3">
  <input bind:value={content} type="text" class="form-control font-monospace" />
  <button
    bind:this={codeElement}
    data-clipboard-text={content}
    data-bs-toggle="tooltip"
    data-bs-title="copy to clipboard"
    class="btn btn-outline-secondary"
    type="button"
  >
    <i class="bi bi-clipboard" />
  </button>
</div>
