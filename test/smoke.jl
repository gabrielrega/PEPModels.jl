# Verificação rápida da calibração contra valores do GAMS (uso manual).
using PEPModels
cal = PEPModels.PEP11.default_calibration()
println("beta_KD(cap,agr) = ", cal.beta_KD[(:cap, :agr)], "  (GAMS: 0.20978324705373783)")
println("beta_M(othind)   = ", cal.beta_M[:othind], "  (GAMS: 0.5413983440662373)")
println("B_X(ser,ser)     = ", cal.B_X[(:ser, :ser)], "  (GAMS: 2.475555084422872)")
println("GDP_BPO          = ", cal.GDP_BPO)
println("CO(agr,hrp)      = ", cal.CO[(:agr, :hrp)], "  (GAMS BASE: 5970.280872983598)")
