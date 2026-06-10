# Changelog

Todas as mudanças notáveis deste projeto são documentadas aqui.
Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/);
versionamento conforme [SemVer](https://semver.org/lang/pt-BR/).

## [Não lançado]

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
