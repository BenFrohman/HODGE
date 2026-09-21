/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Basic
import Hodge.Classical
import Hodge.Construct

/-!
# Named hypothesis for the first open case

`construct_of_codim_ge_two` is a guarded axiom.
The instance is introduced with `letI`, not a named `inst :=` argument.
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

axiom construct_of_codim_ge_two
    (D : Datum Z V N) [IsVariety D] (_h : 2 ≤ D.codim) :
    CycleConstructor D

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

/-- Bring the axiom in as a local instance. No `inst :=` named argument. -/
theorem HodgeConjecture.of_variety_codim_ge_two
    (D : Datum Z V N) [IsVariety D] (h : 2 ≤ D.codim) :
    D.HodgeConjecture := by
  letI : CycleConstructor D := construct_of_codim_ge_two D h
  exact hodgeConjecture_of_constructor D

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

theorem HodgeConjecture.general_fourfold
    (D : Datum Z V N) [IsVariety D] (h : D.codim = 2) :
    D.HodgeConjecture :=
  HodgeConjecture.of_variety_codim_ge_two D (codim_two_ge_two D h)

end Hodge
