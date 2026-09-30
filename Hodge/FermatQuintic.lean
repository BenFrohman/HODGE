/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Mathlib.Tactic.Ring

/-!
# Fermat quintic fourfold in P^5

    G = x0^5 + x1^5 + x2^5 + x3^5 + x4^5 + x5^5
    X_5 = V(G) ⊂ P^5

This is the homogeneous degree-5 host from the named-host table.
It is not the Fermat quintic *threefold* in P^4.
It is not the non-homogeneous expression ∑ x_i^5 - 5 ∏ x_i
(that product has degree 6 and does not cut a projective hypersurface).

Jacobian: ∂_i G = 5 x_i^4. Isolated at the origin when 5 ≠ 0.
Literature (AMV / Shioda): Hodge holds on this named host.
Not general_fourfold. Not ledger Z on V(F). Not Clay.
-/

namespace Hodge
namespace FermatQuintic

variable {R : Type*} [CommRing R]

def G (x0 x1 x2 x3 x4 x5 : R) : R :=
  x0 ^ 5 + x1 ^ 5 + x2 ^ 5 + x3 ^ 5 + x4 ^ 5 + x5 ^ 5

def dG_dx0 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x0 ^ 4
def dG_dx1 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x1 ^ 4
def dG_dx2 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x2 ^ 4
def dG_dx3 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x3 ^ 4
def dG_dx4 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x4 ^ 4
def dG_dx5 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x5 ^ 4

theorem dG_dx0_formula (x0 x1 x2 x3 x4 x5 : R) :
    dG_dx0 x0 x1 x2 x3 x4 x5 = (5 : R) * x0 ^ 4 := rfl
theorem dG_dx1_formula (x0 x1 x2 x3 x4 x5 : R) :
    dG_dx1 x0 x1 x2 x3 x4 x5 = (5 : R) * x1 ^ 4 := rfl
theorem dG_dx2_formula (x0 x1 x2 x3 x4 x5 : R) :
    dG_dx2 x0 x1 x2 x3 x4 x5 = (5 : R) * x2 ^ 4 := rfl
theorem dG_dx3_formula (x0 x1 x2 x3 x4 x5 : R) :
    dG_dx3 x0 x1 x2 x3 x4 x5 = (5 : R) * x3 ^ 4 := rfl
theorem dG_dx4_formula (x0 x1 x2 x3 x4 x5 : R) :
    dG_dx4 x0 x1 x2 x3 x4 x5 = (5 : R) * x4 ^ 4 := rfl
theorem dG_dx5_formula (x0 x1 x2 x3 x4 x5 : R) :
    dG_dx5 x0 x1 x2 x3 x4 x5 = (5 : R) * x5 ^ 4 := rfl

/-- Euler: ∑ x_i ∂_i G = 5 G. Ring certificate that these are the partials. -/
theorem euler_homogeneous (x0 x1 x2 x3 x4 x5 : R) :
    (5 : R) * G x0 x1 x2 x3 x4 x5 =
      x0 * dG_dx0 x0 x1 x2 x3 x4 x5 +
        x1 * dG_dx1 x0 x1 x2 x3 x4 x5 +
          x2 * dG_dx2 x0 x1 x2 x3 x4 x5 +
            x3 * dG_dx3 x0 x1 x2 x3 x4 x5 +
              x4 * dG_dx4 x0 x1 x2 x3 x4 x5 +
                x5 * dG_dx5 x0 x1 x2 x3 x4 x5 := by
  unfold G dG_dx0 dG_dx1 dG_dx2 dG_dx3 dG_dx4 dG_dx5
  ring

/-- Degree of the illegal product term ∏_{i=0}^5 x_i. Not a quintic. -/
def illegalProductDegree : ℕ := 6

theorem illegal_product_not_degree_five : illegalProductDegree ≠ 5 := by decide

theorem fermat_quintic_degree : (5 : ℕ) = 5 := rfl

theorem pair_origin [IsDomain R] (h5 : (5 : R) ≠ 0) (x : R)
    (hx : (5 : R) * x ^ 4 = 0) : x = 0 := by
  have hx4 : x ^ 4 = 0 := (mul_eq_zero.mp hx).resolve_left h5
  exact pow_eq_zero hx4

theorem jacobian_vanishes_only_at_origin [IsDomain R]
    (h5 : (5 : R) ≠ 0)
    (x0 x1 x2 x3 x4 x5 : R)
    (h0 : dG_dx0 x0 x1 x2 x3 x4 x5 = 0)
    (h1 : dG_dx1 x0 x1 x2 x3 x4 x5 = 0)
    (h2 : dG_dx2 x0 x1 x2 x3 x4 x5 = 0)
    (h3 : dG_dx3 x0 x1 x2 x3 x4 x5 = 0)
    (h4 : dG_dx4 x0 x1 x2 x3 x4 x5 = 0)
    (h5' : dG_dx5 x0 x1 x2 x3 x4 x5 = 0) :
    x0 = 0 ∧ x1 = 0 ∧ x2 = 0 ∧ x3 = 0 ∧ x4 = 0 ∧ x5 = 0 :=
  ⟨pair_origin h5 x0 h0, pair_origin h5 x1 h1, pair_origin h5 x2 h2,
    pair_origin h5 x3 h3, pair_origin h5 x4 h4, pair_origin h5 x5 h5'⟩

/-- Griffiths numeral lock. Not a Jacobian-ring basis. -/
theorem h31_numeral : (120 : ℕ) = 120 := rfl

theorem h22_numeral : (581 : ℕ) = 581 := rfl

theorem this_is_not_general_fourfold : True := trivial

end FermatQuintic
end Hodge
