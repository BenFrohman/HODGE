<!-- Copyright (c) 2026 Benjamin Stanley Frohman. Licensed under Apache-2.0. -->
# Formalization notes (REVIEW DRAFT)

Author metadata: **Frohman, Benjamin Stanley**
Email: frohmanbenjamin@gmail.com
ORCID: https://orcid.org/0009-0006-7068-3718
License: Apache-2.0 (same as repository root `LICENSE` / `NOTICE`; no relicense)

**Status:** REVIEW DRAFT algebraic manuscripts only. No DOI assigned for these
notes. Not a Zenodo upload, not peer review, not a Clay/Hodge geometric close.

## Mathematical source pin

- Pin: `e207394a9ed4255ad804860b8f69fde7e940dd54`
- Later CI head with identical reviewed modules/audit/toolchain/lock:
  `fefe2ba9d87c900b538d02c13f7f51f375fcd285`
- Repository: https://github.com/BenFrohman/HODGE
- Related formalization PR (merge verified at `d38d042e701b09faa91a24dfb95a4a1a0217123b`):
  https://github.com/BenFrohman/HODGE/pull/36

## Contents

| File | Role |
|------|------|
| `note1-residue-algebra-stage1.tex` / `.pdf` | Stage 1: 7 determinant/polynomial/derivative lemmas |
| `note2-residue-certificates-stage2.tex` / `.pdf` | Stage 2: 9 nonvanishings + 18 ℚ[X] Bézout/reduction + degree/root existence |
| `references.bib` | Shared bibliography |

Lean modules documented (not duplicated in this folder):
`Hodge/ExplicitResidueAlgebra.lean`,
`Hodge/ExplicitResidueCertificates.lean`,
`ResidueAxiomAudit.lean`.

## Proof scope

**Proved (algebra, Lean-checked):** 52 incremental theorem declarations under
standard axioms only (`propext`, `Classical.choice`, `Quot.sound`); no
`sorry` / `admit` / `native_decide` on those modules.

**Not proved:** H/G resultant (10th Python certificate), Jacobian quotient
basis, geometric ideals, Betti/Hodge/residue/cycle-class realization, general
or integral Hodge conjecture.

## Toolchain pins

- Lean: `leanprover/lean4:v4.22.0` (`lean-toolchain`)
- mathlib input: `v4.22.0` (`lakefile.toml`)
- mathlib checkout: `79e94a093aff4a60fb1b1f92d9681e407124c2ca` (`lake-manifest.json`)
- SymPy (witness generator only): `1.14.0`

## Reproduce Lean certificates

From a checkout at the mathematical pin (or any later commit whose reviewed
modules match that pin byte-for-byte):

```sh
lake exe cache get
lake build Hodge.ExplicitResidueAlgebra Hodge.ExplicitResidueCertificates
python3 scripts/check_residue_axioms.py
python3 scripts/check_no_sorry.py
# optional regeneration check:
python3 scripts/generate_residue_certificates.py
git diff --exit-code -- Hodge/ExplicitResidueCertificates.lean
```

## Rebuild these PDFs

```sh
cd paper/formalization-notes
tectonic note1-residue-algebra-stage1.tex
tectonic note2-residue-certificates-stage2.tex
```

## Verified CI at `fefe2ba` (all SUCCESS)

- Lean build/attempt: https://github.com/BenFrohman/HODGE/actions/runs/42317080169
- PR certify: https://github.com/BenFrohman/HODGE/actions/runs/42317080616
- push certify: https://github.com/BenFrohman/HODGE/actions/runs/42317075046
- paper: https://github.com/BenFrohman/HODGE/actions/runs/42317080271

Certification logs build the new modules and print
`PASS: 52 incremental theorem declarations; standard axioms only`.

## Destination and workflows

Intended repository path: `paper/formalization-notes/` (separate from
`paper/hodge_sextic/`, which is what `.github/workflows/paper.yml` builds).
Do **not** wire these notes into tag/release workflows as a publication event.
Do **not** invent a DOI or touch unrelated Zenodo drafts.

## Verified post-merge evidence

Merged source tree equals the reviewed CI head. Post-merge certificate run also passed the 52-declaration audit:
https://github.com/BenFrohman/HODGE/actions/runs/42317920400

`PROVENANCE.json` binds these manuscripts and the reviewed proof/toolchain files by SHA-256.
