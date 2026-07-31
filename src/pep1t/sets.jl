# Conjuntos do modelo (seção 1 do GAMS), dados pela base em vez de fixos —
# mesma decisão do PEP-1-1, ver `src/pep11/sets.jl`.
#
# Sobre o PEP-1-1, o 1-t acrescenta duas coisas ao `sets.csv`:
#
# - `PUB`, as indústrias públicas. O 1-t separa investimento público de
#   privado (EQ101–EQ108), e essa partição não é inferível da SAM: `adm` é
#   pública na SAM fictícia por convenção do modelo, não por um traço da
#   matriz. `BUS` é derivado por diferença.
# - `T`, os períodos. O horizonte é da base, não do modelo — na SAM fictícia
#   o GAMS fixa `T /1*10/`, mas nada no modelo exige dez.

"""
    Sets

Conjuntos de índices do PEP-1-t. Construa com o construtor por palavra-chave,
que deriva `BUS`, `AG`, `AGNG`, `AGD` e `I1` dos conjuntos primitivos.

- `J` indústrias, `I` produtos, `L` tipos de trabalho, `K` tipos de capital
- `H` famílias, `F` empresas
- `PUB` indústrias públicas, `BUS` privadas (`J` menos `PUB`)
- `T` períodos, em ordem; `T1` é o primeiro
- `walras` produto excluído da EQ84, cujo mercado fecha pela lei de Walras
"""
struct Sets
    J::Vector{Symbol}
    I::Vector{Symbol}
    L::Vector{Symbol}
    K::Vector{Symbol}
    H::Vector{Symbol}
    F::Vector{Symbol}
    PUB::Vector{Symbol}
    BUS::Vector{Symbol}
    T::Vector{Int}
    T1::Int
    walras::Symbol
    I1::Vector{Symbol}
    AG::Vector{Symbol}
    AGNG::Vector{Symbol}
    AGD::Vector{Symbol}
end

function Sets(; J, I, L, K, H, F, PUB, T, walras = first(I))
    for (name, s) in (("J", J), ("I", I), ("L", L), ("K", K), ("H", H), ("F", F))
        isempty(s) && error("conjunto $name está vazio")
        allunique(s) || error("conjunto $name tem elementos repetidos")
    end
    allunique(PUB) || error("conjunto PUB tem elementos repetidos")
    for j in PUB
        j in J || error("indústria pública `$j` não pertence a J = $J")
    end
    isempty(T) && error("conjunto T está vazio")
    allunique(T) || error("conjunto T tem períodos repetidos")
    issorted(T) || error("os períodos em T precisam estar em ordem crescente")
    walras in I || error("produto de Walras `$walras` não pertence a I = $I")
    for reserved in (:gvt, :row)
        reserved in H && error("`$reserved` é rótulo reservado, não pode estar em H")
        reserved in F && error("`$reserved` é rótulo reservado, não pode estar em F")
    end
    # Ordem preservada (H, F, gvt, row) — a mesma do GAMS original, para que as
    # somas sobre AG mantenham a ordem de acumulação em ponto flutuante.
    AG = vcat(H, F, [:gvt, :row])
    return Sets(J, I, L, K, H, F,
                PUB, filter(!in(PUB), J), T, first(T), walras,
                filter(!=(walras), I), AG,
                filter(!=(:gvt), AG), filter(!=(:row), AG))
end

"""
    read_sets(path) -> Sets

Lê `sets.csv`: uma linha por conjunto, primeiro campo com o nome (`J`, `I`,
`L`, `K`, `H`, `F`, `PUB`, `T` ou `WALRAS`) e os demais com os elementos.
Linhas em branco e iniciadas por `#` são ignoradas.
"""
function read_sets(path::AbstractString)
    vals = Dict{Symbol,Vector{Symbol}}()
    for line in readlines(path)
        f = split_csv(line)
        head = strip(f[1])
        (isempty(head) || startswith(head, "#")) && continue
        elems = [_sym(x) for x in f[2:end] if !isempty(strip(x))]
        vals[Symbol(uppercase(head))] = elems
    end
    for name in (:J, :I, :L, :K, :H, :F, :PUB, :T)
        haskey(vals, name) || error("$path não define o conjunto $name")
    end
    periods = map(vals[:T]) do t
        n = tryparse(Int, String(t))
        n === nothing && error("$path: período `$t` em T não é um inteiro")
        n
    end
    walras = haskey(vals, :WALRAS) ? only(vals[:WALRAS]) : first(vals[:I])
    return Sets(J = vals[:J], I = vals[:I], L = vals[:L], K = vals[:K],
                H = vals[:H], F = vals[:F], PUB = vals[:PUB],
                T = periods, walras = walras)
end
