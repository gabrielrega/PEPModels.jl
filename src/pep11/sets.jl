# Conjuntos do modelo (seção 1 do GAMS), agora dados por SAM em vez de fixos.
#
# Alguns rótulos continuam sendo *convenção* obrigatória da SAM, porque o papel
# que exercem nas equações não pode ser inferido da matriz: `gvt` (governo),
# `row` (resto do mundo), `td`/`tm`/`ti` (contas de imposto) e `inv`/`vstk`
# (acumulação). Já J, I, L, K, H e F variam por base e vêm do `sets.csv`.

"""
    Sets

Conjuntos de índices do PEP-1-1. Construa com o construtor por palavra-chave,
que deriva `AG`, `AGNG`, `AGD` e `I1` dos conjuntos primitivos.

- `J` indústrias, `I` produtos, `L` tipos de trabalho, `K` tipos de capital
- `H` famílias, `F` empresas
- `walras` produto excluído da EQ84, cujo mercado fecha pela lei de Walras
"""
struct Sets
    J::Vector{Symbol}
    I::Vector{Symbol}
    L::Vector{Symbol}
    K::Vector{Symbol}
    H::Vector{Symbol}
    F::Vector{Symbol}
    walras::Symbol
    I1::Vector{Symbol}
    AG::Vector{Symbol}
    AGNG::Vector{Symbol}
    AGD::Vector{Symbol}
end

function Sets(; J, I, L, K, H, F, walras = first(I))
    for (name, s) in (("J", J), ("I", I), ("L", L), ("K", K), ("H", H), ("F", F))
        isempty(s) && error("conjunto $name está vazio")
        allunique(s) || error("conjunto $name tem elementos repetidos")
    end
    walras in I || error("produto de Walras `$walras` não pertence a I = $I")
    for reserved in (:gvt, :row)
        reserved in H && error("`$reserved` é rótulo reservado, não pode estar em H")
        reserved in F && error("`$reserved` é rótulo reservado, não pode estar em F")
    end
    # Ordem preservada (H, F, gvt, row) — a mesma do GAMS original, para que as
    # somas sobre AG mantenham a ordem de acumulação em ponto flutuante.
    AG = vcat(H, F, [:gvt, :row])
    return Sets(J, I, L, K, H, F, walras,
                filter(!=(walras), I), AG,
                filter(!=(:gvt), AG), filter(!=(:row), AG))
end

"""
    read_sets(path) -> Sets

Lê `sets.csv`: uma linha por conjunto, primeiro campo com o nome (`J`, `I`,
`L`, `K`, `H`, `F` ou `WALRAS`) e os demais com os elementos. Linhas em branco
e iniciadas por `#` são ignoradas.
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
    for name in (:J, :I, :L, :K, :H, :F)
        haskey(vals, name) || error("$path não define o conjunto $name")
    end
    walras = haskey(vals, :WALRAS) ? only(vals[:WALRAS]) : first(vals[:I])
    return Sets(J = vals[:J], I = vals[:I], L = vals[:L], K = vals[:K],
                H = vals[:H], F = vals[:F], walras = walras)
end
