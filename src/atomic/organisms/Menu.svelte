<script>
  import FilterableData from '../molecules/FilterableData.svelte';
</script>

<nav>
  <FilterableData
    service="nitrox-discovery"
    path="/"
    filterable={false}
    autoReload={false}
    lean={true}
    let:data
  >
    <div slot="loader">
      <div class="menu-item loader">
        <div class="spinner-border spinner-border-sm" role="status">
          <span class="visually-hidden">Loading...</span>
        </div>
      </div>
    </div>

    <div slot="failure">
      <a class="menu-item link-light" href="/">Nitrox</a>
    </div>

    <div slot="data">
      <a class="menu-item link-light" href="/">Nitrox</a>

      {#if data.services['nitrox-channels']}
        <a class="menu-item link-light" href="/wallet/channels">Channels</a>
      {/if}

      {#if data.services['nitrox-receive']}
        <a class="menu-item link-light" href="/wallet/activity">
          <i class="bi bi-wallet2" />
          Activity
        </a>
      {/if}

      {#if data.services['nitrox-receive']}
        <a class="menu-item link-light" href="/wallet/invoices">
          <i class="bi bi-box-arrow-in-down-right" />
          Receive
        </a>
      {/if}

      {#if data.services['nitrox-send']}
        <a class="menu-item link-light" href="/wallet/payments">
          <i class="bi bi-box-arrow-up-right" />
          Send
        </a>
      {/if}
    </div>

    <!-- <a class="menu-item link-light" href="/insights">Insights</a>
    <a class="menu-item link-light" href="/forwards">Forwards</a>
    <a class="menu-item link-light" href="/failures">Failures</a>
    <a class="menu-item link-light" href="/router">Router</a>
    <a class="menu-item link-light" href="/accounting">Accounting</a>
    <a class="menu-item link-light" href="/status">Status</a> -->
  </FilterableData>
</nav>

<style>
  nav {
    padding: 0 3em 1em 2em;
    position: fixed;
    bottom: -1em;
    right: 50%;
    transform: translate(50%, 0%);
    border-radius: 1em;
    z-index: 99;
    background: rgb(247, 37, 133);
    background: linear-gradient(
      90deg,
      rgba(247, 37, 133, 1) 0%,
      rgba(114, 9, 183, 1) 50%,
      rgba(58, 12, 163, 1) 100%
    );
    opacity: 0.9;
    backdrop-filter: blur(6px);
    white-space: nowrap;
  }

  nav .menu-item {
    display: inline-block;
    padding: 1em 1.4em;
    text-decoration: none;
    position: relative;
  }

  nav a:hover {
    opacity: 0.8;
  }

  .loader {
    margin-left: 0.4em;
  }
</style>
