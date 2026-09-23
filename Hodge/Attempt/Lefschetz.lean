/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Mathlib.LinearAlgebra.Basic

/-!
# Lefschetz operator — specification only

On a compact Kähler manifold of complex dimension `n`, the Lefschetz operator
`L` is wedge-product with the Kähler class. Hard Lefschetz says
`L^{n-k} : H^k → H^{2n-k}` is an isomorphism.

Primitive classes: `P^k = ker(L^{n-k+1} : H^k → H^{2n-k+2})`.
Lefschetz decomposition: `H^k = ⊕_j L^j P^{k-2j}`.

On a fourfold (`n = 4`):
`H^4 = P^4 ⊕ L P^2 ⊕ L² H^0`.
Extra Hodge classes of type (2,2) live in the primitive summand after the
hyperplane powers are split off. `L` does not list surfaces.

This file is not imported by `Hodge.lean`. It is not a `CycleSection`.
-/

namespace Hodge
namespace Attempt

variable {V : Type*} [AddCommGroup V] [Module ℚ V]

/-- Placeholder for `H^k(X, ℚ)` as one graded piece of a finite-dimensional space. -/
structure GradedCohomology (V : Type*) [AddCommGroup V] [Module ℚ V] where
  piece : ℤ → Submodule ℚ V

/-- Lefschetz operator of bidegree (1,1): `L : H^k → H^{k+2}`. -/
structure LefschetzOperator (H : GradedCohomology V) where
  L : V →ₗ[ℚ] V
  raises_degree :
    ∀ k : ℤ, Submodule.map L (H.piece k) ≤ H.piece (k + 2)

/-- Hard Lefschetz: `L^{n-k} : H^k → H^{2n-k}` is bijective.
Left `sorry`. Needs a compact Kähler `X` of dimension `n`. -/
def HardLefschetz (H : GradedCohomology V) (Lop : LefschetzOperator H) (n : ℤ) : Prop :=
  ∀ k : ℤ, True

theorem hard_lefschetz_theorem
    (H : GradedCohomology V) (Lop : LefschetzOperator H) (n : ℤ) :
    HardLefschetz H Lop n := by
  sorry

/-- Primitive subspace slogan `P^k = ker L^{n-k+1}` inside `H^k`. -/
def IsPrimitive (H : GradedCohomology V) (Lop : LefschetzOperator H)
    (n k : ℤ) (x : V) : Prop :=
  x ∈ H.piece k

/-- Fourfold middle degree: `H^4 = P^4 ⊕ L P^2 ⊕ L² H^0`. Slogan only. -/
theorem lefschetz_decomposition_fourfold
    (H : GradedCohomology V) (Lop : LefschetzOperator H) :
    True := by
  sorry

end Attempt
end Hodge
