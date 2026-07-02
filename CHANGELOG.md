# Changelog

Todas as mudanças notáveis deste projeto são documentadas aqui.
Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/);
versionamento conforme [SemVer](https://semver.org/lang/pt-BR/).

## [Não lançado]
### Adicionado
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
