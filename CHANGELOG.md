# Changelog

Todas as mudanças notáveis deste projeto são documentadas aqui.
Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/);
versionamento conforme [SemVer](https://semver.org/lang/pt-BR/).

## [Não lançado]
### Modificado
- **Conjuntos de índices vêm dos dados, não mais do código.** `J`, `I`, `L`,
  `K`, `H` e `F` saíam de constantes do módulo fixas nas dimensões da SAM
  fictícia; agora cada base declara os seus num `sets.csv`, e `AG`, `AGNG`,
  `AGD` e `I1` são derivados. `calibrate` e `read_val_par` passaram a receber
  os conjuntos; o produto que fecha pela lei de Walras deixou de ser `agr`
  fixo. A regressão contra o GAMS continua idêntica (932 verificações).
- Tolerância do Ipopt escalonada pela ordem de grandeza da SAM
  (`PEP11.default_tol`), com piso na escala da SAM fictícia; sem isso a SAM
  brasileira, em R$ milhões, não converge dentro do `tol` antigo de 1e-10.

### Adicionado
- `PEP11.calibration(dir)`, `PEP11.br_calibration()` e `PEP11.datadir` para
  calibrar a partir de qualquer diretório de base.
- Testes da base brasileira: conjuntos generalizados, PIB pelas três óticas,
  benchmark como equilíbrio e um choque tarifário.
- `scripts/sensibilidade_br.jl`: sensibilidade dos resultados às elasticidades
  incertas do `val_par.csv` sob um choque tarifário, com coluna de termos de
  troca. Conclusões em `references/sam-br/README.md` — `sigma_XD` domina,
  `sigma_M[ind]` (a escolha 1,15 vs 1,50) é secundária e `sigma_M[agr]` é
  irrelevante.
- Avaliação do `sigma_XD` em `references/sam-br/README.md`: elasticidades-preço
  da demanda por exportações estimadas para o Brasil (Casagrande et al. 2014;
  Meyer 2008) ponderadas pela pauta de 2015, contrastadas com as elasticidades
  de fornecimento do GTAP. As duas bases discordam por uma ordem de grandeza
  (0,5–1,2 contra 4–9), e a resposta das importações varia ~46× na faixa.
- Parâmetros exógenos brasileiros (`data/pep-1-1-br/val_par.csv`): Armington do
  IPEA (TD 124) para a indústria, σVA do GTAP ponderado pelo VAB do IBGE, LES
  com `frisch = -2,0` e elasticidades-renda por Engel; proveniência documentada
  em `references/sam-br/README.md`.
- SAM brasileira 2015 balanceada (`data/pep-1-1-br/sam.csv`) com 4 setores
  (AGR/IND/SER/ADM), 1 trabalho, 1 capital, 1 família, FIRM/GVT/ROW e contas
  de impostos, construída por `references/sam-br/build_sam.py` a partir de
  MIP/TRU/CEI 2015; todas as 22 contas fecham exatas e o PIB bate com o IBGE
  (R$ 5.995.787 mi) pelas óticas da renda e da despesa.
- Dados-fonte do IBGE (ano-base 2015) para a construção da SAM brasileira do
  PEP-1-1 em `references/sam-br/`: MIP níveis 67 e 12, TRU níveis 68 e 12
  e Contas Econômicas Integradas, com dumps CSV e README das fontes.

## [0.1.0] - 2026-06-10
### Adicionado
- Port completo do modelo PEP-1-1 v2.1 (GAMS → Julia/JuMP/Ipopt): leitura da
  SAM em CSV, calibração e equações EQ1–EQ98 + lei de Walras.
- Dados padrão (SAM fictícia V2.0 e parâmetros exógenos) em CSV.
- Arquivos de referência do modelo original (código GAMS, planilhas e
  resultados) em `references/pep-1-1/`.
- Testes de regressão contra o GAMS: calibração (250 valores), replicação do
  benchmark e simulação de redução de 25% no imposto de exportação
  (341 valores cada).
