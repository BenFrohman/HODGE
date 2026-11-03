/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Examples
import Hodge.Fourfold
import Hodge.NamedFamilies
import Hodge.RealClose
import Hodge.Geometry

/-!
# Living skeleton

Packages the compiled theorems of this library and names the open hole.

This is not `general_fourfold` for unspecified `D`.
This is not a Clay close.
-/

namespace Hodge
namespace HodgeConjecture

/-- Compiled skeleton theorems, as a single conjunction. -/
def LivingSkeleton : Prop :=
  Examples.zeroCycle.codim = 2 ∧
  ¬ Examples.zeroCycle.HodgeConjecture ∧
  NamedFourfolds

/-- The skeleton as it actually stands. -/
theorem living_skeleton : LivingSkeleton :=
  ⟨rfl, Examples.zeroCycle_not_hodge, named_fourfolds⟩

/-- Ungated `∀ D, D.codim = 2 → D.HodgeConjecture` is false. -/
theorem ungated_codim_two_false :
    ¬ (∀ (Z V N : Type*)
        [AddCommGroup Z] [Module Rat Z]
        [AddCommGroup V] [Module Rat V]
        [AddCommGroup N] [Module Rat N]
        (D : Datum Z V N), D.codim = 2 → D.HodgeConjecture) :=
  Examples.not_every_codim_ge_two

/-- Named hosts package to `RealClose`. Not `∀ D`. -/
theorem realClose_projectiveFourSpace :
    RealClose Classical.projectiveFourSpace rfl :=
  realClose_of_section _ rfl

theorem realClose_kleinQuadric :
    RealClose Classical.kleinQuadric rfl :=
  realClose_of_section _ rfl

theorem realClose_productOfPlanes :
    RealClose Classical.productOfPlanes rfl :=
  realClose_of_section _ rfl

/-- Open hole. Do not fill. -/
def missingBody (D : Datum Rat Rat Rat) (_h : D.codim = 2) : Type _ :=
  CycleSection D

end HodgeConjecture
end Hodge
