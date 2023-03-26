<script>
  import Cookies from 'js-cookie';

  import TimeAtom from '../atoms/Time.svelte';
  import NodeAtom from '../atoms/Node.svelte';
  import MilliSatsAtom from '../atoms/MilliSats.svelte';
  import NumberAtom from '../atoms/Number.svelte';
  import EmptyAtom from '../atoms/Empty.svelte';
  import ShortenerAtom from '../atoms/Shortener.svelte';
  import FleetingDetails from '../molecules/fleeting/Details.svelte';

  import Liquidity from '../atoms/Liquidity.svelte';

  import FilterableData from '../molecules/FilterableData.svelte';

  const nitroxPattern = /nitrox/;
  const localhostPattern = /localhost/;
  const ipPattern = /\d+\.\d+/;

  const mapServices = (raw) => {
    const ids = Object.keys(raw).sort();

    const services = [];

    ids.forEach((id) => {
      if (nitroxPattern.test(id)) services.push(id);
    });

    ids.forEach((id) => {
      if (!nitroxPattern.test(id)) services.push(id);
    });

    return services.map((id) => {
      let address = raw[id].address;

      if (!ipPattern.test(address) && !localhostPattern.test(address)) {
        address = `${raw['nitrox-proxy'].address}/${id}`;
      }

      let link = true;

      if (['memcached', 'redpanda'].includes(id)) link = false;

      return {
        id: id,
        address: address,
        broadcast_at: raw[id].updated_at,
        link: link
      };
    });
  };
</script>

<FilterableData service="nitrox-discovery" path="/" filterable={false} seconds={30} let:data>
  <div slot="data">
    <table class="table text-center table-hover">
      <thead>
        <tr>
          <th scope="col">Service</th>
          <th scope="col">Broadcast</th>
          <th scope="col">Address</th>
        </tr>
      </thead>
      <tbody>
        {#each mapServices(data.services) as service (`service-${service.id}}`)}
          <tr>
            <td>{service.id}</td>
            <td><TimeAtom at={service.broadcast_at} /></td>
            <td>
              {#if service.link}
                <a href={`http://${service.address}`} target="_blank" title={service.id}
                  >{service.address}</a
                >
              {:else}
                <code>{service.address}</code>
              {/if}
            </td>
          </tr>
        {/each}
      </tbody>
    </table>
  </div>
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
