/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Hodge.Examples
import Hodge.Attempt.GenericObstructed
import Hodge.Attempt.ParameterLocus
import Hodge.Attempt.ClayStatement
import Hodge.Attempt.Grading

/-!
# Vacuity audit of the sandbox (`HodgeAttempt`)

Not imported by `Hodge.lean`. Nothing in earlier files is changed.
-/

namespace Hodge
namespace Attempt
namespace VacuityAudit

/-- `genericObstructedFourfold` is the zero datum `Examples.zeroCycle` (every class
"Hodge", no class "algebraic"); it is not the datum of a variety. -/
theorem genericObstructed_eq_zeroCycle : genericObstructedFourfold = Examples.zeroCycle := rfl

/-- `carriesFermatRecipe` reads a tag, not a polynomial: any codimension carries it once
the tag says so. -/
theorem fermatRecipe_is_tag (k : ℕ) :
    carriesFermatRecipe ⟨k, .fermatLocus true⟩ ∧ ¬ carriesFermatRecipe ⟨k, .kleinQuadric⟩ := by
  simp [carriesFermatRecipe]

/-- `Hypersurface.isSmooth` is an arbitrary `Prop`: a degree-0 "hypersurface" is a smooth
projective fourfold by fiat. -/
theorem isProjectiveFourfold_by_fiat :
    IsProjectiveFourfold ⟨5, 0, True⟩ := ⟨rfl, trivial⟩

/-- `ClayHodgeConjectureCodimTwo` is an opaque predicate on an opaque type, so
`GlobalClayFourfold` has the bare shape `∀ x, P x` with `P` uninterpreted. -/
theorem globalClay_is_shape :
    GlobalClayFourfold = ∀ X : SmoothProjectiveFourfold, ClayHodgeConjectureCodimTwo X := rfl

/-- That shape is true for some predicates and false for others. -/
theorem forall_shape_true_false :
    (∀ _ : Unit, True) ∧ ¬ (∀ _ : Unit, False) :=
  ⟨fun _ => trivial, fun h => h ()⟩

end VacuityAudit
end Attempt
end Hodge
