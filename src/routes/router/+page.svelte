<script>
  import Failures from '../../atomic/organisms/dashboards/Failures.svelte';
  import Channels from '../../atomic/organisms/router/Channels.svelte';
  import Routes from '../../atomic/organisms/router/Routes.svelte';

  import FailuresByChannel from '../../atomic/organisms/dashboards/FailuresByChannel.svelte';

  let from_channel = undefined;
  let from_node = undefined;
  let to_node = undefined;
  let to_channel = undefined;

  let path = `/rebalance?from_node=${from_node}&from_channel=${from_channel}&to_node=${to_node}&to_channel=${to_channel}`;

  const updateRoute = (message) => {
    from_channel = message.detail.from.id;
    to_channel = message.detail.to.id;
    from_node = message.detail.from.partner.node.public_key;
    to_node = message.detail.to.partner.node.public_key;
    path = `/rebalance?from_node=${from_node}&from_channel=${from_channel}&to_node=${to_node}&to_channel=${to_channel}`;
  };
</script>

<div class="container">
  <h1>Router</h1>

  <div class="row">
    <div class="col">
      <div class="card">
        <div class="card-body">
          <h4 class="card-title">Last Failures</h4>
          <Failures channelIn={false} />
        </div>
      </div>
    </div>
    <div class="col">
      <div class="card">
        <div class="card-body">
          <h4 class="card-title">Failures by Channel</h4>
          <FailuresByChannel />
        </div>
      </div>
    </div>
  </div>
  <br />
  <div class="card">
    <div class="card-body">
      <h4 class="card-title">Channels</h4>
      <Channels on:message={updateRoute} />
    </div>
  </div>
  {#if from_node && to_node}
    <br />
    <div class="card">
      <div class="card-body">
        <h4 class="card-title">Possible Routes</h4>
        <Routes {path} />
      </div>
    </div>
  {/if}
</div>

<style>
  h1 {
    margin-top: -1.4em;
    margin-bottom: 1em;
  }

  h4 {
    margin-bottom: -1.1em;
  }

  .container {
    margin-bottom: 4em;
  }
</style>
