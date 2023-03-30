<script>
  import FleetingDetails from '../../../molecules/fleeting/Details.svelte';
  import FleetingRow from '../../../molecules/fleeting/Row.svelte';

  import AmountAtom from '../../../atoms/invoice/AmountKind.svelte';
  import NumberAtom from '../../../atoms/Number.svelte';
  import PayableAtom from '../../../atoms/invoice/Payable.svelte';
  import StateAtom from '../../../atoms/invoice/State.svelte';
  import PercentageAtom from '../../../atoms/Percentage.svelte';
  import MilliSatsAtom from '../../../atoms/MilliSats.svelte';

  import TimeAtom from '../../../atoms/Time.svelte';
  import ShortenerAtom from '../../../atoms/Shortener.svelte';

  import Presenter from '../../../../helpers/presenter.js';
  import FilterableData from '../../../molecules/FilterableData.svelte';
  import Modal from '../../../molecules/Modal.svelte';
  import Invoice from '../../../molecules/wallet/invoices/Invoice.svelte';
  import ProofValidation from '../../../molecules/wallet/invoices/ProofValidation.svelte';

  let invoiceModal = undefined;
  let proofValidationModal = undefined;

  const openInvoice = (invoice) => {
    if (invoiceModal) invoiceModal.open(invoice);
  };

  const openProofValidation = (invoice) => {
    if (proofValidationModal) proofValidationModal.open(invoice);
  };

  let fleetingModal = undefined;
  let modalTitle = null;

  let filterableData = undefined;

  export const reload = () => {
    if(filterableData) filterableData.reload();
  }

  const openFleeting = (fleeting, kind) => {
    modalTitle = kind === 'error' ? 'Error Details' : 'Pending Details';
    if (fleetingModal) fleetingModal.open(fleeting);
  };
</script>

<FilterableData
  bind:this={filterableData}
  service="nitrox-receive"
  path="/invoices"
  filterable={true}
  filter="limit:10"
  example="limit:10"
  let:data
>
  <table slot="data" class="table text-center table-hover">
    <thead>
      <tr>
        <th scope="col">Created</th>
        <th scope="col">Expires</th>
        <th scope="col">Description</th>
        <th scope="col">Amount</th>
        <th scope="col">Received</th>
        <th scope="col">Payable</th>
        <th scope="col">State</th>
        <th scope="col">Code</th>
        <th scope="col" width="1" />
        <th scope="col" width="1" />
      </tr>
    </thead>
    <tbody>
      {#each data.items as invoice (`invoice-${invoice._key}`)}
        {#if invoice._fleeting}
          <FleetingRow fleeting={invoice} opener={openFleeting} colspan="8" />
        {:else}
          <tr>
            <td valign="middle"><TimeAtom at={invoice.created_at} /></td>
            <td valign="middle"><TimeAtom at={invoice.expires_at} expirable={true} /></td>
            <td valign="middle">
              {#if invoice.description.memo}
                {invoice.description.memo}
              {:else}
                -
              {/if}
            </td>
            <td valign="middle">
              {#if invoice.amount}
                <MilliSatsAtom milli={invoice.amount.millisatoshis} />
              {:else}
                <AmountAtom amount="open" />
              {/if}
            </td>
            <td valign="middle">
              {#if invoice.received}
                {#if invoice.payable !== 'once' && invoice.payments && invoice.payments.length > 0}
                  <MilliSatsAtom milli={invoice.received.millisatoshis} />
                  ÷ <span class="text-warning-emphasis">{invoice.payments.length}</span>
                {:else}
                  <MilliSatsAtom milli={invoice.received.millisatoshis} />
                {/if}
              {:else}
                -
              {/if}
            </td>
            <td valign="middle"><PayableAtom payable={invoice.payable} /></td>
            <td valign="middle"><StateAtom state={invoice.state} /></td>
            <td valign="middle"><ShortenerAtom hash={invoice.code} limit={30} /></td>
            <td valign="middle" class="text-center">
              <button
                on:click={openInvoice(invoice)}
                type="button"
                class="btn btn-outline-secondary btn-sm"
              >
                <i class="bi bi-qr-code-scan" />
              </button>
            </td>
            <td>
              <button
                on:click={openProofValidation(invoice)}
                type="button"
                class="btn btn-outline-info btn-sm"
              >
                <i class="bi bi-shield-lock-fill" />
              </button>
            </td>
          </tr>
        {/if}
      {/each}
    </tbody>
  </table>
</FilterableData>

<Modal
  title="Validate Proof of Payment"
  size="lg"
  bind:this={proofValidationModal}
  let:data
  let:modalElement
>
  {#if data !== undefined}
    <ProofValidation invoice={data} {modalElement} />
  {/if}
</Modal>

<Modal title="Invoice" size="lg" bind:this={invoiceModal} let:data let:modalElement>
  {#if data !== undefined}
    <Invoice invoice={data} {modalElement} />
  {/if}
</Modal>

<Modal title={modalTitle} size="lg" bind:this={fleetingModal} let:data>
  {#if data !== undefined}
    <FleetingDetails fleeting={data} />
  {/if}
</Modal>
