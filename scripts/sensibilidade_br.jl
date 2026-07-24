# Sensibilidade dos resultados do PEP-1-1 brasileiro às elasticidades incertas
# do `data/pep-1-1-br/val_par.csv` (proveniência em references/sam-br/README.md).
#
# A calibração replica o mesmo benchmark qualquer que seja a elasticidade, então
# a sensibilidade só aparece na RESPOSTA A CHOQUE. O choque usado é um corte de
# 50% em todas as tarifas de importação, com o fechamento padrão: câmbio como
# numerário, CAB fixo, G fixo, oferta de trabalho e de capital fixas — ou seja,
# a perda de arrecadação cai no déficit público (ΔSG).
#
# Uso: julia --project=. scripts/sensibilidade_br.jl

using PEPModels, JuMP, Printf
const P11 = PEPModels.PEP11

const DIR  = P11.datadir("pep-1-1-br")
const SETS = P11.read_sets(joinpath(DIR, "sets.csv"))
const SAM  = P11.read_sam(joinpath(DIR, "sam.csv"))
const PAR0 = P11.read_val_par(joinpath(DIR, "val_par.csv"), SETS)

"Recalibra com sobreposições em cima do val_par.csv."
function calib(; over...)
    par = PAR0
    for (name, patch) in over
        par = merge(par, (; name => merge(getproperty(par, name), patch)))
    end
    return P11.calibrate(SAM, par, SETS)
end

pct(new, old) = old == 0 ? NaN : 100 * (new / old - 1)

"Aplica o choque, resolve e devolve os indicadores em variação % do benchmark."
function run_case(cal; cut = 0.5)
    m = P11.build(cal)
    for i in m.ext[:sup].iIM
        fix(m[:ttim][i], cal.ttimO[i] * cut; force = true)
    end
    P11.solve!(m)
    abs(value(m[:LEON])) / cal.GDP_MPO < 1e-9 || error("lei de Walras violada")

    ex     = m.ext[:sup].iEXD
    imtot  = sum(cal.PWMO[i] * value(m[:IM][i])  for i in m.ext[:sup].iIM)
    imtot0 = sum(cal.PWMO[i] * cal.IMO[i]        for i in m.ext[:sup].iIM)
    extot  = sum(cal.PWXO[i] * value(m[:EXD][i]) for i in ex)
    extot0 = sum(cal.PWXO[i] * cal.EXDO[i]       for i in ex)
    # Preço de exportação ponderado pela pauta do benchmark: como e e PWM estão
    # fixos no fechamento, ele é a própria medida de termos de troca.
    pxf    = sum(value(m[:PE_FOB][i]) * cal.EXDO[i] for i in ex) / sum(cal.EXDO[i] for i in ex)
    pxf0   = sum(cal.PE_FOBO[i]       * cal.EXDO[i] for i in ex) / sum(cal.EXDO[i] for i in ex)

    return (
        gdp     = pct(value(m[:GDP_MP_REAL]), cal.GDP_MP_REALO),
        bemestar= pct(value(m[:CTH_REAL][:h]), cal.CTH_REALO[:h]),
        import_ = pct(imtot, imtot0),
        export_ = pct(extot, extot0),
        troca   = pct(pxf, pxf0),
        xind    = pct(value(m[:XST][:ind]), cal.XSTO[:ind]),
        salario = pct(value(m[:W][:lab]) / value(m[:PIXCON]), 1.0),
        capital = pct(value(m[:RK][:cap]) / value(m[:PIXCON]), 1.0),
        sg      = value(m[:SG]) - cal.SGO,
    )
end

const COLS = [(:gdp, "PIB real"), (:bemestar, "Bem-estar"), (:import_, "Import."),
              (:export_, "Export."), (:troca, "Trm.troca"), (:xind, "XST ind"),
              (:salario, "Salário r"), (:capital, "Ret.cap.r")]

function table(title, cases)
    println("\n### ", title)
    @printf("%-28s", "cenário")
    for (_, h) in COLS; @printf("%10s", h); end
    @printf("%11s\n", "ΔSG R\$mi")
    println("-"^(28 + 10 * length(COLS) + 11))
    for (label, cal) in cases
        @printf("%-28s", label)
        try
            r = run_case(cal)
            for (k, _) in COLS; @printf("%10.4f", getproperty(r, k)); end
            @printf("%11.0f\n", r.sg)
        catch e
            @printf("  << falhou: %s >>\n", sprint(showerror, e))
        end
    end
end

# Atenção: sigma = 1 é singular na formulação CES (rho = 0 ⇒ divisão por zero
# em B_M/B_VA), tanto aqui quanto no GAMS original. Os cenários evitam esse ponto.

table("A. sigma_M[ind] — IPEA TD 124: 1,15 ponderado por importações / 1,47 simples", [
    ("sigma_M[ind] = 0.90", calib(sigma_M = Dict(:ind => 0.90))),
    ("sigma_M[ind] = 1.15", calib(sigma_M = Dict(:ind => 1.15))),
    ("sigma_M[ind] = 1.50 (base)", calib()),
    ("sigma_M[ind] = 2.00", calib(sigma_M = Dict(:ind => 2.00))),
    ("sigma_M[ind] = 3.00", calib(sigma_M = Dict(:ind => 3.00))),
])

table("B. sigma_M[agr] — o menos ancorado (GTAP vai de 1,30 a 4,45)", [
    ("sigma_M[agr] = 1.30", calib(sigma_M = Dict(:agr => 1.30))),
    ("sigma_M[agr] = 2.00 (base)", calib()),
    ("sigma_M[agr] = 3.50", calib(sigma_M = Dict(:agr => 3.50))),
])

table("C. sigma_M de todos os produtos, ±40% (x0.5 poria agr em 1.0, singular)", [
    ("todos x0.6", calib(sigma_M = Dict(i => 0.6 * PAR0.sigma_M[i] for i in SETS.I))),
    ("base", calib()),
    ("todos x1.4", calib(sigma_M = Dict(i => 1.4 * PAR0.sigma_M[i] for i in SETS.I))),
])

table("D. frisch — -1,5 (default PEP) vs -2,0 (base) vs -3,0", [
    ("frisch = -1.5", calib(frisch = Dict(:h => -1.5))),
    ("frisch = -2.0 (base)", calib()),
    ("frisch = -3.0", calib(frisch = Dict(:h => -3.0))),
])

table("E. sigma_VA — GTAP ponderado pelo VAB (base) vs 1,5 uniforme da PEP", [
    ("base (GTAP ponderado)", calib()),
    ("1.5 uniforme (PEP)", calib(sigma_VA = Dict(j => 1.5 for j in SETS.J))),
    ("metade do GTAP", calib(sigma_VA = Dict(j => 0.5 * PAR0.sigma_VA[j] for j in SETS.J))),
])

table("F. sigma_XD — demanda mundial por exportações (o parâmetro dominante)", [
    ("econométrico BR", calib(sigma_XD = Dict(:agr => 0.53, :ind => 0.78, :ser => 1.18))),
    ("  idem, serviços no GTAP", calib(sigma_XD = Dict(:agr => 0.53, :ind => 0.78, :ser => 3.8))),
    ("uniforme 1.0", calib(sigma_XD = Dict(i => 1.0 for i in SETS.I))),
    ("uniforme 2.0 (base, PEP)", calib()),
    ("uniforme 4.0", calib(sigma_XD = Dict(i => 4.0 for i in SETS.I))),
    ("regra dos dois (2 x sigma_M)",
     calib(sigma_XD = Dict(i => 2 * PAR0.sigma_M[i] for i in SETS.I))),
    ("GTAP sourcing (agr 5 ind 6 ser 3.8)",
     calib(sigma_XD = Dict(:agr => 5.0, :ind => 6.0, :ser => 3.8))),
])
