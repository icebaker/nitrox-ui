<script>
  import TimeAtom from '../../atoms/Time.svelte';
  import NodeAtom from '../../atoms/Node.svelte';
  import MilliSatsAtom from '../../atoms/MilliSats.svelte';
  import NumberAtom from '../../atoms/Number.svelte';
  import ShortenerAtom from '../../atoms/Shortener.svelte';
  import PercentageAtom from '../../atoms/Percentage.svelte';

  import Liquidity from '../../atoms/Liquidity.svelte';

  import FilterableData from '../../molecules/FilterableData.svelte';
</script>

<FilterableData
  service="nitrox-accounting"
  path="/statements/nodes/myself"
  filterable={false}
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
        <th scope="col">Yield</th>

        <th scope="col" class="border-start">PPM</th>

        <th scope="col">Revenue</th>
        <th scope="col">Expenses</th>
        <th scope="col">Net</th>
        <th scope="col">Profit</th>
      </tr>
    </thead>
    <tbody>
      {#each data.channels as channel (`statement-${channel._key}`)}
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

          <td>
            <PercentageAtom
              value={channel.accounting.projections.yield.percentage}
              min={5}
              precision={5}
              colors={true}
            />
          </td>

          <td class="border-start text-info">
            <NumberAtom
              value={channel.accounting.analysis.earnings_per_forwarding.parts_per_million}
              round={true}
            />
          </td>

          <td class="text-info">
            <MilliSatsAtom milli={channel.accounting.statement.revenue.millisatoshis} />
          </td>
          <td class="text-warning">
            (<MilliSatsAtom milli={channel.accounting.statement.expenses.millisatoshis} />)
          </td>
          <td>
            <MilliSatsAtom
              milli={channel.accounting.statement.net_income.millisatoshis}
              colors={true}
            />
          </td>
          <td>
            <PercentageAtom
              value={channel.accounting.statement.profit.percentage}
              precision={0}
              colors={true}
            />
          </td>
        </tr>
      {/each}
      <tr class="fw-bold">
        <td colspan="7" />
        <td class="border-start" />
        <td class="text-info">
          <MilliSatsAtom milli={data.statement.revenue.millisatoshis} />
        </td>
        <td class="text-warning">
          (<MilliSatsAtom milli={data.statement.expenses.millisatoshis} />)
        </td>
        <td>
          <MilliSatsAtom milli={data.statement.net_income.millisatoshis} colors={true} />
        </td>
        <td>
          <PercentageAtom value={data.statement.profit.percentage} precision={0} colors={true} />
        </td>
      </tr>
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
