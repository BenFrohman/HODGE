# Mathlib inventory (specification targets, not modules we have)

Author of this note: Benjamin Stanley Frohman (@BenFrohman).

This list names library work that would be needed to *state* Hodge
classes on a genuine Kähler scheme in Lean. None of it is a
`CycleSection`. `HodgeConjecture.general_fourfold` stays in
`Hodge/Fourfold.lean`.

## What Mathlib already has (do not invent paths)

- `Mathlib.RingTheory.Kaehler` — algebraic Kähler *differentials* `Ω[S⁄R]`, not a Kähler metric.
- `Orientation.kahler` — the 2-dimensional area form on an oriented real inner-product plane.
- `Mathlib.Geometry.Manifold` — smooth / complex manifolds, no `∂̄` complex.
- `Mathlib.AlgebraicGeometry.Scheme` — schemes; étale morphisms exist; étale *cohomology groups* do not.
- Abstract group cohomology of a `G`-module — not `H^{2p}(X_{¯K}, ℚ_ℓ)`.

There is no `Mathlib.Analysis.DifferentialGeometry.Kähler` and no
`Mathlib.AlgebraicGeometry.ÉtaleCohomology` computing those groups.

## List A — complex geometry needed to write `Hdg^p(X)`

1. Almost complex `J` on `T_ℝ M`, `J² = -id`, Nijenhuis tensor (not `True`).
2. Hermitian metric (sesquilinear, positive), `ω(X,Y) = g(JX,Y)`.
3. Kähler: `dω = 0` (not `True`).
4. `∂`, `∂̄`, metric adjoints, `Δ_d`, `Δ_∂̄`, and the identity `Δ_d = 2 Δ_∂̄` on a compact Kähler manifold.
5. Unique harmonic representative of each Dolbeault class.
6. Analytic Hodge theorem:
   `H^k_dR(X^an, ℂ) ≅ ⊕_{p+q=k} H^{p,q}(X)`.
7. Rational / integral Betti cohomology and the comparison that defines
   `Hdg^p(X) = H^{2p}(X, ℚ) ∩ H^{p,p}(X)`.
8. Higher direct images `R^k π_*` and Gauss–Manin
   `∇ : ℋ^k → ℋ^k ⊗ Ω_B` on a family — a connection on a bundle, not one endomorphism of a fixed `V`.

## List B — arithmetic analogue (Tate, not Hodge)

- Étale cohomology `H^{2p}(X_{¯K}, ℚ_ℓ)`.
- Continuous `Gal(¯K/K)`-module structure.
- Tate twist `ℚ_ℓ(p)`.
- Tate cycles = Galois invariants.
- Weight–monodromy (a separate conjecture).

List B is the Tate conjecture. It is not a translation that proves Hodge.

## Hodge numbers / Euler (when the analytic theorem exists)

- `h^{p,q} = dim_ℂ H^{p,q}`.
- `b_k = ∑_{p+q=k} h^{p,q}` (a sum, not a supremum).
- `χ(M) = ∑_k (-1)^k b_k = ∑_{p,q} (-1)^{p+q} h^{p,q}`.
- Not `χ(M) = 0`.

## What will not be filed as Mathlib PRs from this repo

Sketches under `Hodge/Attempt/` and in conversation that use dummy `True`,
`globalL2InnerProduct := 0`, `χ = 0`, or `ModelProd ℝ ℝ` atlas binders.
Those are notes. They are not upstreamable.
