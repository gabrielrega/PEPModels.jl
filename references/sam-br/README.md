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
