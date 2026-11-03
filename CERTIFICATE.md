# Lean verification certificate — scope

CI (`.github/workflows/certify.yml`) runs `lake build` (default targets: `Hodge`, `AxiomPrint`, `HodgeAttempt`),
then `lake env lean AxiomAudit.lean`, and fails unless every audited declaration depends only on
`propext`, `Classical.choice`, `Quot.sound` (or none), and `scripts/check_no_sorry.py` finds no
`sorry`/`admit`/`native_decide`/`axiom`.

## Covered
- `Hodge` library (156 theorems).
- `AxiomPrint` library (root `AxiomPrint.lean`).
- `HodgeAttempt` sandbox library (39 theorems): `Hodge.Attempt.ClayStatement` (definitions only),
  `FermatIdentities` (3), `FermatPlanes` (9), `GenericObstructed` (1), `Grading` (6),
  `IntersectionInvariants` (4), `NamedSexticMembership` (2), `ParameterLocus` (12), `SpecialSexticMembership` (2).
  `HodgeAttempt` is a sandbox: it is **not** the Clay Hodge statement and proves no Clay result.

## Excluded
- `Hodge.Attempt.FermatRecipeScope` — does not compile as committed (missing `ℕ` notation import, and
  `decide` gets stuck on `2 ≤ offLocusGadget.codim`); in addition, its theorem
  `Hodge.Attempt.recipe_is_not_global_constructor` duplicates the declaration of the same name in
  `Hodge.Attempt.ParameterLocus` (which is certified), so it cannot be imported alongside it without renaming.
