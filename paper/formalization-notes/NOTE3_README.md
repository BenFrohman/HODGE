<!-- Copyright (c) 2026 Benjamin Stanley Frohman. Licensed under Apache-2.0. -->
# Stage 3 formalization note, version 1.1

Author: Benjamin Stanley Frohman (metadata form: Frohman, Benjamin Stanley)
Affiliation: Independent Researcher, Texas, United States
Email: frohmanbenjamin@gmail.com · ORCID: https://orcid.org/0009-0006-7068-3718
License: Apache-2.0. Preprint, not peer reviewed. No DOI assigned yet.

## Source and versions

- Module: `Hodge/ExplicitJacobianQuotient.lean` (13 theorems), full source in this repository.
- Introduced at `e56be3d0e848c2098f1d9057dccec324f34bae7f` (PR #38); byte-identical on `main`
  `b13f57f` and at `52325b02f966139c99015443ca5fba8a725ef3bb` (PR #49), where it was re-checked.
- Lean `leanprover/lean4:v4.22.0`; Mathlib `v4.22.0` = `79e94a093aff4a60fb1b1f92d9681e407124c2ca`.
- One-command rebuild: `lake exe cache get && lake build && python3 scripts/check_residue_axioms.py`
- CI evidence: certify run https://github.com/BenFrohman/HODGE/actions/runs/42922528702 (pass:
  `PASS: 78 incremental theorem declarations; standard axioms only`, root audit 699/699);
  build + sorry scan https://github.com/BenFrohman/HODGE/actions/runs/42922528652 (pass).
- Paper: `note3-jacobian-quotient-stage3.tex` / `.pdf` (7 pages).

## Lean hypotheses versus the note's assumptions

| Lean declaration | Lean hypotheses | Assumption stated in the note | Match |
|---|---|---|---|
| `partial_x`, `partial_y`, `partial_x_class`, `partial_y_class` | `[CommRing K]`, `k : K` | Thms 5–6: commutative ring, any `k` | exact |
| `constant_inverse` | `[Field K]`, `a ≠ 0` | Lemma 7: field, `a ≠ 0` | exact |
| `x4y_class`, `y6_class` | `[Field K] [CharZero K]`, `k ≠ 0` | Thm 8: char-0 field, `k ≠ 0` | exact |
| `wronskian_polynomial`, `wronskian_class`, `sectionH_class` | `[Field K] [CharZero K] [Algebra ℚ K]` | Thms 9–10: char-0 field with a ℚ-algebra structure | exact (the ℚ-structure is unique) |
| `section_HW_class`, `section_identity_polynomial` | as above + `hm : P(k) = 0` | Thms 11–12: same + `k` a root of the modulus (eq:mod) | exact |
| `section_common_zero` | as above + `H(a,b) = 0`, `G(a,b) = 0` for `a b : K` | Thm 13: common zero with coordinates in `K` | exact |

Non-vacuity: `hm` is satisfiable. `ExplicitResidueCertificates.exists_complex_nonvanishing`
gives a complex root, and `ExplicitJacobianIndependence.exists_complex_nonzero_HW_class`
gives one with `[HW] ≠ 0`. No hypothesis restates a conclusion. No mismatch was found.

## Scope

**Proved:** the 13 theorems above: partials, quotient relations, the Wronskian and `[HW]`
representatives, `G² − H³ = f_k` in `K[x,y]`, and the common-zero exclusion.

**Proved separately (degree-five milestone, `milestones/degree-five-independence/`):** the four
degree-five classes are independent, so `[HW] ≠ 0`.

**Not proved:** the Sylvester resultant identification, a basis or dimension of the whole
quotient, schemes, and any residue/cohomology/Hodge-type/cycle-class/descent statement.
Kernel checks do not establish geometric statements.

## Rebuild the PDF

```sh
cd paper/formalization-notes && tectonic note3-jacobian-quotient-stage3.tex
```
