/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Mathlib

/-!
# Certificates for the Delsarte sextic fourfold `X` (v1.2)

`X = V(f(x0,x3) + f(x1,x4) + f(x2,x5))`, `f(x,y) = x⁵y + y⁶`.

## (a) Gröbner certificate for the Milnor algebra of `f`
`J = (∂ₓf, ∂ᵧf) = (5x⁴y, x⁵ + 6y⁵)`.  The reduced grevlex Gröbner basis is
`G = {x⁴y, x⁵ + 6y⁵, y⁶}`. Lean checks:
* each element of `G` is an explicit combination of `∂ₓf, ∂ᵧf` (and conversely),
  so `(G) = J` (`gb_in_J`, `J_in_gb`);
* every S-polynomial reduces to `0` modulo `G` by an explicit standard representation
  (`spoly_*`);
* the standard monomials (not divisible by `x⁴y, x⁵, y⁶`) number exactly 25 (`std_card`).
**Cited, not formalized:** Buchberger's criterion (S-pairs reduce to 0 ⇒ Gröbner basis)
and Macaulay's theorem (standard monomials form a basis of the quotient); neither is in
Mathlib for this use.

## (b) Twisted planes and the group action
The twisted planes `x_B = λ x_A, y_B = μ y_A, L_C = 0` lie on `X` (see
`SexticCombinatorics.twisted_pair_vanishes`); here we check that the diagonal group
`(ℤ/30)³` maps the parameter set `λ⁵μ = -1, μ⁶ = -1` to itself (`twist_action`), and
standard factors `η⁵ = -1` to themselves (`eta_action`). This is the action used in
`scripts/per_class_report.py`.

## Not in Lean (documented)
Ranks 125 / 425 and the twisted intersection pattern: a kernel-checked rank of a
217×217 / 757×757 matrix is not feasible with `decide` (no `native_decide` allowed).
They are now established in Python by **two independent methods** (exact Gram rank over
ℚ, and the per-character projection count of `per_class_report.py`), which agree.
-/

namespace Hodge.SexticCertificates

section Groebner
variable {R : Type*} [Field R] [CharZero R] (x y : R)

/-- partial derivatives of `f = x⁵y + y⁶` -/
def fx : R := 5 * x ^ 4 * y
def fy : R := x ^ 5 + 6 * y ^ 5

theorem gb_in_J :
    x ^ 4 * y = (1 / 5 : R) * fx x y ∧
    x ^ 5 + 6 * y ^ 5 = fy x y ∧
    y ^ 6 = (1 / 6 : R) * (y * fy x y - (x / 5) * fx x y) := by
  refine ⟨?_, ?_, ?_⟩ <;> simp only [fx, fy] <;> field_simp <;> ring

theorem J_in_gb : fx x y = 5 * (x ^ 4 * y) ∧ fy x y = x ^ 5 + 6 * y ^ 5 := by
  simp only [fx, fy]; constructor <;> ring

/-- S(x⁵+6y⁵, x⁴y) = y·g₂ − x·g₁ = 6·y⁶ (reduces to 0 by `y⁶`). -/
theorem spoly_12 : y * (x ^ 5 + 6 * y ^ 5) - x * (x ^ 4 * y) = 6 * y ^ 6 := by ring
/-- S(y⁶, x⁴y) = x⁴·y⁶ − y⁵·x⁴y = 0. -/
theorem spoly_13 : x ^ 4 * y ^ 6 - y ^ 5 * (x ^ 4 * y) = 0 := by ring
/-- S(x⁵+6y⁵, y⁶) = y⁶·g₂ − x⁵·y⁶ = 6y⁵·y⁶ (coprime leading terms). -/
theorem spoly_23 : y ^ 6 * (x ^ 5 + 6 * y ^ 5) - x ^ 5 * y ^ 6 = (6 * y ^ 5) * y ^ 6 := by ring
end Groebner

/-- standard monomials `xᵃyᵇ` (a,b < 12) not divisible by `x⁴y`, `x⁵`, `y⁶` -/
def stdMonos : List (ℕ × ℕ) :=
  ((List.range 12).product (List.range 12)).filter fun m =>
    !((4 ≤ m.1 && 1 ≤ m.2) || 5 ≤ m.1 || 6 ≤ m.2)

theorem std_card : stdMonos.length = 25 := by decide +kernel

/-- Milnor number `(6-1)² = 25` and bounded-box completeness: no standard monomial has
`a ≥ 5` or `b ≥ 6`, so the `12×12` box contains all of them. -/
theorem std_bounded : ∀ m ∈ stdMonos, m.1 ≤ 4 ∧ m.2 ≤ 5 := by decide +kernel

section Action
variable {R : Type*} [CommRing R]

theorem twist_action (lam mu ζ ζi : R) (hζ : ζ * ζi = 1) (d : ℕ)
    (h1 : lam ^ 5 * mu = -1) :
    (lam * ζ ^ d) ^ 5 * (mu * ζi ^ (5 * d)) = -1 := by
  have : (ζ * ζi) ^ (5 * d) = 1 := by rw [hζ, one_pow]
  calc (lam * ζ ^ d) ^ 5 * (mu * ζi ^ (5 * d))
      = (lam ^ 5 * mu) * (ζ * ζi) ^ (5 * d) := by ring
    _ = -1 := by rw [h1, this, mul_one]

theorem mu_action (mu ζi : R) (hζ : ζi ^ 30 = 1) (d : ℕ) (h : mu ^ 6 = -1) :
    (mu * ζi ^ (5 * d)) ^ 6 = -1 := by
  have : (ζi ^ 30) ^ d = 1 := by rw [hζ, one_pow]
  calc (mu * ζi ^ (5 * d)) ^ 6 = mu ^ 6 * (ζi ^ 30) ^ d := by ring
    _ = -1 := by rw [h, this, mul_one]

theorem eta_action (η ζ : R) (hζ : ζ ^ 30 = 1) (k : ℕ) (h : η ^ 5 = -1) :
    (η * ζ ^ (6 * k)) ^ 5 = -1 := by
  have : (ζ ^ 30) ^ k = 1 := by rw [hζ, one_pow]
  calc (η * ζ ^ (6 * k)) ^ 5 = η ^ 5 * (ζ ^ 30) ^ k := by ring
    _ = -1 := by rw [h, this, mul_one]
end Action

end Hodge.SexticCertificates
