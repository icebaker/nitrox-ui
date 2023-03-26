<script>
  import TimeAtom from '../../atoms/Time.svelte';
  import NodeAtom from '../../atoms/Node.svelte';
  import MilliSatsAtom from '../../atoms/MilliSats.svelte';
  import NumberAtom from '../../atoms/Number.svelte';
  import ShortenerAtom from '../../atoms/Shortener.svelte';
  import PercentageAtom from '../../atoms/Percentage.svelte';

  import Route from '../../molecules/router/Route.svelte';

  import Liquidity from '../../atoms/Liquidity.svelte';

  import FilterableData from '../../molecules/FilterableData.svelte';

  export let path;
</script>

<br />

<FilterableData
  service="nitrox-router"
  {path}
  filterable={true}
  autoReload={false}
  url={false}
  responseTime={true}
  filter="limit:10 zero:false"
  example="limit:10 satoshis:1000 capacity:1000000 zero:false search:alias"
  let:data
>
  <table class="table text-center table-hover">
    <tbody>
      {#each data.items as route (`statement-${route._key}}`)}
        <tr>
          <td>
            <Route {route} />
          </td>
        </tr>
      {/each}
    </tbody>
  </table>
</FilterableData>
