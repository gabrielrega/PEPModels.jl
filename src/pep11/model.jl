# Modelo — transliteração da seção 5 do GAMS (equações EQ1–EQ98 + WALRAS)
# e da seção 6 (inicialização, capital móvel e fechamento padrão).
#
# Variáveis indexadas só são criadas sobre o suporte (células com fluxo
# positivo no benchmark), espelhando as condições `$` do GAMS que mantêm o
# sistema quadrado. Índices duplos usam chave em tupla: LD[(l, j)].

"Domínio produto cartesiano como vetor de tuplas."
d2(A, B) = [(a, b) for a in A for b in B]

"""
    build(cal; kmob=true, optimizer=Ipopt.Optimizer) -> JuMP.Model

Constrói o modelo PEP-1-1 calibrado, com fechamento padrão já aplicado
(câmbio numerário; `CAB`, `G`, `LS`, `PWM`, `PWX`, `VSTK`, alíquotas e
interceptos fixos; `KS` fixo se capital móvel, `KD` fixo caso contrário).

Para simular um choque, altere variáveis fixas com `fix(...)` e chame
`solve!`. Ex.: `fix(m[:ttix][:agr], cal.ttixO[:agr] * 0.75; force = true)`.
"""
function build(cal; kmob::Bool = true, optimizer = Ipopt.Optimizer)
    m = Model(optimizer)
    set_silent(m)
    set_optimizer_attribute(m, "tol", 1e-10)

    # Suportes (condições $ do GAMS)
    supXS = [(j, i) for j in J for i in I if cal.XSO[(j, i)] > 0]
    supEX = [(j, i) for j in J for i in I if cal.EXO[(j, i)] > 0]
    supDS = [(j, i) for j in J for i in I if cal.DSO[(j, i)] > 0]
    supLD = [(l, j) for l in L for j in J if cal.LDO[(l, j)] > 0]
    supKD = [(k, j) for k in K for j in J if cal.KDO[(k, j)] > 0]
    iDD  = [i for i in I if cal.DDO[i] > 0]
    iIM  = [i for i in I if cal.IMO[i] > 0]
    iEXD = [i for i in I if cal.EXDO[i] > 0]
    jL = [j for j in J if cal.LDCO[j] > 0]
    jK = [j for j in J if cal.KDCO[j] > 0]
    # Transferências definidas pelas EQ47–EQ51 (demais células são nulas)
    supTR = [(a, b) for a in AG for b in AG if !(a == b == :gvt) && !(a == b == :row)]

    POS = 1e-6  # limite inferior de variáveis estritamente positivas (bases de potências)

    ## 5.1.1 Volumes
    @variable(m, C[p in d2(I, H)] >= 0, start = cal.CO[p])
    @variable(m, CG[i in I] >= 0, start = cal.CGO[i])
    @variable(m, CI[j in J] >= 0, start = cal.CIO[j])
    @variable(m, CMIN[p in d2(I, H)], start = cal.CMINO[p])
    @variable(m, CTH_REAL[h in H], start = cal.CTH_REALO[h])
    @variable(m, DD[i in iDD] >= POS, start = cal.DDO[i])
    @variable(m, DI[p in d2(I, J)] >= 0, start = cal.DIO[p])
    @variable(m, DIT[i in I] >= 0, start = cal.DITO[i])
    @variable(m, DS[p in supDS] >= POS, start = cal.DSO[p])
    @variable(m, EX[p in supEX] >= POS, start = cal.EXO[p])
    @variable(m, EXD[i in iEXD] >= POS, start = cal.EXDO[i])
    @variable(m, G_REAL, start = cal.G_REALO)
    @variable(m, GDP_BP_REAL, start = cal.GDP_BP_REALO)
    @variable(m, GDP_MP_REAL, start = cal.GDP_MP_REALO)
    @variable(m, GFCF_REAL, start = cal.GFCF_REALO)
    @variable(m, IM[i in iIM] >= POS, start = cal.IMO[i])
    @variable(m, INV[i in I] >= 0, start = cal.INVO[i])
    @variable(m, KD[p in supKD] >= POS, start = cal.KDO[p])
    @variable(m, KDC[j in jK] >= POS, start = cal.KDCO[j])
    @variable(m, KS[k in K] >= POS, start = cal.KSO[k])
    @variable(m, LD[p in supLD] >= POS, start = cal.LDO[p])
    @variable(m, LDC[j in jL] >= POS, start = cal.LDCO[j])
    @variable(m, LS[l in L] >= POS, start = cal.LSO[l])
    @variable(m, MRGN[i in I] >= 0, start = cal.MRGNO[i])
    @variable(m, Q[i in I] >= POS, start = cal.QO[i])
    @variable(m, VA[j in J] >= POS, start = cal.VAO[j])
    @variable(m, VSTK[i in I], start = cal.VSTKO[i])
    @variable(m, XS[p in supXS] >= POS, start = cal.XSO[p])
    @variable(m, XST[j in J] >= POS, start = cal.XSTO[j])

    ## 5.1.2 Preços
    @variable(m, e >= POS, start = cal.eO)
    @variable(m, P[p in supXS] >= POS, start = cal.PO[p])
    @variable(m, PC[i in I] >= POS, start = cal.PCO[i])
    @variable(m, PCI[j in J] >= POS, start = cal.PCIO[j])
    @variable(m, PD[i in iDD] >= POS, start = cal.PDO[i])
    @variable(m, PE[i in iEXD] >= POS, start = cal.PEO[i])
    @variable(m, PE_FOB[i in iEXD] >= POS, start = cal.PE_FOBO[i])
    @variable(m, PIXCON >= POS, start = cal.PIXCONO)
    @variable(m, PIXGDP >= POS, start = cal.PIXGDPO)
    @variable(m, PIXGVT >= POS, start = cal.PIXGVTO)
    @variable(m, PIXINV >= POS, start = cal.PIXINVO)
    @variable(m, PL[i in iDD] >= POS, start = cal.PLO[i])
    @variable(m, PM[i in iIM] >= POS, start = cal.PMO[i])
    @variable(m, PP[j in J] >= POS, start = cal.PPO[j])
    @variable(m, PT[j in J] >= POS, start = cal.PTO[j])
    @variable(m, PVA[j in J] >= POS, start = cal.PVAO[j])
    @variable(m, PWM[i in iIM] >= POS, start = cal.PWMO[i])
    @variable(m, PWX[i in iEXD] >= POS, start = cal.PWXO[i])
    @variable(m, R[p in supKD] >= POS, start = cal.RO[p])
    @variable(m, RC[j in jK] >= POS, start = cal.RCO[j])
    @variable(m, RK[k in K] >= POS, start = cal.RKO[k])
    @variable(m, RTI[p in supKD] >= POS, start = cal.RTIO[p])
    @variable(m, W[l in L] >= POS, start = cal.WO[l])
    @variable(m, WC[j in jL] >= POS, start = cal.WCO[j])
    @variable(m, WTI[p in d2(L, J)] >= POS, start = cal.WTIO[p])

    ## 5.1.3 Valores nominais
    @variable(m, CAB, start = cal.CABO)
    @variable(m, CTH[h in H], start = cal.CTHO[h])
    @variable(m, G, start = cal.GO)
    @variable(m, GDP_BP, start = cal.GDP_BPO)
    @variable(m, GDP_FD, start = cal.GDP_FDO)
    @variable(m, GDP_IB, start = cal.GDP_IBO)
    @variable(m, GDP_MP, start = cal.GDP_MPO)
    @variable(m, GFCF, start = cal.GFCFO)
    @variable(m, IT, start = cal.ITO)
    @variable(m, SF[f in F], start = cal.SFO[f])
    @variable(m, SG, start = cal.SGO)
    @variable(m, SH[h in H], start = cal.SHO[h])
    @variable(m, SROW, start = cal.SROWO)
    @variable(m, TDF[f in F], start = cal.TDFO[f])
    @variable(m, TDFT, start = cal.TDFTO)
    @variable(m, TDH[h in H], start = cal.TDHO[h])
    @variable(m, TDHT, start = cal.TDHTO)
    @variable(m, TIC[i in I], start = cal.TICO[i])
    @variable(m, TICT, start = cal.TICTO)
    @variable(m, TIK[p in supKD], start = cal.TIKO[p])
    @variable(m, TIKT, start = cal.TIKTO)
    @variable(m, TIM[i in iIM], start = cal.TIMO[i])
    @variable(m, TIMT, start = cal.TIMTO)
    @variable(m, TIP[j in J], start = cal.TIPO[j])
    @variable(m, TIPT, start = cal.TIPTO)
    @variable(m, TIW[p in supLD], start = cal.TIWO[p])
    @variable(m, TIWT, start = cal.TIWTO)
    @variable(m, TIX[i in iEXD], start = cal.TIXO[i])
    @variable(m, TIXT, start = cal.TIXTO)
    @variable(m, TPRCTS, start = cal.TPRCTSO)
    @variable(m, TPRODN, start = cal.TPRODNO)
    @variable(m, TR[p in supTR], start = cal.TRO[p])
    @variable(m, YDF[f in F], start = cal.YDFO[f])
    @variable(m, YDH[h in H], start = cal.YDHO[h])
    @variable(m, YF[f in F], start = cal.YFO[f])
    @variable(m, YFK[f in F], start = cal.YFKO[f])
    @variable(m, YFTR[f in F], start = cal.YFTRO[f])
    @variable(m, YG, start = cal.YGO)
    @variable(m, YGK, start = cal.YGKO)
    @variable(m, YGTR, start = cal.YGTRO)
    @variable(m, YH[h in H], start = cal.YHO[h])
    @variable(m, YHK[h in H], start = cal.YHKO[h])
    @variable(m, YHL[h in H], start = cal.YHLO[h])
    @variable(m, YHTR[h in H], start = cal.YHTRO[h])
    @variable(m, YROW, start = cal.YROWO)

    ## 5.1.4 Alíquotas e interceptos (fixados no fechamento)
    @variable(m, sh0[h in H], start = cal.sh0O[h])
    @variable(m, sh1[h in H], start = cal.sh1O[h])
    @variable(m, tr0[h in H], start = cal.tr0O[h])
    @variable(m, tr1[h in H], start = cal.tr1O[h])
    @variable(m, ttdf0[f in F], start = cal.ttdf0O[f])
    @variable(m, ttdf1[f in F], start = cal.ttdf1O[f])
    @variable(m, ttdh0[h in H], start = cal.ttdh0O[h])
    @variable(m, ttdh1[h in H], start = cal.ttdh1O[h])
    @variable(m, ttic[i in I], start = cal.tticO[i])
    @variable(m, ttik[p in supKD], start = cal.ttikO[p])
    @variable(m, ttim[i in iIM], start = cal.ttimO[i])
    @variable(m, ttip[j in J], start = cal.ttipO[j])
    @variable(m, ttiw[p in d2(L, J)], start = cal.ttiwO[p])
    @variable(m, ttix[i in iEXD], start = cal.ttixO[i])

    ## 5.1.5 Verificação da lei de Walras
    @variable(m, LEON, start = 0.0)

    ## 5.3.1 Produção
    @constraint(m, EQ1[j in J], VA[j] == cal.v[j] * XST[j])
    @constraint(m, EQ2[j in J], CI[j] == cal.io[j] * XST[j])
    for j in J  # EQ3 (termos condicionados a LDCO/KDCO)
        terms = Any[]
        cal.LDCO[j] > 0 && push!(terms, cal.beta_VA[j] * LDC[j]^(-cal.rho_VA[j]))
        cal.KDCO[j] > 0 && push!(terms, (1 - cal.beta_VA[j]) * KDC[j]^(-cal.rho_VA[j]))
        @constraint(m, VA[j] == cal.B_VA[j] * sum(terms)^(-1 / cal.rho_VA[j]))
    end
    @constraint(m, EQ4[j in J; cal.LDCO[j] > 0 && cal.KDCO[j] > 0],
        LDC[j] == ((cal.beta_VA[j] / (1 - cal.beta_VA[j])) * (RC[j] / WC[j]))^cal.sigma_VA[j] * KDC[j])
    @constraint(m, EQ5[j in jL],
        LDC[j] == cal.B_LD[j] * sum(cal.beta_LD[(l, j)] * LD[(l, j)]^(-cal.rho_LD[j])
                                    for l in L if (l, j) in supLD)^(-1 / cal.rho_LD[j]))
    @constraint(m, EQ6[p in supLD],
        LD[p] == (cal.beta_LD[p] * WC[p[2]] / WTI[p])^cal.sigma_LD[p[2]] *
                 cal.B_LD[p[2]]^(cal.sigma_LD[p[2]] - 1) * LDC[p[2]])
    @constraint(m, EQ7[j in jK],
        KDC[j] == cal.B_KD[j] * sum(cal.beta_KD[(k, j)] * KD[(k, j)]^(-cal.rho_KD[j])
                                    for k in K if (k, j) in supKD)^(-1 / cal.rho_KD[j]))
    @constraint(m, EQ8[p in supKD],
        KD[p] == (cal.beta_KD[p] * RC[p[2]] / RTI[p])^cal.sigma_KD[p[2]] *
                 cal.B_KD[p[2]]^(cal.sigma_KD[p[2]] - 1) * KDC[p[2]])
    @constraint(m, EQ9[p in d2(I, J)], DI[p] == cal.aij[p] * CI[p[2]])

    ## 5.3.2.1 Famílias
    @constraint(m, EQ10[h in H], YH[h] == YHL[h] + YHK[h] + YHTR[h])
    @constraint(m, EQ11[h in H],
        YHL[h] == sum(cal.lambda_WL[(h, l)] * W[l] *
                      sum(LD[(l, j)] for j in J if (l, j) in supLD) for l in L))
    @constraint(m, EQ12[h in H],
        YHK[h] == sum(cal.lambda_RK[(h, k)] *
                      sum(R[(k, j)] * KD[(k, j)] for j in J if (k, j) in supKD) for k in K))
    @constraint(m, EQ13[h in H], YHTR[h] == sum(TR[(h, ag)] for ag in AG))
    @constraint(m, EQ14[h in H], YDH[h] == YH[h] - TDH[h] - TR[(:gvt, h)])
    @constraint(m, EQ15[h in H],
        CTH[h] == YDH[h] - SH[h] - sum(TR[(a, h)] for a in AGNG))
    @constraint(m, EQ16[h in H], SH[h] == PIXCON^cal.eta * sh0[h] + sh1[h] * YDH[h])

    ## 5.3.2.2 Empresas
    @constraint(m, EQ17[f in F], YF[f] == YFK[f] + YFTR[f])
    @constraint(m, EQ18[f in F],
        YFK[f] == sum(cal.lambda_RK[(f, k)] *
                      sum(R[(k, j)] * KD[(k, j)] for j in J if (k, j) in supKD) for k in K))
    @constraint(m, EQ19[f in F], YFTR[f] == sum(TR[(f, ag)] for ag in AG))
    @constraint(m, EQ20[f in F], YDF[f] == YF[f] - TDF[f])
    @constraint(m, EQ21[f in F], SF[f] == YDF[f] - sum(TR[(ag, f)] for ag in AG))

    ## 5.3.2.3 Governo
    @constraint(m, EQ22, YG == YGK + TDHT + TDFT + TPRODN + TPRCTS + YGTR)
    @constraint(m, EQ23,
        YGK == sum(cal.lambda_RK[(:gvt, k)] *
                   sum(R[(k, j)] * KD[(k, j)] for j in J if (k, j) in supKD) for k in K))
    @constraint(m, EQ24, TDHT == sum(TDH[h] for h in H))
    @constraint(m, EQ25, TDFT == sum(TDF[f] for f in F))
    @constraint(m, EQ26, TPRODN == TIWT + TIKT + TIPT)
    @constraint(m, EQ27, TIWT == sum(TIW[p] for p in supLD))
    @constraint(m, EQ28, TIKT == sum(TIK[p] for p in supKD))
    @constraint(m, EQ29, TIPT == sum(TIP[j] for j in J))
    @constraint(m, EQ30, TPRCTS == TICT + TIMT + TIXT)
    @constraint(m, EQ31, TICT == sum(TIC[i] for i in I))
    @constraint(m, EQ32, TIMT == sum(TIM[i] for i in iIM))
    @constraint(m, EQ33, TIXT == sum(TIX[i] for i in iEXD))
    @constraint(m, EQ34, YGTR == sum(TR[(:gvt, a)] for a in AGNG))
    @constraint(m, EQ35[h in H], TDH[h] == PIXCON^cal.eta * ttdh0[h] + ttdh1[h] * YH[h])
    @constraint(m, EQ36[f in F], TDF[f] == PIXCON^cal.eta * ttdf0[f] + ttdf1[f] * YFK[f])
    @constraint(m, EQ37[p in supLD], TIW[p] == ttiw[p] * W[p[1]] * LD[p])
    @constraint(m, EQ38[p in supKD], TIK[p] == ttik[p] * R[p] * KD[p])
    @constraint(m, EQ39[j in J], TIP[j] == ttip[j] * PP[j] * XST[j])
    for i in I  # EQ40 (termos condicionados a DDO/IMO)
        terms = Any[]
        cal.DDO[i] > 0 && push!(terms,
            (PL[i] + sum(PC[ij] * cal.tmrg[(ij, i)] for ij in I)) * DD[i])
        cal.IMO[i] > 0 && push!(terms,
            ((1 + ttim[i]) * e * PWM[i] + sum(PC[ij] * cal.tmrg[(ij, i)] for ij in I)) * IM[i])
        @constraint(m, TIC[i] == ttic[i] * sum(terms))
    end
    @constraint(m, EQ41[i in iIM], TIM[i] == ttim[i] * e * PWM[i] * IM[i])
    @constraint(m, EQ42[i in iEXD],
        TIX[i] == ttix[i] * (PE[i] + sum(PC[ij] * cal.tmrg_X[(ij, i)] for ij in I)) * EXD[i])
    @constraint(m, EQ43, SG == YG - sum(TR[(a, :gvt)] for a in AGNG) - G)

    ## 5.3.2.4 Resto do mundo
    @constraint(m, EQ44,
        YROW == e * sum(PWM[i] * IM[i] for i in iIM) +
                sum(cal.lambda_RK[(:row, k)] *
                    sum(R[(k, j)] * KD[(k, j)] for j in J if (k, j) in supKD) for k in K) +
                sum(TR[(:row, a)] for a in AGD))
    @constraint(m, EQ45,
        SROW == YROW - sum(PE_FOB[i] * EXD[i] for i in iEXD) -
                sum(TR[(a, :row)] for a in AGD))
    @constraint(m, EQ46, SROW == -CAB)

    ## 5.3.2.5 Transferências
    @constraint(m, EQ47[p in d2(AGNG, H)], TR[p] == cal.lambda_TR[p] * YDH[p[2]])
    @constraint(m, EQ48[h in H],
        TR[(:gvt, h)] == PIXCON^cal.eta * tr0[h] + tr1[h] * YH[h])
    @constraint(m, EQ49[p in d2(AG, F)], TR[p] == cal.lambda_TR[p] * YDF[p[2]])
    @constraint(m, EQ50[a in AGNG], TR[(a, :gvt)] == PIXCON^cal.eta * cal.TRO[(a, :gvt)])
    @constraint(m, EQ51[a in AGD], TR[(a, :row)] == PIXCON^cal.eta * cal.TRO[(a, :row)])

    ## 5.3.3 Demanda
    @constraint(m, EQ52[p in d2(I, H)],
        PC[p[1]] * C[p] == PC[p[1]] * CMIN[p] +
                           cal.gamma_LES[p] * (CTH[p[2]] -
                           sum(PC[ij] * CMIN[(ij, p[2])] for ij in I)))
    @constraint(m, EQ53, GFCF == IT - sum(PC[i] * VSTK[i] for i in I))
    @constraint(m, EQ54[i in I], PC[i] * INV[i] == cal.gamma_INV[i] * GFCF)
    @constraint(m, EQ55[i in I], PC[i] * CG[i] == cal.gamma_GVT[i] * G)
    @constraint(m, EQ56[i in I], DIT[i] == sum(DI[(i, j)] for j in J))
    @constraint(m, EQ57[i in I],
        MRGN[i] == sum(cal.tmrg[(i, ij)] * DD[ij] for ij in iDD) +
                   sum(cal.tmrg[(i, ij)] * IM[ij] for ij in iIM) +
                   sum(cal.tmrg_X[(i, ij)] * EXD[ij] for ij in iEXD))

    ## 5.3.4 Comércio internacional
    @constraint(m, EQ58[j in J],
        XST[j] == cal.B_XT[j] * sum(cal.beta_XT[(j, i)] * XS[(j, i)]^cal.rho_XT[j]
                                    for i in I if (j, i) in supXS)^(1 / cal.rho_XT[j]))
    @constraint(m, EQ59[p in supXS; cal.XSO[p] != cal.XSTO[p[1]]],
        XS[p] == XST[p[1]] / cal.B_XT[p[1]]^(1 + cal.sigma_XT[p[1]]) *
                 (P[p] / (cal.beta_XT[p] * PT[p[1]]))^cal.sigma_XT[p[1]])
    for p in supXS  # EQ60 (termos condicionados a EXO/DSO)
        terms = Any[]
        cal.EXO[p] > 0 && push!(terms, cal.beta_X[p] * EX[p]^cal.rho_X[p])
        cal.DSO[p] > 0 && push!(terms, (1 - cal.beta_X[p]) * DS[p]^cal.rho_X[p])
        @constraint(m, XS[p] == cal.B_X[p] * sum(terms)^(1 / cal.rho_X[p]))
    end
    @constraint(m, EQ61[p in supXS; cal.EXO[p] > 0 && cal.DSO[p] > 0],
        EX[p] == (((1 - cal.beta_X[p]) / cal.beta_X[p]) * (PE[p[2]] / PL[p[2]]))^cal.sigma_X[p] * DS[p])
    @constraint(m, EQ62[i in iEXD],
        EXD[i] == cal.EXDO[i] * (e * PWX[i] / PE_FOB[i])^cal.sigma_XD[i])
    for i in I  # EQ63 (termos condicionados a IMO/DDO)
        terms = Any[]
        cal.IMO[i] > 0 && push!(terms, cal.beta_M[i] * IM[i]^(-cal.rho_M[i]))
        cal.DDO[i] > 0 && push!(terms, (1 - cal.beta_M[i]) * DD[i]^(-cal.rho_M[i]))
        @constraint(m, Q[i] == cal.B_M[i] * sum(terms)^(-1 / cal.rho_M[i]))
    end
    @constraint(m, EQ64[i in I; cal.IMO[i] > 0 && cal.DDO[i] > 0],
        IM[i] == ((cal.beta_M[i] / (1 - cal.beta_M[i])) * (PD[i] / PM[i]))^cal.sigma_M[i] * DD[i])

    ## 5.3.5 Preços
    @constraint(m, EQ65[j in J], PP[j] * XST[j] == PVA[j] * VA[j] + PCI[j] * CI[j])
    @constraint(m, EQ66[j in J], PT[j] == (1 + ttip[j]) * PP[j])
    @constraint(m, EQ67[j in J], PCI[j] * CI[j] == sum(PC[i] * DI[(i, j)] for i in I))
    for j in J  # EQ68 (termos condicionados a LDCO/KDCO)
        terms = Any[]
        cal.LDCO[j] > 0 && push!(terms, WC[j] * LDC[j])
        cal.KDCO[j] > 0 && push!(terms, RC[j] * KDC[j])
        @constraint(m, PVA[j] * VA[j] == sum(terms))
    end
    @constraint(m, EQ70[p in d2(L, J)], WTI[p] == W[p[1]] * (1 + ttiw[p]))
    @constraint(m, EQ72[p in supKD], RTI[p] == R[p] * (1 + ttik[p]))
    if kmob
        @constraint(m, EQ73[p in supKD], R[p] == RK[p[1]])
    end
    @constraint(m, EQ74[p in supXS; cal.XSO[p] == cal.XSTO[p[1]]], P[p] == PT[p[1]])
    for p in supXS  # EQ75 (termos condicionados a EXO/DSO)
        terms = Any[]
        cal.EXO[p] > 0 && push!(terms, PE[p[2]] * EX[p])
        cal.DSO[p] > 0 && push!(terms, PL[p[2]] * DS[p])
        @constraint(m, P[p] * XS[p] == sum(terms))
    end
    @constraint(m, EQ76[i in iEXD],
        PE_FOB[i] == (1 + ttix[i]) * (PE[i] + sum(PC[ij] * cal.tmrg_X[(ij, i)] for ij in I)))
    @constraint(m, EQ77[i in iDD],
        PD[i] == (1 + ttic[i]) * (PL[i] + sum(PC[ij] * cal.tmrg[(ij, i)] for ij in I)))
    @constraint(m, EQ78[i in iIM],
        PM[i] == (1 + ttic[i]) * ((1 + ttim[i]) * e * PWM[i] +
                                  sum(PC[ij] * cal.tmrg[(ij, i)] for ij in I)))
    for i in I  # EQ79 (termos condicionados a IMO/DDO)
        terms = Any[]
        cal.IMO[i] > 0 && push!(terms, PM[i] * IM[i])
        cal.DDO[i] > 0 && push!(terms, PD[i] * DD[i])
        @constraint(m, PC[i] * Q[i] == sum(terms))
    end
    @constraint(m, EQ80,
        PIXGDP == sqrt(
            sum((PVA[j] * VA[j] + TIP[j]) / VA[j] * cal.VAO[j] for j in J) /
            sum((cal.PVAO[j] * cal.VAO[j] + cal.TIPO[j]) / cal.VAO[j] * cal.VAO[j] for j in J) *
            sum(PVA[j] * VA[j] + TIP[j] for j in J) /
            sum((cal.PVAO[j] * cal.VAO[j] + cal.TIPO[j]) / cal.VAO[j] * VA[j] for j in J)))
    @constraint(m, EQ81,
        PIXCON == sum(PC[i] * sum(cal.CO[(i, h)] for h in H) for i in I) /
                  sum(cal.PCO[i] * sum(cal.CO[(i, h)] for h in H) for i in I))
    @constraint(m, EQ82,
        PIXINV == prod((PC[i] / cal.PCO[i])^cal.gamma_INV[i]
                       for i in I if cal.gamma_INV[i] > 0))
    @constraint(m, EQ83,
        PIXGVT == prod((PC[i] / cal.PCO[i])^cal.gamma_GVT[i]
                       for i in I if cal.gamma_GVT[i] > 0))

    ## 5.3.6 Equilíbrio
    @constraint(m, EQ84[i in I1],
        Q[i] == sum(C[(i, h)] for h in H) + CG[i] + INV[i] + VSTK[i] + DIT[i] + MRGN[i])
    @constraint(m, EQ85[l in L], LS[l] == sum(LD[(l, j)] for j in J if (l, j) in supLD))
    @constraint(m, EQ86[k in K], KS[k] == sum(KD[(k, j)] for j in J if (k, j) in supKD))
    @constraint(m, EQ87, IT == sum(SH[h] for h in H) + sum(SF[f] for f in F) + SG + SROW)
    @constraint(m, EQ88[i in iDD], sum(DS[(j, i)] for j in J if (j, i) in supDS) == DD[i])
    @constraint(m, EQ89[i in iEXD], sum(EX[(j, i)] for j in J if (j, i) in supEX) == EXD[i])

    ## 5.3.7 Produto interno bruto
    @constraint(m, EQ90, GDP_BP == sum(PVA[j] * VA[j] for j in J) + TIPT)
    @constraint(m, EQ91, GDP_MP == GDP_BP + TPRCTS)
    @constraint(m, EQ92,
        GDP_IB == sum(W[p[1]] * LD[p] for p in supLD) +
                  sum(R[p] * KD[p] for p in supKD) + TPRODN + TPRCTS)
    @constraint(m, EQ93,
        GDP_FD == sum(PC[i] * (sum(C[(i, h)] for h in H) + CG[i] + INV[i] + VSTK[i]) for i in I) +
                  sum(PE_FOB[i] * EXD[i] for i in iEXD) -
                  sum(PWM[i] * e * IM[i] for i in iIM))

    ## 5.3.8 Variáveis reais
    @constraint(m, EQ94[h in H], CTH_REAL[h] == CTH[h] / PIXCON)
    @constraint(m, EQ95, G_REAL == G / PIXGVT)
    @constraint(m, EQ96, GDP_BP_REAL == GDP_BP / PIXGDP)
    @constraint(m, EQ97, GDP_MP_REAL == GDP_MP / PIXCON)
    @constraint(m, EQ98, GFCF_REAL == GFCF / PIXINV)

    ## 5.3.9 Lei de Walras (folga do mercado de agr, excluído da EQ84)
    @constraint(m, WALRAS,
        LEON == Q[:agr] - sum(C[(:agr, h)] for h in H) - CG[:agr] - INV[:agr] -
                VSTK[:agr] - DIT[:agr] - MRGN[:agr])

    @objective(m, Min, 0)

    ## 6.2 Capital móvel ou específico por setor
    if kmob
        for k in K
            fix(KS[k], cal.KSO[k]; force = true)
        end
    else
        for p in supKD
            fix(KD[p], cal.KDO[p]; force = true)
        end
    end

    ## 6.3 Fechamento padrão (numerário: câmbio nominal)
    fix(e, 1.0; force = true)
    fix(CAB, cal.CABO)
    for p in d2(I, H)
        fix(CMIN[p], cal.CMINO[p])
    end
    fix(G, cal.GO)
    for l in L
        fix(LS[l], cal.LSO[l]; force = true)
    end
    for i in iIM
        fix(PWM[i], cal.PWMO[i]; force = true)
    end
    for i in iEXD
        fix(PWX[i], cal.PWXO[i]; force = true)
    end
    for i in I
        fix(VSTK[i], cal.VSTKO[i])
        fix(ttic[i], cal.tticO[i])
    end
    for h in H
        fix(sh0[h], cal.sh0O[h])
        fix(sh1[h], cal.sh1O[h])
        fix(tr0[h], cal.tr0O[h])
        fix(tr1[h], cal.tr1O[h])
        fix(ttdh0[h], cal.ttdh0O[h])
        fix(ttdh1[h], cal.ttdh1O[h])
    end
    for f in F
        fix(ttdf0[f], cal.ttdf0O[f])
        fix(ttdf1[f], cal.ttdf1O[f])
    end
    for p in supKD
        fix(ttik[p], cal.ttikO[p])
    end
    for i in iIM
        fix(ttim[i], cal.ttimO[i])
    end
    for j in J
        fix(ttip[j], cal.ttipO[j])
    end
    for p in d2(L, J)
        fix(ttiw[p], cal.ttiwO[p])
    end
    for i in iEXD
        fix(ttix[i], cal.ttixO[i])
    end

    m.ext[:cal] = cal
    m.ext[:sup] = (; supXS, supEX, supDS, supLD, supKD, iDD, iIM, iEXD, jL, jK, supTR)
    m.ext[:kmob] = kmob
    return m
end

"""
    solve!(m; quiet=true) -> JuMP.Model

Resolve o sistema (factibilidade quadrada, como o CNS do GAMS) e verifica a
convergência. Lança erro se o solver não encontrar solução.
"""
function solve!(m::Model; quiet::Bool = true)
    quiet ? set_silent(m) : unset_silent(m)
    optimize!(m)
    st = termination_status(m)
    st in (MOI.OPTIMAL, MOI.LOCALLY_SOLVED) ||
        error("solver terminou com status $st")
    return m
end

"Verifica se a variável `name` existe no modelo com o índice dado."
function hasindex(m::Model, name::Symbol, idx::Symbol...)
    haskey(object_dictionary(m), name) || return false
    var = m[name]
    var isa VariableRef && return isempty(idx)
    isempty(idx) && return false
    key = length(idx) == 1 ? idx[1] : Tuple(idx)
    return key in axes(var)[1]
end

"Valor resolvido da variável `name` com índices simbólicos."
function value_of(m::Model, name::Symbol, idx::Symbol...)
    var = m[name]
    var isa VariableRef && return value(var)
    key = length(idx) == 1 ? idx[1] : Tuple(idx)
    return value(var[key])
end
