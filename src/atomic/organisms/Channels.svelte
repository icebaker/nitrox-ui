<script>
  import NodeAtom from '../atoms/Node.svelte';
  import Presenter from '../../helpers/presenter.js';
  import Liquidity from '../atoms/Liquidity.svelte';
  import FilterableData from '../molecules/FilterableData.svelte';

  const sortByOutbound = (channels) => {
    if (!channels) return [];

    channels.sort((a, b) =>
      a.myself.accounting.balance.millisatoshis > b.myself.accounting.balance.millisatoshis ? -1 : 1
    );
    return channels;
  };
</script>

<FilterableData
  service="nitrox-node"
  path="/hydrate/channels/mine"
  filterable={false}
  seconds={1}
  let:data={channels}
>
  <table class="table text-center table-hover">
    <thead>
      <tr>
        <th scope="col">Alias</th>
        <th scope="col">State</th>
        <th scope="col">Capacity <span class="text-secondary">丰</span></th>
        <th scope="col">PPM</th>
        <th scope="col">CTR</th>
        <th scope="col">Yield</th>
        <th scope="col">Outbound <span class="text-secondary">丰</span></th>
        <th scope="col">Balance</th>
        <th scope="col">Inbound <span class="text-secondary">丰</span></th>
      </tr>
    </thead>
    <tbody>
      {#each sortByOutbound(channels) as channel}
        <tr>
          <td><NodeAtom node={channel} /></td>
          <td><code>{channel.state}</code></td>
          <td>{Presenter.shortMoney(channel.capacity)}</td>
          <td class="text-success">{Presenter.number(channel.fee.ppm)}</td>
          <td class="text-danger">{Presenter.number(channel.cost)}</td>
          <td class={channel.yield > 0.0 ? 'text-primary' : 'text-danger'}
            >{Presenter.percent(channel.yield, 0, 0)}</td
          >
          <td>{Presenter.shortMoney(channel.local_balance)}</td>
          <td><Liquidity {channel} /></td>
          <td>{Presenter.shortMoney(channel.remote_balance)}</td>
        </tr>
      {/each}
    </tbody>
  </table>
</FilterableData>
