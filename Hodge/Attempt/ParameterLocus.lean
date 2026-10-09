/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
SPDX-License-Identifier: Apache-2.0
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
  codim : Nat
  locus : ParameterLocus

def carriesFermatRecipe (D : Tagged) : Prop :=
  match D.locus with
  | .fermatLocus true => True
  | _ => False

def GlobalFermatRecipe : Prop :=
  ∀ D : Tagged, 2 ≤ D.codim → carriesFermatRecipe D

def genericObstructedTag : Tagged where
  codim := (2 : Nat)
  locus := .genericObstructedLocus

theorem generic_tag_has_no_fermat_recipe :
    ¬ carriesFermatRecipe genericObstructedTag := by
  intro h
  simp [carriesFermatRecipe, genericObstructedTag] at h

theorem recipe_is_not_global_constructor : ¬ GlobalFermatRecipe := by
  intro h
  have hcodim : genericObstructedTag.codim = 2 := rfl
  have hle : 2 ≤ genericObstructedTag.codim := by
    rw [hcodim]
    exact Nat.le_refl 2
  exact generic_tag_has_no_fermat_recipe (h genericObstructedTag hle)

end Attempt
end Hodge
