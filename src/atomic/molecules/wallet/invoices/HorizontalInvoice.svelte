<script>
  import AmountAtom from '../../../atoms/invoice/AmountKind.svelte';
  import ShortenerAtom from '../../../atoms/Shortener.svelte';
  import MilliSatsAtom from '../../../atoms/MilliSats.svelte';
  import PayableAtom from '../../../atoms/invoice/Payable.svelte';
  import TimeAtom from '../../../atoms/Time.svelte';
  import Copyable from '../../../atoms/Copyable.svelte';

  export let invoice;
  export let modalElement = undefined;
</script>

<div class="code">
  <Copyable
    label="Code"
    cssClass="text-info-emphasis"
    content={invoice.code}
    {modalElement}
    caption="invoice code"
  />
</div>

<table class="table text-center table-hover">
  <tbody>
    <tr>
      <th scope="col" class="text-end">Created</th>
      <td valign="middle" class="text-start">
        <TimeAtom at={invoice.created_at} />
      </td>
      <th scope="col" class="text-end">Payable</th>
      <td valign="middle" class="text-start">
        <PayableAtom payable={invoice.payable} label={true} />
      </td>
    </tr>
    <tr>
      <th scope="col" class="text-end">Description</th>
      <td valign="middle" class="text-start">
        {#if invoice.description.memo}
          {invoice.description.memo}
        {:else}
          -
        {/if}
      </td>
      {#if invoice.amount && invoice.amount.millisatoshis !== 0}
        <th scope="col" class="text-end">Millisatoshis</th>
        <td valign="middle" class="text-start">
          <MilliSatsAtom milli={invoice.amount.millisatoshis} as="millisatoshis" />
        </td>
      {:else}
        <th scope="col" class="text-end">Amount</th>
        <td valign="middle" class="text-start">
          <AmountAtom amount="open" label={true} />
        </td>
      {/if}
    </tr>
    <tr>
      <th scope="col" class="text-end">Expires</th>
      <td valign="middle" class="text-start">
        <TimeAtom at={invoice.expires_at} expirable={true} />
      </td>
      <th scope="col" class="text-end">Secret Hash</th>
      <td valign="middle" class="text-start">
        <ShortenerAtom hash={invoice.secret.hash} limit={20} />
      </td>
    </tr>
  </tbody>
</table>

<style>
.code {
  margin: .6em 0 1.2em 0;
}
</style>
