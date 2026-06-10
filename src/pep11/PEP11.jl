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

# Seção 1 do GAMS — conjuntos
const J  = [:agr, :ind, :ser, :adm]                       # indústrias
const I  = [:agr, :food, :othind, :ser, :adm]             # produtos
const I1 = [:food, :othind, :ser, :adm]                   # produtos exceto agr
const L  = [:usk, :sk]                                    # tipos de trabalho
const K  = [:cap, :land]                                  # tipos de capital
const AG   = [:hrp, :hup, :hrr, :hur, :firm, :gvt, :row]  # agentes
const AGNG = [:hrp, :hup, :hrr, :hur, :firm, :row]        # agentes não governamentais
const AGD  = [:hrp, :hup, :hrr, :hur, :firm, :gvt]        # agentes domésticos
const H  = [:hrp, :hup, :hrr, :hur]                       # famílias
const F  = [:firm]                                        # empresas

include("data.jl")
include("calibration.jl")
include("model.jl")

const DATA_DIR = normpath(joinpath(@__DIR__, "..", "..", "data", "pep-1-1"))

"Calibra o modelo com os dados-padrão empacotados (SAM fictícia V2.0)."
function default_calibration()
    sam = read_sam(joinpath(DATA_DIR, "sam.csv"))
    par = read_val_par(joinpath(DATA_DIR, "val_par.csv"))
    calibrate(sam, par)
end

end # module PEP11
