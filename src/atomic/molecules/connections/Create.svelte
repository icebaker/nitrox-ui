<script>
  import { nanoid } from 'nanoid';

  import Loading from '../../atoms/states/Loading.svelte';
  import Success from '../../atoms/states/Success.svelte';

  import Nitrox from '../../../components/nitrox';

  export let at;
  export let openAmount = false;

  let state = undefined;

  const connectionTemplate = {
    config: {
      kind: 'lndconnect',
      name: null,
      connect: null,
      address: null,
      certificate: null,
      macaroon: null,
      certificate_path: null,
      macaroon_path: null
    }
  };

  let newConnection = JSON.parse(JSON.stringify(connectionTemplate));

  let idempotencyKey = undefined;

  const prepare = () => {
    newConnection = JSON.parse(JSON.stringify(connectionTemplate));
    idempotencyKey = nanoid(20);
    state = 'prepare';
  };

  $: {
    if (at) prepare();
  }

  let baseUrl = undefined;

  const createConnection = async () => {
    if (baseUrl === undefined) {
      baseUrl = `${await Nitrox.service('connector')}`;
    }
    state = 'creating';

    const headers = {
      'Content-Type': 'application/json',
      'Idempotency-Key': idempotencyKey
    };

    const body = { connection: newConnection };

    const response = await fetch(`${baseUrl}/connections`, {
      method: 'POST',
      headers: headers,
      body: JSON.stringify(body)
    });

    state = 'created';
  };

  const switchKind = (newKind) => {
    newConnection.config.kind = newKind;
  };

  let previousValue = null;
</script>

{#if state === 'creating'}
  <div class="state">
    <Loading />
  </div>
{:else if state === 'created'}
  <div class="state">
    <Success message="Connection Created Successfully!" />
  </div>
{:else if state === 'prepare'}
  <form on:submit|preventDefault={createConnection}>
    <div class="mb-3">
      <label for="name" class="form-label">Name</label>
      <input
        bind:value={newConnection.config.name}
        placeholder="alice"
        type="text"
        class="form-control"
        id="name"
        aria-describedby="nameHelp"
      />
      <div id="nameHelp" class="form-text">The name for the connection.</div>
    </div>

    <ul class="nav nav-tabs" id="connect" role="tablist">
      <li class="nav-item" role="presentation">
        <button
          on:click={() => {
            switchKind('connect');
          }}
          class="nav-link active"
          id="connect-tab"
          data-bs-toggle="tab"
          data-bs-target="#connect-tab-pane"
          type="button"
          role="tab"
          aria-controls="connect-tab-pane"
          aria-selected="true"
        >
          URL
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button
          on:click={() => {
            switchKind('encoded');
          }}
          class="nav-link"
          id="encoded-tab"
          data-bs-toggle="tab"
          data-bs-target="#encoded-tab-pane"
          type="button"
          role="tab"
          aria-controls="encoded-tab-pane"
          aria-selected="false"
        >
          Encoded
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button
          on:click={() => {
            switchKind('path');
          }}
          class="nav-link"
          id="path-tab"
          data-bs-toggle="tab"
          data-bs-target="#path-tab-pane"
          type="button"
          role="tab"
          aria-controls="path-tab-pane"
          aria-selected="false"
        >
          Paths
        </button>
      </li>
    </ul>
    <div class="tab-content">
      <div
        class="tab-pane fade show active"
        id="connect-tab-pane"
        role="tabpanel"
        aria-labelledby="connect-tab"
        tabindex="0"
      >
        <div class="mb-3">
          <label for="connect" class="form-label">Connection URL</label>
          <input
            bind:value={newConnection.config.connect}
            placeholder="lndconnect://172.17.0.1:10009?cert=MIICJz...JBEERQ&macaroon=AgEDbG...45ukJ4"
            type="text"
            class="form-control"
            id="connect"
            aria-describedby="connectHelp"
          />
          <div id="connectHelp" class="form-text">
            Read more about <a
              href="https://github.com/LN-Zap/lndconnect"
              target="_blank"
              rel="noopener noreferrer">lnd connect URL</a
            >.
          </div>
        </div>
      </div>

      <div
        class="tab-pane fade"
        id="encoded-tab-pane"
        role="tabpanel"
        aria-labelledby="encoded-tab"
        tabindex="0"
      >
        {#if newConnection.config.kind === 'encoded'}
          <div class="mb-3">
            <label for="address" class="form-label">Address</label>
            <input
              bind:value={newConnection.config.address}
              placeholder="172.17.0.1:10009"
              type="text"
              class="form-control"
              id="address"
              aria-describedby="addressHelp"
            />
            <div id="addressHelp" class="form-text">
              The Node's address should include both the IP address and port number.
            </div>
          </div>
        {/if}

        <div class="mb-3">
          <label for="certificate" class="form-label">Certificate</label>
          <input
            bind:value={newConnection.config.certificate}
            placeholder="LS0tLS1CRU...UtLS0tLQo="
            type="text"
            class="form-control"
            id="certificate"
            aria-describedby="certificateHelp"
          />
          <div id="certificateHelp" class="form-text">
            The certificate for the Node can be provided in either Base64 or hexadecimal format.
          </div>
        </div>

        <div class="mb-3">
          <label for="macaroon" class="form-label">Macaroon</label>
          <input
            bind:value={newConnection.config.macaroon}
            placeholder="AgEDbG5kAv...inv45ukJ4="
            type="text"
            class="form-control"
            id="macaroon"
            aria-describedby="macaroonHelp"
          />
          <div id="macaroonHelp" class="form-text">
            The macaroon for the Node can be provided in either Base64 or hexadecimal format.
          </div>
        </div>
      </div>

      <div
        class="tab-pane fade"
        id="path-tab-pane"
        role="tabpanel"
        aria-labelledby="path-tab"
        tabindex="0"
      >
        {#if newConnection.config.kind === 'path'}
          <div class="mb-3">
            <label for="address" class="form-label">Address</label>
            <input
              bind:value={newConnection.config.address}
              placeholder="172.17.0.1:10009"
              type="text"
              class="form-control"
              id="address"
              aria-describedby="addressHelp"
            />
            <div id="addressHelp" class="form-text">
              The Node's address should include both the IP address and port number.
            </div>
          </div>
        {/if}

        <div class="mb-3">
          <label for="certificatePath" class="form-label">Certificate Path</label>
          <input
            bind:value={newConnection.config.certificate_path}
            placeholder="/lnd/tls.cert"
            type="text"
            class="form-control"
            id="certificatePath"
            aria-describedby="certificatePathHelp"
          />
          <div id="certificatePathHelp" class="form-text">
            The file path for the Node's certificate.
          </div>
        </div>

        <div class="mb-3">
          <label for="macaroonPath" class="form-label">Macaroon Path</label>
          <input
            bind:value={newConnection.config.macaroon_path}
            placeholder="/lnd/data/chain/bitcoin/mainnet/admin.macaroon"
            type="text"
            class="form-control"
            id="macaroonPath"
            aria-describedby="macaroonPathHelp"
          />
          <div id="macaroonPathHelp" class="form-text">The file path for the Node's macaroon.</div>
        </div>
      </div>
    </div>

    <div class="text-center border-top actions">
      <button type="submit" class="btn btn-primary">Create</button>
    </div>
  </form>
{/if}

<style>
  .mb-3 {
    /*  padding-bottom: .0em;*/
  }

  .actions {
    padding-top: 1em;
  }

  .tab-pane {
    padding-top: 1em;
  }
</style>
