<script>
  import AmountAtom from '../../../atoms/invoice/AmountKind.svelte';
  import ShortenerAtom from '../../../atoms/Shortener.svelte';
  import MilliSatsAtom from '../../../atoms/MilliSats.svelte';
  import PayableAtom from '../../../atoms/invoice/Payable.svelte';
  import TimeAtom from '../../../atoms/Time.svelte';

  export let invoice;
</script>

<table class="table text-center table-hover">
  <tbody>
    <tr>
      <th scope="col" class="text-end">Created</th>
      <td valign="middle" class="text-start">
        <TimeAtom at={invoice.created_at} />
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
    </tr>
    {#if invoice.amount && invoice.amount.millisatoshis !== 0}
      <tr>
        <th scope="col" class="text-end">Millisatoshis</th>
        <td valign="middle" class="text-start">
          <MilliSatsAtom milli={invoice.amount.millisatoshis} as="millisatoshis" />
        </td>
      </tr>
    {:else}
      <tr>
        <th scope="col" class="text-end">Amount</th>
        <td valign="middle" class="text-start">
          <AmountAtom amount="open" label={true} />
        </td>
      </tr>
    {/if}
    <tr>
      <th scope="col" class="text-end">Payable</th>
      <td valign="middle" class="text-start">
        <PayableAtom payable={invoice.payable} label={true} />
      </td>
    </tr>
    <tr>
      <th scope="col" class="text-end">Expires</th>
      <td valign="middle" class="text-start">
        <TimeAtom at={invoice.expires_at} expirable={true} />
      </td>
    </tr>
    <slot />
  </tbody>
</table>
