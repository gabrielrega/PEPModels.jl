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

"Campo `i` da linha, ou string vazia se a linha foi cortada nas vírgulas finais."
_at(f::Vector{String}, i::Int) = i <= length(f) ? f[i] : ""

"""
    read_sam(path) -> Dict{NTuple{4,Symbol},Float64}

Lê a SAM em grade CSV (categoria/elemento nas duas primeiras colunas e nas
linhas 4–5, como no intervalo lido pelo GAMS com Rdim=2 Cdim=2). A extensão da
grade vem do próprio arquivo, então SAMs de dimensões diferentes são aceitas.
Células vazias são omitidas; consultas devem usar `get(sam, chave, 0.0)`.
"""
function read_sam(path::AbstractString)
    rows = split_csv.(readlines(path))
    colcat, colelem = rows[4], rows[5]
    ncol = min(length(colcat), length(colelem))
    sam = Dict{NTuple{4,Symbol},Float64}()
    for r in 6:length(rows)
        f = rows[r]
        (length(f) < 2 || isempty(strip(f[1]))) && continue
        rcat, relem = _sym(f[1]), _sym(f[2])
        for c in 3:min(length(f), ncol)
            isempty(strip(f[c])) && continue
            sam[(rcat, relem, _sym(colcat[c]), _sym(colelem[c]))] = _num(f[c])
        end
    end
    return sam
end

"""
    val_par_blocks(path) -> Vector{Dict{NTuple{2,Symbol},Float64}}

Quebra a grade do `VAL_PAR` nos seus blocos rótulo × coluna, sem depender dos
números de linha do arquivo original (que variavam com o tamanho dos
conjuntos). Um bloco começa numa linha de cabeçalho — primeiro campo vazio e
algum outro preenchido — e segue enquanto o primeiro campo estiver preenchido.
Linhas de título de seção ficam de fora porque só têm o primeiro campo.
"""
function val_par_blocks(path::AbstractString)
    rows = split_csv.(readlines(path))
    blocks = Dict{NTuple{2,Symbol},Float64}[]
    r = 1
    while r <= length(rows)
        f = rows[r]
        isheader = !isempty(f) && isempty(strip(f[1])) &&
                   any(!isempty(strip(x)) for x in f[2:end])
        if !isheader
            r += 1
            continue
        end
        cols = Symbol[]
        for c in 2:length(f)
            isempty(strip(f[c])) && continue
            length(cols) == c - 2 || error("$path: coluna vazia no meio do cabeçalho da linha $r")
            push!(cols, _sym(f[c]))
        end
        block = Dict{NTuple{2,Symbol},Float64}()
        r += 1
        while r <= length(rows) && !isempty(strip(_at(rows[r], 1)))
            key = _sym(rows[r][1])
            for (c, col) in enumerate(cols)
                block[(key, col)] = _num(_at(rows[r], c + 1))
            end
            r += 1
        end
        push!(blocks, block)
    end
    return blocks
end

"""
    read_val_par(path, sets) -> NamedTuple

Lê os parâmetros exógenos (elasticidades, Frisch, interceptos) do `VAL_PAR` em
CSV. Os quatro blocos são, na ordem: parâmetros em `j`, em `i`, em `(j,i)` e em
`ag`, como no `VAL_PAR.xlsx` original.
"""
function read_val_par(path::AbstractString, sets::Sets)
    (; J, I, H, F) = sets
    blocks = val_par_blocks(path)
    length(blocks) == 4 ||
        error("$path: esperados 4 blocos de parâmetros, encontrados $(length(blocks))")
    parj, pari, parji, parag = blocks

    # Falha com mensagem útil quando a grade não cobre um índice do `sets.csv`.
    function need(block, key, what)
        haskey(block, key) ||
            error("$path: falta $what para $(key[1]) × $(key[2])")
        return block[key]
    end

    return (
        sigma_KD = Dict(j => need(parj, (j, :sigma_kd), "sigma_KD") for j in J),
        sigma_LD = Dict(j => need(parj, (j, :sigma_ld), "sigma_LD") for j in J),
        sigma_VA = Dict(j => need(parj, (j, :sigma_va), "sigma_VA") for j in J),
        sigma_XT = Dict(j => need(parj, (j, :sigma_xt), "sigma_XT") for j in J),
        sigma_M  = Dict(i => need(pari, (i, :sigma_m), "sigma_M") for i in I),
        sigma_XD = Dict(i => need(pari, (i, :sigma_xd), "sigma_XD") for i in I),
        sigma_X  = Dict((j, i) => need(parji, (j, i), "sigma_X") for j in J, i in I),
        frisch   = Dict(h => need(parag, (:frisch, h), "frisch") for h in H),
        sigma_Y  = Dict((i, h) => need(parag, (i, h), "sigma_Y") for i in I, h in H),
        sh0O     = Dict(h => need(parag, (:sh0o, h), "sh0O") for h in H),
        tr0O     = Dict(h => need(parag, (:tr0o, h), "tr0O") for h in H),
        ttdh0O   = Dict(h => need(parag, (:ttdh0o, h), "ttdh0O") for h in H),
        ttdf0O   = Dict(f => need(parag, (:ttdf0o, f), "ttdf0O") for f in F),
    )
end
