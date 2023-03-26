<script>
  import Cookies from 'js-cookie';

  import { onMount } from 'svelte';

  export let at;

  let theme = Cookies.get('theme');

  let currentTooltip = undefined;
  let pictureThemeElement = undefined;
  let lightThemeElement = undefined;
  let darkThemeElement = undefined;

  const disposeTooltip = () => {
    if (currentTooltip) {
      currentTooltip.dispose();
      currentTooltip = undefined;
    }
  };

  const applyTooltip = () => {
    disposeTooltip();

    if (pictureThemeElement) {
      currentTooltip = new bootstrap.Tooltip(pictureThemeElement);
    } else if (lightThemeElement) {
      currentTooltip = new bootstrap.Tooltip(lightThemeElement);
    } else if (darkThemeElement) {
      currentTooltip = new bootstrap.Tooltip(darkThemeElement);
    }
  };

  onMount(() => {
    if (theme === undefined || theme === null || theme === '') {
      theme = 'dark';
    }

    applyTooltip();

    if (theme === 'light') {
      document.documentElement.setAttribute('data-bs-theme', 'dark');
    } else {
      document.documentElement.removeAttribute('data-bs-theme', 'dark');
    }

    document.documentElement.setAttribute('class', theme);
  });

  const toggleTheme = () => {
    disposeTooltip();

    const currentTheme = document.documentElement.getAttribute('class');

    if (currentTheme === 'dark') {
      document.documentElement.setAttribute('data-bs-theme', 'dark');
      document.documentElement.setAttribute('class', 'picture');
      theme = 'picture';
      Cookies.set('theme', 'picture');
    } else if (currentTheme === 'picture') {
      document.documentElement.removeAttribute('data-bs-theme');
      document.documentElement.setAttribute('class', 'light');
      theme = 'light';
      Cookies.set('theme', 'light');
    } else {
      document.documentElement.setAttribute('data-bs-theme', 'dark');
      document.documentElement.setAttribute('class', 'dark');
      theme = 'dark';
      Cookies.set('theme', 'dark');
    }

    setTimeout(() => {
      applyTooltip();
    }, 0);
  };
</script>

{#if theme === 'dark'}
  <button
    on:click={toggleTheme}
    bind:this={pictureThemeElement}
    data-bs-placement="bottom"
    data-bs-toggle="tooltip"
    data-bs-title="Switch to Picture Mode"
    type="button"
    class="btn btn-outline-secondary"
  >
    <i class="bi bi-card-image" />
  </button>
{:else if theme === 'picture'}
  <button
    on:click={toggleTheme}
    bind:this={lightThemeElement}
    data-bs-placement="bottom"
    data-bs-toggle="tooltip"
    data-bs-title="Switch to Light Mode"
    type="button"
    class="btn btn-outline-secondary"
  >
    <i class="bi bi-brightness-high" />
  </button>
{:else}
  <button
    on:click={toggleTheme}
    type="button"
    bind:this={darkThemeElement}
    data-bs-placement="bottom"
    data-bs-toggle="tooltip"
    data-bs-title="Switch to Dark Mode"
    class="btn btn-outline-secondary"
  >
    <i class="bi bi-moon-fill" />
  </button>
{/if}

<style>
  button {
    float: right;
  }
</style>
