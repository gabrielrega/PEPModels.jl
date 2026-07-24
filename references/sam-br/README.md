# Dados-fonte para a SAM brasileira (PEP-1-1)

Arquivos originais do IBGE usados na construção de uma SAM do Brasil (ano-base
2015) compatível com o modelo PEP-1-1. Baixados de `ftp.ibge.gov.br` em
2026-07-02. Os CSVs `*__*.csv` são dumps das abas dos Excel, gerados por
`dump_sheets.py`.

## mip-ibge-2015/ — Matriz de Insumo-Produto 2015

Fonte: <https://ftp.ibge.gov.br/Contas_Nacionais/Matriz_de_Insumo_Produto/2015/>

- `Matriz_de_Insumo_Produto_2015_Nivel_67.xls` — 15 tabelas, 67 atividades ×
  127 produtos: recursos, usos, oferta/demanda nacional e importada a preço
  básico, destino de impostos e margens (comércio e transporte), matrizes de
  coeficientes e de Leontief.
- `Matriz_de_Insumo_Produto_2015_Nivel_12.xls` — mesmas tabelas agregadas em
  12 atividades (útil para conferência das agregações).
- `indice_de_tabelas.txt` — sumário das tabelas.

## tru-2015/ — Tabelas de Recursos e Usos 2015, nível 68

Fonte: <https://ftp.ibge.gov.br/Contas_Nacionais/Sistema_de_Contas_Nacionais/2015/tabelas_xls/tabelas_de_recursos_e_usos/>
(zip `nivel_68_2010_2015_xls.zip`; mantidos só os arquivos de 2015)

- `68_tab1_2015.xls` — recursos (oferta, produção, importação) a preço corrente.
- `68_tab2_2015.xls` — usos a preço corrente; a aba `VA` traz os componentes do
  valor adicionado por atividade: remunerações (salários + contribuições),
  rendimento misto, EOB, outros impostos/subsídios sobre a produção e ocupações.
- `68_tab3_2015.xls` / `68_tab4_2015.xls` — recursos e usos no ano anterior
  (preços constantes).

## cei-2015/ — Contas Econômicas Integradas 2015

Fonte: <https://ftp.ibge.gov.br/Contas_Nacionais/Sistema_de_Contas_Nacionais/2015/tabelas_xls/contas_economicas_integradas/>
(zip `contas_economicas_integradas_2000a2015_xls.zip`; mantido só 2015)

- `CEI2015.xls` — contas correntes e de acumulação por setor institucional
  (S.11 empresas não financeiras, S.12 financeiras, S.13 governo, S.14
  famílias, S.15 ISFLSF, resto do mundo): geração/alocação/distribuição da
  renda, transferências (D.x), poupança (B.8) e FBCF por setor.

## Papel de cada fonte na SAM

- **MIP nível 67**: consumo intermediário, demanda final, importações,
  impostos sobre produtos e margens — blocos produto × atividade da SAM.
- **TRU aba VA**: divisão do valor adicionado em trabalho × capital por
  atividade (remunerações → trabalho; EOB + rendimento misto → capital).
- **CEI**: fechamento institucional — renda das famílias/firmas/governo,
  transferências entre agentes, impostos diretos, poupança e conta externa.

## Parâmetros exógenos (`data/pep-1-1-br/val_par.csv`)

Diferentemente da SAM, os parâmetros exógenos não saem do IBGE: são
elasticidades de comportamento tomadas da literatura. A regra adotada foi usar
estimativa brasileira quando existe, GTAP quando não existe, e o default da PEP
quando nem uma nem outra se aplica. Cada escolha abaixo indica a origem.

### `sigma_M(i)` — Armington (importado × doméstico)

| produto | valor | origem |
|---|---|---|
| AGR | 2,00 | GTAP 6, tab. 14.2 (culturas/pecuária: 1,30–4,45) — o IPEA **não** estimou agropecuária |
| IND | 1,50 | Tourinho, Kume & Pedroso (IPEA TD 124): média aritmética das estimativas positivas = **1,47** |
| SER | 1,90 | GTAP 6, tab. 14.2 (σD = 1,90 para todos os serviços) — o IPEA **não** estimou serviços |
| ADM | 1,90 | irrelevante: a SAM não tem importação de ADM |

O TD 124 estima 28 setores industriais (1986–2002); as estimativas
significativas variam de 0,16 a 5,3. A **média ponderada por importações é
1,15** — alternativa mais conservadora a 1,50 para o agregado IND, vale testar
a sensibilidade do modelo entre os dois.

### `sigma_VA(j)` — CES trabalho × capital

Média dos σVA do GTAP 6 (tab. 14.2) sobre as 12 atividades do IBGE que compõem
cada setor, **ponderada pelo VAB de 2015** (TRU nível 12, aba `VA`):

| setor | atividades IBGE | VAB (R$ mi) | σVA |
|---|---|---|---|
| AGR | 01 | 258.967 | 0,24 |
| IND | 02–05 | 1.160.772 | 1,27 |
| SER | 06–11 | 2.850.275 | 1,39 |
| ADM | 12 | 885.587 | 1,26 |

σVA do GTAP por atividade: agropecuária 0,24; extrativa 0,20; transformação e
utilities 1,26; construção, comércio e transporte 1,68; demais serviços e
administração pública 1,26.

### `frisch(h)` e `sigma_Y(i,h)` — sistema LES

- `frisch = -2,0`. O default da PEP é −1,5 (país de renda alta); para renda
  média a literatura (Lluch, Powell & Williams) aponta magnitude maior. Com
  −2,0 a parcela de subsistência do consumo fica em ~50% (com −1,5 seria 33%).
- Elasticidades-renda seguindo a lei de Engel: AGR 0,6 (alimento in natura),
  IND 1,0, SER 1,1, ADM 1,0. A calibração renormaliza esses valores para
  satisfazer a condição de agregação, então só as **razões** entre eles
  importam. ADM é irrelevante (consumo das famílias é zero na SAM).

### `sigma_XD(i)` — demanda mundial pelas exportações

Está em **2 (default da PEP)**, mas é o parâmetro que mais move os resultados,
e a evidência é contraditória. Vale entender a escolha antes de usar o modelo
para qualquer coisa que dependa de resposta comercial.

**Duas bases de evidência que discordam por uma ordem de grandeza:**

*(a) Econometria brasileira.* Casagrande, Feistel, Hidalgo & Azevedo (ANPEC
2014) estimam a função de demanda por exportações de Goldstein-Khan
(substitutos imperfeitos) — que é **exatamente a forma funcional da EQ62** —
por cointegração de Johansen, 1999–2013, por classe de produto e destino.
Elasticidades-preço de longo prazo:

| classe | Ásia | Nafta | UE | média | Meyer (2008) |
|---|---|---|---|---|---|
| Básicos | −0,85 | −0,26 | −0,49 | **−0,53** | −0,57 |
| Manufaturados | −1,57 | −1,71 | −0,26 | **−1,18** | −0,91 |

Ponderando pela pauta de 2015 (TRU nível 68) e agregando nos setores da SAM —
a agropecuária é 100% básicos e **61% das exportações industriais são
commodities** (minério de ferro, petróleo, açúcar, carnes, celulose,
metalurgia básica) — chega-se a `sigma_XD` = 0,53 (AGR), 0,78 (IND). Serviços
não têm estimativa brasileira. Há literatura dedicada ao ponto: o IPEA tem um
texto inteiro chamado *"Por que a elasticidade-preço das exportações é baixa no
Brasil?"*, atribuindo o resultado à pauta concentrada em commodities, onde a
concorrência não se dá por preço.

*(b) Armington / GTAP.* Em modelo de comércio Armington, a elasticidade da
demanda pelas exportações de um país é a elasticidade de substituição **entre
fornecedores** (σM do GTAP), que para os produtos da pauta brasileira fica
entre 4 e 9 — média simples de 7,0 no GTAP 6. A "regra dos dois" do GTAP
(σM = 2σD) aplicada aos nossos `sigma_M` daria `sigma_XD` de 3,0 a 4,0.

**Por que discordam:** as estimativas macroeconométricas usam índices
agregados e não instrumentam preço contra quantidade, o que enviesa o
coeficiente na direção de zero — é o "elasticity puzzle" da literatura
(Kehoe, Ruhl). Do outro lado, `sigma_XD` < 1 implica que o Brasil aumentaria
sua receita de exportação restringindo volume, o que é uma afirmação forte.

**O que muda no modelo** (corte de 50% nas tarifas de importação):

| `sigma_XD` | PIB real | Bem-estar | Importações | Termos de troca |
|---|---|---|---|---|
| econométrico BR (0,53 / 0,78 / 1,18) | −0,159 | +0,236 | **+0,02** | −0,85 |
| uniforme 2 (base) | −0,085 | +0,277 | +0,56 | −0,46 |
| regra dos dois (2 × σM) | −0,057 | +0,294 | +0,77 | −0,31 |
| GTAP sourcing (5 / 6 / 3,8) | −0,035 | +0,306 | +0,92 | −0,20 |

O mecanismo: com CAB fixo, importação só cresce o quanto a exportação
financiar. Com elasticidade baixa o país só vende mais cortando muito o preço,
os termos de troca despencam e **a liberalização praticamente não gera
importação** (+0,02%). A resposta das importações varia ~46× na faixa; o
bem-estar, só 30%.

**Conclusão prática:** não há valor único defensável. `sigma_XD` deve ser
tratado como eixo de cenário, não como ponto — resultados de política
comercial neste modelo só significam alguma coisa se vierem com a faixa.

### Demais parâmetros — default da PEP, sem evidência brasileira

- `sigma_XT(j) = 2` (CET entre produtos de uma indústria) e
  `sigma_X(j,i) = 2` (CET exportação × venda local).
- `sigma_KD(j) = sigma_LD(j) = 0,8`: **degenerados** nesta SAM, que tem um só
  tipo de trabalho (LAB) e um só de capital (CAP). O valor não afeta resultado.
- Interceptos `sh0O`, `tr0O`, `ttdh0O`, `ttdf0O` = 0, ou seja, poupança,
  transferências e impostos diretos proporcionais à renda (como no PEP padrão).

### O que a sensibilidade mostrou

`scripts/sensibilidade_br.jl` roda um corte de 50% em todas as tarifas de
importação sob cada variação de parâmetro (o benchmark é o mesmo em todos os
casos, então a sensibilidade só aparece na resposta ao choque). Resumo:

| parâmetro | faixa testada | efeito nos agregados |
|---|---|---|
| `sigma_XD` | 0,5 a 10 | **dominante** — importações variam ~46×; ver seção própria acima |
| `sigma_M[ind]` | 0,9 a 3,0 | moderado — PIB −0,057% a −0,129%; sinais nunca invertem |
| `sigma_VA` | metade a 1,5 uniforme | irrelevante nos agregados, **relevante nos preços de fator** |
| `frisch` | −1,5 a −3,0 | desprezível para choque comercial |
| `sigma_M[agr]` | 1,3 a 4,5 | desprezível (agropecuária é 1,5% das importações) |

Três consequências práticas:

1. **A escolha 1,15 vs 1,50 para `sigma_M[ind]` não é crítica.** Muda a
   magnitude em ~20% nas variáveis de comércio e produto, mas nenhum sinal se
   inverte e o bem-estar quase não se move (+0,282% vs +0,277%).
2. **O parâmetro que manda é `sigma_XD`** — justamente o que ficou no default 2
   da PEP, sem nenhuma evidência brasileira. É aí que vale investir estimação.
3. `sigma_M[agr]`, que era o menos ancorado, é também o menos consequente.

Cuidado ao ler o PIB: `GDP_MP` inclui impostos sobre produtos, então parte da
queda é a perda mecânica de arrecadação, não perda de eficiência. O bem-estar
(`CTH_REAL`) sobe em todos os cenários.
