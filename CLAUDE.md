# CLAUDE.md — PEPModels.jl

Guia para o Claude Code neste repositório. As convenções gerais da pasta `projetos` valem aqui; detalhes do projeto no `README.md`.

## Ficha

- **Pergunta**: Os modelos EGC da rede PEP rodam em Julia/JuMP com resultado idêntico ao GAMS?
- **Status**: v0.2.0, ativo. PEP-1-1 validado; PEP-1-t com calibração (não lançada). Bases BR 2015 e 2019.
- **Entradas**: SAMs em `data/<base>/` (a de 2019 gerada por `datalake.sut sam-pep`).
- **Saídas**: Modelos calibrados e resolvidos (JuMP/Ipopt).
- **Rodar**: `julia --project=. -e "using Pkg; Pkg.test()"`.
- **Pronto quando**: Regressão contra o GAMS (BASE e SIM1) e benchmarks das bases brasileiras como equilíbrio (`LEON`/PIB < 1e-10).
