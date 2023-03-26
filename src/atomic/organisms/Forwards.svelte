<script>
  import { format } from 'timeago.js';

  import Presenter from '../../helpers/presenter.js';
  import NodeAtom from '../atoms/Node.svelte';

  import FilterableData from '../molecules/FilterableData.svelte';
</script>

<FilterableData service="nitrox-node" path="/forwards" filterable={false} let:data={forwards}>
  <table class="table text-center table-hover">
    <thead>
      <tr>
        <th scope="col">At</th>
        <th scope="col">In</th>
        <th scope="col">Out</th>
        <th scope="col">Amount <span class="text-secondary">丰</span></th>
        <th scope="col">PPM</th>
      </tr>
    </thead>
    <tbody>
      {#each forwards.slice(0, 17) as forward (`forward-${forward.key}`)}
        <tr>
          <td title={Presenter.dateTime(forward.at)}>{format(forward.at)}</td>
          <td><NodeAtom node={forward.in} /></td>
          <td><NodeAtom node={forward.out} /></td>
          <td>{Presenter.shortMoney(forward.amount)}</td>
          <td>{Presenter.number(forward.ppm)}</td>
        </tr>
      {/each}
    </tbody>
  </table>
</FilterableData>
