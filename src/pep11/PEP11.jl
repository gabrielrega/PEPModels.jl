"""
    PEP11

Tradução em Julia/JuMP do modelo PEP-1-1 v2.1 (modelo EGC estático de país
único da rede PEP), de Robichaud, Lemelin, Maisonnave e Decaluwé (2013).

O código espelha o original em GAMS (`references/pep-1-1/PEP-1-1_v2_1.gms`)
seção a seção: leitura da SAM, calibração e equações EQ1–EQ98 + WALRAS.
Comentários citam os números de linha/equação do `.gms` original.
"""
module PEP11

using JuMP
import Ipopt

# sets.jl antes de data.jl: `read_val_par` tem `::Sets` na assinatura.
include("sets.jl")
include("data.jl")
include("calibration.jl")
include("model.jl")

const DATA_ROOT = normpath(joinpath(@__DIR__, "..", "..", "data"))

"Diretório dos dados empacotados de `name` (`pep-1-1`, `pep-1-1-br`, ...)."
datadir(name::AbstractString) = joinpath(DATA_ROOT, name)

"""
    calibration(dir) -> NamedTuple

Calibra o modelo a partir de um diretório com `sam.csv`, `val_par.csv` e
`sets.csv`.
"""
function calibration(dir::AbstractString)
    sets = read_sets(joinpath(dir, "sets.csv"))
    sam  = read_sam(joinpath(dir, "sam.csv"))
    par  = read_val_par(joinpath(dir, "val_par.csv"), sets)
    return calibrate(sam, par, sets)
end

"Calibra o modelo com os dados-padrão empacotados (SAM fictícia V2.0)."
default_calibration() = calibration(datadir("pep-1-1"))

"Calibra o modelo com a SAM brasileira de 2015 (IBGE)."
br_calibration() = calibration(datadir("pep-1-1-br"))

end # module PEP11
