<script>
  import Modal from '../../../molecules/Modal.svelte';
  import FleetingDetails from '../../../molecules/fleeting/Details.svelte';
  import FleetingRow from '../../../molecules/fleeting/Row.svelte';

  import PurposeAtom from '../../../atoms/payments/Purpose.svelte';
  import ThroughAtom from '../../../atoms/payments/Through.svelte';
  import HowAtom from '../../../atoms/payments/How.svelte';
  import NumberAtom from '../../../atoms/Number.svelte';
  import PercentageAtom from '../../../atoms/Percentage.svelte';
  import MilliSatsAtom from '../../../atoms/MilliSats.svelte';

  import TimeAtom from '../../../atoms/Time.svelte';
  import ShortenerAtom from '../../../atoms/Shortener.svelte';
  import HopsToggler from '../../../molecules/wallet/payments/HopsToggler.svelte';

  import Presenter from '../../../../helpers/presenter.js';
  import FilterableData from '../../../molecules/FilterableData.svelte';

  let fleetingModal = undefined;
  let modalTitle = null;

  const openFleeting = (fleeting, kind) => {
    modalTitle = kind === 'error' ? 'Error Details' : 'Pending Details';
    if (fleetingModal) fleetingModal.open(fleeting);
  };
</script>

<FilterableData
  service="nitrox-send"
  path="/payments"
  filterable={true}
  filter="limit:10"
  example="purpose:rebalance purpose:!rebalance limit:10"
  let:data
>
  <table slot="data" class="table text-center table-hover">
    <thead>
      <tr>
        <th scope="col">At</th>
        <th scope="col">Purpose</th>
        <th scope="col">How</th>
        <th scope="col">Through</th>
        <th scope="col">Amount</th>
        <th scope="col">Fee</th>
        <th scope="col">PPM</th>
        <th scope="col">Message</th>
        <th scope="col">Hops</th>
        <th scope="col" />
      </tr>
    </thead>
    <tbody>
      {#each data.items as payment (`payment-${payment._key}`)}
        {#if payment._fleeting}
          <FleetingRow fleeting={payment} opener={openFleeting} colspan="8" />
        {:else}
          <tr>
            <td valign="middle"><TimeAtom at={payment.at} /></td>
            <td valign="middle"><PurposeAtom purpose={payment.purpose} /></td>
            <td valign="middle"><HowAtom how={payment.how} /></td>
            <td valign="middle"><ThroughAtom through={payment.through} /></td>
            <td valign="middle"><MilliSatsAtom milli={payment.amount.millisatoshis} /></td>
            <td valign="middle"><MilliSatsAtom milli={payment.fee.millisatoshis} as="milli" /></td>
            <td valign="middle"
              ><NumberAtom value={payment.fee.parts_per_million} round={true} /></td
            >
            <td valign="middle">
              {#if payment.message}
                <ShortenerAtom hash={payment.message} limit={22} code={false} />
              {:else}
                -
              {/if}
            </td>
            <HopsToggler {payment} />
          </tr>
        {/if}
      {/each}
    </tbody>
  </table>
</FilterableData>

<Modal title={modalTitle} size="lg" bind:this={fleetingModal} let:data>
  {#if data !== undefined}
    <FleetingDetails fleeting={data} />
  {/if}
</Modal>
