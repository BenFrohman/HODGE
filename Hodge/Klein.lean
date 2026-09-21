/-
Copyright (c) 2026 Ben Frohman (@BenFrohman). Released under the MIT license.
Authors: Ben Frohman (@BenFrohman)
-/
import Hodge.Classical

/-!
# Named geometric data for the Klein quadric

`Classical.kleinQuadric` is a two-dimensional rational vector space with
`cl = id`. This file names the objects that vector space is the shadow of:

* six Plücker coordinates on `ℝ(∧² ℂ⁴)`;
* the single quadratic Plücker relation;
* two linear ideals cutting out planes `Π` and `Π'`;
* the formal cycle `a Π + b Π'` attached to a pair of rationals.

None of these is a scheme. This file does not prove `[Π]² = 1` inside the
Chow ring. The geometric identities remain in `docs/CLASSICAL_FOURFOLDS.md`.
What is initialized here is the *naming*.
-/

namespace Hodge
namespace Klein

/-- The six Plücker coordinates on `∧² ℂ⁴`. -/
inductive Coord where
  | p01 | p02 | p03 | p12 | p13 | p23
  deriving DecidableEq, Repr

/-- Opposite pairs appearing in the Plücker quadratic. -/
def opposite : Coord → Coord
  | .p01 => .p23
  | .p02 => .p13
  | .p03 => .p12
  | .p12 => .p03
  | .p13 => .p02
  | .p23 => .p01

/-- Sign of the three terms in `p01 p23 − p02 p13 + p03 p12`. -/
def pluckerSign : Coord → ℤ
  | .p01 | .p23 => 1
  | .p02 | .p13 => -1
  | .p03 | .p12 => 1

/-- The Plücker quadratic, recorded as signed opposite pairs.
This is the equation of `Q⁴ ⊂ ℝ⁵`. -/
def pluckerTerms : List (ℤ × Coord × Coord) :=
  [(1, .p01, .p23), (-1, .p02, .p13), (1, .p03, .p12)]

/-- Linear generators of the ideal of `Π = V(p12, p13, p23) ∩ Q`. -/
def piIdeal : List Coord := [.p12, .p13, .p23]

/-- Linear generators of the ideal of `Π' = V(p01, p02, p03) ∩ Q`. -/
def pi'Ideal : List Coord := [.p01, .p02, .p03]

/-- Evaluation of the Plücker quadratic at a 6-tuple of scalars. -/
def pluckerEval (v : Coord → ℚ) : ℚ :=
  v .p01 * v .p23 - v .p02 * v .p13 + v .p03 * v .p12

/-- `Π ⊂ Q`: if the three generators of `piIdeal` vanish, so does the quadratic. -/
theorem pi_on_quadric (v : Coord → ℚ)
    (h : ∀ c ∈ piIdeal, v c = 0) :
    pluckerEval v = 0 := by
  have h12 : v .p12 = 0 := h _ (by simp [piIdeal])
  have h13 : v .p13 = 0 := h _ (by simp [piIdeal])
  have h23 : v .p23 = 0 := h _ (by simp [piIdeal])
  simp [pluckerEval, h12, h13, h23]

/-- `Π' ⊂ Q`: if the three generators of `pi'Ideal` vanish, so does the quadratic. -/
theorem pi'_on_quadric (v : Coord → ℚ)
    (h : ∀ c ∈ pi'Ideal, v c = 0) :
    pluckerEval v = 0 := by
  have h01 : v .p01 = 0 := h _ (by simp [pi'Ideal])
  have h02 : v .p02 = 0 := h _ (by simp [pi'Ideal])
  have h03 : v .p03 = 0 := h _ (by simp [pi'Ideal])
  simp [pluckerEval, h01, h02, h03]

/-- The two planes are complementary: every coordinate appears in exactly
one of the two linear ideals. -/
theorem ideals_cover : ∀ c : Coord, c ∈ piIdeal ∨ c ∈ pi'Ideal := by
  intro c
  cases c <;> simp [piIdeal, pi'Ideal]

theorem ideals_disjoint : ∀ c : Coord, ¬ (c ∈ piIdeal ∧ c ∈ pi'Ideal) := by
  intro c
  cases c <;> simp [piIdeal, pi'Ideal]

/-- Formal algebraic cycle on the Klein quadric: a rational combination
of the two named planes. -/
structure FormalCycle where
  coeffPi  : ℚ
  coeffPi' : ℚ

/-- Initialize a cycle from a Hodge class written in the `(a, b)` basis
of `Classical.kleinQuadric`. -/
def initialize : ℚ × ℚ → FormalCycle
  | (a, b) => ⟨a, b⟩

/-- The cycle produced from `(a, b)` has those coefficients. -/
@[simp] theorem initialize_coeff (a b : ℚ) :
    (initialize (a, b)).coeffPi = a ∧ (initialize (a, b)).coeffPi' = b :=
  ⟨rfl, rfl⟩

/-- Sending a class through `Classical.construct` and then `initialize`
recovers the same pair. This is the named correspondence between the
linear shadow and the two planes. It is not a theorem in Chow. -/
theorem initialize_construct (γ : ℚ × ℚ) :
    initialize (Classical.construct γ) = initialize γ :=
  rfl

end Klein
end Hodge
