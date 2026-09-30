/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.SpecialSextic

/-!
# Named Jacobian generators of the chain sextic

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6

    ∂F/∂x0 = 5 x0^4 x3
    ∂F/∂x1 = 5 x1^4 x4
    ∂F/∂x2 = 5 x2^4 x5
    ∂F/∂x3 = x0^5 + 6 x3^5
    ∂F/∂x4 = x1^5 + 6 x4^5
    ∂F/∂x5 = x2^5 + 6 x5^5

These are the six hypotheses of `affine_cone_isolated_at_origin`.
Naming them does not pick a residue in `R(F)_12` and does not compute
ledger `Z`. Not `general_fourfold`. Not Clay.
-/

namespace Hodge
namespace SpecialSextic

variable {R : Type*} [CommRing R]

def dF_dx0 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x0 ^ 4 * x3
def dF_dx1 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x1 ^ 4 * x4
def dF_dx2 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x2 ^ 4 * x5
def dF_dx3 (x0 x1 x2 x3 x4 x5 : R) : R := x0 ^ 5 + (6 : R) * x3 ^ 5
def dF_dx4 (x0 x1 x2 x3 x4 x5 : R) : R := x1 ^ 5 + (6 : R) * x4 ^ 5
def dF_dx5 (x0 x1 x2 x3 x4 x5 : R) : R := x2 ^ 5 + (6 : R) * x5 ^ 5

theorem dF_dx0_formula (x0 x1 x2 x3 x4 x5 : R) :
    dF_dx0 x0 x1 x2 x3 x4 x5 = (5 : R) * x0 ^ 4 * x3 := rfl
theorem dF_dx1_formula (x0 x1 x2 x3 x4 x5 : R) :
    dF_dx1 x0 x1 x2 x3 x4 x5 = (5 : R) * x1 ^ 4 * x4 := rfl
theorem dF_dx2_formula (x0 x1 x2 x3 x4 x5 : R) :
    dF_dx2 x0 x1 x2 x3 x4 x5 = (5 : R) * x2 ^ 4 * x5 := rfl
theorem dF_dx3_formula (x0 x1 x2 x3 x4 x5 : R) :
    dF_dx3 x0 x1 x2 x3 x4 x5 = x0 ^ 5 + (6 : R) * x3 ^ 5 := rfl
theorem dF_dx4_formula (x0 x1 x2 x3 x4 x5 : R) :
    dF_dx4 x0 x1 x2 x3 x4 x5 = x1 ^ 5 + (6 : R) * x4 ^ 5 := rfl
theorem dF_dx5_formula (x0 x1 x2 x3 x4 x5 : R) :
    dF_dx5 x0 x1 x2 x3 x4 x5 = x2 ^ 5 + (6 : R) * x5 ^ 5 := rfl

theorem euler_homogeneous (x0 x1 x2 x3 x4 x5 : R) :
    (6 : R) * F x0 x1 x2 x3 x4 x5 =
      x0 * dF_dx0 x0 x1 x2 x3 x4 x5 +
        x1 * dF_dx1 x0 x1 x2 x3 x4 x5 +
          x2 * dF_dx2 x0 x1 x2 x3 x4 x5 +
            x3 * dF_dx3 x0 x1 x2 x3 x4 x5 +
              x4 * dF_dx4 x0 x1 x2 x3 x4 x5 +
                x5 * dF_dx5 x0 x1 x2 x3 x4 x5 := by
  unfold F dF_dx0 dF_dx1 dF_dx2 dF_dx3 dF_dx4 dF_dx5
  ring

theorem jacobian_vanishes_only_at_origin [IsDomain R]
    (h5 : (5 : R) ≠ 0) (h6 : (6 : R) ≠ 0)
    (x0 x1 x2 x3 x4 x5 : R)
    (h0 : dF_dx0 x0 x1 x2 x3 x4 x5 = 0)
    (h1 : dF_dx1 x0 x1 x2 x3 x4 x5 = 0)
    (h2 : dF_dx2 x0 x1 x2 x3 x4 x5 = 0)
    (h3 : dF_dx3 x0 x1 x2 x3 x4 x5 = 0)
    (h4 : dF_dx4 x0 x1 x2 x3 x4 x5 = 0)
    (h5' : dF_dx5 x0 x1 x2 x3 x4 x5 = 0) :
    x0 = 0 ∧ x1 = 0 ∧ x2 = 0 ∧ x3 = 0 ∧ x4 = 0 ∧ x5 = 0 :=
  affine_cone_isolated_at_origin h5 h6 x0 x1 x2 x3 x4 x5 h0 h1 h2 h3 h4 h5'

theorem jacobian_lock_is_not_general_fourfold : True := trivial

end SpecialSextic
end Hodge
