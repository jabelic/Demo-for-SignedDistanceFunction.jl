import { requestStatus } from "./store";
export const use = () => {
    // let requestStatus = writable("no request");
    const mutateStatus = (arg) => {
        requestStatus.update(item=>item= arg);
    }
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
        mutateStatus('request...')
        const url = "http://127.0.0.1:8000/SDF";
        try {
            const res = await fetch(url, {
                mode: "no-cors",
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: data,
                }
                ).then(()=>{
                    mutateStatus('ok')
                    console.debug(requestStatus)
                });
            returnValue.data = res;
            return res;
        } catch (e) {
            console.error(e);
            mutateStatus('error')
        } finally {
            console.debug(returnValue.data);
        }
    };
    return {SDF,requestStatus}
}