# Despeja todas as abas dos arquivos Excel de referência em CSVs (um por aba).
# Uso: uv run --with pandas --with xlrd --with openpyxl dump_sheets.py
#
# O pacote do PEP-1-t não traz `parameters.xlsx` nem `results.xlsx` — a
# calibração e os resultados de referência só existem depois de rodar o GAMS,
# que grava esses arquivos via os programas `RESULTS PEP 1-t *.GMS`.
from pathlib import Path

import pandas as pd

HERE = Path(__file__).parent
FILES = ["SAM-V2_0.xls", "VAL_PAR.xlsx", "parameters.xlsx", "results.xlsx"]

for name in FILES:
    path = HERE / name
    if not path.exists():
        print(f"{name}: ausente, pulando")
        continue
    sheets = pd.read_excel(path, sheet_name=None, header=None)
    for sheet_name, df in sheets.items():
        if df.empty:
            continue
        out = HERE / f"{path.stem}__{sheet_name}.csv".replace(" ", "_")
        df.to_csv(out, index=False, header=False)
        print(f"{out.name}: {df.shape[0]}x{df.shape[1]}")
