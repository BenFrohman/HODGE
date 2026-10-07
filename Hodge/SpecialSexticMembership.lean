/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Mathlib.Tactic.Ring
import Mathlib.RingTheory.Ideal.Basic

/-!
# Named sextic membership (locked)

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6
    I(Π) = ⟨x3, x4, x5⟩
    I(Π₋) = ⟨x0 + x3, x1 + x4, x2 + x5⟩

`*` associates left, so `a * g * p = (a * g) * p`. The sign-plane generator
is the middle factor `g`. This file is the checked copy of that membership.
It says both named planes lie on V(F). It is not a Hodge class.
-/

namespace Hodge
namespace SpecialSexticMembership

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

theorem F_factors_minus1 (x0 x1 x2 x3 x4 x5 : R) :
    F x0 x1 x2 x3 x4 x5 =
      x3 * (x0 + x3) *
          (x0 ^ 4 - x0 ^ 3 * x3 + x0 ^ 2 * x3 ^ 2 - x0 * x3 ^ 3 + x3 ^ 4) +
        x4 * (x1 + x4) *
          (x1 ^ 4 - x1 ^ 3 * x4 + x1 ^ 2 * x4 ^ 2 - x1 * x4 ^ 3 + x4 ^ 4) +
          x5 * (x2 + x5) *
            (x2 ^ 4 - x2 ^ 3 * x5 + x2 ^ 2 * x5 ^ 2 - x2 * x5 ^ 3 + x5 ^ 4) := by
  unfold F
  ring

def planeIdeal (x3 x4 x5 : R) : Ideal R :=
  Ideal.span {x3, x4, x5}

def planeIdealMinus1 (x0 x1 x2 x3 x4 x5 : R) : Ideal R :=
  Ideal.span {x0 + x3, x1 + x4, x2 + x5}

theorem F_mem_plane (x0 x1 x2 x3 x4 x5 : R) :
    F x0 x1 x2 x3 x4 x5 ∈ planeIdeal x3 x4 x5 := by
  rw [F_factors]
  refine Ideal.add_mem _ (Ideal.add_mem _ ?_ ?_) ?_
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (Or.inl rfl))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (Or.inr (Or.inl rfl)))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (Or.inr (Or.inr rfl)))

/-- `*` is left-associative, so `a * g * p = (a * g) * p`.
The generator is the middle factor `g`. Peel `p` on the right, then `a` on the left. -/
theorem F_mem_plane_minus1 (x0 x1 x2 x3 x4 x5 : R) :
    F x0 x1 x2 x3 x4 x5 ∈ planeIdealMinus1 x0 x1 x2 x3 x4 x5 := by
  rw [F_factors_minus1]
  refine Ideal.add_mem _ (Ideal.add_mem _ ?_ ?_) ?_
  · exact Ideal.mul_mem_right _ _
      (Ideal.mul_mem_left _ _ (Ideal.subset_span (Or.inl rfl)))
  · exact Ideal.mul_mem_right _ _
      (Ideal.mul_mem_left _ _ (Ideal.subset_span (Or.inr (Or.inl rfl))))
  · exact Ideal.mul_mem_right _ _
      (Ideal.mul_mem_left _ _ (Ideal.subset_span (Or.inr (Or.inr rfl))))

theorem contains_two_planes (x0 x1 x2 x3 x4 x5 : R) :
    F x0 x1 x2 x3 x4 x5 ∈ planeIdeal x3 x4 x5 ∧
      F x0 x1 x2 x3 x4 x5 ∈ planeIdealMinus1 x0 x1 x2 x3 x4 x5 :=
  ⟨F_mem_plane x0 x1 x2 x3 x4 x5,
    F_mem_plane_minus1 x0 x1 x2 x3 x4 x5⟩

end SpecialSexticMembership
end Hodge
