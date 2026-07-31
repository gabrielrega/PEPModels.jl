# Leitura dos dados de entrada em CSV.
#
# Os formatos de grade (SAM e VAL_PAR) são os mesmos do PEP-1-1 — o `sam.csv`
# do 1-t é byte a byte o do 1-1, e o `val_par.csv` é a mesma planilha com três
# blocos a mais. Por isso os leitores primitivos vêm de `PEP11` em vez de
# duplicados aqui; o que muda é só `read_val_par`, que precisa dos 7 blocos.

"""
    read_val_par(path, sets) -> NamedTuple

Lê os parâmetros exógenos do `VAL_PAR` em CSV. Os sete blocos são, na ordem:
parâmetros em `j`, em `i`, em `(j,i)`, em `ag`, em `t` (crescimento), em
`(k,j)` (depreciação) e em `(k,j)` (elasticidade da demanda de investimento) —
a mesma ordem dos ranges do `GDXXRW` no `.gms` original (linha 402).
"""
function read_val_par(path::AbstractString, sets::Sets)
    (; J, I, K, H, F, T) = sets
    blocks = val_par_blocks(path)
    length(blocks) == 7 ||
        error("$path: esperados 7 blocos de parâmetros, encontrados $(length(blocks))")
    parj, pari, parji, parag, part, parkj1, parkj2 = blocks

    # Falha com mensagem útil quando a grade não cobre um índice do `sets.csv`.
    function need(block, key, what)
        haskey(block, key) ||
            error("$path: falta $what para $(key[1]) × $(key[2])")
        return block[key]
    end

    return (
        sigma_KD  = Dict(j => need(parj, (j, :sigma_kd), "sigma_KD") for j in J),
        sigma_LD  = Dict(j => need(parj, (j, :sigma_ld), "sigma_LD") for j in J),
        sigma_VA  = Dict(j => need(parj, (j, :sigma_va), "sigma_VA") for j in J),
        sigma_XT  = Dict(j => need(parj, (j, :sigma_xt), "sigma_XT") for j in J),
        sigma_M   = Dict(i => need(pari, (i, :sigma_m), "sigma_M") for i in I),
        sigma_XD  = Dict(i => need(pari, (i, :sigma_xd), "sigma_XD") for i in I),
        sigma_X   = Dict((j, i) => need(parji, (j, i), "sigma_X") for j in J, i in I),
        frisch    = Dict(h => need(parag, (:frisch, h), "frisch") for h in H),
        sigma_Y   = Dict((i, h) => need(parag, (i, h), "sigma_Y") for i in I, h in H),
        sh0O      = Dict(h => need(parag, (:sh0o, h), "sh0O") for h in H),
        tr0O      = Dict(h => need(parag, (:tr0o, h), "tr0O") for h in H),
        ttdh0O    = Dict(h => need(parag, (:ttdh0o, h), "ttdh0O") for h in H),
        ttdf0O    = Dict(f => need(parag, (:ttdf0o, f), "ttdf0O") for f in F),
        # Camada dinâmica (linhas 408, 419 e 614 do `.gms`).
        n         = Dict(t => need(part, (Symbol(t), :n), "n") for t in T),
        delta     = Dict((k, j) => need(parkj1, (k, j), "delta") for k in K, j in J),
        sigma_INV = Dict((k, j) => need(parkj2, (k, j), "sigma_INV") for k in K, j in J),
    )
end
