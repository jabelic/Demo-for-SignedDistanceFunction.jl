export const coordinatesToCSV = (coordinates) => {
    let csvContent = "data:text/csv;charset=utf-8,";
    coordinates.forEach((rowArray) => {
      let row = rowArray.join(",");
      csvContent += row + "\r\n";
    });
    let encodedUri = encodeURI(csvContent);
    window.open(encodedUri);
  };