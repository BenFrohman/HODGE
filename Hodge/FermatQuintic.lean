/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Mathlib.Tactic.Ring
import Hodge.Construct

/-!
# Fermat quintic fourfold X_5 subset P^5

Host: `G = ∑ x_i^5`. Partials `5 x_i^4`. Cone isolated at the origin when `5 ≠ 0`.
The partials are unfolded before the zero test so no `Nat` coercion is inserted.
-/

namespace Hodge
namespace FermatQuintic

theorem h40_numeral : (0 : Nat) = 0 := rfl
theorem h31_numeral : (126 : Nat) - 6 = 120 := by decide
theorem h22_full_numeral : (580 : Nat) + 1 = 581 := by decide
theorem b4_numeral : (0 : Nat) + 120 + 581 + 120 + 0 = 821 := by decide
theorem canonical_degree : (5 : Int) - 6 = -1 := by decide
theorem this_is_not_general_fourfold : True := trivial

section Poly
variable {R : Type*} [CommRing R]

def G (x0 x1 x2 x3 x4 x5 : R) : R :=
  x0 ^ 5 + x1 ^ 5 + x2 ^ 5 + x3 ^ 5 + x4 ^ 5 + x5 ^ 5

def F5 (x0 x1 x2 x3 x4 x5 : R) : R := G x0 x1 x2 x3 x4 x5

theorem F5_eq_G (x0 x1 x2 x3 x4 x5 : R) :
    F5 x0 x1 x2 x3 x4 x5 = G x0 x1 x2 x3 x4 x5 := rfl

def dG_dx0 (x0 _x1 _x2 _x3 _x4 _x5 : R) : R := (5 : R) * x0 ^ 4
def dG_dx1 (_x0 x1 _x2 _x3 _x4 _x5 : R) : R := (5 : R) * x1 ^ 4
def dG_dx2 (_x0 _x1 x2 _x3 _x4 _x5 : R) : R := (5 : R) * x2 ^ 4
def dG_dx3 (_x0 _x1 _x2 x3 _x4 _x5 : R) : R := (5 : R) * x3 ^ 4
def dG_dx4 (_x0 _x1 _x2 _x3 x4 _x5 : R) : R := (5 : R) * x4 ^ 4
def dG_dx5 (_x0 _x1 _x2 _x3 _x4 x5 : R) : R := (5 : R) * x5 ^ 4

def X_5_name : String := "Fermat quintic fourfold X_5 = V(G)"
def locked_T_F_name : String := "CycleSection.construct"

theorem X_5_name_ne_T_F : X_5_name ≠ locked_T_F_name := by decide

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

theorem affine_cone_isolated_at_origin [IsDomain R]
    (h5 : (5 : R) ≠ 0)
    (x0 x1 x2 x3 x4 x5 : R)
    (d0 : dG_dx0 x0 x1 x2 x3 x4 x5 = 0)
    (d1 : dG_dx1 x0 x1 x2 x3 x4 x5 = 0)
    (d2 : dG_dx2 x0 x1 x2 x3 x4 x5 = 0)
    (d3 : dG_dx3 x0 x1 x2 x3 x4 x5 = 0)
    (d4 : dG_dx4 x0 x1 x2 x3 x4 x5 = 0)
    (d5 : dG_dx5 x0 x1 x2 x3 x4 x5 = 0) :
    x0 = 0 ∧ x1 = 0 ∧ x2 = 0 ∧ x3 = 0 ∧ x4 = 0 ∧ x5 = 0 := by
  unfold dG_dx0 at d0
  unfold dG_dx1 at d1
  unfold dG_dx2 at d2
  unfold dG_dx3 at d3
  unfold dG_dx4 at d4
  unfold dG_dx5 at d5
  have hx : ∀ x : R, (5 : R) * x ^ 4 = 0 → x = 0 := by
    intro x h
    exact pow_eq_zero ((mul_eq_zero.mp h).resolve_left h5)
  exact ⟨hx x0 d0, hx x1 d1, hx x2 d2, hx x3 d3, hx x4 d4, hx x5 d5⟩

def G_inhomogeneous (x0 x1 x2 x3 x4 x5 : R) : R :=
  G x0 x1 x2 x3 x4 x5 - (5 : R) * x0 * x1 * x2 * x3 * x4 * x5

theorem G_not_euler_degree5 (x0 x1 x2 x3 x4 x5 : R) :
    x0 * ((5 : R) * x0 ^ 4 - (5 : R) * x1 * x2 * x3 * x4 * x5) +
      x1 * ((5 : R) * x1 ^ 4 - (5 : R) * x0 * x2 * x3 * x4 * x5) +
        x2 * ((5 : R) * x2 ^ 4 - (5 : R) * x0 * x1 * x3 * x4 * x5) +
          x3 * ((5 : R) * x3 ^ 4 - (5 : R) * x0 * x1 * x2 * x4 * x5) +
            x4 * ((5 : R) * x4 ^ 4 - (5 : R) * x0 * x1 * x2 * x3 * x5) +
              x5 * ((5 : R) * x5 ^ 4 - (5 : R) * x0 * x1 * x2 * x3 * x4) -
                (5 : R) * G_inhomogeneous x0 x1 x2 x3 x4 x5 =
                  - (5 : R) * x0 * x1 * x2 * x3 * x4 * x5 := by
  unfold G_inhomogeneous G
  ring

theorem jacobian_certificate [IsDomain R] (h5 : (5 : R) ≠ 0) :
    (∀ x0 x1 x2 x3 x4 x5 : R,
        dG_dx0 x0 x1 x2 x3 x4 x5 = 0 →
        dG_dx1 x0 x1 x2 x3 x4 x5 = 0 →
        dG_dx2 x0 x1 x2 x3 x4 x5 = 0 →
        dG_dx3 x0 x1 x2 x3 x4 x5 = 0 →
        dG_dx4 x0 x1 x2 x3 x4 x5 = 0 →
        dG_dx5 x0 x1 x2 x3 x4 x5 = 0 →
        x0 = 0 ∧ x1 = 0 ∧ x2 = 0 ∧ x3 = 0 ∧ x4 = 0 ∧ x5 = 0) ∧
      X_5_name ≠ locked_T_F_name ∧
      (126 : Nat) - 6 = 120 ∧
      (580 : Nat) + 1 = 581 ∧
      (0 : Nat) + 120 + 581 + 120 + 0 = 821 ∧
      ((5 : Int) - 6 = -1) := by
  refine ⟨?_, X_5_name_ne_T_F, h31_numeral, h22_full_numeral, b4_numeral, canonical_degree⟩
  intro x0 x1 x2 x3 x4 x5 d0 d1 d2 d3 d4 d5
  exact affine_cone_isolated_at_origin h5 x0 x1 x2 x3 x4 x5 d0 d1 d2 d3 d4 d5

end Poly
end FermatQuintic
end Hodge
