# Authors

**Benjamin Stanley Frohman** (@BenFrohman) is the author of this repository:
core library `Hodge`, sandbox `HodgeAttempt`, and `docs/`.

Copyright (c) 2026 Benjamin Stanley Frohman.
License: Apache License 2.0 (see `LICENSE` and `NOTICE.md`).
Copies and derivatives must keep that notice and attribution.

Sister repos FermatPlanes, NoetherLefschetz, CubicFourfold, DerivedCategories:
same author, Apache-2.0.

This encoding is independent of whether the Hodge conjecture is discharged.
It is not discharged. Cite as a skeleton, not as a Clay proof.

## Frohman encoding (this repo)

- `Datum`, `HodgeConjecture`, `CycleConstructor`, `CycleSection`
- Three-island terms `classical_fourfolds` / `ClassicalFourfolds`
- Island constructions (`constructP4`, Klein pair, `constructProduct`)
- `zeroCycle` / `not_every_codim_ge_two`
- Named Fermat quartic datum (`Hodge/Fermat.lean`)
- Named derived surfaces (`Hodge/DerivedSurfaces.lean`): inventory of `O_Z`,
  `residual_not_partner` (`objectDim = 2`, not a fourfold `Y`)
- Lake target `HodgeAttempt` and the notes in `docs/`

## Shoulders (not Frohman theorems)

- W. V. D. Hodge — the conjecture
- S. Lefschetz — (1,1) theorem; hard Lefschetz
- M. Noether — Noether–Lefschetz on high-degree hypersurfaces
- H. Schubert — Schubert calculus on `Gr(2,4)` / the Klein quadric
- S. Zucker — Hodge for cubic fourfolds (citation in CubicFourfold)
- T. Shioda, Z. Ran, Aljovín–Movasati–Villaflor — Fermat Hodge cycles
- C. Voisin — surveys and integral Hodge questions
- Lean 4 and mathlib4 (Apache-2.0; see `NOTICE.md`)
