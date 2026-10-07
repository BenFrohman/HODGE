/-
Copyright (c) 2026 Ben Frohman (@BenFrohman). Released under the MIT license.
Authors: Ben Frohman (@BenFrohman)
-/
import Hodge.Classical

namespace Hodge
namespace Klein

inductive Coord where
  | p01 | p02 | p03 | p12 | p13 | p23
  deriving DecidableEq, Repr

def opposite : Coord → Coord
  | .p01 => .p23
  | .p02 => .p13
  | .p03 => .p12
  | .p12 => .p03
  | .p13 => .p02
  | .p23 => .p01

def pluckerSign : Coord → ℤ
  | .p01 | .p23 => 1
  | .p02 | .p13 => -1
  | .p03 | .p12 => 1

def pluckerTerms : List (ℤ × Coord × Coord) :=
  [(1, .p01, .p23), (-1, .p02, .p13), (1, .p03, .p12)]

def piIdeal : List Coord := [.p12, .p13, .p23]
def pi'Ideal : List Coord := [.p01, .p02, .p03]

def pluckerEval (v : Coord → ℚ) : ℚ :=
  v .p01 * v .p23 - v .p02 * v .p13 + v .p03 * v .p12

theorem pi_on_quadric (v : Coord → ℚ)
    (h : ∀ c ∈ piIdeal, v c = 0) :
    pluckerEval v = 0 := by
  have h12 : v .p12 = 0 := h .p12 (by decide)
  have h13 : v .p13 = 0 := h .p13 (by decide)
  have h23 : v .p23 = 0 := h .p23 (by decide)
  simp [pluckerEval, h12, h13, h23]

theorem pi'_on_quadric (v : Coord → ℚ)
    (h : ∀ c ∈ pi'Ideal, v c = 0) :
    pluckerEval v = 0 := by
  have h01 : v .p01 = 0 := h .p01 (by decide)
  have h02 : v .p02 = 0 := h .p02 (by decide)
  have h03 : v .p03 = 0 := h .p03 (by decide)
  simp [pluckerEval, h01, h02, h03]

theorem ideals_cover : ∀ c : Coord, c ∈ piIdeal ∨ c ∈ pi'Ideal := by
  intro c
  cases c <;> decide

theorem ideals_disjoint : ∀ c : Coord, ¬ (c ∈ piIdeal ∧ c ∈ pi'Ideal) := by
  intro c
  cases c <;> decide

structure FormalCycle where
  coeffPi : ℚ
  coeffPi' : ℚ

/-- `initialize` is a Lean keyword, so the constructor is `cycleOf`. -/
def cycleOf : ℚ × ℚ → FormalCycle
  | (a, b) => ⟨a, b⟩

@[simp] theorem cycleOf_coeff (a b : ℚ) :
    (cycleOf (a, b)).coeffPi = a ∧ (cycleOf (a, b)).coeffPi' = b :=
  ⟨rfl, rfl⟩

theorem cycleOf_construct (gamma : ℚ × ℚ) :
    cycleOf (Classical.construct gamma) = cycleOf gamma :=
  rfl

end Klein
end Hodge
