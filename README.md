# PEPModels.jl

Traduções em **Julia/JuMP** dos modelos de equilíbrio geral computável (EGC)
da rede [PEP](https://www.pep-net.org/) — os *workhorses* da modelagem EGC de
Decaluwé, Lemelin, Robichaud e Maisonnave — originalmente escritos em GAMS
(software proprietário).

O objetivo é manter **funcionalidade idêntica** ao original, verificada por
testes de regressão contra os resultados do GAMS, usando apenas ferramentas
abertas (Julia, JuMP, Ipopt, dados em CSV).

## Modelos

| Modelo | Descrição | Status |
|---|---|---|
| **PEP-1-1** v2.1 | País único, estático | ✅ portado e validado |
| PEP-1-t | País único, dinâmico recursivo | planejado |
| PEP-w-1 / PEP-w-t | Multi-país | planejado |

## Uso

```julia
using PEPModels, JuMP
const PEP11 = PEPModels.PEP11

# Calibra com a SAM fictícia padrão (data/pep-1-1/)
cal = PEP11.default_calibration()

# Constrói o modelo com fechamento padrão (câmbio numerário, CAB/G/LS/KS fixos)
m = PEP11.build(cal)

# Choque: redução de 25% no imposto de exportação
for i in m.ext[:sup].iEXD
    fix(m[:ttix][i], cal.ttixO[i] * 0.75; force = true)
end

PEP11.solve!(m)

value(m[:GDP_MP_REAL])          # PIB real a preços de mercado
value(m[:PC][:food])            # preço ao consumidor de alimentos
value(m[:LD][(:usk, :agr)])     # demanda por trabalho não qualificado em agr
```

Para usar outra SAM, forneça CSVs no mesmo layout de `data/pep-1-1/` e chame
`read_sam`/`read_val_par`/`calibrate` diretamente.

## Estrutura

- `src/pep11/data.jl` — leitura da SAM e parâmetros exógenos (CSV)
- `src/pep11/calibration.jl` — calibração (seções 3–4 do GAMS, transliteração linha a linha)
- `src/pep11/model.jl` — equações EQ1–EQ98 + lei de Walras (seções 5–6), JuMP/Ipopt
- `references/pep-1-1/` — código GAMS original, SAM e resultados de referência
- `test/` — regressão completa contra os números do GAMS (calibração, benchmark e simulação)

## Notas de implementação

- O sistema é quadrado (CNS no GAMS); aqui é resolvido como problema de
  factibilidade com Ipopt, partindo do benchmark.
- As condições `$` do GAMS (fluxos zero) viram **suportes**: variáveis e
  equações só existem onde o fluxo de benchmark é positivo.
- Convenção `0^0 = 1` de Julia coincide com a do GAMS nas calibrações com
  fluxo zero (ex.: `beta_X = 0.5` em produtos sem exportação).

## Licença e atribuição

O modelo PEP-1-1 original é de **Véronique Robichaud, André Lemelin, Hélène
Maisonnave e Bernard Decaluwé**, licenciado sob
[CC BY-NC-SA 3.0](http://creativecommons.org/licenses/by-nc-sa/3.0/).
Esta tradução é obra derivada e mantém a mesma licença.
