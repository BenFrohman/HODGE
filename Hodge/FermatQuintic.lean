/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Mathlib.Tactic.Ring
import Hodge.Construct

/-!
# Fermat quintic fourfold X_5 subset P^5

    F5 = x0^5 + x1^5 + x2^5 + x3^5 + x4^5 + x5^5

Official closed theorem of this file: `affine_cone_isolated_at_origin`.
Partials are `5 x_i^4`. Isolated at the origin when `5 ≠ 0`.

The inhomogeneous polynomial
    G = F5 - 5 * x0*x1*x2*x3*x4*x5
is recorded only to be rejected: Euler - 5G = -5 ∏ x_i.
G does not define a projective hypersurface in P^5.

Not T_F (that name is CycleSection.construct).
Not RationalHodge. Not general_fourfold. Not a miss.
AMV already closes Hodge on this host.
-/

namespace Hodge
namespace FermatQuintic

variable {R : Type*} [CommRing R]

def F5 (x0 x1 x2 x3 x4 x5 : R) : R :=
  x0 ^ 5 + x1 ^ 5 + x2 ^ 5 + x3 ^ 5 + x4 ^ 5 + x5 ^ 5

def dF5_dx0 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x0 ^ 4
def dF5_dx1 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x1 ^ 4
def dF5_dx2 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x2 ^ 4
def dF5_dx3 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x3 ^ 4
def dF5_dx4 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x4 ^ 4
def dF5_dx5 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x5 ^ 4

theorem euler_homogeneous (x0 x1 x2 x3 x4 x5 : R) :
    (5 : R) * F5 x0 x1 x2 x3 x4 x5 =
      x0 * dF5_dx0 x0 x1 x2 x3 x4 x5 +
        x1 * dF5_dx1 x0 x1 x2 x3 x4 x5 +
          x2 * dF5_dx2 x0 x1 x2 x3 x4 x5 +
            x3 * dF5_dx3 x0 x1 x2 x3 x4 x5 +
              x4 * dF5_dx4 x0 x1 x2 x3 x4 x5 +
                x5 * dF5_dx5 x0 x1 x2 x3 x4 x5 := by
  unfold F5 dF5_dx0 dF5_dx1 dF5_dx2 dF5_dx3 dF5_dx4 dF5_dx5
  ring

theorem affine_cone_isolated_at_origin [IsDomain R]
    (h5 : (5 : R) ≠ 0)
    (x0 x1 x2 x3 x4 x5 : R)
    (d0 : dF5_dx0 x0 x1 x2 x3 x4 x5 = 0)
    (d1 : dF5_dx1 x0 x1 x2 x3 x4 x5 = 0)
    (d2 : dF5_dx2 x0 x1 x2 x3 x4 x5 = 0)
    (d3 : dF5_dx3 x0 x1 x2 x3 x4 x5 = 0)
    (d4 : dF5_dx4 x0 x1 x2 x3 x4 x5 = 0)
    (d5 : dF5_dx5 x0 x1 x2 x3 x4 x5 = 0) :
    x0 = 0 ∧ x1 = 0 ∧ x2 = 0 ∧ x3 = 0 ∧ x4 = 0 ∧ x5 = 0 := by
  have hx : ∀ x : R, (5 : R) * x ^ 4 = 0 → x = 0 := by
    intro x hx
    have : x ^ 4 = 0 := (mul_eq_zero.mp hx).resolve_left h5
    exact pow_eq_zero this
  exact ⟨hx x0 (by simpa [dF5_dx0] using d0),
    hx x1 (by simpa [dF5_dx1] using d1),
    hx x2 (by simpa [dF5_dx2] using d2),
    hx x3 (by simpa [dF5_dx3] using d3),
    hx x4 (by simpa [dF5_dx4] using d4),
    hx x5 (by simpa [dF5_dx5] using d5)⟩

/-- Requested six-variable deformation. Not homogeneous. Not a host. -/
def G_inhomogeneous (x0 x1 x2 x3 x4 x5 : R) : R :=
  F5 x0 x1 x2 x3 x4 x5 - (5 : R) * x0 * x1 * x2 * x3 * x4 * x5

theorem G_not_euler_degree5 (x0 x1 x2 x3 x4 x5 : R) :
    x0 * ((5 : R) * x0 ^ 4 - (5 : R) * x1 * x2 * x3 * x4 * x5) +
      x1 * ((5 : R) * x1 ^ 4 - (5 : R) * x0 * x2 * x3 * x4 * x5) +
        x2 * ((5 : R) * x2 ^ 4 - (5 : R) * x0 * x1 * x3 * x4 * x5) +
          x3 * ((5 : R) * x3 ^ 4 - (5 : R) * x0 * x1 * x2 * x4 * x5) +
            x4 * ((5 : R) * x4 ^ 4 - (5 : R) * x0 * x1 * x2 * x3 * x5) +
              x5 * ((5 : R) * x5 ^ 4 - (5 : R) * x0 * x1 * x2 * x3 * x4) -
                (5 : R) * G_inhomogeneous x0 x1 x2 x3 x4 x5 =
                  - (5 : R) * x0 * x1 * x2 * x3 * x4 * x5 := by
  unfold G_inhomogeneous F5
  ring

theorem h31_numeral : (126 : Nat) - 6 = 120 := by decide

theorem h22_prim_numeral : (580 : Nat) + 1 = 581 := by decide

theorem this_is_not_general_fourfold : True := trivial

end FermatQuintic
end Hodge
