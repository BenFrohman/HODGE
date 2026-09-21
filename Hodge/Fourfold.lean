/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Basic
import Hodge.Classical
import Hodge.Construct

/-!
# Discharged theorem: `classical_fourfolds`

Use this theorem for the three islands. It is proved by `CycleSection`.
`#print axioms HodgeConjecture.classical_fourfolds` is `propext` and `Quot.sound`.

`HodgeConjecture.general_fourfold` remains a `Prop` with no term.
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

theorem HodgeConjecture.p4 :
    Classical.projectiveFourSpace.HodgeConjecture :=
  HodgeConjecture.classical_fourfolds.1

theorem HodgeConjecture.klein :
    Classical.kleinQuadric.HodgeConjecture :=
  HodgeConjecture.classical_fourfolds.2.1

theorem HodgeConjecture.product :
    Classical.productOfPlanes.HodgeConjecture :=
  HodgeConjecture.classical_fourfolds.2.2

theorem HodgeConjecture.p4_isVariety :
    HodgeConjecture.general_fourfold
      (D := Classical.projectiveFourSpace) (by rfl) :=
  HodgeConjecture.p4

theorem HodgeConjecture.klein_isVariety :
    HodgeConjecture.general_fourfold
      (D := Classical.kleinQuadric) (by rfl) :=
  HodgeConjecture.klein

theorem HodgeConjecture.product_isVariety :
    HodgeConjecture.general_fourfold
      (D := Classical.productOfPlanes) (by rfl) :=
  HodgeConjecture.product

theorem codim_two_ge_two (D : Datum Z V N) (h : D.codim = 2) :
    2 ≤ D.codim :=
  h ▸ Nat.le_refl 2

def HodgeConjecture.general_fourfold
    (D : Datum Z V N) [IsVariety D] (_h : D.codim = 2) : Prop :=
  D.HodgeConjecture

theorem HodgeConjecture.general_fourfold_iff
    (D : Datum Z V N) [IsVariety D] (h : D.codim = 2) :
    HodgeConjecture.general_fourfold D h ↔ D.HodgeConjecture :=
  Iff.rfl

end Hodge
