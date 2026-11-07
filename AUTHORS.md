# Authors

**Frohman, Benjamin Stanley** (@BenFrohman) is credited for original contributions to this repository:
core library `Hodge`, sandbox `HodgeAttempt`, axiom-print root `AxiomPrint`, and `docs/`.

Copyright (c) 2026 Benjamin Stanley Frohman.
License: Apache License 2.0 (see `LICENSE` and `NOTICE`).
SPDX-License-Identifier: Apache-2.0
Redistribution obligations are governed by `LICENSE`; preserve applicable
third-party notices rather than attributing their work to this author.

Sister repos FermatPlanes, NoetherLefschetz, CubicFourfold, DerivedCategories:
same author, Apache-2.0.

This encoding is independent of whether the Hodge conjecture is discharged.
The full geometric statement is not discharged in Lean. Cite the abstract
interface, classical manuscript, and incremental polynomial proofs according to
their distinct scopes, never as a Clay proof.

## Frohman encoding (this repo)

- `Datum`, `HodgeConjecture`, `CycleConstructor`, `CycleSection`
- Three-island terms `classical_fourfolds` / `ClassicalFourfolds`
- Island constructions (`constructP4`, Klein pair, `constructProduct`)
- `zeroCycle` / `not_every_codim_ge_two`
- Named Fermat quartic datum (`Hodge/Fermat.lean`)
- Named derived surfaces (`Hodge/DerivedSurfaces.lean`): inventory of `O_Z`,
  `residual_not_partner` (`objectDim = 2`, not a fourfold `Y`)
- Lake target `HodgeAttempt` and the notes in `docs/`
- Lake target `AxiomPrint`: axiom prints for `GlobalClayFourfold`,
  `fermat_pair_vanishing`, and `fermat_quartic_contains_Z1`

## Shoulders (not Frohman theorems)

- W. V. D. Hodge — the conjecture
- S. Lefschetz — (1,1) theorem; hard Lefschetz
- M. Noether — Noether–Lefschetz on high-degree hypersurfaces
- H. Schubert — Schubert calculus on `Gr(2,4)` / the Klein quadric
- S. Zucker — Hodge for cubic fourfolds (citation in CubicFourfold)
- T. Shioda, Z. Ran, Aljovín–Movasati–Villaflor — Fermat Hodge cycles
- C. Voisin — surveys and integral Hodge questions
- Lean 4 and mathlib4 (Apache-2.0; see `NOTICE`)

- R. Villaflor Loyola — the cited complete-intersection cycle-class formula
