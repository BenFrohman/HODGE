/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/

/-!
# The Fermat recipe is not a global constructor

This file records the *true* universal that failed:
the ζ-plane identity does not hold for every gadget of codimension 2.

It does not assert ¬ HodgeConjecture on an `IsVariety`.
Not imported by `Hodge.lean`.
-/

namespace Hodge
namespace Attempt

structure RecipeDatum where
  codim : ℕ
  hasFermatFactorization : Bool

def FermatRecipe (D : RecipeDatum) : Prop :=
  D.hasFermatFactorization = true

def GlobalFermatRecipeConstructor : Prop :=
  ∀ D : RecipeDatum, 2 ≤ D.codim → FermatRecipe D

def offLocusGadget : RecipeDatum where
  codim := 2
  hasFermatFactorization := false

theorem recipe_is_not_global_constructor :
    ¬ GlobalFermatRecipeConstructor := by
  intro hGlobal
  have hSpec := hGlobal offLocusGadget (by decide)
  unfold FermatRecipe at hSpec
  exact Bool.noConfusion hSpec

end Attempt
end Hodge
