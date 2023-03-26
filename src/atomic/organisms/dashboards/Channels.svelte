<script>
  import TimeAtom from '../../atoms/Time.svelte';
  import NodeAtom from '../../atoms/Node.svelte';
  import MilliSatsAtom from '../../atoms/MilliSats.svelte';
  import NumberAtom from '../../atoms/Number.svelte';
  import ShortenerAtom from '../../atoms/Shortener.svelte';
  import PercentageAtom from '../../atoms/Percentage.svelte';

  import Liquidity from '../../atoms/Liquidity.svelte';

  import FilterableData from '../../molecules/FilterableData.svelte';

  const sortByOutbound = (channels) => {
    if (!channels) return [];

    channels.sort((a, b) =>
      a.myself.accounting.balance.millisatoshis > b.myself.accounting.balance.millisatoshis ? -1 : 1
    );
    return channels;
  };
</script>

<FilterableData
  service="nitrox-accounting"
  path="/statements/channels/mine"
  filterable={false}
  seconds={1}
  let:data
>
  <table class="table text-center table-hover">
    <thead>
      <tr>
        <th scope="col">Channel</th>
        <th scope="col">Partner</th>

        <th scope="col" class="border-start">Base</th>
        <th scope="col">PPM</th>
        <th scope="col" class="border-start">CTR</th>
        <th scope="col">Spread</th>
        <th scope="col" class="border-start">Capacity <span class="text-secondary">丰</span></th>
        <th scope="col" class="border-start">Outbound <span class="text-secondary">丰</span></th>
        <th scope="col">Balance</th>
        <th scope="col">Inbound <span class="text-secondary">丰</span></th>
        <th scope="col">Exposure</th>
        <th scope="col" class="border-start">State</th>
      </tr>
    </thead>
    <tbody>
      {#each sortByOutbound(data.items) as channel (`statement-${channel._key}}`)}
        <tr>
          <td><ShortenerAtom hash={channel.id} /></td>
          <td><NodeAtom node={channel.partner.node} /></td>

          <td class="text-info border-start">
            <NumberAtom value={channel.myself.policy.fee.base.millisatoshis} />
          </td>
          <td class="text-info">
            <NumberAtom value={channel.myself.policy.fee.rate.parts_per_million} />
          </td>

          <td class="text-warning border-start">
            (<NumberAtom
              value={channel.accounting.analysis.cost_to_rebalance.parts_per_million}
              round={true}
            />)
          </td>
          <td>
            <PercentageAtom
              value={channel.accounting.projections.spread.percentage}
              precision={0}
              colors={true}
            />
          </td>

          <td class="border-start">
            <MilliSatsAtom milli={channel.accounting.capacity.millisatoshis} />
          </td>
          <td class="border-start">
            <MilliSatsAtom milli={channel.myself.accounting.balance.millisatoshis} />
          </td>
          <td><Liquidity {channel} /></td>
          <td><MilliSatsAtom milli={channel.partner.accounting.balance.millisatoshis} /></td>

          <td>{channel.exposure == 'private' ? 'Private' : 'Public'}</td>
          <td class="border-start"><code>{channel.state}</code></td>
        </tr>
      {/each}
    </tbody>
  </table>
</FilterableData>

<style>
  .direction {
    margin: 0 0.6em;
  }

  .in {
    padding-right: 2em;
  }

  .out {
    padding-left: 2em;
  }
</style>
