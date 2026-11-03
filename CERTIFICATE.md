# Lean verification certificate — scope

CI (`.github/workflows/certify.yml`) runs `lake build` (default targets: `Hodge`, `AxiomPrint`, `HodgeAttempt`),
then `lake env lean AxiomAudit.lean`, and fails unless every audited declaration depends only on
`propext`, `Classical.choice`, `Quot.sound` (or none), and `scripts/check_no_sorry.py` finds no
`sorry`/`admit`/`native_decide`/`axiom`.

## Current certificate
- Verified commit: `fc6ad0982a118a824c554001ee4ad10bf401766c`
- Lean `v4.22.0`, Mathlib `v4.22.0`
- CI (both passed): [Lean certificate run 41731467848](https://github.com/BenFrohman/HODGE/actions/runs/41731467848), [Lean run 41731468054](https://github.com/BenFrohman/HODGE/actions/runs/41731468054)
- `AxiomAudit.lean`: **348** `#print axioms` declarations (238 source theorems + 110 Lean-generated lemmas), all standard axioms only; no `sorry`, no `native_decide`, no `axiom`.

## Covered
- `Hodge` library (307 theorem declarations), including `Hodge.Chow`, `ContainerSeparation`, `Cubic`, `Islands`,
  `JacobianLength`, `KleinPairing`, `NoShadow` (imported from the `Hodge` root since v1.1.2).
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

- `Hodge.JacobianGenerators` — redeclares, with identical names and statements, the declarations of
  `Hodge.SpecialSexticJacobian` (certified), so it cannot be imported alongside it.

## Lean ↔ paper
The paper's appendix lists, for each claim of the body with a Lean counterpart, the exact Lean statement.
Lefschetz (1,1), hard Lefschetz and the Hodge conjecture are only hypotheses/`Prop`s in Lean, not theorems.
