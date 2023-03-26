<script>
  import { onMount } from 'svelte';

  import Prism from 'prismjs';
  import 'prismjs/components/prism-json.min';
  import 'prismjs/themes/prism-tomorrow.css';
  import 'prism-svelte';

  import TimeAtom from '../../atoms/Time.svelte';
  import Table from './Table.svelte';

  export let fleeting;

  let codeElementA = undefined;
  let codeElementB = undefined;
  let codeElementC = undefined;
  let codeElementD = undefined;

  const updateCode = () => {
    if (fleeting.error) {
      if (fleeting.error.request && codeElementA) {
        codeElementA.innerHTML = Prism.highlight(
          JSON.stringify(fleeting.error.request, false, 2),
          Prism.languages.javascript,
          'javascript'
        );
      }

      if (fleeting.error.response && codeElementB) {
        codeElementB.innerHTML = Prism.highlight(
          JSON.stringify(fleeting.error.response, false, 2),
          Prism.languages.javascript,
          'javascript'
        );
      }

      if (fleeting.error.grpc && codeElementC) {
        codeElementC.innerHTML = Prism.highlight(
          JSON.stringify(fleeting.error.grpc, false, 2),
          Prism.languages.javascript,
          'javascript'
        );
      }
    }

    if (fleeting.request && codeElementD) {
      codeElementD.innerHTML = Prism.highlight(
        JSON.stringify(fleeting.request, false, 2),
        Prism.languages.javascript,
        'javascript'
      );
    }
  };
  onMount(async () => {
    updateCode();
  });

  $: {
    if (fleeting) updateCode();
  }
</script>

<div class="fleeting">
  <Table {fleeting} />

  <div class={`card ${fleeting.error && fleeting.error.request ? '' : 'd-none'}`}>
    <div class="card-header">GRPC Request</div>
    <div class="card-body">
      <pre class="language-javascript"><code bind:this={codeElementA} /></pre>
    </div>
  </div>

  <div class={`card ${fleeting.error && fleeting.error.response ? '' : 'd-none'}`}>
    <div class="card-header">GRPC Response</div>
    <div class="card-body">
      <pre class="language-javascript"><code bind:this={codeElementB} /></pre>
    </div>
  </div>

  <div class={`card ${fleeting.error && fleeting.error.grpc ? '' : 'd-none'}`}>
    <div class="card-header">GRPC Error</div>
    <div class="card-body">
      <pre class="language-javascript"><code bind:this={codeElementC} /></pre>
    </div>
  </div>

  <div class={`card ${fleeting.request ? '' : 'd-none'}`}>
    <div class="card-header">Lighstorm Request</div>
    <div class="card-body">
      <pre class="language-javascript"><code bind:this={codeElementD} /></pre>
    </div>
  </div>
</div>

<style>
  pre {
    white-space: pre-wrap;
  }

  .card {
    margin-top: 1.4em;
  }
</style>
