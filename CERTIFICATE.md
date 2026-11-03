# Lean verification certificate — scope

CI (`.github/workflows/certify.yml`) runs `lake build` (default targets: `Hodge`, `AxiomPrint`, `HodgeAttempt`),
then `lake env lean AxiomAudit.lean`, and fails unless every audited declaration depends only on
`propext`, `Classical.choice`, `Quot.sound` (or none), and `scripts/check_no_sorry.py` finds no
`sorry`/`admit`/`native_decide`/`axiom`.

## Current certificate
- Verified commit: `cb96cd49114ad142758c473a8e5f6506288e4fb7`
- Lean `v4.22.0`, Mathlib `v4.22.0`
- CI (both passed): [Lean certificate run 41728656318](https://github.com/BenFrohman/HODGE/actions/runs/41728656318), [Lean run 41728656264](https://github.com/BenFrohman/HODGE/actions/runs/41728656264)
- `AxiomAudit.lean`: **291** `#print axioms` declarations (201 source theorems + 90 Lean-generated lemmas), all standard axioms only; no `sorry`, no `native_decide`, no `axiom`.

## Covered
- `Hodge` library (250 theorem declarations).
- `AxiomPrint` library (root `AxiomPrint.lean`).
- `HodgeAttempt` sandbox library (41 theorem declarations): `Hodge.Attempt.ClayStatement` (definitions only),
  `FermatIdentities` (3), `FermatPlanes` (9), `GenericObstructed` (1), `Grading` (6),
  `IntersectionInvariants` (4), `NamedSexticMembership` (2), `ParameterLocus` (12), `SpecialSexticMembership` (2).
  `HodgeAttempt` is a sandbox: it is **not** the Clay Hodge statement and proves no Clay result.

## Excluded
- `Hodge.Attempt.FermatRecipeScope` — does not compile as committed (missing `ℕ` notation import, and
  `decide` gets stuck on `2 ≤ offLocusGadget.codim`); in addition, its theorem
  `Hodge.Attempt.recipe_is_not_global_constructor` duplicates the declaration of the same name in
  `Hodge.Attempt.ParameterLocus` (which is certified), so it cannot be imported alongside it without renaming.

## Not in the default build (not covered)
`Hodge.Chow`, `Hodge.ContainerSeparation`, `Hodge.Cubic`, `Hodge.Islands`, `Hodge.JacobianGenerators`,
`Hodge.JacobianLength`, `Hodge.KleinPairing`, `Hodge.NoShadow` are not imported by the `Hodge` root.
