<script>
  import NodeAtom from '../atoms/Node.svelte';
  import { format } from 'timeago.js';

  import Presenter from '../../helpers/presenter.js';
  import FilterableData from '../molecules/FilterableData.svelte';
</script>

<FilterableData
  service="nitrox-node"
  path="/payments/rebalances"
  filterable={false}
  seconds={30}
  let:data={payments}
>
  <table class="table text-center table-hover">
    <thead>
      <tr>
        <th scope="col">At</th>
        <th scope="col">Ended</th>
        <th scope="col">Amount <span class="text-secondary">丰</span></th>
        <th scope="col">PPM</th>
      </tr>
    </thead>
    <tbody>
      {#each payments.slice(0, 8) as payment}
        <tr>
          <td title={Presenter.dateTime(payment.at)}>{format(payment.at)}</td>
          <td><NodeAtom node={payment.hops[payment.hops.length - 1]} /></td>
          <td>
            <a
              href={`http://icebaker-machine.local:8889/route?=${payment.hash}`}
              target="_blank"
              rel="noopener noreferrer"
            >
              {Presenter.shortMoney(payment.value)}
            </a>
          </td>
          <td>{payment.ppm}</td>
        </tr>
      {/each}
    </tbody>
  </table>
</FilterableData>
