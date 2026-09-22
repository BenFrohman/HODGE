/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Mathlib.Tactic.Ring
import Mathlib.RingTheory.Ideal.Basic
import Hodge.Construct

/-!
# Named special sextic

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6
    I(Π) = ⟨x3, x4, x5⟩
    I(h^2) = ⟨x0, x1⟩

`F_mem_plane` is the easy arrow on Π. `planeSpan` is the Q^2 shadow.
Not general_fourfold.
-/

namespace Hodge
namespace SpecialSextic

variable {R : Type*} [CommRing R]

inductive P5Coord where
  | x0 | x1 | x2 | x3 | x4 | x5
  deriving DecidableEq, Repr

def planeIdealCoords : List P5Coord := [.x3, .x4, .x5]
def hyperplaneSectionIdeal : List P5Coord := [.x0, .x1]

def F (x0 x1 x2 x3 x4 x5 : R) : R :=
  x0 ^ 5 * x3 + x3 ^ 6 +
    x1 ^ 5 * x4 + x4 ^ 6 +
      x2 ^ 5 * x5 + x5 ^ 6

theorem F_factors (x0 x1 x2 x3 x4 x5 : R) :
    F x0 x1 x2 x3 x4 x5 =
      x3 * (x0 ^ 5 + x3 ^ 5) +
        x4 * (x1 ^ 5 + x4 ^ 5) +
          x5 * (x2 ^ 5 + x5 ^ 5) := by
  unfold F
  ring

def planeIdeal (x3 x4 x5 : R) : Ideal R :=
  Ideal.span {x3, x4, x5}

def linearSectionIdeal (x0 x1 : R) : Ideal R :=
  Ideal.span {x0, x1}

theorem F_mem_plane (x0 x1 x2 x3 x4 x5 : R) :
    F x0 x1 x2 x3 x4 x5 ∈ planeIdeal x3 x4 x5 := by
  rw [F_factors]
  refine Ideal.add_mem _ (Ideal.add_mem _ ?_ ?_) ?_
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))

def planeSpan : Datum (Rat × Rat) (Rat × Rat) Rat where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

def construct (gamma : Rat × Rat) : Rat × Rat := gamma

theorem construct_section (gamma : Rat × Rat) :
    planeSpan.cl (construct gamma) = gamma :=
  rfl

instance : CycleSection planeSpan where
  construct := fun γ => construct γ.val
  is_section := fun γ => construct_section γ.val

theorem planeSpan_hodge : planeSpan.HodgeConjecture :=
  hodgeConjecture_of_constructor planeSpan

end SpecialSextic
end Hodge
