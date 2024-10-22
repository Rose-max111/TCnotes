using Yao

function j1j2(n::Int, j1::Real, j2::Real)
    j1terms = sum([sum([kron(n, i=>G, i+1=>G) for G in [X, Y, Z]]) for i=1:n-1])
    j2terms = sum([sum([kron(n, i=>G, i+2=>G) for G in [X, Y, Z]]) for i=1:n-2])
    return j1 * j1terms + j2 * j2terms
end

h = j1j2(12, 1.0, 0.0)
using KrylovKit
evals, evecs = eigsolve(mat(h), 1, :SR)