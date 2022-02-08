
export const use = () => {
    const SDF = async (coordinates) => {
    let csvContent = "";
    coordinates.forEach((rowArray) => {
        // FIXME: use map.
        let row = rowArray.join(",");
        csvContent += row + "\r\n";
    });
    const returns = await request(csvContent);
    console.debug(csvContent, returns);
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
    return {SDF}
}