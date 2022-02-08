<script>
  import { onMount } from "svelte";
  import { use } from "./sdf";
  import { coordinatesToCSV } from "./csv";
  const { SDF } = use();

  onMount(async () => {
    const canvas = document.querySelector("#draw-area");
    const context = canvas.getContext("2d");
    canvas.addEventListener("mousedown", (event) => dragStart(event, context));
    canvas.addEventListener("mouseup", (event) => dragEnd(event, context));
    canvas.addEventListener("mouseout", (event) => dragEnd(event, context));
    canvas.addEventListener("mousemove", (event) => {
      draw(event.layerX, event.layerY, context);
    });
  });
  let isDragging = false;
  const lastPosition = { x: null, y: null };
  const dragStart = (event, context) => {
    console.debug("drag start");
    context.beginPath();
    isDragging = true;
  };

  const dragEnd = (event, context) => {
    console.debug("drag end");
    context.closePath();
    isDragging = false;
    lastPosition.x = null;
    lastPosition.y = null;
  };

  const boardSize = { x: 300, y: 200 };
  const draw = (x, y, context) => {
    if (!isDragging) return;
    context.lineCap = "round";
    context.lineJoin = "round";
    context.lineWidth = 2;
    context.strokeStyle = "#000000";
    if (lastPosition.x === null || lastPosition.y === null) {
      context.moveTo(x, y);
    } else {
      context.moveTo(lastPosition.x, lastPosition.y);
    }
    context.lineTo(x, y);
    context.stroke();
    addCoordinate(x - boardSize.x, y - boardSize.y);
    lastPosition.x = x;
    lastPosition.y = y;
  };
  const coordinates = [];
  const addCoordinate = (x, y) => {
    x /= boardSize.x;
    y /= boardSize.y;
    coordinates.push([x, -y]);
  };
  //   https://www.delftstack.com/ja/howto/javascript/export-javascript-csv/

  function handleTouchMove(event) {
    event.preventDefault();
  }
  document.addEventListener("touchmove", handleTouchMove, { passive: false });
</script>

<main>
  <canvas
    id="draw-area"
    width="600px"
    height="400px"
    style="border: 1px solid #000000;"
  />
  <button class="button" on:click={() => SDF(coordinates)}> convert!!</button>
  <button class="button" on:click={() => coordinatesToCSV(coordinates)}>
    generateCSV</button
  >
</main>

<style></style>
