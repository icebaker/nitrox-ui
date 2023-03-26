<script>
  import Presenter from '../../helpers/presenter.js';
  import MilliSatsAtom from './MilliSats.svelte';

  import { onMount } from 'svelte';

  export let channel = {};

  let tooltipElement = undefined;

  const unsettled = `Unsettled: ${Presenter.shortMoney(
    channel.accounting.unsettled.millisatoshis / 1000.0
  )}`;

  onMount(() => {
    if (tooltipElement && channel.accounting.unsettled.millisatoshis > 0.0)
      new bootstrap.Tooltip(tooltipElement);
  });
</script>

<div
  class="progress-stacked"
  bind:this={tooltipElement}
  data-bs-toggle="tooltip"
  data-bs-title={unsettled}
>
  <div
    class="progress"
    role="progressbar"
    aria-label="Segment one"
    aria-valuenow="15"
    aria-valuemin="0"
    aria-valuemax="100"
    style={`width: ${
      (channel.myself.accounting.balance.millisatoshis /
        channel.accounting.capacity.millisatoshis) *
      100.0
    }%`}
  >
    <div class="progress-bar bg-info" />
  </div>

  <div
    class="progress-bar progress-bar-striped progress-bar-animated"
    role="progressbar"
    aria-label="Segment two"
    aria-valuenow="30"
    aria-valuemin="0"
    aria-valuemax="100"
    style={`width: ${
      (channel.accounting.unsettled.millisatoshis / channel.accounting.capacity.millisatoshis) *
      100.0
    }%`}
  >
    <div class="progress-bar" />
  </div>

  <div
    class="progress"
    role="progressbar"
    aria-label="Segment two"
    aria-valuenow="30"
    aria-valuemin="0"
    aria-valuemax="100"
    style={`width: ${
      (channel.partner.accounting.balance.millisatoshis /
        channel.accounting.capacity.millisatoshis) *
      100.0
    }%`}
  >
    <div class="progress-bar bg-warning" />
  </div>
</div>
