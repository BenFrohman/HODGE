/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Mathlib.Tactic.Ring
import Mathlib.RingTheory.Ideal.Basic
import Hodge.Construct

/-!
# Special Noether–Lefschetz sextic (plane locus)

Standard name: a hypersurface in P^5 that contains a linear space (a plane).
Lean namespace stays `Hodge.SpecialSextic` so `Hodge.lean` does not break.

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6
    Π = {x3 = x4 = x5 = 0},   I(Π) = ⟨x3, x4, x5⟩

One equation of the shape F = x3 A + x4 B + x5 C. Not a new polynomial.
Example on the plane component of the NL locus of sextic fourfolds.

Proved here: F ∈ I(Π); ∇F = 0 only at the origin (char ≠ 2,3,5);
5^6 = 15625; Q² shadow with cl = id.
Literature aliases below name those same theorems.
Not dim R(F). Not general_fourfold.
-/

namespace Hodge
namespace SpecialSextic

variable {R : Type*} [CommRing R]

inductive P5Coord where
  | x0 | x1 | x2 | x3 | x4 | x5
  deriving DecidableEq, Repr

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

theorem F_mem_plane (x0 x1 x2 x3 x4 x5 : R) :
    F x0 x1 x2 x3 x4 x5 ∈ planeIdeal x3 x4 x5 := by
  rw [F_factors]
  refine Ideal.add_mem _ (Ideal.add_mem _ ?_ ?_) ?_
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))

/-- Recognized statement: this hypersurface contains the coordinate plane. -/
theorem hypersurface_contains_the_plane (x0 x1 x2 x3 x4 x5 : R) :
    F x0 x1 x2 x3 x4 x5 ∈ planeIdeal x3 x4 x5 :=
  F_mem_plane x0 x1 x2 x3 x4 x5

theorem gradPair_origin [IsDomain R]
    (h5 : (5 : R) ≠ 0) (h6 : (6 : R) ≠ 0) (x y : R)
    (hxy : (5 : R) * x ^ 4 * y = 0)
    (hsum : x ^ 5 + (6 : R) * y ^ 5 = 0) :
    x = 0 ∧ y = 0 := by
  have hyx : x ^ 4 * y = 0 := by
    have : (5 : R) * (x ^ 4 * y) = 0 := by
      simpa [mul_assoc] using hxy
    exact (mul_eq_zero.mp this).resolve_left h5
  rcases mul_eq_zero.mp hyx with hx4 | hy
  · have hx : x = 0 := pow_eq_zero (by simpa using hx4)
    have : (6 : R) * y ^ 5 = 0 := by
      simpa [hx] using hsum
    have hy5 : y ^ 5 = 0 := (mul_eq_zero.mp this).resolve_left h6
    exact ⟨hx, pow_eq_zero hy5⟩
  · have : x ^ 5 = 0 := by simpa [hy] using hsum
    exact ⟨pow_eq_zero this, hy⟩

theorem gradient_only_origin [IsDomain R]
    (h5 : (5 : R) ≠ 0) (h6 : (6 : R) ≠ 0)
    (x0 x1 x2 x3 x4 x5 : R)
    (d0 : (5 : R) * x0 ^ 4 * x3 = 0)
    (d1 : (5 : R) * x1 ^ 4 * x4 = 0)
    (d2 : (5 : R) * x2 ^ 4 * x5 = 0)
    (d3 : x0 ^ 5 + (6 : R) * x3 ^ 5 = 0)
    (d4 : x1 ^ 5 + (6 : R) * x4 ^ 5 = 0)
    (d5 : x2 ^ 5 + (6 : R) * x5 ^ 5 = 0) :
    x0 = 0 ∧ x1 = 0 ∧ x2 = 0 ∧ x3 = 0 ∧ x4 = 0 ∧ x5 = 0 := by
  have h03 := gradPair_origin h5 h6 x0 x3 d0 d3
  have h14 := gradPair_origin h5 h6 x1 x4 d1 d4
  have h25 := gradPair_origin h5 h6 x2 x5 d2 d5
  exact ⟨h03.1, h14.1, h25.1, h03.2, h14.2, h25.2⟩

/-- Recognized statement: isolated singularity of the affine cone
    (the projective sextic is smooth). -/
theorem affine_cone_isolated_at_origin [IsDomain R]
    (h5 : (5 : R) ≠ 0) (h6 : (6 : R) ≠ 0)
    (x0 x1 x2 x3 x4 x5 : R)
    (d0 : (5 : R) * x0 ^ 4 * x3 = 0)
    (d1 : (5 : R) * x1 ^ 4 * x4 = 0)
    (d2 : (5 : R) * x2 ^ 4 * x5 = 0)
    (d3 : x0 ^ 5 + (6 : R) * x3 ^ 5 = 0)
    (d4 : x1 ^ 5 + (6 : R) * x4 ^ 5 = 0)
    (d5 : x2 ^ 5 + (6 : R) * x5 ^ 5 = 0) :
    x0 = 0 ∧ x1 = 0 ∧ x2 = 0 ∧ x3 = 0 ∧ x4 = 0 ∧ x5 = 0 :=
  gradient_only_origin h5 h6 x0 x1 x2 x3 x4 x5 d0 d1 d2 d3 d4 d5

theorem five_pow_six : 5 ^ 6 = 15625 := by decide

def planeSpan : Datum (Rat × Rat) (Rat × Rat) Rat where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

/-- Coefficient shadow of [Π] and h² on this special NL host. -/
abbrev span_of_plane_and_hyperplane_square := planeSpan

def construct (gamma : Rat × Rat) : Rat × Rat := gamma

theorem construct_section (gamma : Rat × Rat) :
    planeSpan.cl (construct gamma) = gamma :=
  rfl

instance : CycleSection planeSpan where
  construct := fun γ => construct γ.val
  is_section := fun γ => construct_section γ.val

theorem planeSpan_hodge : planeSpan.HodgeConjecture :=
  hodgeConjecture_of_constructor planeSpan

/-- Same fact under the literature name of the host. -/
theorem special_NL_sextic_coefficient_shadow :
    span_of_plane_and_hyperplane_square.HodgeConjecture :=
  planeSpan_hodge

end SpecialSextic
end Hodge
