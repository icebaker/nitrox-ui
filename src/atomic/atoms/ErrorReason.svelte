<script>
  import { onMount } from 'svelte';

  export let error;

  let label;

  switch (error) {
    case 'insufficient-fee':
      label = 'Fee';
      break;
    case 'insufficient-balance':
      label = 'Balance';
      break;
    case 'unknown-next-peer':
      label = 'Peer';
      break;
    default:
      label = error;
  }

  let errorElement;

  onMount(() => {
    new bootstrap.Tooltip(errorElement);
  });
</script>

<span bind:this={errorElement} class="text-danger" data-bs-toggle="tooltip" data-bs-title={error}>
  {label}
</span>
