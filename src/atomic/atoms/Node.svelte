<script>
  import { onMount } from 'svelte';

  let circleElement;
  let aliasElement;
  export let color = '';
  export let small = true;
  export let underline = true;
  export let node;
  export let short = undefined;

  let alias;
  $: {
    if (node) {
      alias = node.alias;

      if (short !== undefined) {
        const chunk = Math.floor((short - 3) / 2);

        if (alias && alias.length > short) {
          alias = `${alias.slice(0, chunk)}...${alias.slice(alias.length - chunk, alias.length)}`;
        }
      }

      if (alias == undefined) {
        let chunk;
        if (short != undefined) {
          chunk = Math.floor((short - 3) / 2);
        } else {
          chunk = Math.floor((20 - 3) / 2);
        }
        alias = `${node.public_key.slice(0, chunk)}...${node.public_key.slice(
          node.public_key.length - chunk,
          node.public_key.length
        )}`;
      }
    }
  }

  const cssClass = small ? 'node small' : 'node';

  onMount(() => {
    if (aliasElement && short !== undefined && node.alias && node.alias.length > short) {
      new bootstrap.Tooltip(aliasElement);
    }

    if (circleElement) {
      new bootstrap.Tooltip(circleElement);
      new ClipboardJS(circleElement);
    }
  });
</script>

<span class={cssClass}>
  {#if node && node['public_key']}
    <span
      bind:this={circleElement}
      data-clipboard-text={node.public_key}
      data-bs-toggle="tooltip"
      data-bs-title={node.public_key}
      class="circle"
      style={`background-color: ${node.color};`}
    />
  {/if}
  {#if node && node['public_key']}
    <a
      class={underline ? color : `${color} no-underline`}
      href={`https://amboss.space/node/${node.public_key}`}
      target="_blank"
      bind:this={aliasElement}
      data-bs-toggle="tooltip"
      data-bs-title={node.alias ? node.alias : node.public_key}
      rel="noopener noreferrer"
    >
      {alias}
    </a>
  {:else}
    <span class="unknown"><i class="bi bi-question" /></span>
  {/if}
</span>

<style>
  .node {
    white-space: nowrap;
  }

  .small a {
    /*  font-size: .9em;*/
  }

  .circle {
    cursor: copy;
    display: inline-block;
    border-radius: 50%;
    width: 0.6em;
    height: 0.6em;
    border: 1px solid #888;
    vertical-align: middle;
    margin-right: 0.2em;
  }

  .small .unknown {
  }

  .no-underline {
    text-decoration: none;
  }

  .no-underline:hover {
    text-decoration: underline;
  }
</style>
