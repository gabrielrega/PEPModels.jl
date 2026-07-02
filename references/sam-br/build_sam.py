# Constrói a SAM brasileira (ano-base 2015) para o PEP-1-1 a partir da MIP
# nível 12, da TRU nível 12 e da CEI 2015 do IBGE (ver README.md).
#
# Agregação: AGR = 01 | IND = 02–05 | SER = 06–11 | ADM = 12.
# Fatores: 1 trabalho (LAB = remunerações), 1 capital (CAP = EOB + rend. misto).
# Agentes: 1 família (S.14+S.15), FIRM (S.11+S.12), GVT (S.13), ROW.
#
# Convenções (mesmas células que a calibração do PEP11 lê, ver
# src/pep11/calibration.jl):
#   linha I  ← usos a preço de consumidor (tab 02 da MIP) + margens recebidas
#   coluna I → make doméstica (J), importações (ROW), TI, TM, margens pagas
#   contas X → vendas das indústrias a preço básico + margens + imp. exportação
#   D.4/D.7/D.9 bilaterais por alocação proporcional (CEI só tem totais);
#   D.73 (transferências intragoverno) eliminado por consolidação.
#
# Uso: uv run --with pandas --with xlrd --with openpyxl build_sam.py

from pathlib import Path

import pandas as pd

HERE = Path(__file__).parent
OUT = HERE / ".." / ".." / "data" / "pep-1-1-br"

GROUPS = {"agr": ["01"], "ind": ["02", "03", "04", "05"],
          "ser": ["06", "07", "08", "09", "10", "11"], "adm": ["12"]}
SECTORS = list(GROUPS)
CODE2GRP = {c: g for g, codes in GROUPS.items() for c in codes}

TOL = 5.0  # R$ milhões — folga p/ arredondamento das tabelas IBGE


def check(label, a, b, tol=TOL):
    diff = abs(a - b)
    flag = "ok" if diff <= tol else "** FALHOU **"
    print(f"  [{flag}] {label}: {a:,.0f} vs {b:,.0f} (dif {a - b:+,.1f})")
    assert diff <= tol, f"{label}: {a} != {b}"


def read_sheet(path, sheet):
    return pd.read_excel(HERE / path, sheet_name=sheet, header=None)


def product_rows(df):
    "Linhas de produto (código '01'..'12' na primeira coluna)."
    mask = df[0].astype(str).str.strip().isin(CODE2GRP)
    sub = df[mask].copy()
    sub["grp"] = sub[0].astype(str).str.strip().map(CODE2GRP)
    return sub


def by_group(df, col):
    "Soma a coluna `col` das linhas de produto, por grupo de 4 setores."
    sub = product_rows(df)
    s = sub.groupby("grp")[col].sum()
    return {g: float(s.get(g, 0.0)) for g in SECTORS}


# ---------------------------------------------------------------------------
# 1. MIP nível 12 — blocos produto × usuário
# ---------------------------------------------------------------------------
mip = "mip-ibge-2015/Matriz_de_Insumo_Produto_2015_Nivel_12.xls"
tab02 = read_sheet(mip, "02")   # usos a preço de consumidor
tab03 = read_sheet(mip, "03")   # demanda nacional a preço básico
tab04 = read_sheet(mip, "04")   # demanda importada a preço básico
tabs_tax = [read_sheet(mip, s) for s in ("05", "06")]
tabs_mrg = [read_sheet(mip, s) for s in ("07", "08", "09", "10")]

# tab02: col0 código, col2–13 CI das 12 atividades, col15 exportação,
# col16 governo, col17 ISFLSF, col18 famílias, col19 FBCF, col20 var. estoque
sub02 = product_rows(tab02)
DI = {}  # DI[i][j] consumo intermediário a preço de consumidor
for irow in SECTORS:
    rows = sub02[sub02["grp"] == irow]
    for jcol, code in enumerate(["01", "02", "03", "04", "05", "06",
                                 "07", "08", "09", "10", "11", "12"]):
        j = CODE2GRP[code]
        DI.setdefault(irow, {}).setdefault(j, 0.0)
        DI[irow][j] += float(rows[2 + jcol].sum())
C_H = by_group(tab02, 18)
C_ISFLSF = by_group(tab02, 17)
for g in SECTORS:  # ISFLSF consolidado na família
    C_H[g] += C_ISFLSF[g]
CG = by_group(tab02, 16)
INV = by_group(tab02, 19)
VSTK = by_group(tab02, 20)
EXD = by_group(tab02, 15)          # exportações FOB (preço de consumidor)

# tab03/tab04: col2 = recursos (produção nacional / importação),
# col16 = exportação. Nas tabs 03/04 as margens estão REALOCADAS para os
# produtos comércio/transporte (linhas 06/07); as tabs 07–10 informam as
# margens pagas sobre cada produto.
PROD = by_group(tab03, 2)
IM = by_group(tab04, 2)            # importações CIF
EXP_IMP = by_group(tab04, 16)      # reexportação / ajuste CIF-FOB

# impostos e margens por produto: total (col2) e parcela exportada (col16)
def tot_exp(tabs):
    tot = {g: 0.0 for g in SECTORS}
    exp = {g: 0.0 for g in SECTORS}
    for t in tabs:
        for g, v in by_group(t, 2).items():
            tot[g] += v
        for g, v in by_group(t, 16).items():
            exp[g] += v
    return tot, exp

TAX, TAX_X = tot_exp(tabs_tax)     # impostos sobre produtos (nac. + imp.)
MRG, MRG_X = tot_exp(tabs_mrg)     # margens de comércio + transporte

# ---------------------------------------------------------------------------
# 2. TRU nível 12 — make matrix, imposto de importação e valor adicionado
# ---------------------------------------------------------------------------
tru1_of = read_sheet("tru-2015/12_tab1_2015.xls", "oferta")
tru1_pr = read_sheet("tru-2015/12_tab1_2015.xls", "producao")
tru2_va = read_sheet("tru-2015/12_tab2_2015.xls", "VA")

TIM = by_group(tru1_of, 5)         # imposto de importação por produto

# make matrix V[produto i, atividade j] (col2–13 = atividades 01–12)
sub_pr = product_rows(tru1_pr)
MAKE = {i: {j: 0.0 for j in SECTORS} for i in SECTORS}
for _, row in sub_pr.iterrows():
    i = row["grp"]
    for jcol, code in enumerate(["01", "02", "03", "04", "05", "06",
                                 "07", "08", "09", "10", "11", "12"]):
        MAKE[i][CODE2GRP[code]] += float(row[2 + jcol])

def va_row(label):
    mask = tru2_va[0].astype(str).str.strip() == label
    row = tru2_va[mask].iloc[0]
    out = {g: 0.0 for g in SECTORS}
    for jcol, code in enumerate(["01", "02", "03", "04", "05", "06",
                                 "07", "08", "09", "10", "11", "12"]):
        out[CODE2GRP[code]] += float(row[1 + jcol])
    return out

LD = va_row("Remunerações")
KD = va_row("Excedente operacional bruto e rendimento misto bruto")
TIP_tax = va_row("Outros impostos sobre a produção")
TIP_sub = va_row("Outros subsídios à produção")
TIP = {j: TIP_tax[j] + TIP_sub[j] for j in SECTORS}  # subsídios já negativos
VBP = va_row("Valor da produção")

print("== Checagens MIP/TRU ==")
for g in SECTORS:
    check(f"produção de {g} (MIP tab03 vs TRU make)", PROD[g],
          sum(MAKE[g].values()))
check("PIB ótica renda (LD+KD+TIP+imp.produtos)",
      sum(LD.values()) + sum(KD.values()) + sum(TIP.values()) + 840186,
      5995787)
check("importações CIF (MIP tab04 vs CEI P.7)", sum(IM.values()), 842614)
check("exportações FOB (MIP tab02 vs CEI P.6)", sum(EXD.values()), 773468)

# ---------------------------------------------------------------------------
# 3. Blocos produtivos da SAM
# ---------------------------------------------------------------------------
# reexportações/ajuste CIF-FOB (EXP_IMP): abatidas das importações e das
# exportações FOB para manter o modelo sem reexportação
IM = {g: IM[g] - EXP_IMP[g] for g in SECTORS}
EXD = {g: EXD[g] - EXP_IMP[g] for g in SECTORS}

TIX = TAX_X                                   # impostos s/ produtos exportados
TIC = {g: TAX[g] - TAX_X[g] - TIM[g] for g in SECTORS}  # domésticos, exc. TM
MRG_D = {g: MRG[g] - MRG_X[g] for g in SECTORS}         # margens domésticas

# exportações nacionais a preço básico = FOB − margens − imp. de exportação
EX_BAS = {g: EXD[g] - MRG_X[g] - TIX[g] for g in SECTORS}

# identidade oferta×demanda por grupo: absorção doméstica a preço de
# consumidor = oferta doméstica a preço básico + impostos + margens (o grupo
# SER, fornecedor das margens, recebe de volta o total realocado)
mrg_total = sum(MRG_D.values()) + sum(MRG_X.values())
for g in SECTORS:
    uses_dom = (sum(DI[g].values()) + C_H[g] + CG[g] + INV[g] + VSTK[g]
                + (mrg_total if g == "ser" else 0.0))
    supply_dom = ((PROD[g] - EX_BAS[g]) + IM[g]
                  + (TAX[g] - TAX_X[g]) + MRG_D[g])
    check(f"absorção doméstica de {g}", uses_dom, supply_dom)

# vendas das indústrias: locais (DS) e exportadas (EX), a preço básico,
# rateadas pela participação de cada atividade na produção do produto
DS = {j: {i: 0.0 for i in SECTORS} for j in SECTORS}
EX = {j: {i: 0.0 for i in SECTORS} for j in SECTORS}
for i in SECTORS:
    for j in SECTORS:
        share = MAKE[i][j] / PROD[i]
        DS[j][i] = (PROD[i] - EX_BAS[i]) * share
        EX[j][i] = EX_BAS[i] * share

# consumo intermediário total por atividade (preço de consumidor) fecha o
# valor da produção com o VA e impostos s/ produção
print("== Checagem VBP por atividade ==")
for j in SECTORS:
    ci_j = sum(DI[i][j] for i in SECTORS)
    check(f"VBP de {j} (CI+VA+TIP vs make)", ci_j + LD[j] + KD[j] + TIP[j],
          sum(MAKE[i][j] for i in SECTORS))

# ---------------------------------------------------------------------------
# 4. Bloco institucional (CEI 2015)
# ---------------------------------------------------------------------------
cei = read_sheet("cei-2015/CEI2015.xls", "CEI")
# colunas: usos 3=RM 5=S.15 6=S.14 7=S.13 8=S.12 9=S.11 | código 10 |
#          recursos 12=S.11 13=S.12 14=S.13 15=S.14 16=S.15 18=RM

def cei_row(code, occ=0):
    mask = cei[10].astype(str).str.strip() == code
    return cei[mask].iloc[occ]

def flows(code, occ=0):
    "Retorna (usos, recursos) por agente consolidado {h, firm, gvt, row}."
    r = cei_row(code, occ)
    f = lambda c: float(r[c]) if pd.notna(r[c]) else 0.0
    usos = {"h": f(5) + f(6), "firm": f(8) + f(9), "gvt": f(7), "row": f(3)}
    rec = {"h": f(15) + f(16), "firm": f(12) + f(13), "gvt": f(14),
           "row": f(18)}
    return usos, rec

AGENTS = ["h", "firm", "gvt", "row"]
TR = {(a, b): 0.0 for a in AGENTS for b in AGENTS}  # TR[recebe, paga]

def add_proportional(usos, rec):
    total = sum(usos.values())
    assert abs(total - sum(rec.values())) <= TOL
    for b in AGENTS:
        for a in AGENTS:
            TR[(a, b)] += usos[b] * rec[a] / total

# renda do capital por setor institucional (B.2 + B.3)
_, b2 = flows("B.2")
_, b3 = flows("B.3")
LAMBDA_RK = {a: b2[a] + b3[a] for a in ("h", "firm", "gvt")}
check("EOB+RMB (CEI vs TRU)", sum(LAMBDA_RK.values()), sum(KD.values()))

# trabalho: atividades pagam LAB; 293 vão a não residentes; famílias ainda
# recebem 1.450 do exterior — ambos viram transferências com ROW
d1_usos, d1_rec = flows("D.1")
TR[("h", "row")] += d1_usos["row"]        # 1.450
TR[("row", "h")] += d1_rec["row"]         # 293

# impostos diretos: D.5 + contribuições sociais recebidas pelo governo (D.61);
# D.5 pago pelo próprio governo é consolidado (sai dos dois lados)
d5_usos, _ = flows("D.5")
d61 = cei_row("D.61")
TDH = d5_usos["h"] + float(d61[14])       # famílias: D.5 + D.61 ao governo
TDF = d5_usos["firm"]
TR[("firm", "h")] += float(d61[13])       # previdência privada (S.12)

# benefícios sociais (D.62) e ajuste de fundos de pensão (D.8)
d62_usos, _ = flows("D.62")
TR[("h", "gvt")] += d62_usos["gvt"]
TR[("h", "firm")] += d62_usos["firm"]
d8_usos, _ = flows("D.8")
TR[("h", "gvt")] += d8_usos["gvt"]
TR[("h", "firm")] += d8_usos["firm"]

# renda de propriedade (D.4): alocação proporcional
add_proportional(*flows("D.4"))

# outras transferências correntes (D.7), excluindo D.73 (intragoverno)
d7_usos, d7_rec = flows("D.7")
d73_usos, d73_rec = flows("D.73")
d7_usos = {a: d7_usos[a] - d73_usos[a] for a in AGENTS}
d7_rec = {a: d7_rec[a] - d73_rec[a] for a in AGENTS}
add_proportional(d7_usos, d7_rec)

# transferências de capital (D.9): "a receber" e "a pagar" (valores negativos)
_, d9_rec = flows("D.9", 0)
_, d9_pay = flows("D.9", 1)
add_proportional({a: -d9_pay[a] for a in AGENTS}, d9_rec)

# poupança: como o D.9 entra como transferência, a poupança de cada agente é
# a B.10.1 (poupança bruta + transferências de capital líquidas); para o ROW
# é o saldo externo corrente mais o D.9 líquido (também B.10.1)
_, SAV = flows("B.10.1")
check("poupança total vs investimento", sum(SAV.values()),
      sum(INV.values()) + sum(VSTK.values()))

# ---------------------------------------------------------------------------
# 5. Montagem da SAM e verificação de equilíbrio
# ---------------------------------------------------------------------------
XSEC = [g for g in SECTORS if EXD[g] > 0]   # contas de exportação
sam = {}

def put(rc, re, cc, ce, v):
    if abs(v) > 1e-9:
        sam[(rc, re, cc, ce)] = sam.get((rc, re, cc, ce), 0.0) + v

for j in SECTORS:
    put("l", "lab", "j", j, LD[j])                    # trabalho
    put("k", "cap", "j", j, KD[j])                    # capital
    put("ag", "gvt", "j", j, TIP[j])                  # imp. líq. s/ produção
for a, pep in (("h", "h"), ("firm", "firm"), ("gvt", "gvt")):
    put("ag", pep, "k", "cap", LAMBDA_RK[a])
put("ag", "h", "l", "lab", sum(LD.values()))
for a in AGENTS:
    for b in AGENTS:
        put("ag", a, "ag", b, TR[(a, b)])
put("ag", "td", "ag", "h", TDH)
put("ag", "td", "ag", "firm", TDF)
put("ag", "gvt", "ag", "td", TDH + TDF)
put("ag", "gvt", "ag", "tm", sum(TIM.values()))
put("ag", "gvt", "ag", "ti", sum(TIC.values()))
for i in SECTORS:
    for j in SECTORS:
        put("i", i, "j", j, DI[i][j])                 # consumo intermediário
        put("j", j, "i", i, DS[j][i])                 # make local
    put("i", i, "ag", "h", C_H[i])
    put("i", i, "ag", "gvt", CG[i])
    put("i", i, "oth", "inv", INV[i])
    put("i", i, "oth", "vstk", VSTK[i])
    put("ag", "row", "i", i, IM[i])                   # importações
    put("ag", "ti", "i", i, TIC[i])
    put("ag", "tm", "i", i, TIM[i])
    put("i", "ser", "i", i, MRG_D[i])                 # margens domésticas
for i in XSEC:
    put("x", i, "ag", "row", EXD[i])                  # exportações FOB
    put("ag", "gvt", "x", i, TIX[i])                  # imp. s/ exportação
    put("i", "ser", "x", i, MRG_X[i])                 # margens s/ exportação
    for j in SECTORS:
        put("j", j, "x", i, EX[j][i])                 # vendas p/ exportação
for a in AGENTS:
    put("oth", "inv", "ag", a, SAV[a])
put("oth", "vstk", "oth", "inv", sum(VSTK.values()))

# equilíbrio linha = coluna de cada conta
ACCOUNTS = ([("l", "lab"), ("k", "cap")] +
            [("ag", a) for a in ("h", "firm", "gvt", "td", "tm", "ti", "row")] +
            [("j", j) for j in SECTORS] + [("i", i) for i in SECTORS] +
            [("x", i) for i in XSEC] + [("oth", "inv"), ("oth", "vstk")])

print("== Equilíbrio da SAM ==")
worst = 0.0
for acc in ACCOUNTS:
    row = sum(v for k, v in sam.items() if k[:2] == acc)
    col = sum(v for k, v in sam.items() if k[2:] == acc)
    worst = max(worst, abs(row - col))
    check(f"conta {acc[0]}:{acc[1]}", row, col, tol=25.0)
print(f"maior desequilíbrio: {worst:,.1f} R$ mi "
      f"({100 * worst / sum(VBP.values()):.5f}% do VBP)")

# PIB pela ótica da despesa (usos finais a preço de consumidor − importações)
gdp_fd = (sum(C_H.values()) + sum(CG.values()) + sum(INV.values())
          + sum(VSTK.values()) + sum(EXD.values()) - sum(IM.values()))
check("PIB ótica despesa vs IBGE", gdp_fd, 5995787)

# ---------------------------------------------------------------------------
# 6. Emissão da grade CSV
# ---------------------------------------------------------------------------
OUT.mkdir(parents=True, exist_ok=True)
cols = ACCOUNTS
lines = ["Matriz de Contabilidade Social do Brasil — 2015 (R$ milhões)",
         "Construída de MIP/TRU/CEI 2015 do IBGE por references/sam-br/build_sam.py",
         ""]
lines.append(",," + ",".join(c.upper() for c, _ in cols) + ",OTH")
lines.append(",," + ",".join(e.upper() for _, e in cols) + ",TOT")
def fmt(v):
    return f"{v:.6f}".rstrip("0").rstrip(".") if v != 0.0 else ""

for racc in ACCOUNTS:
    vals = [fmt(sam.get(racc + cacc, 0.0)) for cacc in cols]
    total = sum(sam.get(racc + cacc, 0.0) for cacc in cols)
    lines.append(f"{racc[0].upper()},{racc[1].upper()}," + ",".join(vals) +
                 f",{fmt(total)}")
tot_cols = [fmt(sum(sam.get(r + c, 0.0) for r in ACCOUNTS)) for c in cols]
lines.append("OTH,TOT," + ",".join(tot_cols) + ",")
(OUT / "sam.csv").write_text("\n".join(lines) + "\n", encoding="utf-8")
print(f"SAM gravada em {OUT.resolve() / 'sam.csv'}")
