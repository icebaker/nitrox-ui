<script>
  import { onMount } from 'svelte';

  import Themes from '../atoms/Themes.svelte';

  let etymologyElement = undefined;
  let serviceDiscoveryElement = undefined;
  let connectionsElement = undefined;

  onMount(() => {
    if (etymologyElement) new bootstrap.Tooltip(etymologyElement);
    if (serviceDiscoveryElement) new bootstrap.Tooltip(serviceDiscoveryElement);
    if (connectionsElement) new bootstrap.Tooltip(connectionsElement);
  });
</script>

<div class="container header">
  <div class="actions">
    <a
      href="/etymology"
      class="btn btn-outline-secondary"
      bind:this={etymologyElement}
      data-bs-placement="bottom"
      data-bs-toggle="tooltip"
      data-bs-title="Etymology"
    >
      <i class="bi bi-body-text" />
    </a>
    <a
      href="/service-discovery"
      class="btn btn-outline-secondary"
      bind:this={serviceDiscoveryElement}
      data-bs-placement="bottom"
      data-bs-toggle="tooltip"
      data-bs-title="Service Discovery"
    >
      <i class="bi bi-modem" />
    </a>
    <a
      href="/connections"
      class="btn btn-outline-secondary"
      bind:this={connectionsElement}
      data-bs-placement="bottom"
      data-bs-toggle="tooltip"
      data-bs-title="Connections"
    >
      <i class="bi bi-hdd-network" />
    </a>
    <span class="themes">
      <Themes at={performance.now()} />
    </span>
  </div>
</div>

<style>
  .header {
    position: relative;
    margin-top: 2em;
    text-align: center;
  }

  .themes {
    margin-left: 0.3em;
  }

  .actions a {
    margin-right: 1em;
  }

  .actions {
    position: absolute;
    text-align: right;
    top: 0;
    right: 0;
  }
</style>
