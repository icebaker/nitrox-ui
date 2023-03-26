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
    background-image: url('https://images.unsplash.com/photo-1519608487953-e999c86e7455?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80');

    /*      background-image: url('https://images.unsplash.com/Ys-DBJeX0nE.JPG?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80');*/
    /*      background-image: url('https://images.unsplash.com/photo-1548919973-5cef591cdbc9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80');*/
    /*      background-image: url('https://images.unsplash.com/photo-1619796404374-aff912b43cd2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2456&q=80');*/

    /*      background-image: url('https://images.unsplash.com/photo-1575365717666-1a84be3fd104?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80');*/

    /*      background-image: url('https://images.unsplash.com/photo-1557515126-1bf9ada5cb93?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2531&q=80');*/
    /*      background-image: url('https://images.unsplash.com/photo-1581373449483-37449f962b6c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1469&q=80');*/
    /*      background-image: url('https://w.wallhaven.cc/full/8o/wallhaven-8oky1j.jpg');*/
    /*      background-image: url('https://w.wallhaven.cc/full/6o/wallhaven-6oqzgq.jpg');*/
    /*      background-image: url('https://w.wallhaven.cc/full/6k/wallhaven-6k2ogx.jpg');*/
    /*      background-image: url('https://w.wallhaven.cc/full/wy/wallhaven-wy1lyr.jpg');*/
    /*      background-image: url('https://w.wallhaven.cc/full/6k/wallhaven-6k8kkx.jpg');*/
    /*      background-image: url('https://w.wallhaven.cc/full/ox/wallhaven-oxlprl.jpg');*/
    /*      background-image: url('https://w.wallhaven.cc/full/r2/wallhaven-r2opq1.jpg');*/
    /*      background-image: url('https://images.unsplash.com/photo-1535391879778-3bae11d29a24?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80');*/
    /*      background-image: url('https://images.unsplash.com/photo-1534076355207-1717511180ba?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80');*/
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
    opacity: 0.15;
    filter: blur(5px);
    /*    opacity: 0.10;*/
    /*    filter: blur(15px);*/
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
