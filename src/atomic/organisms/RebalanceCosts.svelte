<script>
  import NodeAtom from '../atoms/Node.svelte';
  import Presenter from '../../helpers/presenter.js';
  import FilterableData from '../molecules/FilterableData.svelte';
</script>

<FilterableData
  service="nitrox-node"
  path="/payments/rebalance/costs"
  seconds={30}
  example="days_ago:180"
  let:data={channels}
>
  <table class="table text-center table-hover">
    <thead>
      <tr>
        <th scope="col">Channel</th>
        <th scope="col">Total <span class="text-secondary">丰</span></th>
        <th scope="col">Fee</th>
        <th scope="col">Cost</th>
        <th scope="col">PPM</th>
      </tr>
    </thead>
    <tbody>
      {#each channels.slice(0, 10) as channel}
        <tr>
          <td><NodeAtom node={channel} /></td>
          <td>{Presenter.shortMoney(channel.value)}</td>
          <td>{Presenter.shortMoney(channel.fee)}</td>
          <td>{Presenter.percent(channel.cost, 0, 4)}</td>
          <td>{channel.ppm}</td>
        </tr>
      {/each}
    </tbody>
  </table>
</FilterableData>
