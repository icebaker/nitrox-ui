<script>
  import Copyable from '../../../atoms/Copyable.svelte';
  import ShortenerAtom from '../../../atoms/Shortener.svelte';
  import MilliSatsAtom from '../../../atoms/MilliSats.svelte';
  import Nitrox from '../../../../components/nitrox';
  import QRCode from './QRCode.svelte';
  import PublicInformation from './Public.svelte';

  export let invoice;
  export let modalElement = undefined;
</script>

<div class="row">
  <div class="col-4">
    <QRCode code={invoice.code} />
  </div>
  <div class="col-8">
    <div class="details border-top">
      <PublicInformation {invoice} />
    </div>
  </div>

  <div class="code">
    <Copyable
      label="Code"
      cssClass="text-info-emphasis"
      content={invoice.code}
      {modalElement}
      caption="invoice code"
    />
  </div>
</div>

<style>
  .details {
    margin-top: 1em;
  }

  .code {
    margin-top: 1.6em;
    margin-bottom: 0.6em;
  }
</style>
