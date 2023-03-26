<script>
  import Cookies from 'js-cookie';

  import { fade } from 'svelte/transition';
  import Header from '../atomic/organisms/Header.svelte';
  import Menu from '../atomic/organisms/Menu.svelte';
  import Connection from '../atomic/organisms/Connection.svelte';
  import QuickStatus from '../atomic/molecules/status/Quick.svelte';

  import { onMount } from 'svelte';

  let loading = true;

  onMount(() => {
    if (Cookies.get('theme') === 'light') {
      document.documentElement.removeAttribute('data-bs-theme');
    } else {
      document.documentElement.setAttribute('data-bs-theme', 'dark');
    }
    loading = false;
  });
</script>

{#if loading}
  <div class="wall" out:fade={{ duration: 250 }} />
{/if}

<div class="background-blur">
  <div class="container">
    <Menu />
    <QuickStatus />
    <Header />
    <Connection />
    <slot />
  </div>
</div>

<style>
  .container {
    margin-bottom: 6em;
  }

  .wall {
    position: fixed;
    width: 120%;
    height: 120%;
    top: -20%;
    bottom: -20%;
    background: rgb(247, 37, 133);
    background: linear-gradient(
      90deg,
      rgba(247, 37, 133, 1) 0%,
      rgba(114, 9, 183, 1) 50%,
      rgba(58, 12, 163, 1) 100%
    );
    z-index: 120;
  }

  .background-blur {
    position: relative;
    width: 100%;
    min-height: 100vh;
    overflow: hidden;
  }

  .background-blur::before {
    content: '';
    position: absolute;
    top: 0;
    background-attachment: fixed;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: url('images/photo-1519608487953-e999c86e7455.avif');
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
    opacity: 0.15;
    filter: blur(5px);
    z-index: -1;
  }

  :global(html.picture, html.picture body) {
    background-color: 000;
  }

  :global(html.dark .background-blur::before, html.light .background-blur::before) {
    background-image: none !important;
  }

  :global(html.picture .card) {
    background: none !important;
  }
</style>
