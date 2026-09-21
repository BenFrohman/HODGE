/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Basic

/-!
# The frontier

Lefschetz (1,1) is the known constructor in mathematics.
A K3 surface is dimension 2, so its Hodge classes are codimension 1.
That case is this file. It is not `classical_fourfolds`.
-/

namespace Hodge

variable {Z V N : Type*}
    [AddCommGroup Z] [Module Rat Z]
    [AddCommGroup V] [Module Rat V]
    [AddCommGroup N] [Module Rat N]

class LefschetzOneOne (D : Datum Z V N) : Prop where
  is_codim_one : D.codim = 1
  construct : ∀ v ∈ D.hodgeClasses, v ∈ D.algebraicClasses

instance (D : Datum Z V N) [LefschetzOneOne D] : CycleConstructor D :=
  ⟨LefschetzOneOne.construct⟩

theorem hodgeConjecture_codim_one (D : Datum Z V N) [LefschetzOneOne D] :
    D.HodgeConjecture :=
  hodgeConjecture_of_constructor D

/-- Linear shadow of a K3 surface. Codim 1. Not a scheme. Not a fourfold. -/
def k3Surface : Datum Rat Rat Rat where
  codim := 1
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro _; rfl

instance : LefschetzOneOne k3Surface where
  is_codim_one := rfl
  construct := fun v _ => ⟨v, rfl⟩

theorem k3Surface_hodge : k3Surface.HodgeConjecture :=
  hodgeConjecture_codim_one k3Surface

theorem k3Surface_codim : k3Surface.codim = 1 :=
  rfl

end Hodge
