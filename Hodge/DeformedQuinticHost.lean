/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Mathlib.RingTheory.MvPolynomial.Homogeneous
import Mathlib.Algebra.MvPolynomial.PDeriv
import Mathlib.Tactic

/-!
# The deformed quintic  V(Σ xᵢ⁵ - 5·x0x1x2x3x4) ⊂ P⁵ is SINGULAR

Proven here (no `sorry`, no `native_decide`):
* `G` is homogeneous of degree 5 (`G_isHomogeneous`).
* The point `p = [1:1:1:1:1:0]` lies on `V(G)` and every partial derivative of `G`
  vanishes there (`singular_at_p`), so the Jacobian criterion fails (`not_smooth`):
  `V(G)` is **not smooth**, and the smooth-host Griffiths/Hodge-number machinery
  does not apply to it.

This is the Dwork-type pencil `Σ xᵢ⁵ - 5ψ·x0⋯x4` at `ψ = 1`, where `ψ⁵ = 1`.
Nearest smooth member proven in this repository: `ψ = 0`, the Fermat quintic
(`Hodge.QuinticHost`). Smoothness for other `ψ` with `ψ⁵ ≠ 1` is not proven here.
-/

namespace Hodge
namespace DeformedQuinticHost

open MvPolynomial

variable {K : Type*} [Field K]

/-- The deformed quintic `Σ_{i≤5} xᵢ⁵ - 5·x0x1x2x3x4` (constant written `C 5`). -/
noncomputable def G : MvPolynomial (Fin 6) K :=
  (∑ i : Fin 6, X i ^ 5) - C 5 * (X 0 * X 1 * X 2 * X 3 * X 4)

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
    simpa using (isHomogeneous_C (Fin 6) (5 : K)).mul h

/-- The singular point `[1:1:1:1:1:0]`. -/
def p : Fin 6 → K := ![1, 1, 1, 1, 1, 0]

theorem singular_at_p :
    eval (p : Fin 6 → K) G = 0 ∧
      ∀ i, eval (p : Fin 6 → K) (pderiv i (G : MvPolynomial (Fin 6) K)) = 0 := by
  refine ⟨?_, ?_⟩
  · simp [G, p, Fin.sum_univ_succ]; norm_num
  · intro i
    fin_cases i <;>
      simp [G, p, Fin.sum_univ_succ, Derivation.leibniz, Derivation.leibniz_pow,
        pderiv_X]

theorem not_smooth : ¬ ∀ x : Fin 6 → K,
    (∀ i, eval x (pderiv i (G : MvPolynomial (Fin 6) K)) = 0) → x = 0 := by
  intro h
  have := congrFun (h p singular_at_p.2) 0
  simp [p] at this

end DeformedQuinticHost
end Hodge
