/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Mathlib.RingTheory.Ideal.Basic
import Mathlib.Tactic.Ring

/-!
# Easy-arrow membership on the named special sextic

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6
    Π = V(x3, x4, x5)

    F = x3(x0^5 + x3^5) + x4(x1^5 + x4^5) + x5(x2^5 + x5^5)
    so F ∈ ⟨x3, x4, x5⟩.

Not imported by Hodge.lean. Not general_fourfold.
-/

namespace Hodge.Attempt.NamedSextic

variable {R : Type*} [CommRing R]

def namedSextic (x0 x1 x2 x3 x4 x5 : R) : R :=
  x0 ^ 5 * x3 + x3 ^ 6 + x1 ^ 5 * x4 + x4 ^ 6 + x2 ^ 5 * x5 + x5 ^ 6

def planeIdeal (x3 x4 x5 : R) : Ideal R :=
  Ideal.span {x3, x4, x5}

theorem namedSextic_eq_plane_combination (x0 x1 x2 x3 x4 x5 : R) :
    namedSextic x0 x1 x2 x3 x4 x5 =
      x3 * (x0 ^ 5 + x3 ^ 5) +
      x4 * (x1 ^ 5 + x4 ^ 5) +
      x5 * (x2 ^ 5 + x5 ^ 5) := by
  unfold namedSextic
  ring

theorem namedSextic_mem_plane (x0 x1 x2 x3 x4 x5 : R) :
    namedSextic x0 x1 x2 x3 x4 x5 ∈ planeIdeal x3 x4 x5 := by
  rw [namedSextic_eq_plane_combination]
  unfold planeIdeal
  refine Ideal.add_mem _ (Ideal.add_mem _ ?_ ?_) ?_
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))

end Hodge.Attempt.NamedSextic
