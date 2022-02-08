<script>
  import Canvas from "./Canvas.svelte";
  //   export let name;
  const clearPage = () => {
    window.location.href = window.location.href;
  };
</script>

<main>
  <h1 class="rainbow_font">Data Generator</h1>
  <Canvas />
  <div>
    <button class="btn--orange" on:click={() => clearPage}> clearPage!!</button>
  </div>
</main>

<style>
  main {
    text-align: center;
    padding: 1em;
    max-width: 240px;
    margin: 0 auto;
  }
  .btn--orange,
  button.btn--orange {
    display: block;
    color: #fff;
    border-radius: 100vh;
    background-color: #eb6100;
    margin-left: auto;
    margin-right: auto;
    width: 8em;
  }
  .btn--orange:hover,
  button.btn--orange:hover {
    color: #fff;
    background: #f56500;
  }

  h1 {
    /* color: #ff3e00; */
    color: #999333;
    /* text-transform: uppercase; */
    font-size: 4em;
    font-weight: 100;
  }
  @media (min-width: 640px) {
    main {
      max-width: none;
    }
  }
</style>
