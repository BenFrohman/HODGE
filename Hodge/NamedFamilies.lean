/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Fourfold
import Hodge.Fermat
import Hodge.SpecialSextic
import Hodge.Hassett

/-!
# Finite conjunction of named hosts

This extends the three-island release by the families that now have
`CycleSection`. It is still a finite list. It is not `general_fourfold`.
-/

namespace Hodge
namespace HodgeConjecture

def NamedFourfolds : Prop :=
  ClassicalFourfolds ∧
    Fermat.twoPlanes.HodgeConjecture ∧
      SpecialSextic.planeSpan.HodgeConjecture ∧
        Hassett.planeSpan.HodgeConjecture

theorem named_fourfolds : NamedFourfolds :=
  ⟨classical_fourfolds,
    Fermat.twoPlanes_hodge,
    SpecialSextic.planeSpan_hodge,
    Hassett.planeSpan_hodge⟩

end HodgeConjecture
end Hodge
