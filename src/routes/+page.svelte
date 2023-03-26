<div class="title text-center">
  <h1 class="font-monospace">Nitrox</h1>
  <p class="text-body-secondary slogan">A delightful Lightning Network experience.</p>
</div>

<style>
  .title {
    position: fixed;
    top: 50%;
    right: 50%;
    transform: translate(50%, -50%);
  }

  :global(html[data-bs-theme='dark'] p.slogan) {
    color: rgb(173, 181, 189) !important;
  }

  h1 {
    /*  letter-spacing: .4em;*/
    font-family: 'Poiret One' !important;
    /*  color:red;*/
    background: rgb(247, 37, 133);
    background-image: linear-gradient(
      90deg,
      rgba(247, 37, 133, 1) 0%,
      rgba(114, 9, 183, 1) 50%,
      rgba(58, 12, 163, 1) 100%
    );
    background-size: 100%;
    -webkit-background-clip: text;
    -moz-background-clip: text;
    -webkit-text-fill-color: transparent;
    -moz-text-fill-color: transparent;
    filter: brightness(1.3) saturate(1.2);
  }

  p {
    margin-top: 2em;
  }
</style>
