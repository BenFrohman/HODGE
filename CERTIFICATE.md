# Lean verification certificate — scope

CI (`.github/workflows/certify.yml`, job `certify`, workflow "Lean certificate") runs on every push and pull request:

1. `lake build` of the default targets `Hodge`, `AxiomPrint`, `HodgeAttempt`;
2. `lake env lean AxiomAudit.lean`, and fails unless every `#print axioms` line reports only
   `propext`, `Classical.choice`, `Quot.sound` (or no axioms) and the output contains no error or
   `declaration uses 'sorry'` warning;
3. `scripts/check_no_sorry.py`: fails on any `sorry`/`admit`/`native_decide` or `axiom` declaration in any
   tracked `.lean` file;
4. `scripts/explicit_projection_certificate.py` (exact sympy certificate) and `scripts/check_residue_axioms.py`
   (builds the incremental residue modules and audits `ResidueAxiomAudit.lean`).

Every successful run uploads the artifact **`axiom-certificate-<audited commit SHA>`** (90-day retention):
raw and line-joined `AxiomAudit.lean` output, the standard-axiom count, the no-sorry output, the residue audit,
the projection certificate, `METADATA.txt` (audited commit, run URL, Lean/Lake/Mathlib versions) and
`SHA256SUMS`. For pull-request runs the audited commit is GitHub's PR merge commit; `METADATA.txt` also
records the PR head commit. CI regenerates this artifact for every later commit; this file pins one.

## Current certificate
- Verified commit: `51b907c256153994b5b71fb4abc71d8711c442c0` (main, merge of PR #52, 2026-11-16 12:32 PM CT).
  This certificate was written on a branch based on that commit, so it cannot cite its own later merge commit.
- Lean `v4.22.0` (`ba2cbbf09d4978f416e0ebd1fceeebc2c4138c05`), Mathlib `v4.22.0` (`79e94a093aff4a60fb1b1f92d9681e407124c2ca`).
- CI on that commit (both passed):
  [Lean certificate run 43929872589](https://github.com/BenFrohman/HODGE/actions/runs/43929872589) (12:32–12:44 PM CT),
  [Lean run 43929872675](https://github.com/BenFrohman/HODGE/actions/runs/43929872675).
  The "Lean header" check failed on that commit only because `Hodge/GeometricCycleClass.lean` lacked the standard
  copyright/Authors lines; the comment-only fix lands with this certificate.
- `AxiomAudit.lean`: **750** `#print axioms` declarations; CI log line:
  `audited 750 declarations, 750 with standard axioms only`. Breakdown of the 750 results:
  160 no axioms, 80 `[propext]`, 41 `[propext, Quot.sound]`, 1 `[Classical.choice]`,
  468 `[propext, Classical.choice, Quot.sound]`.
- `check_no_sorry.py`: `OK: no sorry/admit/native_decide, no axiom declarations`.
- `ResidueAxiomAudit.lean`: `PASS: 78 incremental theorem declarations; standard axioms only`.
- Audit output committed in the repository:
  [`certificates/axiom-audit-51b907c256153994b5b71fb4abc71d8711c442c0.txt`](certificates/axiom-audit-51b907c256153994b5b71fb4abc71d8711c442c0.txt),
  sha256 `6b42d2e899eb43f5da16edd3e5b46eef2ce8650c692cec81deee6e6e7b4c9bca`
  (the "Axiom audit" step output of run 43929872589, timestamps removed).
- History: the previous certificate cited `fc6ad09` with 348 declarations. Main `93fd178` (merge of PR #51) audited
  747 ([run 43157359818](https://github.com/BenFrohman/HODGE/actions/runs/43157359818)); the 750 above are exactly those
  747 plus the three `Hodge.GeometricCycleClass` declarations.

## Covered
All 78 modules built by `lake build` in run 43929872589 (the import closure of `Hodge`, `HodgeAttempt`,
`AxiomPrint`); `AxiomAudit.lean` imports the roots, so the audit runs against all of them.

- `Hodge` library: `Basic`, `Frontier`, `Integral`, `Known`, `Examples`, `Fourfold`, `Classical`, `Klein`, `KleinPairing`,
  `Geometry`, `Construct`, `Fermat`, `FermatPlanes`, `FermatQuintic`, `FermatCubicHost`, `QuinticHost`,
  `DeformedQuinticHost`, `DworkQuinticPsi2`, `HostSplit`, `HonestHosts`, `SpecialSextic`, `SpecialSexticMembership`,
  `SpecialSexticJacobian`, `PlaneSpanPairing`, `HeadPlane`, `Hassett`, `NamedFamilies`, `SexticModuli`,
  `SexticCombinatorics`, `SexticCertificates`, `ExplicitCurve`, `DerivedSurfaces`, `Clay`, `ClayTerm`, `ClayStatement`,
  `Release`, `Verify`, `RealClose`, `Skeleton`, `Chow`, `ContainerSeparation`, `Cubic`, `Islands`, `JacobianLength`,
  `NoShadow`, `AlgebraicSpanChecks`, `VacuityAudit`, `ChainSexticRank`, `ChainSexticRho`, `ChainSexticBridgeAudit`,
  `ChainSexticR12`, `ChainSexticR12Bridge`, `ChainSexticCharacterCore`, `ChainSexticCharacterModel` and
  `ChainSexticCharacterModel/{Space, Roots, Lines, Indep, GaloisMin, Bridge}`, `GeometricCycleClass`,
  `ExplicitResidueAlgebra`, `ExplicitResidueCertificates`, `ExplicitJacobianQuotient`, `ExplicitJacobianIndependence`.
- `AxiomPrint` (root `AxiomPrint.lean`).
- `HodgeAttempt` sandbox: `Hodge.Attempt.{ClayStatement, FermatIdentities, FermatPlanes, GenericObstructed, Grading,
  IntersectionInvariants, NamedSexticMembership, ParameterLocus, SpecialSexticMembership, VacuityAudit}`.
  `HodgeAttempt` is a sandbox: it is **not** the Clay Hodge statement and proves no Clay result.

Key audited results (each line is in `AxiomAudit.lean` and in the committed audit output):
- `Hodge.ChainSexticCharacterModel.finrank_modelH`, `finrank_denseH` (`finrank ℚ ModelH = 27001`, `finrank ℚ DenseH = 27001`),
  `finrank_eq_of_equivDense`; `equivDense : ModelH ≃ₗ[ℚ] DenseH` is a definition, checked through the theorems that use it.
- `Hodge.ChainSexticCharacterModel.characterCore_model_rho`, `characterCore_dense_rho` (`rho = 786`) and
  `characterCore_model_finrank`, `characterCore_dense_finrank`; `characterCore_model` / `characterCore_dense` are the
  explicit inhabitants of `ChainSexticCharacterCore` on `ModelH` / `DenseH`.
- `Hodge.ChainSexticCore.ChainSexticCharacterCore.rho_eq_786`, `Hodge.ChainSexticCore.ChainSexticCharacterGalois.rho_eq_786`,
  `Hodge.ChainSexticRho.ChainSexticCharacterBridge.rho_eq_786`.
- `Hodge.GeometricCycleClass.cycleClassMap`, `algebraic_le_hodge`, `hodgeConjecture_iff_hasSection`.

## Excluded (not in the default build targets, not audited)
Re-checked with `lake env lean <file>` in CI ([run 43932188379](https://github.com/BenFrohman/HODGE/actions/runs/43932188379),
artifact `excluded-status.txt`):
- `Hodge.Attempt.FermatRecipeScope` — still does not compile: `failed to synthesize OfNat ℕ 2` (line 31; the file has no
  imports) and `decide` gets stuck on `2 ≤ offLocusGadget.codim` (line 37). Its theorem
  `Hodge.Attempt.recipe_is_not_global_constructor` also duplicates the certified declaration of that name in
  `Hodge.Attempt.ParameterLocus`.
- `Hodge.JacobianGenerators` — compiles on its own (unused-variable warnings only), but all 14 of its declarations
  redeclare, in the same namespace `Hodge.SpecialSextic`, the declarations of `Hodge.SpecialSexticJacobian` (certified),
  so it cannot be imported alongside it.
- `drafts/OpenCase.lean` — the original `Hodge.OpenCase` skeleton, moved unchanged (`git mv`). It does not compile:
  its goal `∃ z, X.cl z = γ` is left unsolved (placeholder `?z_of`). That goal cannot be closed, because
  `ExtraRational22` is false for the abstract structure `Fourfold`: the rebuilt module `Hodge.OpenCase` (now in the
  default build and in `AxiomAudit.lean`) proves `OpenCase.not_extraRational22 : ¬ OpenCase.ExtraRational22` with a
  record that has no cycles and one extra class. This refutes only that abstract formulation; it says nothing about
  the Hodge conjecture for any variety.
- `ResidueAxiomAudit.lean` and `AxiomAudit.lean` are audit scripts, run by CI as described above, not library modules.

## Scope (what the certificate does and does not say)
- It certifies that the Lean kernel accepted every audited **Lean statement** with only the three standard axioms.
  It says nothing about whether a Lean statement matches a mathematical claim beyond what the statement itself says.
- Lefschetz (1,1), hard Lefschetz, the Hodge conjecture, the cycle class map and the geometric bridge facts are
  **hypotheses / `Prop`s / structure fields** in Lean, not theorems. `Hodge.GeometricCycleClass` proves
  `algebraicClasses ≤ hodgeClasses` from the supplied field `fund_isHodge`; the reverse inclusion is the open
  conjecture, stated as `HodgeConjecture`, and no inhabitant of `GeometricCycleClassData` is constructed.
- `ChainSexticCharacterGalois` is not inhabited anywhere in the repository; its `rho_eq_786` is conditional on its fields.
- `ModelH` / `DenseH` (dimension 27001) are a linear-algebra model, not the cohomology of the sextic; `rho = 786` is
  proved for that model and for the abstract hypothesis packages, not for the geometric variety.

## Lean ↔ paper
The paper's appendix lists, for each claim of the body with a Lean counterpart, the exact Lean statement.
