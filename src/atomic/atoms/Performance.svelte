<script>
  import Presenter from '../../helpers/presenter.js';

  export let value;
</script>

<span>
  {#if value > 1000.0}
    {Presenter.number(value / 1000.0)} seconds
  {:else}
    {Presenter.number(value, 0, 0)} ms
  {/if}
</span>
