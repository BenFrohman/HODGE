"""Build and audit every theorem in the incremental residue modules.
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Author: Frohman, Benjamin Stanley.
"""
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parents[1]
MODULES = ['ExplicitResidueAlgebra', 'ExplicitResidueCertificates']
expected = []
for module in MODULES:
    text = (ROOT/'Hodge'/f'{module}.lean').read_text()
    expected += [f'Hodge.{module}.{name}' for name in
                 re.findall(r'^(?:@\[simp\] )?theorem (\w+)', text, re.M)]
audit_source = (ROOT/'ResidueAxiomAudit.lean').read_text()
actual = re.findall(r'^#print axioms (\S+)$', audit_source, re.M)
if actual != expected:
    raise SystemExit('ResidueAxiomAudit.lean must cover every incremental theorem in source order')
subprocess.run(['lake', 'build'] + ['Hodge.'+m for m in MODULES], cwd=ROOT, check=True)
run = subprocess.run(['lake', 'env', 'lean', 'ResidueAxiomAudit.lean'], cwd=ROOT,
                     text=True, capture_output=True, check=True)
print(run.stdout, end='')
if run.stderr:
    print(run.stderr, end='')
lines = []
for line in run.stdout.splitlines():
    if line.startswith(' ') and lines:
        lines[-1] += ' '+line.strip()
    else:
        lines.append(line)
entries = [line for line in lines if line.startswith("'")]
allowed = {'propext', 'Classical.choice', 'Quot.sound'}
if len(entries) != len(expected):
    raise SystemExit(f'Expected {len(expected)} audited declarations, saw {len(entries)}')
for name, line in zip(expected, entries):
    if not line.startswith("'"+name+"'"):
        raise SystemExit('Unexpected declaration order: '+line)
    if line.endswith('does not depend on any axioms'):
        continue
    match = re.search(r'depends on axioms: \[(.*)\]$', line)
    if not match or not set(match.group(1).split(', ')) <= allowed:
        raise SystemExit('Nonstandard axiom dependency: '+line)
print(f'PASS: {len(expected)} incremental theorem declarations; standard axioms only')
