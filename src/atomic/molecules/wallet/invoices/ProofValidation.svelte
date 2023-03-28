<script>
  import Invoice from './InvoiceValidation.svelte';

  export let invoice;
  export let modalElement = undefined;

  // ---------------------------------------

  import Cookies from 'js-cookie';

  import { onMount } from 'svelte';
  import { nanoid } from 'nanoid';

  let proofInput = undefined;

  onMount(() => {
    if (proofInput) proofInput.focus();
  });

  import Success from '../../../atoms/states/Success.svelte';

  import Nitrox from '../../../../components/nitrox';

  const invoiceProofTemplate = {
    code: undefined,
    secret: {
      proof: undefined,
      hash: undefined
    }
  };

  let invoiceProof = JSON.parse(JSON.stringify(invoiceProofTemplate));

  let state = 'prepare';

  let previousProof = invoice.secret.proof;

  const prepare = () => {
    invoiceProof = JSON.parse(JSON.stringify(invoiceProofTemplate));
    state = 'prepare';
    previousProof = invoice.secret.proof;
  };

  $: {
    if (invoiceProof.secret.proof) state = 'prepare';
    if (proofInput && invoice.secret.proof != previousProof) {
      proofInput.focus();
    }
    if (invoice.secret.proof != previousProof) prepare();
  }

  let baseUrl = undefined;

  let validationResult = undefined;

  const validateProof = async () => {
    if (baseUrl === undefined) {
      baseUrl = `${await Nitrox.service('receive')}`;
    }

    state = 'loading';

    invoiceProof.code = invoice.code;

    const body = { invoice: invoiceProof };

    const headers = {
      'Content-Type': 'application/json',
      'Nitrox-Connection-Id': Cookies.get('connection')
    };

    const response = await fetch(`${baseUrl}/invoices/validate`, {
      method: 'POST',
      headers: headers,
      body: JSON.stringify(body)
    });

    validationResult = await response.json();

    state = 'success';
  };
</script>

<Invoice {invoice} {modalElement} />

<form on:submit|preventDefault={validateProof} class="proof-form">
  <div class="mb-3">
    <label for="code" class="form-label">Proof of Payment</label>
    <input
      tabindex="1"
      bind:value={invoiceProof.secret.proof}
      bind:this={proofInput}
      placeholder="7db1e67359...56dedbf96e"
      type="text"
      class="form-control text-center"
      id="code"
      aria-describedby="codeHelp"
    />
    <div id="codeHelp" class="form-text">
      The <em>Proof of Payment</em>, also known as the <code>preimage</code>, is a unique identifier
      similar to
      <code>7db1e67359...56dedbf96e<code />. </code>
    </div>
  </div>
  {#if state === 'prepare'}
    <div class="text-center border-top actions">
      <button type="submit" class="btn btn-primary">Validate Proof of Payment</button>
    </div>
  {/if}
</form>

{#if state !== 'prepare'}
  <div class="result text-center">
    {#if state === 'loading'}
      <div class="loading">
        <div class="spinner-border" role="status">
          <span class="visually-hidden">Loading...</span>
        </div>
      </div>
    {:else if state === 'success'}
      {#if validationResult.valid_proof}
        <i class="bi bi-check-circle-fill text-success" />
        <p class="text-success-emphasis">The Proof of Payment is valid and legitimate.</p>
      {:else}
        <i class="bi bi-exclamation-triangle-fill text-danger" />
        <p class="message text-danger-emphasis">The Proof of Payment is invalid.</p>
      {/if}

      <input
        tabindex="1"
        bind:value={invoiceProof.secret.proof}
        type="text"
        class={`form-control text-center ${
          validationResult.valid_proof ? 'text-success' : 'text-danger'
        }`}
        readonly
      />
    {/if}
  </div>
{/if}

<style type="text/css">
  .proof-form {
    margin-top: 2em;
  }

  .result {
    padding: 1em 2em 2em 2em;
  }
  .result p {
    font-size: 1.1em;
  }

  .result i.bi {
    font-size: 2em;
  }

  .actions {
    padding-top: 1em;
  }
</style>
