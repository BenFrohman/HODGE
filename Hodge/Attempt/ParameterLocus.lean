/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/

/-!
# Tags for the Fermat recipe, not a moduli space

`IsValidVariety` here is not `Hodge.IsVariety`.
Not imported by `Hodge.lean`.
-/

namespace Hodge
namespace Attempt

inductive ParameterLocus
  | projectiveFourSpace
  | kleinQuadric
  | productOfPlanes
  | fermatLocus (ζfourEqNegOne : Bool)
  | genericObstructedLocus

structure Tagged where
  codim : ℕ
  locus : ParameterLocus

def carriesFermatRecipe (D : Tagged) : Prop :=
  match D.locus with
  | .fermatLocus true => True
  | _ => False

def GlobalFermatRecipe : Prop :=
  ∀ D : Tagged, 2 ≤ D.codim → carriesFermatRecipe D

def genericObstructedTag : Tagged :=
  { codim := 2, locus := .genericObstructedLocus }

theorem recipe_is_not_global_constructor : ¬ GlobalFermatRecipe := by
  intro h
  exact h genericObstructedTag (by decide)

theorem generic_tag_has_no_fermat_recipe :
    ¬ carriesFermatRecipe genericObstructedTag := by
  decide

end Attempt
end Hodge
