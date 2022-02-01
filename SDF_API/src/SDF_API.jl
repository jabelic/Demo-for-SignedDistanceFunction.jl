include("sdf.jl")
using .exe_sdf
using Genie, Genie.Requests
import Genie.Router: route
import Genie.Renderer.Json: json
Genie.config.run_as_server = true
SDF = []


route("/SDF") do
    (:message => "please POST knapsack problem instance as it is") |> json
end

# JSON.stingfy({hoge: "huga"})をparseできなくて、raw文字列として受け取るしかなかった。
route("/SDF", method = "POST") do
    data = rawpayload()
    println("post request", data)
    push!(SDF, (data))
    p = main(data)
    # (:data => "POST success") |> json
    (:data => p) |> json
end

route("/SDF", method = "GET") do
    message = join(SDF, ", ")
    (:message => message) |> json
end


Genie.AppServer.startup()

