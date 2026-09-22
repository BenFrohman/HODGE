/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Basic
import Hodge.Classical
import Hodge.Construct

/-!
# Two sentences

`ClassicalFourfolds` — discharged on three specified hosts.
`general_fourfold` / `LefschetzTwoTwo` — the same uninhabited Prop.
`Iff.rfl` renames. It does not write z.
-/

namespace Hodge

variable {Z V N : Type*}
    [AddCommGroup Z] [Module Rat Z]
    [AddCommGroup V] [Module Rat V]
    [AddCommGroup N] [Module Rat N]

theorem HodgeConjecture.of_constructor (D : Datum Z V N)
    [CycleConstructor D] : D.HodgeConjecture :=
  hodgeConjecture_of_constructor D

theorem HodgeConjecture.of_section (D : Datum Z V N) [CycleSection D] :
    D.HodgeConjecture :=
  hodgeConjecture_of_constructor D

def HodgeConjecture.ClassicalFourfolds : Prop :=
  Classical.projectiveFourSpace.HodgeConjecture ∧
    Classical.kleinQuadric.HodgeConjecture ∧
      Classical.productOfPlanes.HodgeConjecture

theorem HodgeConjecture.classical_fourfolds :
    HodgeConjecture.ClassicalFourfolds :=
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

/-- Hodge at codimension 2. No term for unspecified `D`. -/
def HodgeConjecture.general_fourfold
    (D : Datum Z V N) (_h : D.codim = 2) : Prop :=
  D.HodgeConjecture

/-- Official name of the same sentence. Not a proof. -/
def HodgeConjecture.LefschetzTwoTwo
    (D : Datum Z V N) (h : D.codim = 2) : Prop :=
  HodgeConjecture.general_fourfold D h

theorem HodgeConjecture.general_fourfold_iff
    (D : Datum Z V N) (h : D.codim = 2) :
    HodgeConjecture.general_fourfold D h ↔ D.HodgeConjecture :=
  Iff.rfl

theorem HodgeConjecture.LefschetzTwoTwo_iff
    (D : Datum Z V N) (h : D.codim = 2) :
    HodgeConjecture.LefschetzTwoTwo D h ↔
      HodgeConjecture.general_fourfold D h :=
  Iff.rfl

end Hodge
