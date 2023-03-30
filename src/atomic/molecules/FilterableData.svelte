<script>
  import Cookies from 'js-cookie';

  import { fade } from 'svelte/transition';

  import { onMount, onDestroy } from 'svelte';

  import Nitrox from '../../components/nitrox';

  import PerformanceAtom from '../atoms/Performance.svelte';
  import Failure from './Failure.svelte';

  export let controls = false;
  export let retry = true;
  export let service;
  export let path;
  export let loader = 'default';

  export let seconds = 60;
  export let lean = false;
  export let responseTime = false;
  export let filterable = true;
  export let filter = undefined;
  export let example = undefined;
  export let url = true;

  let toolTipePending = true;
  let autoReloadElement;

  let data;

  export let autoReload = true;

  let state = 'loading';

  let searchInput;

  let expectFocus = false;

  const params = { query: filter ? filter : '' };

  let timeout = undefined;

  let destroyed = false;

  let lastResponseTime = undefined;

  let requestFailure = false;

  let baseUrl = undefined;
  let requestUrl = undefined;
  let shortRequestUrl = undefined;

  const loadData = async (kind) => {
    if (kind === 'post') {
      state = 'postLoading';
    } else {
      state = 'loading';
    }

    if (baseUrl == undefined) {
      baseUrl = `${await Nitrox.service(service.replace('nitrox-', ''))}${path}`;
    }

    requestUrl = baseUrl;

    if (params.query) {
      const queryStrings = [];
      params.query.split(/\s+/).forEach((command) => {
        const [key, value] = command.split(':');
        queryStrings.push(`${key}=${value}`);
      });
      if (requestUrl.includes('?')) {
        requestUrl = `${requestUrl}&${queryStrings.join('&')}`;
      } else {
        requestUrl = `${requestUrl}?${queryStrings.join('&')}`;
      }
    }

    const headers = {
      'Content-Type': 'application/json',
      'Nitrox-Connection-Id': Cookies.get('connection')
    };

    shortRequestUrl = requestUrl;

    if (requestUrl.includes('?')) {
      requestUrl = `${requestUrl}&connection_id=${Cookies.get('connection')}`;
    } else {
      requestUrl = `${requestUrl}?connection_id=${Cookies.get('connection')}`;
    }

    try {
      const startedAt = performance.now();
      const response = await fetch(requestUrl, { headers: headers });
      data = { data: await response.json() };
      if (responseTime) {
        lastResponseTime = performance.now() - startedAt;
      }

      if (data.data.error) {
        throw new Error(data.data.error);
      } else {
        requestFailure = false;
      }

      state = 'ready';

      if (!destroyed) {
        setTimeout(() => {
          if (autoReloadElement && toolTipePending) {
            toolTipePending = false;
            new bootstrap.Tooltip(autoReloadElement);
          }
        }, 0);
      }

      if (autoReload) {
        clearTimeout(timeout);
        if (!destroyed) {
          timeout = setTimeout(() => {
            loadData('post');
          }, seconds * 1000);
        }
      }
    } catch (error) {
      requestFailure = {
        at: Date.now(),
        url: requestUrl,
        response: data,
        error: error
      };
      state = 'ready';
      if (autoReload) {
        clearTimeout(timeout);
        if (!destroyed && retry) {
          timeout = setTimeout(() => {
            loadData('post');
          }, seconds * 1000);
        }
      }
    }

    if (expectFocus) {
      expectFocus = false;
      setTimeout(() => {
        searchInput.focus();
      }, 0);
    }
  };

  export const reload = () => {
    loadData('post');
  };

  onMount(async () => {
    loadData();

    if (autoReloadElement && toolTipePending) {
      toolTipePending = false;
      new bootstrap.Tooltip(autoReloadElement);
    }
  });

  onDestroy(() => {
    destroyed = true;
    clearTimeout(timeout);
  });

  let firstUpdatePath = true;

  const updatePath = async (path) => {
    if (!firstUpdatePath) {
      if (!baseUrl) {
        baseUrl = `${await Nitrox.service(service.replace('nitrox-', ''))}${path}`;
      }

      loadData('post');
    }

    firstUpdatePath = false;
  };

  $: {
    updatePath(path);
  }

  const onKeyPress = (e) => {
    if (e.charCode === 13) {
      expectFocus = true;
      loadData('post');
    }
  };

  const updateLimitBy = (value) => {
    const queryStrings = {};
    params.query.split(/\s+/).forEach((command) => {
      const [key, value] = command.split(':');
      queryStrings[key] = value;
    });

    if (
      queryStrings['limit'] !== '' &&
      queryStrings['limit'] !== null &&
      queryStrings['limit'] !== undefined
    ) {
      params.query = params.query.replace(
        `limit:${queryStrings['limit']}`,
        `limit:${parseInt(queryStrings['limit'], 10) + value}`
      );
    } else {
      throw 'TODO';
    }

    loadData('post');
  };
</script>

<div class={`molecule ${lean ? 'lean' : ''}`}>
  {#if state === 'loading'}
    {#if $$slots.loader}
      <slot name="loader" />
    {:else if loader === 'default'}
      <div class="loading">
        <div class="spinner-border" role="status">
          <span class="visually-hidden">Loading...</span>
        </div>
      </div>
    {:else}
      <div class="discreet-loading">
        <div class="spinner-border spinner-border-sm" role="status">
          <span class="visually-hidden">Loading...</span>
        </div>
      </div>
    {/if}
  {:else}
    {#if requestFailure === false}
      <slot
        name="header"
        message="Data retrieval failed."
        failure={requestFailure}
        data={data ? data.data : null}
      />
    {/if}
    {#if !lean}
      <div class="reload">
        <div class="item reloading">
          {#if state === 'postLoading'}
            <div transition:fade={{ duration: 250 }}>
              <div class="spinner-border spinner-border-sm" role="status">
                <span class="visually-hidden">Loading...</span>
              </div>
            </div>
          {/if}
        </div>
        <div
          bind:this={autoReloadElement}
          data-bs-toggle="tooltip"
          data-bs-title={`every ${seconds} second${seconds != 1 ? 's' : ''}`}
          class="item"
        >
          <div class="form-check form-switch">
            <input
              class="form-check-input"
              type="checkbox"
              bind:checked={autoReload}
              role="switch"
              id="flexSwitchCheckDefault"
            />
            <label class="form-check-label" for="flexSwitchCheckDefault">auto reload</label>
          </div>
        </div>
        <div class="item reload-now">
          <button
            on:click={() => {
              loadData('post');
            }}
            type="button"
            class="btn btn-outline-secondary btn-sm"
            disabled={state === 'postLoading'}
          >
            <i class="bi bi-arrow-clockwise" />
          </button>
        </div>
      </div>
    {/if}
    {#if filterable}
      <div class="filter">
        <div class="input-group mb-3">
          <span class="input-group-text" id="basic-addon1"><i class="bi bi-search" /></span>
          <input
            bind:this={searchInput}
            on:keypress={onKeyPress}
            bind:value={params.query}
            type="text"
            class="form-control"
            placeholder="search for"
            aria-label="search for"
            aria-describedby="basic-addon1"
          />
        </div>
        {#if example || url}
          <div class="footer row">
            <div class="col-4 examples">
              {#if example}<code>{example}</code>{/if}
            </div>
            <div class="col-8 result-size text-secondary">
              {#if responseTime && lastResponseTime}
                <a
                  class="text-secondary"
                  href={requestUrl}
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <PerformanceAtom value={lastResponseTime} />
                </a>
              {:else if url}
                <a
                  class="text-secondary url"
                  href={requestUrl}
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  {shortRequestUrl}
                </a>
              {/if}
            </div>
          </div>
        {/if}
      </div>
    {/if}
    <div class="content">
      {#if requestFailure !== false && $$slots.failure}
        <slot name="failure" message="Data retrieval failed." failure={requestFailure} />
      {/if}
      {#if requestFailure !== false && !$$slots.failure}
        <Failure message="Data retrieval failed." failure={requestFailure} />
      {/if}
      {#if requestFailure === false}
        <slot name="data" {reload} data={data ? data.data : null} />

        {#if controls}
          <div class="controls text-center">
            {#if state === 'postLoading' || state === 'loading'}
              <button disabled type="button" class="btn btn-outline-secondary">
                <div class="spinner-border spinner-border-sm" role="status">
                  <span class="visually-hidden">Loading...</span>
                </div>
              </button>
            {:else}
              <button
                on:click={() => updateLimitBy(-1)}
                tyvaluepe="button"
                class="btn btn-outline-danger"
              >
                <i class="bi bi-dash-square-fill" />
              </button>

              <button
                on:click={() => updateLimitBy(1)}
                tyvaluepe="button"
                class="btn btn-outline-success"
              >
                <i class="bi bi-plus-square-fill" />
              </button>
            {/if}
          </div>
        {/if}
      {/if}
    </div>
  {/if}
</div>

<style>
  .controls button {
    margin: 0 1em;
  }
  .molecule {
    min-height: 10em;
  }

  .molecule.lean {
    min-height: 0;
  }

  .reload {
    text-align: right;
    margin-bottom: 1em;
  }

  .reload .item {
    display: inline-block;
  }

  .reload .reload-now {
    margin-left: 1em;
  }

  .reload .reloading {
    margin-right: 0.6em;
  }

  .loading {
    text-align: center;
    padding-top: 2em;
  }

  .filter {
    margin-bottom: 1.6em;
  }

  .examples {
    text-align: left;
    margin-bottom: 0.1em;
  }

  .examples code {
    margin-left: 0.3em;
    font-size: 0.8em;
  }

  .result-size {
    text-align: right;
    padding-right: 1.4em;
    font-size: 0.8em;
  }

  .footer {
    margin-top: -0.6em;
    text-align: right;
  }

  .url {
    font-style: italic;
    font-size: 0.8em;
  }

  .discreet-loading {
    text-align: center;
  }
</style>
