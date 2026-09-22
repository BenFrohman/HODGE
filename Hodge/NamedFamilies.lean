/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman).
Released under Apache-2.0 as described in LICENSE.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Fourfold
import Hodge.Fermat
import Hodge.Hassett
import Hodge.SpecialSextic

/-!
# Extended release: more named hosts

Adding named families to a finite conjunction does **not** close Hodge.
`general_fourfold` stays uninhabited.
-/

namespace Hodge

def HodgeConjecture.NamedFamilies : Prop :=
  HodgeConjecture.ClassicalFourfolds ∧
    Fermat.twoPlanes.HodgeConjecture ∧
      Hassett.planeSpan.HodgeConjecture ∧
        SpecialSextic.planeSpan.HodgeConjecture

theorem HodgeConjecture.named_families :
    HodgeConjecture.NamedFamilies :=
  ⟨HodgeConjecture.classical_fourfolds,
    Fermat.twoPlanes_hodge,
    Hassett.planeSpan_hodge,
    SpecialSextic.planeSpan_hodge⟩

end Hodge
