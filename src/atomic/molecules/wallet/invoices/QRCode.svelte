<script>
  import Nitrox from '../../../../components/nitrox';

  import Failure from '../../Failure.svelte';

  export let code;

  let baseUrl = undefined;

  let state = 'loading';

  let imageSource = undefined;

  let requestFailure = null;

  const loadQRCode = async () => {
    state = 'loading';

    if (baseUrl === undefined) {
      baseUrl = `${await Nitrox.service('render')}/qr-code.svg`;
    }

    const requestUrl = `${baseUrl}?code=${code}`;
    try {
      const response = await fetch(requestUrl);
      imageSource = await response.text();
      state = 'ready';
    } catch (error) {
      requestFailure = { at: Date.now(), url: requestUrl, error: error };
      state = 'ready';
    }
  };

  $: {
    if (code) loadQRCode();
  }
</script>

<div>
  {#if state !== 'ready'}
    <div class="loading">
      <div class="spinner-border" role="status">
        <span class="visually-hidden">Loading...</span>
      </div>
    </div>
  {:else if requestFailure}
    <Failure failure={requestFailure} />
  {:else}
    <div class="qr-code">
      {@html imageSource}
    </div>
  {/if}
</div>

<style>
  .details {
    margin-top: 1em;
  }
  .qr-code {
    background: #fff;
    padding: 1em;
    width: 100%;
    margin: auto;
  }

  .loading {
    text-align: center;
    padding: 2em 0;
  }
</style>
