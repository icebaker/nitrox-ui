<script>
  import PurposeAtom from '../../atoms/payments/Purpose.svelte';
  import NumberAtom from '../../atoms/Number.svelte';
  import PercentageAtom from '../../atoms/Percentage.svelte';
  import MilliSatsAtom from '../../atoms/MilliSats.svelte';
  import NodeAtom from '../../atoms/Node.svelte';

  import TimeAtom from '../../atoms/Time.svelte';
  import ShortenerAtom from '../../atoms/Shortener.svelte';
  import HopsToggler from '../../molecules/wallet/payments/HopsToggler.svelte';

  import Presenter from '../../../helpers/presenter.js';
  import FilterableData from '../../molecules/FilterableData.svelte';
</script>

<FilterableData
  service="nitrox-node"
  path="/payments"
  filterable={false}
  filter="purpose:rebalance limit:5"
  seconds={1}
  let:data
>
  <table class="table text-center table-hover">
    <thead>
      <tr>
        <th scope="col">Created</th>
        <th scope="col">Amount</th>
        <th scope="col">CTR</th>
        <th scope="col">
          From
          <i class="bi bi-box-arrow-up-right direction text-warning-emphasis" />
        </th>
        <th scope="col">
          <i class="bi bi-box-arrow-in-down-right direction text-success-emphasis" />
          To
        </th>
      </tr>
    </thead>
    <tbody>
      {#each data.items as payment (`payment-${payment._key}`)}
        <tr>
          <td valign="middle"><TimeAtom at={payment.created_at} /></td>
          <td valign="middle"><MilliSatsAtom milli={payment.request.amount.millisatoshis} /></td>
          <td valign="middle"><NumberAtom value={payment.fee.parts_per_million} round={true} /></td>
          <td>
            <NodeAtom node={payment.from.channel.exit} />
          </td>
          <td>
            <NodeAtom node={payment.to.channel.entry} />
          </td>
        </tr>
      {/each}
    </tbody>
  </table>
</FilterableData>

<style>
  .direction {
    margin: 0 0.3em;
  }
</style>
