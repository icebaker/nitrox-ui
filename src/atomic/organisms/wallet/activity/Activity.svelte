<script>
  import LayerAtom from '../../../atoms/activity/Layer.svelte';
  import DirectionAtom from '../../../atoms/activity/Direction.svelte';
  import HowAtom from '../../../atoms/payments/How.svelte';
  import NumberAtom from '../../../atoms/Number.svelte';
  import PercentageAtom from '../../../atoms/Percentage.svelte';
  import MilliSatsAtom from '../../../atoms/MilliSats.svelte';

  import TimeAtom from '../../../atoms/Time.svelte';
  import ShortenerAtom from '../../../atoms/Shortener.svelte';

  import Presenter from '../../../../helpers/presenter.js';
  import FilterableData from '../../../molecules/FilterableData.svelte';

  const DEBUG_MODE = false;
</script>

<FilterableData
  service="nitrox-receive"
  path="/activities"
  filterable={true}
  controls={false}
  filter="limit:10"
  example="limit:10"
  let:data
>
  <div slot="header">
    <div class="container px-4 text-center balances">
      <div class="row gx-5">
        <div class="col-1" />
        <div class="col">
          <div class="p-3">
            <div class="card mb-3">
              <div class="card-header">
                <LayerAtom layer="bitcoin" />
                Bitcoin
              </div>
              <div class="card-body">
                <p class="card-text">
                  <MilliSatsAtom milli={data.wallet.bitcoin.millisatoshis} />
                </p>
              </div>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="p-4">
            <div class="card mb-3">
              <div class="card-header">
                <LayerAtom layer="lightning" />
                Lightning
              </div>
              <div class="card-body">
                <p class="card-text">
                  <MilliSatsAtom milli={data.wallet.lightning.millisatoshis} />
                </p>
              </div>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="p-4">
            <div class="card mb-3">
              <div class="card-header">Total</div>
              <div class="card-body">
                <p class="card-text">
                  <MilliSatsAtom milli={data.wallet.total.millisatoshis} />
                </p>
              </div>
            </div>
          </div>
        </div>
        <div class="col-1" />
      </div>
    </div>
  </div>
  <div slot="data">
    <table class="table text-center table-hover">
      <thead>
        <tr>
          <th scope="col">At</th>
          <th scope="col">Direction</th>
          <th scope="col">Layer</th>
          <th scope="col">How</th>
          <th scope="col">Amount</th>
          <th scope="col">Details</th>
          <th scope="col">Message</th>
        </tr>
      </thead>
      <tbody>
        {#each data.items as activity (`activity-${activity._key}`)}
          <tr>
            <!--
              Should activities have hops for everything?
                Hops makes sense from spontaenous receibed payments?
                Hops makes sense for forwards? Or even: Do they exist?
            -->
            <td valign="middle"><TimeAtom at={activity.at} /></td>
            <td valign="middle">
              <DirectionAtom direction={activity.direction} />
            </td>
            <td valign="middle">
              <LayerAtom layer={activity.layer} />
            </td>
            <td valign="middle">
              <HowAtom how={activity.how} />
            </td>
            <td valign="middle">
              {#if activity.direction == 'in'}
                <span class="text-success">
                  +<MilliSatsAtom milli={activity.amount.millisatoshis} /></span
                >
              {:else}
                <span class="text-danger"
                  >-<MilliSatsAtom milli={activity.amount.millisatoshis} /></span
                >
              {/if}
            </td>
            <td>
              {#if activity.invoice && activity.invoice.description.memo}
                <ShortenerAtom hash={activity.invoice.description.memo} limit={30} code={false} />
              {:else if activity.transaction && activity.transaction.label}
                <ShortenerAtom hash={activity.transaction.label} limit={50} code={false} />
              {:else}
                -
              {/if}
            </td>
            <td>
              {#if activity.message}
                <ShortenerAtom hash={activity.message} limit={30} code={false} />
              {:else}
                -
              {/if}
            </td>
          </tr>
        {/each}
      </tbody>
    </table>

    {#if DEBUG_MODE}
      <div class="container px-4 text-center">
        <div class="row gx-5">
          <div class="col">
            <div class="p-3">
              <div class="card mb-3">
                <div class="card-header">Total Activities</div>
                <div class="card-body">
                  <p class="card-text">
                    <NumberAtom value={data.analysis.count} />
                  </p>
                </div>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="p-4">
              <div class="card mb-3">
                <div class="card-header">In</div>
                <div class="card-body">
                  <p class="card-text">
                    <MilliSatsAtom milli={data.analysis.in.millisatoshis} />
                  </p>
                </div>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="p-4">
              <div class="card mb-3">
                <div class="card-header">Out</div>
                <div class="card-body">
                  <p class="card-text">
                    <MilliSatsAtom milli={data.analysis.out.millisatoshis} />
                  </p>
                </div>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="p-4">
              <div class="card mb-3">
                <div class="card-header">Balance</div>
                <div class="card-body">
                  <p class="card-text">
                    <MilliSatsAtom milli={data.analysis.balance.millisatoshis} />
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    {/if}
  </div>
</FilterableData>

<style>
  .balances {
    margin: 2em 0 1em 0;
  }
</style>
