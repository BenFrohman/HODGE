# Degree-five independence and a nonzero actual Jacobian class

Author: Benjamin Stanley Frohman (Frohman, Benjamin Stanley) <frohmanbenjamin@gmail.com>.
Affiliation: Independent Researcher, Texas, United States. Version 1.1, 10 November 2026.
Copyright (c) 2026 Benjamin Stanley Frohman. Existing Apache-2.0 license unchanged.
Published v1.1: DOI [10.5281/zenodo.24145349](https://doi.org/10.5281/zenodo.24145349) (11 November 2026;
source pinned to `4c768890dc88bc180bf10887e4ba1b426f33a41a`; paper files CC BY 4.0 on Zenodo).

Code commit: `52325b02f966139c99015443ca5fba8a725ef3bb` (PR #49, on `main` `b13f57f`; first prepared on `e56be3d`).
CI: https://github.com/BenFrohman/HODGE/actions/runs/42922528702 (certify, pass: 78/78 standard axioms)
and https://github.com/BenFrohman/HODGE/actions/runs/42922528652 (build + sorry scan, pass).
One-command rebuild: `lake exe cache get && lake build && python3 scripts/check_residue_axioms.py`.
The separate [paper source](main.tex) and [three-page PDF](main.pdf) concern this
specific algebraic milestone, not geometric Hodge or cycle-class assertions.

## Lean hypotheses versus the note's assumptions

| Lean declaration | Lean hypotheses | Assumption stated in the note | Match |
|---|---|---|---|
| `jacobian_ideal_coefficient_constraints` | `[CommRing K]`, `p ∈ jacobianIdeal k` | Lemma 1: any commutative ring, `p` in the full ideal | exact |
| `representative_mem_ideal_iff`, `degreeFiveClasses_linearIndependent` | `[Field K]`, `k ≠ 0` | Theorem 1: field, `k ≠ 0` | exact |
| `section_HW_class_ne_zero` | `[Field K] [CharZero K] [Algebra ℚ K]`, `P(k) = 0` | Theorem 2: char-0 field, `k` a root of `P` | exact (the ℚ-structure is unique) |
| `exists_complex_nonzero_HW_class` | none | non-vacuity: a complex root with `[HW] ≠ 0` | exact |

No hypothesis restates its conclusion, and every hypothesis set is inhabited (`k = 1` over ℚ;
the complex root above). No mismatch was found.

## Established result

In `K[x,y]/(5*k*x^4*y, k*x^5+6*y^5)`, the classes of `y^5`, `x*y^4`,
`x^2*y^3`, and `x^3*y^2` are linearly independent over every field `K` when
`k != 0`. No basis or quotient-nontriviality premise is assumed.

For arbitrary ideal multipliers, the degree-five coefficient functionals

    L0(p) = k*coeff_(0,5)(p) - 6*coeff_(5,0)(p)
    Li(p) = coeff_(i,5-i)(p), i = 1,2,3

annihilate the FULL ideal. The `x^5` term and minus sign in L0 implement the
actual relation `k*x^5+6*y^5`; taking the raw y^5 coefficient would be wrong.
On the four-term representative these give `k*c0,c1,c2,c3`, proving independence.

For the original characteristic-zero Q-algebra field and original modulus-root
hypothesis, the actual Stage3 `section_HW_class` identity and Stage2 exact
`u0_ne_zero` certificate now imply that the actual quotient image of `H*W` is
nonzero. An actual complex root carrying a nonzero image also exists.

Principal declarations in `Hodge.ExplicitJacobianIndependence`:

- `jacobian_ideal_coefficient_constraints`
- `representative_mem_ideal_iff`
- `degreeFiveClasses_linearIndependent`
- `section_HW_class_ne_zero`
- `exists_complex_nonzero_HW_class`

There are 13 new named theorems, all in the ordered incremental axiom audit.
Neither a spanning theorem for the degree-five component nor a basis of the
entire quotient is claimed. Geometric realization, residue-to-cohomology,
Hodge-type identification, cycle classes and descent remain separate obligations.

## Reproduce

Use `lean-toolchain` (Lean 4.22.0) and the unchanged exact package revisions in
`lake-manifest.json` (Mathlib `79e94a093aff4a60fb1b1f92d9681e407124c2ca`).
From the repository root, with the existing pinned cache available:

```sh
lake build
python3 scripts/check_residue_axioms.py
python3 scripts/check_no_sorry.py
lake env lean AxiomAudit.lean
fresh=$(mktemp -d)
lake env lean -o "$fresh/ExplicitJacobianIndependence.olean" Hodge/ExplicitJacobianIndependence.lean
tectonic --only-cached --untrusted milestones/degree-five-independence/main.tex
```

Full default cached build, fresh new-module source elaboration, existing root
axiom audit, ordered incremental audit (78 declarations across four modules),
and the no-sorry/admit/native_decide/axiom-declaration scan passed locally.
All nine dependency HEADs match their pins and tracked dependency sources are
clean. No clean dependency rebuild, upgrade or new download was performed.

The no-sorry scanner examines Git-tracked Lean paths. In a source-only archive,
initialize a local index containing the supplied project Lean files if using
that scanner; it does not require a commit or remote. The local verification
index included the new module as well as every baseline tracked Lean file.

The review evidence bundle supplies exact versions, proof sources, logs,
per-theorem axiom prints, compiled project artifacts, notices and hash manifests.
It is not a standalone independently trusted proof certificate. Rebuilding the
sources requires Lean and the pinned dependency artifacts; an axiom audit proves
neither geometric semantic correctness nor mathematical novelty.
