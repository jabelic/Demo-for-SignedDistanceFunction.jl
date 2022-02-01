module exe_sdf
    include("../SignedDistanceFunction/src/SignedDistanceFunction.jl")
    include("../SignedDistanceFunction/src/environments.jl")
    # include("../SignedDistanceFunction/test/APT.jl")
    using .SignedDistanceFunction
    using CSV
    using DataFrames
    using Plots
    # JULIA_MULTI_PROCESS = true
    # L=1.5
    function generage_CSV_data_from_arg(arg::String)
        # println(size(split(arg)))
        tmp = [split(ss,",") for ss in split(arg)]
        ary_twoD =  []
        for item in tmp
            push!(ary_twoD, [parse(Float64, item[1]) parse(Float64, item[2])])
        end
        # println(ary_twoD, size(ary_twoD), length(ary_twoD))
        ary_twoD = vcat(ary_twoD...)
        DataFrame(ary_twoD, :auto) |> CSV.write("interface.csv", header=false)
    end
    function main(arg1)
        N = 300
        arg = "0,0.5403
        0.25331,0.43567
        0.48827,0.34012
        0.68889,0.2563
        0.84343,0.18548
        0.94554,0.12789
        0.99441,0.082982
        0.99411,0.049688
        0.95228,0.026574
        0.8787,0.011958
        0.78373,0.003986
        0.67716,0.00068544
        0.56742,5.4903e-06
        0.46111,-0.00014818
        0.36298,-0.0018785
        0.27607,-0.0072626
        0.20194,-0.018317
        0.14107,-0.036959
        0.093071,-0.064966
        0.056996,-0.10391
        0.031487,-0.15505
        0.014915,-0.21923
        0.0054624,-0.29664
        0.0011838,-0.38656
        4.3916e-05,-0.48707
        -4.3916e-05,-0.59476
        -0.0011838,-0.7044
        -0.0054624,-0.80892
        -0.014915,-0.8995
        -0.031487,-0.96612
        -0.056996,-0.99842
        -0.093071,-0.98704
        -0.14107,-0.92506
        -0.20194,-0.80956
        -0.27607,-0.64268
        -0.36298,-0.43219
        -0.46111,-0.19101
        -0.56742,0.064065
        -0.67716,0.31446
        -0.78373,0.54219
        -0.8787,0.73219
        -0.95228,0.87399
        -0.99411,0.96267
        -0.99441,0.9987
        -0.94554,0.98718
        -0.84343,0.93646
        -0.68889,0.85656
        -0.48827,0.75782
        -0.25331,0.64973
        -2.4493e-16,0.5403
        "
        if arg1!= undef
            generage_CSV_data_from_arg(arg1)
        else
            generage_CSV_data_from_arg(arg)
        end
        _phi = signedDistance2D("interface.csv", N, "multi")
        _x = [i for i = -L:2*L/N:L] # len:N+1
        _y = [i for i = -L:2*L/N:L] # len:N+1
        s = plot(_x, _y, _phi, st = :wireframe, title = "wireframe")
        p = contour(_x, _y, _phi, title = "contour")
        q = surface(_x, _y, _phi, title = "surface")
        r = plot(_x, _y, _phi, st = :heatmap, title = "heatmap")
        plot(s, p, q, r, layout = (2, 2), size = (1100, 800))
        savefig("demo.png")
        return _phi
    end
    export main
end
