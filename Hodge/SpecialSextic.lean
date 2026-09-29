/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Mathlib.Tactic.Ring
import Mathlib.RingTheory.Ideal.Basic
import Hodge.Construct

/-!
# Special Noether–Lefschetz sextic (plane locus)

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6
    Π     = {x3 = x4 = x5 = 0},                 I(Π) = ⟨x3, x4, x5⟩
    Π_{-1} = {x0+x3 = x1+x4 = x2+x5 = 0},         I(Π_{-1}) = ⟨x0+x3, x1+x4, x2+x5⟩

Official closed theorem of this file: `contains_two_planes`.
Type of that theorem: ideal membership in a commutative ring.
That type is not `Clay.RationalHodgeCodimTwo`.

Both planes lie on V(F). `{x0=x1=x2=0}` does not.
Gram of (h², [Π], [Π_{-1}]) has det 2604; that is a lower bound, not Hodge.
Identity-shadow `Datum`s below discharge `Datum.HodgeConjecture` by `rfl`.
That is not Clay. Not general_fourfold.
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
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))

theorem F_mem_plane_minus1 (x0 x1 x2 x3 x4 x5 : R) :
    F x0 x1 x2 x3 x4 x5 ∈ planeIdealMinus1 x0 x1 x2 x3 x4 x5 := by
  rw [F_factors_minus1]
  refine Ideal.add_mem _ (Ideal.add_mem _ ?_ ?_) ?_
  · refine Ideal.mul_mem_right _ _ (Ideal.mul_mem_right _ _ ?_)
    exact Ideal.subset_span (by simp)
  · refine Ideal.mul_mem_right _ _ (Ideal.mul_mem_right _ _ ?_)
    exact Ideal.subset_span (by simp)
  · refine Ideal.mul_mem_right _ _ (Ideal.mul_mem_right _ _ ?_)
    exact Ideal.subset_span (by simp)

/-- Official closed theorem of this file (Frohman, Apache-2.0).
    Both named planes lie on V(F). Type: ring membership. Not Clay. -/
theorem contains_two_planes (x0 x1 x2 x3 x4 x5 : R) :
    F x0 x1 x2 x3 x4 x5 ∈ planeIdeal x3 x4 x5 ∧
      F x0 x1 x2 x3 x4 x5 ∈ planeIdealMinus1 x0 x1 x2 x3 x4 x5 :=
  ⟨F_mem_plane x0 x1 x2 x3 x4 x5,
    F_mem_plane_minus1 x0 x1 x2 x3 x4 x5⟩

/-- Packaged type of the closed theorem. Not `Clay.RationalHodgeCodimTwo`. -/
def ClosedMembership : Prop :=
  ∀ {R : Type*} [CommRing R] (x0 x1 x2 x3 x4 x5 : R),
    F x0 x1 x2 x3 x4 x5 ∈ planeIdeal x3 x4 x5 ∧
      F x0 x1 x2 x3 x4 x5 ∈ planeIdealMinus1 x0 x1 x2 x3 x4 x5

theorem closed_membership : ClosedMembership := by
  intro R _ x0 x1 x2 x3 x4 x5
  exact contains_two_planes x0 x1 x2 x3 x4 x5

theorem hypersurface_contains_the_plane (x0 x1 x2 x3 x4 x5 : R) :
    F x0 x1 x2 x3 x4 x5 ∈ planeIdeal x3 x4 x5 :=
  F_mem_plane x0 x1 x2 x3 x4 x5

theorem hypersurface_contains_the_sign_plane (x0 x1 x2 x3 x4 x5 : R) :
    F x0 x1 x2 x3 x4 x5 ∈ planeIdealMinus1 x0 x1 x2 x3 x4 x5 :=
  F_mem_plane_minus1 x0 x1 x2 x3 x4 x5

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

/-- Arithmetic identity for the 3×3 Gram determinant. Not an intersection proof. -/
theorem gram_det_numeral :
    (6 : Nat) * 21 * 21 - 21 - 21 = 2604 := by decide

/-- Coefficient shadow of ℚ[Π]. `cl = id`. Not a Chow ring. Not Clay. -/
def planeSpan : Datum (Rat × Rat) (Rat × Rat) Rat where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

/-- Coefficient shadow of ℚ h² + ℚ[Π] + ℚ[Π_{-1}]. Still a shadow, not Hodge. -/
def threeSpan : Datum (Rat × Rat × Rat) (Rat × Rat × Rat) Rat where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

abbrev span_of_plane_and_hyperplane_square := planeSpan

def construct (gamma : Rat × Rat) : Rat × Rat := gamma

theorem construct_section (gamma : Rat × Rat) :
    planeSpan.cl (construct gamma) = gamma :=
  rfl

instance : CycleSection planeSpan where
  construct := fun γ => construct γ.val
  is_section := fun γ => construct_section γ.val

def constructThree (gamma : Rat × Rat × Rat) : Rat × Rat × Rat := gamma

theorem constructThree_section (gamma : Rat × Rat × Rat) :
    threeSpan.cl (constructThree gamma) = gamma :=
  rfl

instance : CycleSection threeSpan where
  construct := fun γ => constructThree γ.val
  is_section := fun γ => constructThree_section γ.val

/-- Identity shadow: `cl (id γ) = γ`. Not Clay. -/
theorem planeSpan_identity_shadow : planeSpan.HodgeConjecture :=
  hodgeConjecture_of_constructor planeSpan

/-- Identity shadow: `cl (id γ) = γ`. Not Clay. -/
theorem threeSpan_identity_shadow : threeSpan.HodgeConjecture :=
  hodgeConjecture_of_constructor threeSpan

/-- Retained name. Same type as `planeSpan_identity_shadow`. Not Clay. -/
theorem planeSpan_hodge : planeSpan.HodgeConjecture :=
  planeSpan_identity_shadow

/-- Retained name. Same type as `threeSpan_identity_shadow`. Not Clay. -/
theorem threeSpan_hodge : threeSpan.HodgeConjecture :=
  threeSpan_identity_shadow

theorem special_NL_sextic_coefficient_shadow :
    span_of_plane_and_hyperplane_square.HodgeConjecture :=
  planeSpan_identity_shadow

end SpecialSextic
end Hodge
