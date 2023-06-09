<script>
  import DirectionAtom from '../../atomic/atoms/activity/Direction.svelte';
  import LayerAtom from '../../atomic/atoms/activity/Layer.svelte';
  import ThroughAtom from '../../atomic/atoms/payments/Through.svelte';
  import HowAtom from '../../atomic/atoms/payments/How.svelte';
  import PayableAtom from '../../atomic/atoms/invoice/Payable.svelte';
  import AmountAtom from '../../atomic/atoms/invoice/AmountKind.svelte';
  import PurposeAtom from '../../atomic/atoms/payments/Purpose.svelte';

  let captions = true;
</script>

<div class="container">
  <h1>Etymology</h1>

  <div class="row">
    <div class="col-7">
      <div class={`card ${captions ? 'captions' : 'icons'}`}>
        <div class="card-header">
          Invoices and Payments
          <div class="form-check form-switch">
            <input
              class="form-check-input"
              type="checkbox"
              role="switch"
              id="paymentsCaptions"
              bind:checked={captions}
            />
            <label class="form-check-label" for="paymentsCaptions">Captions</label>
          </div>
        </div>
        <div class="card-body">
          <table class="table table-hover">
            <thead>
              <tr>
                <th scope="col">How</th>
                <th scope="col">Payable</th>
                <th scope="col">Through</th>
                <th scope="col">Amount</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><HowAtom how="spontaneously" /> <span>Spontaneously</span></td>
                <td><PayableAtom payable="indefinitely" /> <span>Indefinitely</span></td>
                <td><ThroughAtom through="amp" /> <span>AMP</span></td>
                <td><AmountAtom amount="open" /> <span>Open</span></td>
              </tr>
              <tr>
                <td><HowAtom how="spontaneously" /> <span>Spontaneously</span></td>
                <td><PayableAtom payable="indefinitely" /> <span>Indefinitely</span></td>
                <td><ThroughAtom through="keysend" /> <span>Keysend</span></td>
                <td><AmountAtom amount="open" /> <span>Open</span></td>
              </tr>
              <tr>
                <td colspan="4">&nbsp;</td>
              </tr>
              <tr>
                <td><HowAtom how="with-invoice" /> <span>With Invoice</span></td>
                <td><PayableAtom payable="once" /> <span>Once</span></td>
                <td><ThroughAtom through="non-amp" /> <span>Non-AMP</span></td>
                <td><AmountAtom amount="fixed" /> <span>Fixed</span></td>
              </tr>
              <tr>
                <td><HowAtom how="with-invoice" /> <span>With Invoice</span></td>
                <td><PayableAtom payable="once" /> <span>Once</span></td>
                <td><ThroughAtom through="non-amp" /> <span>Non-AMP</span></td>
                <td><AmountAtom amount="open" /> <span>Open</span></td>
              </tr>
              <tr>
                <td colspan="4">&nbsp;</td>
              </tr>
              <tr>
                <td><HowAtom how="with-invoice" /> <span>With Invoice</span></td>
                <td><PayableAtom payable="indefinitely" /> <span>Indefinitely</span></td>
                <td><ThroughAtom through="amp" /> <span>AMP</span></td>
                <td><AmountAtom amount="fixed" /> <span>Fixed</span></td>
              </tr>
              <tr>
                <td><HowAtom how="with-invoice" /> <span>With Invoice</span></td>
                <td><PayableAtom payable="indefinitely" /> <span>Indefinitely</span></td>
                <td><ThroughAtom through="amp" /> <span>AMP</span></td>
                <td><AmountAtom amount="open" /> <span>Open</span></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      <br />
      <div class={`card ${captions ? 'captions' : 'icons'}`}>
        <div class="card-header">
          Potential Purposes for Payments
          <div class="form-check form-switch">
            <input
              class="form-check-input"
              type="checkbox"
              role="switch"
              id="purposesCaptions"
              bind:checked={captions}
            />
            <label class="form-check-label" for="purposesCaptions">Captions</label>
          </div>
        </div>
        <div class="card-body">
          <table class="table table-hover">
            <tbody>
              <tr>
                <td><PurposeAtom purpose="payment" /> <span>Payment</span></td>
                <td><PurposeAtom purpose="peer-to-peer" /> <span>Peer-to-Peer</span></td>
              </tr>
              <tr>
                <td><PurposeAtom purpose="rebalance" /> <span>Rebalance</span></td>
                <td><PurposeAtom purpose="self-payment" /> <span>Self-Payment</span></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <div class="col-5">
      <div class={`card ${captions ? 'captions' : 'icons'}`}>
        <div class="card-header">
          Activity
          <div class="form-check form-switch">
            <input
              class="form-check-input"
              type="checkbox"
              role="switch"
              id="activityCaptions"
              bind:checked={captions}
            />
            <label class="form-check-label" for="activityCaptions">Captions</label>
          </div>
        </div>
        <div class="card-body">
          <table class="table table-hover">
            <thead>
              <tr>
                <th scope="col">Direction</th>
                <th scope="col">Layer</th>
                <th scope="col">How</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><DirectionAtom direction="in" /> <span>In</span></td>
                <td><LayerAtom layer="bitcoin" /> <span>Bitcoin</span></td>
                <td><HowAtom how="spontaneously" /> <span>Spontaneously</span></td>
              </tr>
              <tr>
                <td><DirectionAtom direction="in" /> <span>In</span></td>
                <td><LayerAtom layer="bitcoin" /> <span>Bitcoin</span></td>
                <td><HowAtom how="closing-channel" /> <span>Closing Channel</span></td>
              </tr>
              <tr>
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr>
                <td><DirectionAtom direction="in" /> <span>In</span></td>
                <td><LayerAtom layer="lightning" /> <span>Lightning</span></td>
                <td><HowAtom how="opening-channel" /> <span>Opening Channel</span></td>
              </tr>
              <tr>
                <td><DirectionAtom direction="in" /> <span>In</span></td>
                <td><LayerAtom layer="lightning" /> <span>Lightning</span></td>
                <td><HowAtom how="spontaneously" /> <span>Spontaneously</span></td>
              </tr>
              <tr>
                <td><DirectionAtom direction="in" /> <span>In</span></td>
                <td><LayerAtom layer="lightning" /> <span>Lightning</span></td>
                <td><HowAtom how="with-invoice" /> <span>With Invoice</span></td>
              </tr>
              <tr>
                <td><DirectionAtom direction="in" /> <span>In</span></td>
                <td><LayerAtom layer="lightning" /> <span>Lightning</span></td>
                <td><HowAtom how="forwarding" /> <span>Forwarding</span></td>
              </tr>
              <tr>
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr>
                <td><DirectionAtom direction="out" /> <span>Out</span></td>
                <td><LayerAtom layer="bitcoin" /> <span>Bitcoin</span></td>
                <td><HowAtom how="spontaneously" /> <span>Spontaneously</span></td>
              </tr>
              <tr>
                <td><DirectionAtom direction="out" /> <span>Out</span></td>
                <td><LayerAtom layer="bitcoin" /> <span>Bitcoin</span></td>
                <td><HowAtom how="opening-channel" /> <span>Opening Channel</span></td>
              </tr>
              <tr>
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr>
                <td><DirectionAtom direction="out" /> <span>Out</span></td>
                <td><LayerAtom layer="lightning" /> <span>Lightning</span></td>
                <td><HowAtom how="closing-channel" /> <span>Closing Channel</span></td>
              </tr>
              <tr>
                <td><DirectionAtom direction="out" /> <span>Out</span></td>
                <td><LayerAtom layer="lightning" /> <span>Lightning</span></td>
                <td><HowAtom how="spontaneously" /> <span>Spontaneously</span></td>
              </tr>
              <tr>
                <td><DirectionAtom direction="out" /> <span>Out</span></td>
                <td><LayerAtom layer="lightning" /> <span>Lightning</span></td>
                <td><HowAtom how="with-invoice" /> <span>With Invoice</span></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>

<style>
  h1 {
    margin-top: -1.4em;
    margin-bottom: 1em;
  }

  .container {
    margin-bottom: 4em;
  }

  .actions {
    margin-bottom: -2em;
  }

  h2 {
    margin-bottom: 1em;
  }

  .icons td span {
    display: none;
  }

  /*  .icons td, .icons th {
    text-align: center;
  }*/

  td,
  th {
    text-align: center;
  }

  td span {
    margin-left: 0.4em;
  }

  .card-header .form-check {
    float: right;
  }

  /*  th, td {
    text-align: center;
  }*/
</style>
