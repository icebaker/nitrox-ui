<script>
  import TimeAtom from '../../../atoms/Time.svelte';
  import NodeAtom from '../../../atoms/Node.svelte';
  import MilliSatsAtom from '../../../atoms/MilliSats.svelte';
  import NumberAtom from '../../../atoms/Number.svelte';
  import ShortenerAtom from '../../../atoms/Shortener.svelte';

  import Liquidity from '../../../atoms/Liquidity.svelte';

  import FilterableData from '../../../molecules/FilterableData.svelte';

  const sortByOutbound = (channels) => {
    if (!channels) return [];

    channels.sort((a, b) =>
      a.myself.accounting.balance.millisatoshis > b.myself.accounting.balance.millisatoshis ? -1 : 1
    );
    return channels;
  };
</script>

<FilterableData service="nitrox-channels" path="/mine" filterable={false} seconds={1} let:data>
  <table slot="data" class="table text-center table-hover">
    <thead>
      <tr>
        <th scope="col">State</th>
        <th scope="col">Channel</th>
        <th scope="col">Exposure</th>
        <th scope="col">Partner</th>
        <th scope="col">Capacity</th>
        <th scope="col">Base</th>
        <th scope="col">PPM</th>
        <th scope="col">Outbound</th>
        <th scope="col">Balance</th>
        <th scope="col">Inbound</th>
        <!--         <th scope="col">Uptime</th>
        <th scope="col">Sent</th>
        <th scope="col">Received</th> -->
        <th scope="col">Initiator</th>
      </tr>
    </thead>
    <tbody>
      {#each sortByOutbound(data.items) as channel (`channel-${channel._key}}`)}
        <tr>
          <td>
            {#if channel.state == 'active'}
              <i class="bi bi-check-circle-fill text-success" title={channel.state} />
            {:else}
              <i class="bi bi-dash-circle-fill text-danger" title={channel.state} />
            {/if}
          </td>
          <td><ShortenerAtom hash={channel.id} /></td>
          <td>{channel.exposure == 'private' ? 'Private' : 'Public'}</td>
          <td><NodeAtom node={channel.partner.node} /></td>
          <td><MilliSatsAtom milli={channel.accounting.capacity.millisatoshis} /></td>

          <td><NumberAtom value={channel.myself.policy.fee.base.millisatoshis} /></td>
          <td><NumberAtom value={channel.myself.policy.fee.rate.parts_per_million} /></td>

          <td class="border-start"
            ><MilliSatsAtom milli={channel.myself.accounting.balance.millisatoshis} /></td
          >
          <td><Liquidity {channel} /></td>
          <td><MilliSatsAtom milli={channel.partner.accounting.balance.millisatoshis} /></td>
          <td class="border-start">
            {#if channel.myself.initiator}
              <NodeAtom node={channel.myself.node} />
            {:else}
              <NodeAtom node={channel.partner.node} />
            {/if}
          </td>

          <!--           <td><TimeAtom at={channel.up_at} /></td>

          <td><MilliSatsAtom milli={channel.accounting.sent.millisatoshis} /></td>
          <td><MilliSatsAtom milli={channel.accounting.received.millisatoshis} /></td> -->
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
