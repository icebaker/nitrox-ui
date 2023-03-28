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
  import PaymentProof from '../../../molecules/wallet/payments/PaymentProof.svelte';

  import Presenter from '../../../../helpers/presenter.js';
  import FilterableData from '../../../molecules/FilterableData.svelte';

  let fleetingModal = undefined;
  let modalTitle = null;

  let proofModal = undefined;

  const openFleeting = (fleeting, kind) => {
    modalTitle = kind === 'error' ? 'Error Details' : 'Pending Details';
    if (fleetingModal) fleetingModal.open(fleeting);
  };

  const openProof = (payment) => {
    if (proofModal) proofModal.open(payment);
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
        <th scope="col">Hops</th>
        <th scope="col" />
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
            <HopsToggler {payment} />
            <td width="1">
              {#if payment.secret && payment.secret.proof}
                <button
                  on:click={openProof(payment)}
                  type="button"
                  class="btn btn-outline-success btn-sm"
                >
                  <i class="bi bi-key-fill" />
                </button>
              {:else}
                <button disabled type="button" class="btn btn-outline-secondary btn-sm">
                  <i class="bi bi-key-fill" />
                </button>
              {/if}
            </td>
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

<Modal title="Payment" size="lg" bind:this={proofModal} let:data let:modalElement>
  {#if data !== undefined}
    <PaymentProof payment={data} {modalElement} />
  {/if}
</Modal>
