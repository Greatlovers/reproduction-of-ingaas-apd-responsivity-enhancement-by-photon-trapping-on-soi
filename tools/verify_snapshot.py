"""Verify the public source snapshot, and native data if present."""
from pathlib import Path
import argparse, hashlib, json

ap = argparse.ArgumentParser(description=__doc__)
ap.add_argument('--with-native', action='store_true', help='Also require all native data from the full Release backup.')
args = ap.parse_args()

root = Path(__file__).resolve().parents[1]
manifest = json.loads((root / 'PUBLICATION_MANIFEST.json').read_text(encoding='utf-8'))
count = 0
for name, record in manifest['files'].items():
    f = root / name
    assert f.is_file(), 'Missing: ' + name
    data = f.read_bytes()
    assert len(data) == record['bytes'], 'Size mismatch: ' + name
    assert hashlib.sha256(data).hexdigest() == record['sha256'], 'Hash mismatch: ' + name
    count += 1
native = root / 'NATIVE_MANIFEST.json'
if args.with_native:
    assert native.exists(), 'NATIVE_MANIFEST.json is missing.'
    for name, record in json.loads(native.read_text(encoding='utf-8'))['files'].items():
        f = root / name
        assert f.is_file() and hashlib.sha256(f.read_bytes()).hexdigest() == record['sha256'], name
        count += 1
print('Verified', count, 'files. Native backup checked:', args.with_native)
print('No solver or material-card validation was performed.')
