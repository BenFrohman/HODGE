/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Basic
import Hodge.Classical
import Hodge.Construct

/-!
# Open case, no axiom

`construct_of_codim_ge_two` is not an axiom. The sentence is a `Prop`.
There is no term of that `Prop` for a general fourfold.

`#print axioms HodgeConjecture.classical_fourfolds` does not list a
project axiom: the three islands have `CycleSection` instances.

`HodgeConjecture.general_fourfold` is the same sentence as a definition.
It is not a theorem. `#print axioms` is not run on a definition.
-/

namespace Hodge

variable {Z V N : Type*}
    [AddCommGroup Z] [Module Rat Z]
    [AddCommGroup V] [Module Rat V]
    [AddCommGroup N] [Module Rat N]

class IsVariety (D : Datum Z V N) : Prop

instance : IsVariety Classical.projectiveFourSpace := {}
instance : IsVariety Classical.kleinQuadric := {}
instance : IsVariety Classical.productOfPlanes := {}

/-- Open sentence. Not an axiom. Not a theorem. -/
def constructOfCodimGeTwo (D : Datum Z V N) (_h : 2 ≤ D.codim) : Prop :=
  ∀ v ∈ D.hodgeClasses, v ∈ D.algebraicClasses

theorem constructOfCodimGeTwo_iff (D : Datum Z V N) (h : 2 ≤ D.codim) :
    constructOfCodimGeTwo D h ↔ D.HodgeConjecture :=
  Iff.rfl

theorem HodgeConjecture.of_constructor (D : Datum Z V N)
    [CycleConstructor D] : D.HodgeConjecture :=
  hodgeConjecture_of_constructor D

theorem HodgeConjecture.of_section (D : Datum Z V N) [CycleSection D] :
    D.HodgeConjecture :=
  hodgeConjecture_of_constructor D

theorem HodgeConjecture.classical_fourfolds :
    Classical.projectiveFourSpace.HodgeConjecture ∧
      Classical.kleinQuadric.HodgeConjecture ∧
        Classical.productOfPlanes.HodgeConjecture :=
  ⟨HodgeConjecture.of_section _,
    HodgeConjecture.of_section _,
    HodgeConjecture.of_section _⟩

theorem codim_two_ge_two (D : Datum Z V N) (h : D.codim = 2) :
    2 ≤ D.codim :=
  h ▸ Nat.le_refl 2

/-- The open case, as a proposition. No axiom. No proof. -/
def HodgeConjecture.general_fourfold
    (D : Datum Z V N) [IsVariety D] (h : D.codim = 2) : Prop :=
  D.HodgeConjecture

theorem HodgeConjecture.general_fourfold_iff
    (D : Datum Z V N) [IsVariety D] (h : D.codim = 2) :
    HodgeConjecture.general_fourfold D h ↔ D.HodgeConjecture :=
  Iff.rfl

end Hodge
