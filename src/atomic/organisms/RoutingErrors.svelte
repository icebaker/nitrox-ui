<script>
  import { format } from 'timeago.js';

  import Presenter from '../../helpers/presenter.js';
  import NodeAtom from '../atoms/Node.svelte';
  import ErrorReasonAtom from '../atoms/ErrorReason.svelte';

  import FilterableData from '../molecules/FilterableData.svelte';
</script>

<FilterableData
  service="nitrox-failures"
  path="/htlc/errors?peer=false"
  filterable={false}
  let:data={errors}
>
  <table class="table text-center table-hover">
    <thead>
      <tr>
        <th scope="col">At</th>
        <th scope="col">Amount <span class="text-secondary">丰</span></th>
        <th scope="col">PPM</th>
        <th scope="col">Reason</th>
        <th scope="col">Out</th>
      </tr>
    </thead>
    <tbody>
      {#each errors.slice(0, 7) as error (error.at)}
        <tr>
          <td title={Presenter.dateTime(error.at)}>{format(error.at)}</td>
          <td>{Presenter.shortMoney(error.amount)}</td>
          <td>{Presenter.number(error.ppm)}</td>
          <td class="text-center">
            <ErrorReasonAtom error={error.reason} />
          </td>
          <td class="text-center"><NodeAtom node={error.out} /></td>
        </tr>
      {/each}
    </tbody>
  </table>
</FilterableData>
