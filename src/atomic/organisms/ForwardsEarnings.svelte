<script>
  import { format } from 'timeago.js';

  import Presenter from '../../helpers/presenter.js';
  import NodeAtom from '../atoms/Node.svelte';

  import FilterableData from '../molecules/FilterableData.svelte';

  export let direction;
</script>

<FilterableData
  service="nitrox-node"
  path={`/forwards/earnings/${direction}`}
  filterable={false}
  seconds={30}
  let:data={channels}
>
  <table class="table text-center table-hover">
    <thead>
      <tr>
        <th scope="col">Channel</th>
        <th scope="col">Amount <span class="text-secondary">丰</span></th>
        <th scope="col">PPM</th>
      </tr>
    </thead>
    <tbody>
      {#each channels.slice(0, 10) as channel}
        <tr>
          <td><NodeAtom node={channel} /></td>
          <td>{Presenter.shortMoney(channel.amount)}</td>
          <td>{Presenter.number(channel.ppm)}</td>
        </tr>
      {/each}
    </tbody>
  </table>
</FilterableData>
