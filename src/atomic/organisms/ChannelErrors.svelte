<script>
  import NodeAtom from '../atoms/Node.svelte';
  import ErrorReasonAtom from '../atoms/ErrorReason.svelte';

  import Presenter from '../../helpers/presenter.js';

  import FilterableData from '../molecules/FilterableData.svelte';
</script>

<FilterableData
  service="nitrox-failures"
  path="/htlc/errors/out?peer=false"
  seconds={30}
  example="hours_ago:12"
  filter="hours_ago:2"
  let:data={errors}
>
  <table class="table text-center table-hover">
    <thead>
      <tr>
        <th scope="col">Errors</th>
        <th scope="col">Out</th>
        <th scope="col">Avg <span class="text-secondary">丰</span></th>
        <th scope="col">Reason</th>
      </tr>
    </thead>
    <tbody>
      {#each errors as error}
        <tr>
          <td>{error.count}</td>
          <td><NodeAtom node={error.out} /></td>
          <td>{Presenter.shortMoney(error.avg_satoshis)}</td>
          <td><ErrorReasonAtom error={error.reason} /></td>
        </tr>
      {/each}
    </tbody>
  </table>
</FilterableData>
