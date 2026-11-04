/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Mathlib.RingTheory.MvPolynomial.Homogeneous
import Mathlib.Algebra.MvPolynomial.PDeriv
import Mathlib.Algebra.CharZero.Lemmas

/-!
# Second host: the Fermat cubic fourfold  Y = V(x0³ + … + x5³) ⊂ P⁵

Proven here (no `sorry`):
* `F` is homogeneous of degree 3 (`F_isHomogeneous`).
* `∂F/∂xᵢ = 3·xᵢ²` (`pderiv_F`), and over any field of characteristic 0 the
  partials have no common zero except `0` (`smooth`): Y is smooth (Jacobian criterion).
* The Jacobian-ring Hilbert series coefficients, computed by list convolution
  and checked by `decide`, give the primitive Hodge numbers of a smooth cubic
  fourfold via Griffiths: h^{3,1}=R₀=1, h^{2,2}_prim=R₃=20, h^{1,3}=R₆=1
  (and, for the chain sextic, R₆=426, R₁₂=1751).

The repository's `SmoothComplexProjectiveFourfold` is opaque; this file does not
construct a term of it. Nothing here concerns `Clay.RationalHodgeCodimTwo`.
-/

namespace Hodge
namespace FermatCubicHost

open MvPolynomial

variable {K : Type*} [Field K]

/-- The Fermat cubic in six variables. -/
noncomputable def F : MvPolynomial (Fin 6) K := ∑ i : Fin 6, X i ^ 3

theorem F_isHomogeneous : (F : MvPolynomial (Fin 6) K).IsHomogeneous 3 := by
  unfold F
  apply IsHomogeneous.sum
  intro i _
  first
    | exact isHomogeneous_X_pow i 3
    | exact isHomogeneous_X_pow (R := K) i 3
    | exact (isHomogeneous_X K i).pow 3
    | exact (isHomogeneous_X (R := K) i).pow 3

theorem pderiv_F (i : Fin 6) :
    pderiv i (F : MvPolynomial (Fin 6) K) = 3 * X i ^ 2 := by
  unfold F
  rw [map_sum]
  rw [Finset.sum_eq_single i]
  · rw [Derivation.leibniz_pow, pderiv_X_self]
    simp only [nsmul_eq_mul, smul_eq_mul, mul_one]
    norm_num
  · intro j _ hji
    rw [Derivation.leibniz_pow, pderiv_X_of_ne hji]
    simp
  · intro h; exact absurd (Finset.mem_univ i) h

/-- Jacobian criterion: the partials of `F` vanish simultaneously only at `0`. -/
theorem smooth [CharZero K] (x : Fin 6 → K)
    (h : ∀ i, eval x (pderiv i (F : MvPolynomial (Fin 6) K)) = 0) : x = 0 := by
  funext i
  have hi := h i
  rw [pderiv_F] at hi
  simp only [map_mul, map_pow, eval_X] at hi
  have h3 : (eval x) (3 : MvPolynomial (Fin 6) K) = 3 := by simp
  rw [h3] at hi
  have : x i ^ 2 = 0 := (mul_eq_zero.mp hi).resolve_left (by norm_num)
  simpa using pow_eq_zero_iff (n := 2) (by norm_num) |>.mp this

/-- Coefficient list of `(1 + t + … + t^(d-2))^6`, the Hilbert series of the
Jacobian ring of a Fermat-type degree-`d` hypersurface in six variables. -/
def conv (p q : List ℕ) : List ℕ :=
  (List.range (p.length + q.length - 1)).map fun k =>
    ((List.range (k + 1)).map fun i => p.getD i 0 * q.getD (k - i) 0).sum

def jacobianSeries (d : ℕ) : List ℕ :=
  (List.range 6).foldl (fun acc _ => conv acc (List.replicate (d - 1) 1)) [1]

/-- Griffiths: `h^{4-q,q}_prim = R_{d(q+1)-6}`. -/
def primHodge (d q : ℕ) : ℕ := (jacobianSeries d).getD (d * (q + 1) - 6) 0

theorem cubic_primitive_hodge :
    primHodge 3 1 = 1 ∧ primHodge 3 2 = 20 ∧ primHodge 3 3 = 1 := by decide

theorem sextic_primitive_hodge :
    primHodge 6 1 = 426 ∧ primHodge 6 2 = 1751 ∧ primHodge 6 3 = 426 := by decide

end FermatCubicHost
end Hodge
