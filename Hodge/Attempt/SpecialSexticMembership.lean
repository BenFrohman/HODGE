/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Mathlib.Tactic.Ring
import Mathlib.RingTheory.Ideal.Basic

/-!
# Easy-arrow membership on the named sextic

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6
    Pi = {x3 = x4 = x5 = 0}
    linear section = {x0 = x1 = 0}   -- class h² after cutting X

`F` is in `⟨x3, x4, x5⟩` by `ring`. Not general_fourfold.
Not imported by Hodge.lean.
-/

namespace Hodge.Attempt.SpecialSexticMembership

variable {R : Type*} [CommRing R]

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

/-- Ideal of `Π = V(x3,x4,x5)`. -/
def planeIdeal (x3 x4 x5 : R) : Ideal R :=
  Ideal.span {x3, x4, x5}

/-- Ambient ideal of a linear P³: `V(x0,x1) ⊂ P^5`. -/
def linearSectionIdeal (x0 x1 : R) : Ideal R :=
  Ideal.span {x0, x1}

theorem F_mem_plane (x0 x1 x2 x3 x4 x5 : R) :
    F x0 x1 x2 x3 x4 x5 ∈ planeIdeal x3 x4 x5 := by
  rw [F_factors]
  refine Ideal.add_mem _ (Ideal.add_mem _ ?_ ?_) ?_
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))

theorem generators_of_shadow_span :
    (planeIdeal (x3 := (0 : R)) (0) (0) = Ideal.span {(0 : R), 0, 0}) ∧
      True := by
  exact ⟨rfl, trivial⟩

end Hodge.Attempt.SpecialSexticMembership
