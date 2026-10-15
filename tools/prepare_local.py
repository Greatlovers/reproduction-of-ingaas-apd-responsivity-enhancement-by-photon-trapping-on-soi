"""Copy public project templates to a new directory. Does not run Sentaurus."""
from pathlib import Path
import argparse, shutil

p = argparse.ArgumentParser(description=__doc__)
p.add_argument('--output-root', required=True)
a = p.parse_args()
source = Path(__file__).resolve().parents[1] / 'projects'
target = Path(a.output_root).expanduser().resolve()
if target.exists():
    raise SystemExit('Refusing to overwrite an existing output directory.')
if target == source or source in target.parents:
    raise SystemExit('The destination must be outside the source projects directory.')
shutil.copytree(source, target)
for f in target.rglob('*'):
    if f.is_file() and f.suffix in {'.cmd', '.tcl', '.py', '.json', '.txt', '.dat'}:
        text = f.read_text(encoding='utf-8')
        if '__PROJECT_ROOT__' in text:
            f.write_text(text.replace('__PROJECT_ROOT__', target.as_posix()), encoding='utf-8')
print('Prepared:', target)
print('Material cards and optical tables are intentionally missing; no simulation was launched.')
