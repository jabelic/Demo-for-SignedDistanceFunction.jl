<script>
  import { onMount } from "svelte";

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
      // addCoordinate(x - boardSize.x, y - boardSize.y);
    } else {
      context.moveTo(lastPosition.x, lastPosition.y);
      // addCoordinate(x - boardSize.x, y - boardSize.y);
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

  const CORS_HEADER = {
    "Access-Control-Allow-Headers": "Content-Type",
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "OPTIONS,POST,PUT,GET",
  };
  const request = async (data) => {
    const returnValue = { data: "" };
    try {
      let result = null;
      const url = "http://127.0.0.1:8000/SDF";
      const res = await fetch(url, {
        mode: "no-cors",
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: data,
      });
      returnValue.data = res;
      return res.body;
    } catch (e) {
      console.error(e);
    } finally {
      console.debug(returnValue.data);
    }
  };

  const SDF = async () => {
    let csvContent = "";
    coordinates.forEach((rowArray) => {
      // FIXME: use map.
      let row = rowArray.join(",");
      csvContent += row + "\r\n";
    });
    const returns = await request(csvContent);
    console.debug(csvContent, returns);
  };

  const coordinatesToCSV = () => {
    let csvContent = "data:text/csv;charset=utf-8,";
    coordinates.forEach((rowArray) => {
      let row = rowArray.join(",");
      csvContent += row + "\r\n";
    });
    let encodedUri = encodeURI(csvContent);
    window.open(encodedUri);
  };
</script>

<main>
  <canvas
    id="draw-area"
    width="600px"
    height="400px"
    style="border: 1px solid #000000;"
  />
  <button class="button" on:click={SDF}> convert!!</button>
  <button class="button" on:click={coordinatesToCSV}> generateCSV</button>
</main>

<style></style>
