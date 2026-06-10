# Calibração — transliteração sequencial das seções 3 e 4 do GAMS.
# A ordem das atribuições segue exatamente o original: vários parâmetros são
# normalizados in-place (ex.: tmrg, DDO, IMO), e fórmulas posteriores dependem
# do estado intermediário correto.

"""
    calibrate(sam, par) -> NamedTuple

Calibra todos os parâmetros e valores de benchmark (sufixo `O`) do PEP-1-1 a
partir da SAM (`read_sam`) e dos parâmetros exógenos (`read_val_par`).
"""
function calibrate(sam::Dict{NTuple{4,Symbol},Float64}, par)
    S(a, b, c, d) = get(sam, (a, b, c, d), 0.0)

    # 3.1 Dados da SAM (valores nominais; volumes recalculados na seção 4.4)
    CO    = Dict((i, h) => S(:i, i, :ag, h) for i in I, h in H)
    CGO   = Dict(i => S(:i, i, :ag, :gvt) for i in I)
    DSO   = Dict((j, i) => S(:j, j, :i, i) for j in J, i in I)
    DDO   = Dict(i => sum(DSO[(j, i)] for j in J) for i in I)
    DIO   = Dict((i, j) => S(:i, i, :j, j) for i in I, j in J)
    EXO   = Dict((j, i) => S(:j, j, :x, i) for j in J, i in I)
    EXDO  = Dict(i => S(:x, i, :ag, :row) for i in I)
    INVO  = Dict(i => S(:i, i, :oth, :inv) for i in I)
    VSTKO = Dict(i => S(:i, i, :oth, :vstk) for i in I)
    IMO   = Dict(i => S(:ag, :row, :i, i) for i in I)
    KDO   = Dict((k, j) => S(:k, k, :j, j) for k in K, j in J)
    LDO   = Dict((l, j) => S(:l, l, :j, j) for l in L, j in J)
    SFO   = Dict(f => S(:oth, :inv, :ag, f) for f in F)
    SGO   = S(:oth, :inv, :ag, :gvt)
    SHO   = Dict(h => S(:oth, :inv, :ag, h) for h in H)
    SROWO = S(:oth, :inv, :ag, :row)
    TDFO  = Dict(f => S(:ag, :td, :ag, f) for f in F)
    TDHO  = Dict(h => S(:ag, :td, :ag, h) for h in H)
    TICO  = Dict(i => S(:ag, :ti, :i, i) for i in I)
    TIKO  = Dict((k, j) => S(:ag, k, :j, j) for k in K, j in J)
    TIMO  = Dict(i => S(:ag, :tm, :i, i) for i in I)
    TIPO  = Dict(j => S(:ag, :gvt, :j, j) for j in J)
    TIXO  = Dict(i => S(:ag, :gvt, :x, i) for i in I)
    TIWO  = Dict((l, j) => S(:ag, l, :j, j) for l in L, j in J)
    TRO   = Dict((a, b) => S(:ag, a, :ag, b) for a in AG, b in AG)
    lambda_RK = Dict((a, k) => S(:ag, a, :k, k) for a in AG, k in K)
    lambda_WL = Dict((h, l) => S(:ag, h, :l, l) for h in H, l in L)
    tmrg   = Dict((i, ij) => S(:i, i, :i, ij) for i in I, ij in I)
    tmrg_X = Dict((i, ij) => S(:i, i, :x, ij) for i in I, ij in I)

    # 3.2 Demais dados (elasticidades e parâmetros LES exógenos)
    sigma_KD = par.sigma_KD
    sigma_LD = par.sigma_LD
    sigma_M  = par.sigma_M
    sigma_VA = par.sigma_VA
    sigma_X  = par.sigma_X
    sigma_XT = par.sigma_XT
    sigma_XD = par.sigma_XD
    frisch   = par.frisch
    sigma_Y  = Dict((i, h) => par.sigma_Y[(i, h)] for i in I, h in H)
    sh0O   = Dict(h => par.sh0O[h] for h in H)
    tr0O   = Dict(h => par.tr0O[h] for h in H)
    ttdf0O = Dict(f => par.ttdf0O[f] for f in F)
    ttdh0O = Dict(h => par.ttdh0O[h] for h in H)

    eta = 1.0

    PLO  = Dict(i => 1.0 for i in I)
    PEO  = Dict(i => 1.0 for i in I)
    eO   = 1.0
    PWMO = Dict(i => 1.0 for i in I)
    WO   = Dict(l => 1.0 for l in L)
    RKO  = Dict(k => 1.0 for k in K)
    RO   = Dict((k, j) => RKO[k] for k in K, j in J)

    # 4.1 Renda e poupança
    YHKO  = Dict(h => sum(lambda_RK[(h, k)] for k in K) for h in H)
    YHLO  = Dict(h => sum(lambda_WL[(h, l)] for l in L) for h in H)
    YHTRO = Dict(h => sum(TRO[(h, a)] for a in AG) for h in H)
    YHO   = Dict(h => YHLO[h] + YHKO[h] + YHTRO[h] for h in H)
    YDHO  = Dict(h => YHO[h] - TDHO[h] - TRO[(:gvt, h)] for h in H)
    CTHO  = Dict(h => YDHO[h] - SHO[h] - sum(TRO[(a, h)] for a in AGNG) for h in H)

    YFKO  = Dict(f => sum(lambda_RK[(f, k)] for k in K) for f in F)
    YFTRO = Dict(f => sum(TRO[(f, a)] for a in AG) for f in F)
    YFO   = Dict(f => YFKO[f] + YFTRO[f] for f in F)
    YDFO  = Dict(f => YFO[f] - TDFO[f] for f in F)

    YGKO  = sum(lambda_RK[(:gvt, k)] for k in K)
    TDHTO = sum(TDHO[h] for h in H)
    TDFTO = sum(TDFO[f] for f in F)
    TICTO = sum(TICO[i] for i in I)
    TIMTO = sum(TIMO[i] for i in I)
    TIXTO = sum(TIXO[i] for i in I)
    TIWTO = sum(TIWO[(l, j)] for l in L, j in J)
    TIKTO = sum(TIKO[(k, j)] for k in K, j in J)
    TIPTO = sum(TIPO[j] for j in J)
    TPRODNO = TIKTO + TIWTO + TIPTO
    TPRCTSO = TICTO + TIMTO + TIXTO
    YGTRO = sum(TRO[(:gvt, a)] for a in AG)
    YGO   = YGKO + TDHTO + TDFTO + TPRODNO + TPRCTSO + YGTRO

    YROWO = sum(IMO[i] for i in I) + sum(lambda_RK[(:row, k)] for k in K) +
            sum(TRO[(:row, a)] for a in AG)
    CABO  = -SROWO

    ITO = sum(SHO[h] for h in H) + sum(SFO[f] for f in F) + SGO + SROWO

    for a in AG, k in K
        lambda_RK[(a, k)] /= sum(KDO[(k, j)] for j in J)
    end
    for h in H, l in L
        lambda_WL[(h, l)] /= sum(LDO[(l, j)] for j in J)
    end
    lambda_TR = Dict{NTuple{2,Symbol},Float64}()
    for a in AGNG, h in H
        lambda_TR[(a, h)] = TRO[(a, h)] / YDHO[h]
    end
    for a in AG, f in F
        lambda_TR[(a, f)] = TRO[(a, f)] / YDFO[f]
    end

    sh1O = Dict(h => (SHO[h] - sh0O[h]) / YDHO[h] for h in H)
    tr1O = Dict(h => (TRO[(:gvt, h)] - tr0O[h]) / YHO[h] for h in H)

    # 4.2 Participações do investimento e do gasto público
    gamma_GVT = Dict(i => CGO[i] / sum(CGO[ij] for ij in I) for i in I)
    gamma_INV = Dict(i => INVO[i] / sum(INVO[ij] for ij in I) for i in I)

    # 4.3 Alíquotas de impostos diretos
    ttdf1O = Dict(f => (TDFO[f] - ttdf0O[f]) / YFKO[f] for f in F)
    ttdh1O = Dict(h => (TDHO[h] - ttdh0O[h]) / YHO[h] for h in H)

    # 4.4 Demais alíquotas, preços, margens e volumes
    PCO = Dict(i => (DDO[i] + IMO[i] + sum(tmrg[(ij, i)] for ij in I) +
                     TICO[i] + TIMO[i]) / (DDO[i] + IMO[i]) for i in I)
    for i in I, ij in I
        tmrg[(i, ij)] /= PCO[i]
        tmrg_X[(i, ij)] /= PCO[i]
    end

    for i in I
        DDO[i] /= PLO[i]
        IMO[i] /= (PWMO[i] * eO)
    end

    for i in I, ij in I
        tmrg[(i, ij)] /= (DDO[ij] + IMO[ij])
    end

    tticO = Dict(i => TICO[i] /
                      ((PLO[i] + sum(PCO[ij] * tmrg[(ij, i)] for ij in I)) * DDO[i] +
                       (eO * PWMO[i] + sum(PCO[ij] * tmrg[(ij, i)] for ij in I)) * IMO[i] +
                       TIMO[i]) for i in I)

    PDO = Dict(i => (PLO[i] + sum(PCO[ij] * tmrg[(ij, i)] for ij in I)) *
                    (1 + tticO[i]) for i in I)

    ttimO = Dict(i => IMO[i] > 0 ? TIMO[i] / (eO * PWMO[i] * IMO[i]) : 0.0 for i in I)

    PMO = Dict(i => ((1 + ttimO[i]) * eO * PWMO[i] +
                     sum(PCO[ij] * tmrg[(ij, i)] for ij in I)) * (1 + tticO[i]) for i in I)

    for j in J, i in I
        EXO[(j, i)] /= PEO[i]
    end
    for ij in I, i in I
        if EXDO[i] > 0
            tmrg_X[(ij, i)] /= sum(EXO[(j, i)] for j in J)
        end
    end
    ttixO = Dict(i => EXDO[i] > 0 ? TIXO[i] / (EXDO[i] - TIXO[i]) : 0.0 for i in I)
    PE_FOBO = Dict(i => (1 + ttixO[i]) *
                        (PEO[i] + sum(PCO[ij] * tmrg_X[(ij, i)] for ij in I)) for i in I)
    PWXO = Dict(i => PE_FOBO[i] / eO for i in I)
    for i in I
        EXDO[i] /= (PWXO[i] * eO)
    end

    for j in J, i in I
        DSO[(j, i)] /= PLO[i]
    end
    XSO = Dict((j, i) => DSO[(j, i)] + EXO[(j, i)] for j in J, i in I)
    PO  = Dict((j, i) => XSO[(j, i)] > 0 ?
                         (PLO[i] * DSO[(j, i)] + PEO[i] * EXO[(j, i)]) / XSO[(j, i)] : 0.0
               for j in J, i in I)
    XSTO = Dict(j => sum(XSO[(j, i)] for i in I) for j in J)
    PTO  = Dict(j => sum(PO[(j, i)] * XSO[(j, i)] for i in I if XSO[(j, i)] > 0) / XSTO[j]
                for j in J)

    QO = Dict(i => (PMO[i] * IMO[i] + PDO[i] * DDO[i]) / PCO[i] for i in I)

    MRGNO = Dict(i => sum(tmrg[(i, ij)] * DDO[ij] for ij in I) +
                      sum(tmrg[(i, ij)] * IMO[ij] for ij in I) +
                      sum(tmrg_X[(i, ij)] * EXO[(j, ij)] for j in J, ij in I) for i in I)

    for i in I, h in H
        CO[(i, h)] /= PCO[i]
    end
    for i in I
        CGO[i]   /= PCO[i]
        INVO[i]  /= PCO[i]
        VSTKO[i] /= PCO[i]
    end
    for i in I, j in J
        DIO[(i, j)] /= PCO[i]
    end
    GFCFO = ITO - sum(PCO[i] * VSTKO[i] for i in I)

    CIO  = Dict(j => sum(DIO[(i, j)] for i in I) for j in J)
    DITO = Dict(i => sum(DIO[(i, j)] for j in J) for i in I)
    GO   = sum(PCO[i] * CGO[i] for i in I)

    PCIO = Dict(j => sum(PCO[i] * DIO[(i, j)] for i in I) / CIO[j] for j in J)

    ttiwO = Dict((l, j) => LDO[(l, j)] > 0 ? TIWO[(l, j)] / LDO[(l, j)] : 0.0
                 for l in L, j in J)
    WTIO  = Dict((l, j) => WO[l] * (1 + ttiwO[(l, j)]) for l in L, j in J)
    ttikO = Dict((k, j) => KDO[(k, j)] > 0 ? TIKO[(k, j)] / KDO[(k, j)] : 0.0
                 for k in K, j in J)
    RTIO  = Dict((k, j) => RO[(k, j)] * (1 + ttikO[(k, j)]) for k in K, j in J)

    for l in L, j in J
        LDO[(l, j)] /= WO[l]
    end
    LDCO = Dict(j => sum(LDO[(l, j)] for l in L) for j in J)
    LSO  = Dict(l => sum(LDO[(l, j)] for j in J) for l in L)
    WCO  = Dict(j => LDCO[j] > 0 ?
                     sum(WTIO[(l, j)] * LDO[(l, j)] for l in L) / LDCO[j] : 0.0 for j in J)

    for k in K, j in J
        KDO[(k, j)] /= RO[(k, j)]
    end
    KDCO = Dict(j => sum(KDO[(k, j)] for k in K) for j in J)
    KSO  = Dict(k => sum(KDO[(k, j)] for j in J) for k in K)
    RCO  = Dict(j => KDCO[j] > 0 ?
                     sum(RTIO[(k, j)] * KDO[(k, j)] for k in K) / KDCO[j] : 0.0 for j in J)

    VAO  = Dict(j => LDCO[j] + KDCO[j] for j in J)
    PVAO = Dict(j => (WCO[j] * LDCO[j] + RCO[j] * KDCO[j]) / VAO[j] for j in J)

    ttipO = Dict(j => TIPO[j] / (PVAO[j] * VAO[j] +
                                 sum(PCO[i] * DIO[(i, j)] for i in I)) for j in J)

    PPO = Dict(j => PTO[j] / (1 + ttipO[j]) for j in J)

    # Índices de preço do benchmark são tautologicamente 1 (GAMS, seção 4.4)
    PIXGDPO = 1.0
    PIXCONO = 1.0
    PIXGVTO = 1.0
    PIXINVO = 1.0

    # 4.5 Indexação de transferências e interceptos (com PIXCONO = 1, é inócuo,
    # mas mantido por fidelidade ao original)
    for a in AGD
        TRO[(a, :row)] /= PIXCONO^eta
    end
    for a in AGNG
        TRO[(a, :gvt)] /= PIXCONO^eta
    end
    for f in F
        ttdf0O[f] /= PIXCONO^eta
    end
    for h in H
        ttdh0O[h] /= PIXCONO^eta
        sh0O[h]   /= PIXCONO^eta
        tr0O[h]   /= PIXCONO^eta
    end

    # 4.6.1 Funções Leontief
    io  = Dict(j => CIO[j] / XSTO[j] for j in J)
    v   = Dict(j => VAO[j] / XSTO[j] for j in J)
    aij = Dict((i, j) => DIO[(i, j)] / CIO[j] for i in I, j in J)

    # 4.6.2.1 CET entre produtos
    rho_XT  = Dict(j => (1 + sigma_XT[j]) / sigma_XT[j] for j in J)
    beta_XT = Dict((j, i) => XSO[(j, i)] > 0 ?
                             PO[(j, i)] * XSO[(j, i)]^(1 - rho_XT[j]) /
                             sum(PO[(j, ij)] * XSO[(j, ij)]^(1 - rho_XT[j])
                                 for ij in I if XSO[(j, ij)] > 0) : 0.0
                   for j in J, i in I)
    B_XT = Dict(j => XSTO[j] /
                     sum(beta_XT[(j, i)] * XSO[(j, i)]^rho_XT[j]
                         for i in I if XSO[(j, i)] > 0)^(1 / rho_XT[j]) for j in J)

    # 4.6.2.2 CET entre exportações e vendas locais
    # (0^0 = 1 em Julia, mesma convenção do GAMS nas células de fluxo zero)
    rho_X = Dict((j, i) => (EXO[(j, i)] > 0 && DSO[(j, i)] > 0) ?
                           (1 + sigma_X[(j, i)]) / sigma_X[(j, i)] : 1.0
                 for j in J, i in I)
    beta_X = Dict((j, i) => XSO[(j, i)] > 0 ?
                            PEO[i] * EXO[(j, i)]^(1 - rho_X[(j, i)]) /
                            (PEO[i] * EXO[(j, i)]^(1 - rho_X[(j, i)]) +
                             PLO[i] * DSO[(j, i)]^(1 - rho_X[(j, i)])) : 0.0
                  for j in J, i in I)
    B_X = Dict((j, i) => XSO[(j, i)] > 0 ?
                         XSO[(j, i)] /
                         (beta_X[(j, i)] * EXO[(j, i)]^rho_X[(j, i)] +
                          (1 - beta_X[(j, i)]) * DSO[(j, i)]^rho_X[(j, i)])^(1 / rho_X[(j, i)]) : 0.0
               for j in J, i in I)

    # 4.6.3.1 CES bem composto
    rho_M = Dict(i => (IMO[i] > 0 && DDO[i] > 0) ?
                      (1 - sigma_M[i]) / sigma_M[i] : -1.0 for i in I)
    beta_M = Dict(i => QO[i] > 0 ?
                       PMO[i] * IMO[i]^(rho_M[i] + 1) /
                       (PMO[i] * IMO[i]^(rho_M[i] + 1) + PDO[i] * DDO[i]^(rho_M[i] + 1)) : 0.0
                  for i in I)
    B_M = Dict(i => QO[i] > 0 ?
                    QO[i] / (beta_M[i] * IMO[i]^(-rho_M[i]) +
                             (1 - beta_M[i]) * DDO[i]^(-rho_M[i]))^(-1 / rho_M[i]) : 0.0
               for i in I)

    # 4.6.3.2 CES capital composto
    rho_KD = Dict(j => KDCO[j] > 0 ? (1 - sigma_KD[j]) / sigma_KD[j] : 0.0 for j in J)
    beta_KD = Dict((k, j) => KDO[(k, j)] > 0 ?
                             RTIO[(k, j)] * KDO[(k, j)]^(rho_KD[j] + 1) /
                             sum(RTIO[(kj, j)] * KDO[(kj, j)]^(rho_KD[j] + 1) for kj in K) : 0.0
                   for k in K, j in J)
    B_KD = Dict(j => KDCO[j] > 0 ?
                     KDCO[j] / sum(beta_KD[(k, j)] * KDO[(k, j)]^(-rho_KD[j])
                                   for k in K if KDO[(k, j)] > 0)^(-1 / rho_KD[j]) : 0.0
                for j in J)

    # 4.6.3.3 CES trabalho composto
    rho_LD = Dict(j => (1 - sigma_LD[j]) / sigma_LD[j] for j in J)
    beta_LD = Dict((l, j) => LDO[(l, j)] > 0 ?
                             WTIO[(l, j)] * LDO[(l, j)]^(rho_LD[j] + 1) /
                             sum(WTIO[(lj, j)] * LDO[(lj, j)]^(rho_LD[j] + 1) for lj in L) : 0.0
                   for l in L, j in J)
    B_LD = Dict(j => LDCO[j] > 0 ?
                     LDCO[j] / sum(beta_LD[(l, j)] * LDO[(l, j)]^(-rho_LD[j])
                                   for l in L if LDO[(l, j)] > 0)^(-1 / rho_LD[j]) : 0.0
                for j in J)

    # 4.6.3.4 CES valor adicionado
    rho_VA = Dict(j => (KDCO[j] > 0 && LDCO[j] > 0) ?
                       (1 - sigma_VA[j]) / sigma_VA[j] : -1.0 for j in J)
    beta_VA = Dict(j => WCO[j] * LDCO[j]^(rho_VA[j] + 1) /
                        (WCO[j] * LDCO[j]^(rho_VA[j] + 1) +
                         RCO[j] * KDCO[j]^(rho_VA[j] + 1)) for j in J)
    B_VA = Dict(j => VAO[j] /
                     (beta_VA[j] * LDCO[j]^(-rho_VA[j]) +
                      (1 - beta_VA[j]) * KDCO[j]^(-rho_VA[j]))^(-1 / rho_VA[j]) for j in J)

    # 4.6.4 Parâmetros LES (elasticidades-renda reescalonadas para somar 1)
    sigma_Y = Dict((i, h) => sigma_Y[(i, h)] * CTHO[h] /
                             sum(sigma_Y[(ij, h)] * PCO[ij] * CO[(ij, h)] for ij in I)
                   for i in I, h in H)
    gamma_LES = Dict((i, h) => PCO[i] * CO[(i, h)] * sigma_Y[(i, h)] / CTHO[h]
                     for i in I, h in H)
    CMINO = Dict((i, h) => CO[(i, h)] + gamma_LES[(i, h)] *
                           (CTHO[h] / (PCO[i] * frisch[h])) for i in I, h in H)

    # 4.7 Produto interno bruto
    GDP_BPO = sum(PVAO[j] * VAO[j] for j in J) + TIPTO
    GDP_MPO = GDP_BPO + TPRCTSO
    GDP_IBO = sum(WO[l] * LDO[(l, j)] for l in L, j in J) +
              sum(RO[(k, j)] * KDO[(k, j)] for k in K, j in J) + TPRODNO + TPRCTSO
    GDP_FDO = sum(PCO[i] * (sum(CO[(i, h)] for h in H) + CGO[i] + INVO[i] + VSTKO[i])
                  for i in I) +
              sum(PE_FOBO[i] * EXDO[i] for i in I) -
              sum(PWMO[i] * eO * IMO[i] for i in I)

    # 4.8 Variáveis reais
    CTH_REALO = Dict(h => CTHO[h] / PIXCONO for h in H)
    G_REALO = GO / PIXGVTO
    GDP_BP_REALO = GDP_BPO / PIXGDPO
    GDP_MP_REALO = GDP_MPO / PIXCONO
    GFCF_REALO = GFCFO / PIXINVO

    return (;
        # parâmetros
        aij, B_KD, B_LD, B_M, B_VA, B_X, B_XT,
        beta_KD, beta_LD, beta_M, beta_VA, beta_X, beta_XT,
        eta, frisch, gamma_GVT, gamma_INV, gamma_LES, io,
        lambda_RK, lambda_TR, lambda_WL,
        rho_KD, rho_LD, rho_M, rho_VA, rho_X, rho_XT,
        sigma_KD, sigma_LD, sigma_M, sigma_VA, sigma_X, sigma_XT, sigma_XD, sigma_Y,
        tmrg, tmrg_X, v,
        # benchmark — volumes
        CO, CGO, CIO, CMINO, CTH_REALO, DDO, DIO, DITO, DSO, EXO, EXDO,
        G_REALO, GDP_BP_REALO, GDP_MP_REALO, GFCF_REALO, IMO, INVO,
        KDO, KDCO, KSO, LDO, LDCO, LSO, MRGNO, QO, VAO, VSTKO, XSO, XSTO,
        # benchmark — preços
        eO, PO, PCO, PCIO, PDO, PEO, PE_FOBO, PIXCONO, PIXGDPO, PIXGVTO, PIXINVO,
        PLO, PMO, PPO, PTO, PVAO, PWMO, PWXO, RO, RCO, RKO, RTIO, WO, WCO, WTIO,
        # benchmark — valores nominais
        CABO, CTHO, GO, GDP_BPO, GDP_FDO, GDP_IBO, GDP_MPO, GFCFO, ITO,
        SFO, SGO, SHO, SROWO, TDFO, TDFTO, TDHO, TDHTO, TICO, TICTO,
        TIKO, TIKTO, TIMO, TIMTO, TIPO, TIPTO, TIWO, TIWTO, TIXO, TIXTO,
        TPRCTSO, TPRODNO, TRO, YDFO, YDHO, YFO, YFKO, YFTRO,
        YGO, YGKO, YGTRO, YHO, YHKO, YHLO, YHTRO, YROWO,
        # benchmark — alíquotas e interceptos
        sh0O, sh1O, tr0O, tr1O, ttdf0O, ttdf1O, ttdh0O, ttdh1O,
        tticO, ttikO, ttimO, ttipO, ttiwO, ttixO,
    )
end
