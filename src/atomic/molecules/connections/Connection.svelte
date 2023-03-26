<script>
  import { onMount } from 'svelte';

  import Prism from 'prismjs';
  import 'prismjs/components/prism-json.min';
  import 'prismjs/themes/prism-tomorrow.css';
  import 'prism-svelte';

  export let connection;

  let codeElementA = undefined;

  const updateCode = () => {
    if (connection.state && codeElementA) {
      codeElementA.innerHTML = Prism.highlight(
        JSON.stringify(connection.state, false, 2),
        Prism.languages.javascript,
        'javascript'
      );
    }
  };

  onMount(async () => {
    updateCode();
  });

  $: {
    if (connection) updateCode();
  }
</script>

<table class="table table-hover text-start">
  <tbody>
    {#if connection.config}
      <tr>
        <th scope="col" class="text-end">Name</th>
        <td>{connection.config.name}</td>
      </tr>
      <tr>
        <th scope="col" class="text-end">Config</th>
        <td>{connection.config.kind}</td>
      </tr>
      {#if connection.config.connect}
        <tr>
          <th scope="col" class="text-end">Connection URL</th>
          <td><code class="text-break">{connection.config.connect}</code></td>
        </tr>
      {/if}
      {#if connection.config.address}
        <tr>
          <th scope="col" class="text-end">Address</th>
          <td><code class="text-break">{connection.config.address}</code></td>
        </tr>
      {/if}
      {#if connection.config.certificate}
        <tr>
          <th scope="col" class="text-end">Certificate</th>
          <td><code class="text-break">{connection.config.certificate}</code></td>
        </tr>
      {/if}
      {#if connection.config.macaroon}
        <tr>
          <th scope="col" class="text-end">Macaroon</th>
          <td><code class="text-break">{connection.config.macaroon}</code></td>
        </tr>
      {/if}
      {#if connection.config.certificate_path}
        <tr>
          <th scope="col" class="text-end">Certificate Path</th>
          <td><code class="text-break">{connection.config.certificate_path}</code></td>
        </tr>
      {/if}
      {#if connection.config.macaroon_path}
        <tr>
          <th scope="col" class="text-end">Macaroon Path</th>
          <td><code class="text-break">{connection.config.macaroon_path}</code></td>
        </tr>
      {/if}
    {/if}
  </tbody>
</table>

<div class="card">
  <div class="card-header">State</div>
  <div class="card-body">
    <pre class="language-javascript"><code bind:this={codeElementA} /></pre>
  </div>
</div>

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
