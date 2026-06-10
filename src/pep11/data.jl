# Leitura dos dados de entrada em CSV (formatos abertos, espelhando os
# arquivos Excel originais lidos via GDXXRW no GAMS).

"Divide uma linha CSV respeitando aspas duplas (sem suporte a quebras de linha internas)."
function split_csv(line::AbstractString)
    fields = String[]
    buf = IOBuffer()
    inquotes = false
    for ch in line
        if ch == '"'
            inquotes = !inquotes
        elseif ch == ',' && !inquotes
            push!(fields, String(take!(buf)))
        else
            write(buf, ch)
        end
    end
    push!(fields, String(take!(buf)))
    return fields
end

_num(s::AbstractString) = isempty(strip(s)) ? 0.0 : parse(Float64, strip(s))
_sym(s::AbstractString) = Symbol(lowercase(strip(s)))

"""
    read_sam(path) -> Dict{NTuple{4,Symbol},Float64}

Lê a SAM em grade CSV (categoria/elemento nas duas primeiras colunas e nas
linhas 4–5, como no intervalo `SAM!A4:AJ39` lido pelo GAMS com Rdim=2 Cdim=2).
Células vazias são omitidas; consultas devem usar `get(sam, chave, 0.0)`.
"""
function read_sam(path::AbstractString)
    rows = split_csv.(readlines(path))
    colcat, colelem = rows[4], rows[5]
    sam = Dict{NTuple{4,Symbol},Float64}()
    for r in 6:min(39, length(rows))
        f = rows[r]
        (length(f) < 2 || isempty(strip(f[1]))) && continue
        rcat, relem = _sym(f[1]), _sym(f[2])
        for c in 3:min(36, length(f))
            isempty(strip(f[c])) && continue
            sam[(rcat, relem, _sym(colcat[c]), _sym(colelem[c]))] = _num(f[c])
        end
    end
    return sam
end

"""
    read_val_par(path) -> NamedTuple

Lê os parâmetros exógenos (elasticidades, Frisch, interceptos) da grade CSV
espelhando os intervalos `PAR!A5:E9`, `A12:C17`, `A20:F24` e `A27:F37` do
`VAL_PAR.xlsx` original.
"""
function read_val_par(path::AbstractString)
    rows = split_csv.(readlines(path))

    # PARJ (A5:E9): linhas indexadas em j, colunas sigma_KD..sigma_XT
    parj_names = _sym.(rows[5][2:5])
    parj = Dict{NTuple{2,Symbol},Float64}()
    for r in 6:9
        j = _sym(rows[r][1])
        for (c, name) in enumerate(parj_names)
            parj[(j, name)] = _num(rows[r][c + 1])
        end
    end

    # PARI (A12:C17): linhas indexadas em i, colunas sigma_M e sigma_XD
    pari_names = _sym.(rows[12][2:3])
    pari = Dict{NTuple{2,Symbol},Float64}()
    for r in 13:17
        i = _sym(rows[r][1])
        for (c, name) in enumerate(pari_names)
            pari[(i, name)] = _num(rows[r][c + 1])
        end
    end

    # PARJI (A20:F24): sigma_X(j,i)
    parji_cols = _sym.(rows[20][2:6])
    sigma_X = Dict{NTuple{2,Symbol},Float64}()
    for r in 21:24
        j = _sym(rows[r][1])
        for (c, i) in enumerate(parji_cols)
            sigma_X[(j, i)] = _num(rows[r][c + 1])
        end
    end

    # PARAG (A27:F37): linhas frisch / sigma_Y(i,.) / interceptos, colunas ag
    parag_cols = _sym.(rows[27][2:6])
    parag = Dict{NTuple{2,Symbol},Float64}()
    for r in 28:37
        key = _sym(rows[r][1])
        for (c, ag) in enumerate(parag_cols)
            parag[(key, ag)] = _num(rows[r][c + 1])
        end
    end

    return (
        sigma_KD = Dict(j => parj[(j, :sigma_kd)] for j in J),
        sigma_LD = Dict(j => parj[(j, :sigma_ld)] for j in J),
        sigma_VA = Dict(j => parj[(j, :sigma_va)] for j in J),
        sigma_XT = Dict(j => parj[(j, :sigma_xt)] for j in J),
        sigma_M  = Dict(i => pari[(i, :sigma_m)] for i in I),
        sigma_XD = Dict(i => pari[(i, :sigma_xd)] for i in I),
        sigma_X  = sigma_X,
        frisch   = Dict(h => parag[(:frisch, h)] for h in H),
        sigma_Y  = Dict((i, h) => parag[(i, h)] for i in I, h in H),
        sh0O     = Dict(h => parag[(:sh0o, h)] for h in H),
        tr0O     = Dict(h => parag[(:tr0o, h)] for h in H),
        ttdh0O   = Dict(h => parag[(:ttdh0o, h)] for h in H),
        ttdf0O   = Dict(f => parag[(:ttdf0o, f)] for f in F),
    )
end
