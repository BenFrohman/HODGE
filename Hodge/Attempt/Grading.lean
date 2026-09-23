/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Mathlib.Data.Nat.Basic

/-!
# Grading of a hypersurface in ℙ⁵

Complex dimension 4, middle surfaces dimension 2, cycle codimension 2.
Independent of degree. Not imported by `Hodge.lean`.
Does not mention remainders and does not define genericObstructedFourfold.
-/

namespace Hodge
namespace Attempt

structure Hypersurface where
  ambientDim : ℕ
  degree : ℕ
  isSmooth : Prop

def IsProjectiveFourfold (X : Hypersurface) : Prop :=
  X.ambientDim = 5 ∧ X.isSmooth

def complexDimension (X : Hypersurface) : ℕ :=
  X.ambientDim - 1

theorem fourfold_complex_dim_eq_four {X : Hypersurface}
    (hX : IsProjectiveFourfold X) :
    complexDimension X = 4 := by
  unfold complexDimension IsProjectiveFourfold at *
  rcases hX with ⟨hAmb, _⟩
  simp [hAmb]

def middleCycleDimension (X : Hypersurface) : ℕ :=
  complexDimension X / 2

def cycleCodimension (X : Hypersurface) (cycleDim : ℕ) : ℕ :=
  complexDimension X - cycleDim

theorem middle_cycle_dim_eq_two {X : Hypersurface}
    (hX : IsProjectiveFourfold X) :
    middleCycleDimension X = 2 := by
  unfold middleCycleDimension
  rw [fourfold_complex_dim_eq_four hX]

theorem middle_cycle_codimension_is_two {X : Hypersurface}
    (hX : IsProjectiveFourfold X) :
    cycleCodimension X (middleCycleDimension X) = 2 := by
  unfold cycleCodimension
  rw [fourfold_complex_dim_eq_four hX, middle_cycle_dim_eq_two hX]

end Attempt
end Hodge
