/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Basic
import Hodge.Classical
import Hodge.Construct

/-!
# Discharged term: `classical_fourfolds`

Easy arrow: `Datum.cl_isHodge`.
Hard arrow on the three islands: `HodgeConjecture.classical_fourfolds`.
There is no `general_fourfold` name in this file.
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

end Hodge
