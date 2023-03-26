<script>
  import ShortenerAtom from '../../../atoms/Shortener.svelte';
  import MilliSatsAtom from '../../../atoms/MilliSats.svelte';
  import Nitrox from '../../../../components/nitrox';
  import QRCode from './QRCode.svelte';
  import PublicInformation from './Public.svelte';

  export let invoice;
</script>

<div>
  <QRCode code={invoice.code} />
  <div class="details border-top">
    <PublicInformation {invoice}>
      <tr>
        <th scope="col" class="text-end">Secret Hash</th>
        <td valign="middle" class="text-start">
          <ShortenerAtom hash={invoice.secret.hash} limit={40} /></td
        >
      </tr>
    </PublicInformation>
  </div>
</div>

<style>
  .details {
    margin-top: 1em;
  }
</style>
