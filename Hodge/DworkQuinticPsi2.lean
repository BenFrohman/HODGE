/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Mathlib.RingTheory.MvPolynomial.Homogeneous
import Mathlib.Algebra.MvPolynomial.PDeriv
import Mathlib.Tactic
import Hodge.FermatCubicHost

/-!
# Dwork-type quintic fourfold at ψ = 2:  X = V(Σ_{i≤5} xᵢ⁵ - 10·x0x1x2x3x4) ⊂ P⁵

Proven here in Lean (no `sorry`, no `native_decide`):
* `G` is homogeneous of degree 5 (`G_isHomogeneous`).
* Explicit partial derivatives at a point (`eval_pderiv`).
* **Smoothness** over any field of characteristic 0 (`smooth`): the six partials
  have no common zero except `0`. Proof: `x5⁴ = 0`; for `i ≤ 4`,
  `xᵢ⁴ = 2·∏_{j≠i, j≤4} xⱼ`; multiplying the five relations gives `P⁴ = 32·P⁴`
  with `P = x0⋯x4`, so `P = 0`; then `xᵢ⁵ = 2P = 0`. (This is the `ψ⁵ ≠ 1` argument
  for `ψ = 2`: `2⁵ = 32 ≠ 1`.)
* Hodge numbers: the Jacobian ring of a smooth quintic in six variables has Hilbert
  series `(1+t+t²+t³)⁶` (partials form a regular sequence — cited theory, not
  formalised), so `h^{3,1}=120, h^{2,2}_prim=580, h^{1,3}=120` (`dwork_primitive_hodge`,
  the arithmetic checked by `decide`). The Hilbert function of `ℚ[x]/J(G)` for this
  specific `G` was also computed by Singular (`scripts/dwork_quintic_psi2/`) and
  agrees: 1,6,21,56,120,…,580,…,120,…,1 (total 4096).

Computed outside Lean (Singular, exact over ℚ; see STATUS.md):
* X contains **no planes**: the Fano scheme of planes is empty (Gröbner basis `{1}`
  over ℚ on the two S₅-orbit representatives of Grassmannian charts).
* Character count: at least 240 primitive rational Hodge classes (eigenspaces of
  the symmetry group that are rank 1 and of type (2,2) for the whole pencil).
  Their algebraicity at ψ = 2 is **not** established here.
-/

namespace Hodge
namespace DworkQuinticPsi2

open MvPolynomial
open Hodge.FermatCubicHost (jacobianSeries primHodge)

variable {K : Type*} [Field K]

/-- `Σ_{i≤5} xᵢ⁵ - 10·x0x1x2x3x4`. -/
noncomputable def G : MvPolynomial (Fin 6) K :=
  (∑ i : Fin 6, X i ^ 5) - C 10 * (X 0 * X 1 * X 2 * X 3 * X 4)

theorem G_isHomogeneous : (G : MvPolynomial (Fin 6) K).IsHomogeneous 5 := by
  unfold G
  apply IsHomogeneous.sub
  · apply IsHomogeneous.sum
    intro i _
    exact isHomogeneous_X_pow i 5
  · have h : (X 0 * X 1 * X 2 * X 3 * X 4 : MvPolynomial (Fin 6) K).IsHomogeneous
        (1 + 1 + 1 + 1 + 1) :=
      ((((isHomogeneous_X K 0).mul (isHomogeneous_X K 1)).mul (isHomogeneous_X K 2)).mul
        (isHomogeneous_X K 3)).mul (isHomogeneous_X K 4)
    simpa using (isHomogeneous_C (Fin 6) (10 : K)).mul h

/-- The six partial derivatives, evaluated at `x`. -/
theorem eval_pderiv (x : Fin 6 → K) :
    eval x (pderiv 0 (G : MvPolynomial (Fin 6) K)) = 5 * x 0 ^ 4 - 10 * (x 1 * x 2 * x 3 * x 4) ∧
    eval x (pderiv 1 (G : MvPolynomial (Fin 6) K)) = 5 * x 1 ^ 4 - 10 * (x 0 * x 2 * x 3 * x 4) ∧
    eval x (pderiv 2 (G : MvPolynomial (Fin 6) K)) = 5 * x 2 ^ 4 - 10 * (x 0 * x 1 * x 3 * x 4) ∧
    eval x (pderiv 3 (G : MvPolynomial (Fin 6) K)) = 5 * x 3 ^ 4 - 10 * (x 0 * x 1 * x 2 * x 4) ∧
    eval x (pderiv 4 (G : MvPolynomial (Fin 6) K)) = 5 * x 4 ^ 4 - 10 * (x 0 * x 1 * x 2 * x 3) ∧
    eval x (pderiv 5 (G : MvPolynomial (Fin 6) K)) = 5 * x 5 ^ 4 := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;>
  · simp [G, Fin.sum_univ_succ, Derivation.leibniz, Derivation.leibniz_pow, pderiv_X]
    all_goals (try ring_nf)
    all_goals (try simp)

/-- Jacobian criterion: over a field of characteristic 0 the partials of `G`
vanish simultaneously only at `0`, so `V(G) ⊂ P⁵` is smooth. -/
theorem smooth [CharZero K] (x : Fin 6 → K)
    (h : ∀ i, eval x (pderiv i (G : MvPolynomial (Fin 6) K)) = 0) : x = 0 := by
  obtain ⟨e0, e1, e2, e3, e4, e5⟩ := eval_pderiv (K := K) x
  have h0 := h 0; have h1 := h 1; have h2 := h 2; have h3 := h 3; have h4 := h 4
  have h5 := h 5
  rw [e0] at h0; rw [e1] at h1; rw [e2] at h2; rw [e3] at h3; rw [e4] at h4; rw [e5] at h5
  have q0 : x 0 ^ 4 = 2 * (x 1 * x 2 * x 3 * x 4) := by linear_combination h0 / 5
  have q1 : x 1 ^ 4 = 2 * (x 0 * x 2 * x 3 * x 4) := by linear_combination h1 / 5
  have q2 : x 2 ^ 4 = 2 * (x 0 * x 1 * x 3 * x 4) := by linear_combination h2 / 5
  have q3 : x 3 ^ 4 = 2 * (x 0 * x 1 * x 2 * x 4) := by linear_combination h3 / 5
  have q4 : x 4 ^ 4 = 2 * (x 0 * x 1 * x 2 * x 3) := by linear_combination h4 / 5
  set P := x 0 * x 1 * x 2 * x 3 * x 4 with hP
  have hP4 : P ^ 4 = 32 * P ^ 4 := by
    calc P ^ 4 = x 0 ^ 4 * x 1 ^ 4 * x 2 ^ 4 * x 3 ^ 4 * x 4 ^ 4 := by rw [hP]; ring
      _ = 32 * P ^ 4 := by rw [q0, q1, q2, q3, q4, hP]; ring
  have hP0 : P = 0 := by
    have : (31 : K) * P ^ 4 = 0 := by linear_combination -hP4
    exact pow_eq_zero_iff (n := 4) (by norm_num) |>.mp
      ((mul_eq_zero.mp this).resolve_left (by norm_num))
  have z : ∀ y : K, y ^ 5 = 0 → y = 0 := fun y hy =>
    pow_eq_zero_iff (n := 5) (by norm_num) |>.mp hy
  have r0 : x 0 = 0 := z _ (by linear_combination x 0 * q0 + 2 * hP0)
  have r1 : x 1 = 0 := z _ (by linear_combination x 1 * q1 + 2 * hP0)
  have r2 : x 2 = 0 := z _ (by linear_combination x 2 * q2 + 2 * hP0)
  have r3 : x 3 = 0 := z _ (by linear_combination x 3 * q3 + 2 * hP0)
  have r4 : x 4 = 0 := z _ (by linear_combination x 4 * q4 + 2 * hP0)
  have r5 : x 5 = 0 := by
    have : x 5 ^ 4 = 0 := by linear_combination h5 / 5
    exact pow_eq_zero_iff (n := 4) (by norm_num) |>.mp this
  funext i
  fin_cases i <;> simp [r0, r1, r2, r3, r4, r5]

/-- `2⁵ ≠ 1`: ψ = 2 is not a singular value of the pencil `Σ xᵢ⁵ - 5ψ·x0⋯x4`. -/
theorem psi_not_root : (2 : ℕ) ^ 5 ≠ 1 := by decide

/-- Primitive Hodge numbers of any smooth quintic fourfold (Griffiths residues on the
Jacobian ring with Hilbert series `(1+t+t²+t³)⁶`), arithmetic checked by `decide`. -/
theorem dwork_primitive_hodge :
    primHodge 5 1 = 120 ∧ primHodge 5 2 = 580 ∧ primHodge 5 3 = 120 := by decide

end DworkQuinticPsi2
end Hodge
