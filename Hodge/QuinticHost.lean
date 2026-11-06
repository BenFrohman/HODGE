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
# Third host: the Fermat quintic fourfold  Y = V(x0⁵ + … + x5⁵) ⊂ P⁵

Proven here (no `sorry`, no `native_decide`):
* `G` is homogeneous of degree 5 (`G_isHomogeneous`).
* `∂G/∂xᵢ = 5·xᵢ⁴` (`pderiv_G`), and over any field of characteristic 0 the
  partials have no common zero except `0` (`smooth`): Y is smooth (Jacobian criterion).
* Jacobian ring Hilbert series `((1-t⁴)/(1-t))⁶`, computed by list convolution and
  checked by `decide`; Griffiths `h^{4-q,q}_prim = R_{5(q+1)-6}` gives
  h^{3,1}=R₄=120, h^{2,2}_prim=R₉=580, h^{1,3}=R₁₄=120 (sum 820 = (4⁶+4)/5), and h^{4,0}=0 because
  the required degree 5·1-6 is negative.

Note: the earlier proposal `Σ xᵢ⁵ - 5·x0⋯x5` is not homogeneous (the product
term has degree 6), so it does not define a hypersurface in P⁵. Also h^{3,1} ≠ 0
for degree 5; only h^{4,0} vanishes.

The repository's `SmoothComplexProjectiveFourfold` is opaque; this file does not
construct a term of it. Nothing here concerns `Clay.RationalHodgeCodimTwo`.
-/

namespace Hodge
namespace QuinticHost

open MvPolynomial
open Hodge.FermatCubicHost (jacobianSeries primHodge)

variable {K : Type*} [Field K]

/-- The Fermat quintic in six variables. -/
noncomputable def G : MvPolynomial (Fin 6) K := ∑ i : Fin 6, X i ^ 5

theorem G_isHomogeneous : (G : MvPolynomial (Fin 6) K).IsHomogeneous 5 := by
  unfold G
  apply IsHomogeneous.sum
  intro i _
  exact isHomogeneous_X_pow i 5

theorem pderiv_G (i : Fin 6) :
    pderiv i (G : MvPolynomial (Fin 6) K) = 5 * X i ^ 4 := by
  unfold G
  rw [map_sum]
  rw [Finset.sum_eq_single i]
  · rw [Derivation.leibniz_pow, pderiv_X_self]
    simp only [nsmul_eq_mul, smul_eq_mul, mul_one]
    norm_num
  · intro j _ hji
    rw [Derivation.leibniz_pow, pderiv_X_of_ne hji]
    simp
  · intro h; exact absurd (Finset.mem_univ i) h

/-- Jacobian criterion: the partials of `G` vanish simultaneously only at `0`. -/
theorem smooth [CharZero K] (x : Fin 6 → K)
    (h : ∀ i, eval x (pderiv i (G : MvPolynomial (Fin 6) K)) = 0) : x = 0 := by
  funext i
  have hi := h i
  rw [pderiv_G] at hi
  simp only [map_mul, map_pow, eval_X] at hi
  have h5 : (eval x) (5 : MvPolynomial (Fin 6) K) = 5 := by simp
  rw [h5] at hi
  have : x i ^ 4 = 0 := (mul_eq_zero.mp hi).resolve_left (by norm_num)
  simpa using pow_eq_zero_iff (n := 4) (by norm_num) |>.mp this

/-- The Hilbert series of the Jacobian ring `(1+t+t²+t³)⁶`: degree 18, total 4⁶. -/
theorem quintic_series :
    (jacobianSeries 5).length = 19 ∧ (jacobianSeries 5).sum = 4096 := by decide

theorem quintic_primitive_hodge :
    primHodge 5 1 = 120 ∧ primHodge 5 2 = 580 ∧ primHodge 5 3 = 120 := by decide

/-- `h^{4,0} = 0`: the Griffiths degree `5·(0+1)` is below `6`, so `R_{-1} = 0`. -/
theorem quintic_h40_zero : 5 * (0 + 1) < 6 := by decide

/-- Regression: the counting function itself returns zero at the negative degree. -/
theorem quintic_primHodge_h40_zero : primHodge 5 0 = 0 := by decide

/-- The conjugate boundary is beyond the socle, in degree 19. -/
theorem quintic_primHodge_h04_zero : primHodge 5 4 = 0 := by decide

/-- `h^{3,1} ≠ 0` for degree 5. -/
theorem quintic_h31_ne_zero : primHodge 5 1 ≠ 0 := by decide

end QuinticHost
end Hodge
