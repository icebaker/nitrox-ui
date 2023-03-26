<script>
  import { onMount } from 'svelte';

  export let hash;
  export let code = true;
  export let limit = 10;

  let chunk = undefined;
  let short = undefined;

  const update = () => {
    chunk = Math.floor((limit - 3) / 2);

    short = `${hash}`;

    if (short.length > limit) {
      short = `${short.slice(0, chunk)}...${short.slice(short.length - chunk, short.length)}`;
    }
  };

  let codeElement;

  onMount(() => {
    update();

    if (codeElement) {
      new bootstrap.Tooltip(codeElement);
      new ClipboardJS(codeElement);
    }
  });

  $: {
    if (hash !== undefined) update();
  }
</script>

{#if hash}
  {#if code}
    <code
      bind:this={codeElement}
      data-clipboard-text={hash}
      data-bs-toggle="tooltip"
      data-bs-title={` ${hash} `}
    >
      <!-- U+00A0 NO-BREAK SPACE -->
      {short}
    </code>
  {:else}
    <span
      bind:this={codeElement}
      data-clipboard-text={hash}
      data-bs-toggle="tooltip"
      data-bs-title={` ${hash} `}
    >
      <!-- U+00A0 NO-BREAK SPACE -->
      {short}
    </span>
  {/if}
{:else}
  <span class="unknown"><i class="bi bi-question" /></span>
{/if}

<style>
  code:hover {
    cursor: copy;
  }
</style>
