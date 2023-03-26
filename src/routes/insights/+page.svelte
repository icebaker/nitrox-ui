<script>
  import Channels from '../../atomic/organisms/dashboards/Channels.svelte';
  import Rebalances from '../../atomic/organisms/dashboards/Rebalances.svelte';
  import Failures from '../../atomic/organisms/dashboards/Failures.svelte';
  import Forwards from '../../atomic/organisms/dashboards/Forwards.svelte';
  import FailuresByChannel from '../../atomic/organisms/dashboards/FailuresByChannel.svelte';
  import ForwardsByChannel from '../../atomic/organisms/dashboards/ForwardsByChannel.svelte';
</script>

<div class="container">
  <h1>Insights</h1>

  <div class="card">
    <div class="card-body">
      <h4 class="card-title">Channels</h4>
      <Channels />
    </div>
  </div>
  <br />
  <div class="row">
    <div class="col">
      <div class="card">
        <div class="card-body">
          <h4 class="card-title">Last Forwards</h4>
          <Forwards />
        </div>
      </div>
      <br />
      <div class="card">
        <div class="card-body">
          <h4 class="card-title">Forwards In</h4>
          <ForwardsByChannel direction="in" />
        </div>
      </div>
      <br />
      <div class="card">
        <div class="card-body">
          <h4 class="card-title">Forwards Out</h4>
          <ForwardsByChannel direction="out" />
        </div>
      </div>
    </div>
    <div class="col">
      <div class="card">
        <div class="card-body">
          <h4 class="card-title">Last Failures</h4>
          <Failures />
        </div>
      </div>
      <br />
      <div class="card">
        <div class="card-body">
          <h4 class="card-title">Failures by Channel</h4>
          <FailuresByChannel />
        </div>
      </div>
      <br />
      <div class="card">
        <div class="card-body">
          <h4 class="card-title">Last Rebalances</h4>
          <Rebalances />
        </div>
      </div>
    </div>
  </div>
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
