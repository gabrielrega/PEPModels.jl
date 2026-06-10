# Despeja todas as abas dos arquivos Excel de referência em CSVs (um por aba).
# Uso: uv run --with pandas --with xlrd --with openpyxl dump_sheets.py
from pathlib import Path

import pandas as pd

HERE = Path(__file__).parent
FILES = ["SAM-V2_0.xls", "VAL_PAR.xlsx", "parameters.xlsx", "results.xlsx"]

for name in FILES:
    path = HERE / name
    sheets = pd.read_excel(path, sheet_name=None, header=None)
    for sheet_name, df in sheets.items():
        if df.empty:
            continue
        out = HERE / f"{path.stem}__{sheet_name}.csv".replace(" ", "_")
        df.to_csv(out, index=False, header=False)
        print(f"{out.name}: {df.shape[0]}x{df.shape[1]}")
