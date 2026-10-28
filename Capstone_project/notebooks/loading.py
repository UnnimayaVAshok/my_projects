from pathlib import Path
import nbformat

raw_folder = Path("data/raw")
notebooks_folder = Path("notebooks")

for file in raw_folder.glob("*.csv"):
    notebook_name = f"{file.stem}_analysis.ipynb"
    notebook_path = notebooks_folder / notebook_name

    if not notebook_path.exists():
            notebook = nbformat.v4.new_notebook()
            nbformat.write(notebook, notebook_path)
            print(f"Created: {notebook_path}")
    else:
            print(f"Already exists: {notebook_path}")