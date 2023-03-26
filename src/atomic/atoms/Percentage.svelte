<script>
  import Presenter from '../../helpers/presenter.js';

  export let value;

  export let precision = 3;
  export let min = 0;

  export let colors = false;

  let cssClass = '';

  if (colors && value >= 0.0) {
    cssClass = 'text-success';
  } else if (colors) {
    cssClass = 'text-danger';
  }
</script>

<span class={cssClass}>
  {Presenter.percent(value, min, precision)}
</span>
