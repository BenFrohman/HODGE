/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Examples
import Hodge.Fourfold
import Hodge.NamedFamilies
import Hodge.RealClose
import Hodge.Geometry
import Mathlib.Algebra.Module.ULift

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

universe u v w

/-- `zeroCycle` lifted to arbitrary universes: `cl = 0` on `ULift ℚ`, codim 2. -/
def zeroCycleLift : Datum (ULift.{u} ℚ) (ULift.{v} ℚ) (ULift.{w} ℚ) where
  codim := 2
  obstruction := 0
  cl := 0
  cl_isHodge := by intro _; rfl

theorem zeroCycleLift_not_hodge : ¬ (zeroCycleLift.{u, v, w}).HodgeConjecture := by
  intro h
  have hone : (ULift.up (1 : ℚ) : ULift.{v} ℚ) ∈ (zeroCycleLift.{u, v, w}).hodgeClasses := by
    simp [Datum.hodgeClasses, zeroCycleLift]
  obtain ⟨z, hz⟩ := h hone
  have h0 := congrArg ULift.down hz
  simp [zeroCycleLift] at h0

/-- Ungated `∀ D, D.codim = 2 → D.HodgeConjecture` is false, in every universe. -/
theorem ungated_codim_two_false :
    ¬ (∀ (Z : Type u) (V : Type v) (N : Type w)
        [AddCommGroup Z] [Module Rat Z]
        [AddCommGroup V] [Module Rat V]
        [AddCommGroup N] [Module Rat N]
        (D : Datum Z V N), D.codim = 2 → D.HodgeConjecture) := by
  intro h
  exact zeroCycleLift_not_hodge.{u, v, w} (h _ _ _ zeroCycleLift rfl)

/-- Named hosts package to `RealClose`. Not `∀ D`. -/
def realClose_projectiveFourSpace :
    RealClose Classical.projectiveFourSpace rfl :=
  realClose_of_section _ rfl

def realClose_kleinQuadric :
    RealClose Classical.kleinQuadric rfl :=
  realClose_of_section _ rfl

def realClose_productOfPlanes :
    RealClose Classical.productOfPlanes rfl :=
  realClose_of_section _ rfl

/-- Open hole. Do not fill. -/
def missingBody (D : Datum Rat Rat Rat) (_h : D.codim = 2) : Type _ :=
  CycleSection D

end HodgeConjecture
end Hodge
