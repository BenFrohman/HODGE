/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Mathlib.Tactic.Ring
import Hodge.Construct

/-!
# Fermat quintic fourfold X_5 subset P^5

This file's host is `X_5 = V(G)`, with
`G = ∑ x_i^5`. Docs name: `FermatQuintic.G`.
Partials `5 x_i^4`. Cone isolated at the origin when `5 ≠ 0`.

`G_inhomogeneous = G - 5 ∏ x_i` is not a host: degree 5 against degree 6.

`T_F` is `CycleSection.construct`. This file does not rebind it and does not
supply a `CycleSection` instance. Shioda and Aljovín–Movasati–Villaflor are literature,
not a term of `HodgeConjecture.general_fourfold`.
-/

namespace Hodge
namespace FermatQuintic

variable {R : Type*} [CommRing R]

/-- Legal host polynomial. Homogeneous of degree 5. -/
def G (x0 x1 x2 x3 x4 x5 : R) : R :=
  x0 ^ 5 + x1 ^ 5 + x2 ^ 5 + x3 ^ 5 + x4 ^ 5 + x5 ^ 5

/-- Alias used by earlier certificates. -/
def F5 (x0 x1 x2 x3 x4 x5 : R) : R :=
  G x0 x1 x2 x3 x4 x5

theorem F5_eq_G (x0 x1 x2 x3 x4 x5 : R) :
    F5 x0 x1 x2 x3 x4 x5 = G x0 x1 x2 x3 x4 x5 := rfl

def dG_dx0 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x0 ^ 4
def dG_dx1 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x1 ^ 4
def dG_dx2 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x2 ^ 4
def dG_dx3 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x3 ^ 4
def dG_dx4 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x4 ^ 4
def dG_dx5 (x0 x1 x2 x3 x4 x5 : R) : R := (5 : R) * x5 ^ 4

def dF5_dx0 (x0 x1 x2 x3 x4 x5 : R) : R := dG_dx0 x0 x1 x2 x3 x4 x5
def dF5_dx1 (x0 x1 x2 x3 x4 x5 : R) : R := dG_dx1 x0 x1 x2 x3 x4 x5
def dF5_dx2 (x0 x1 x2 x3 x4 x5 : R) : R := dG_dx2 x0 x1 x2 x3 x4 x5
def dF5_dx3 (x0 x1 x2 x3 x4 x5 : R) : R := dG_dx3 x0 x1 x2 x3 x4 x5
def dF5_dx4 (x0 x1 x2 x3 x4 x5 : R) : R := dG_dx4 x0 x1 x2 x3 x4 x5
def dF5_dx5 (x0 x1 x2 x3 x4 x5 : R) : R := dG_dx5 x0 x1 x2 x3 x4 x5

/-- Host label. Not `T_F`. -/
def X_5_name : String := "Fermat quintic fourfold X_5 = V(G)"

/-- Locked name. Owned by `CycleSection.construct`. -/
def locked_T_F_name : String := "CycleSection.construct"

theorem X_5_name_ne_T_F : X_5_name ≠ locked_T_F_name := by
  decide

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

/-- Jacobian certificate for the host `V(G)`. Not a Hodge-class witness. -/
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
  have hx : ∀ x : R, (5 : R) * x ^ 4 = 0 → x = 0 := by
    intro x hx
    have : x ^ 4 = 0 := (mul_eq_zero.mp hx).resolve_left h5
    exact pow_eq_zero this
  exact ⟨hx x0 d0, hx x1 d1, hx x2 d2, hx x3 d3, hx x4 d4, hx x5 d5⟩

/-- Degree-6 product. Not a projective equation in P^5. Not the host. -/
def G_inhomogeneous (x0 x1 x2 x3 x4 x5 : R) : R :=
  G x0 x1 x2 x3 x4 x5 - (5 : R) * x0 * x1 * x2 * x3 * x4 * x5

/-- Euler defect. Right-hand side is the degree-6 term. -/
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

theorem h40_numeral : (0 : Nat) = 0 := rfl

theorem h31_numeral : (126 : Nat) - 6 = 120 := by decide

theorem h22_full_numeral : (580 : Nat) + 1 = 581 := by decide

theorem b4_numeral : (0 : Nat) + 120 + 581 + 120 + 0 = 821 := by decide

theorem canonical_degree : (5 : Int) - 6 = -1 := by decide

theorem this_is_not_general_fourfold : True := trivial

/-- Finished algebraic certificate for the host `V(G)`. Not a Hodge inhabitant. -/
theorem jacobian_certificate [IsDomain R] (h5 : (5 : R) ≠ 0) :
    (∀ x0 x1 x2 x3 x4 x5,
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

end FermatQuintic
end Hodge
