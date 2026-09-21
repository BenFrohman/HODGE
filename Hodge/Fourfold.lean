/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Basic
import Hodge.Classical
import Hodge.Construct

/-!
# Named hypothesis for the first open case

`construct_of_codim_ge_two` is restored as a guarded axiom.

It is important as a label: theorems that need the claim can name it.
It is not a `CycleSection`. It does not send a class to a cycle.

The unguarded form `∀ D, 2 ≤ D.codim → CycleConstructor D` is not restored.
Together with `Examples.zeroCycle` that form is `False`.
-/

namespace Hodge

variable {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]

/-- A gadget packaged as coming from a variety. Not a scheme. -/
class IsVariety (D : Datum Z V N) : Prop

instance : IsVariety Classical.projectiveFourSpace := {}
instance : IsVariety Classical.kleinQuadric := {}
instance : IsVariety Classical.productOfPlanes := {}

/-- Named hypothesis. Guarded by `IsVariety`.
Not a function to cycles. -/
axiom construct_of_codim_ge_two
    (D : Datum Z V N) [IsVariety D] (_h : 2 ≤ D.codim) :
    CycleConstructor D

/-- The same sentence as a proposition, without using the axiom. -/
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

theorem HodgeConjecture.of_variety_codim_ge_two
    (D : Datum Z V N) [IsVariety D] (h : 2 ≤ D.codim) :
    D.HodgeConjecture :=
  hodgeConjecture_of_constructor D (inst := construct_of_codim_ge_two D h)

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

/-- The named hypothesis, specialised to codimension two.
`#print axioms` on this theorem lists `construct_of_codim_ge_two`. -/
theorem HodgeConjecture.general_fourfold
    (D : Datum Z V N) [IsVariety D] (h : D.codim = 2) :
    D.HodgeConjecture :=
  HodgeConjecture.of_variety_codim_ge_two D (codim_two_ge_two D h)

end Hodge
