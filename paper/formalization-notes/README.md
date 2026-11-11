<!-- Copyright (c) 2026 Benjamin Stanley Frohman. Licensed under Apache-2.0. -->
# Formalization notes

Author metadata: **Frohman, Benjamin Stanley**
Email: frohmanbenjamin@gmail.com
ORCID: https://orcid.org/0009-0006-7068-3718
License: Apache-2.0 (same as repository root `LICENSE` / `NOTICE`; no relicense)

**Status (checked live on Zenodo, 11 November 2026):** all three notes are published on Zenodo
as preprints. The Zenodo records license the paper files CC BY 4.0. The code in this repository
stays Apache-2.0.
- Stage 1: v1 [10.5281/zenodo.24025148](https://doi.org/10.5281/zenodo.24025148), v2 (correction)
  [10.5281/zenodo.24082011](https://doi.org/10.5281/zenodo.24082011); concept DOI `10.5281/zenodo.24025147`.
- Stage 2: v1 [10.5281/zenodo.24025150](https://doi.org/10.5281/zenodo.24025150), v2 (correction)
  [10.5281/zenodo.24082012](https://doi.org/10.5281/zenodo.24082012); concept DOI `10.5281/zenodo.24025149`.
- Stage 3 (v1.1): [10.5281/zenodo.24145347](https://doi.org/10.5281/zenodo.24145347), source pinned to `4c76889`.
- Degree-five milestone (v1.1, `milestones/degree-five-independence/`):
  [10.5281/zenodo.24145349](https://doi.org/10.5281/zenodo.24145349), source pinned to `4c76889`.

The earlier wording here called the Stage 1 and 2 DOIs "reserved; unpublished". That is out of date.
Not peer review; not a Clay/Hodge geometric close.

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
The DOIs above are published records (see Status). Do not touch unrelated Zenodo drafts
(including 24024593).

## Verified post-merge evidence

Merged source tree equals the reviewed CI head. Post-merge certificate run also passed the 52-declaration audit:
https://github.com/BenFrohman/HODGE/actions/runs/42317920400

`PROVENANCE.json` binds these manuscripts and the reviewed proof/toolchain files by SHA-256.

## Repository integration facts (DOI update packaging)

- Papers merged via PR #37 at `82a630d110dd80cdebcb708ecbd150d7c41ac473`.
- Current main tip at packaging: `9289b3c6ae3f2f3ef616493737c113a09c255330` (includes Stage 3 Lean proof); these Stage 1/2 notes still document only the 7+45=52 declaration scope pinned at `e207394…`.
- Mathematical pins and Lean proof-run references in the TeX bodies are preserved.

## Stage 3 companion (separate provenance)

Stage 3 Jacobian-quotient note ships alongside this DOI update:
`note3-jacobian-quotient-stage3.tex`/`.pdf`, documented in `NOTE3_README.md`
and `NOTE3_PROVENANCE.json` (mathematical pin `e56be3d…`; merge tip `9289b3c…`).
Stage 3 v1.1 is published as 10.5281/zenodo.24145347. Stage 1/2 `PROVENANCE.json` above is not
overwritten by Note3 hashes.
