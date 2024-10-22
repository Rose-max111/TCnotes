using TOML
using XDiag
N = 12
latfile = TOML.parsefile(joinpath(@__DIR__, "triangular.$N.J1J2.toml"))
    
coords = latfile["Coordinates"]
interactions = latfile["Interactions"]
ops = OpSum()
for interaction in interactions
    type = interaction[1]
    couplingname = interaction[2]
    s1 = interaction[3] + 1
    s2 = interaction[4] + 1
    ops += Op(type, couplingname, [s1, s2])
end
ops["J1"] = 1.0
ops["J2"] = 0.0

block = Spinhalf(N, N÷2)
e0, gs = eig0(ops, block)
@show e0
    
for i in 2:N
    s1si = Op("HB", 1.0, [1, i])
    corr = inner(s1si, gs)
    println("$i $corr")
end