# Despeja todas as abas dos arquivos Excel do IBGE em CSVs (um por aba).
# Uso: uv run --with pandas --with xlrd --with openpyxl dump_sheets.py
from pathlib import Path

import pandas as pd

HERE = Path(__file__).parent
FILES = [
    "mip-ibge-2015/Matriz_de_Insumo_Produto_2015_Nivel_67.xls",
    "mip-ibge-2015/Matriz_de_Insumo_Produto_2015_Nivel_12.xls",
    "cei-2015/CEI2015.xls",
    "tru-2015/12_tab1_2015.xls",
    "tru-2015/12_tab2_2015.xls",
    "tru-2015/68_tab1_2015.xls",
    "tru-2015/68_tab2_2015.xls",
    "tru-2015/68_tab3_2015.xls",
    "tru-2015/68_tab4_2015.xls",
]

for name in FILES:
    path = HERE / name
    sheets = pd.read_excel(path, sheet_name=None, header=None)
    for sheet_name, df in sheets.items():
        if df.empty:
            continue
        out = path.parent / f"{path.stem}__{sheet_name}.csv".replace(" ", "_")
        df.to_csv(out, index=False, header=False)
        print(f"{out.name}: {df.shape[0]}x{df.shape[1]}")
