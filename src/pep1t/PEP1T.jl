"""
    PEP1T

Tradução em Julia/JuMP do modelo PEP-1-t v2.1 (modelo EGC dinâmico recursivo
de país único da rede PEP), de Robichaud, Lemelin, Maisonnave e Decaluwé
(2013).

O código espelha o original em GAMS (`references/pep-1-t/PEP_1-t-b_v2_1.gms`,
a variante que resolve um período por vez) seção a seção. Comentários citam os
números de linha/equação do `.gms` original.

Sobre o PEP-1-1, o 1-t acrescenta o índice de tempo, a partição das indústrias
em públicas e privadas, e o bloco de acumulação de capital: EQ99–EQ109b.
"""
module PEP1T

using JuMP
import Ipopt

# Os formatos de arquivo são os mesmos do PEP-1-1, então os leitores primitivos
# de grade vêm de lá. `read_val_par` e `read_sets` são próprios: o 1-t tem 7
# blocos de parâmetros em vez de 4, e conjuntos a mais (`PUB`, `T`).
import ..PEP11: split_csv, val_par_blocks, read_sam, _sym, _num, _at

# sets.jl antes de data.jl: `read_val_par` tem `::Sets` na assinatura.
include("sets.jl")
include("data.jl")

const DATA_ROOT = normpath(joinpath(@__DIR__, "..", "..", "data"))

"Diretório dos dados empacotados de `name` (`pep-1-t`, ...)."
datadir(name::AbstractString) = joinpath(DATA_ROOT, name)

end # module PEP1T
