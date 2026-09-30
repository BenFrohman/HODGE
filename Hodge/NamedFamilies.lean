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

Published theorem name: **Named (2,2) spans**.
Lean: `NamedFourfolds` / `named_fourfolds`.

`FrohmanTwoTwoSpans` is an encoding alias of the same Prop.
It is not Lefschetz and not `general_fourfold`.
A personal geometric name would require a uniform `γ ↦ (Z_i, a_i)`.
That map is not in this file.
-/

namespace Hodge
namespace HodgeConjecture

def NamedFourfolds : Prop :=
  ClassicalFourfolds ∧
    Fermat.twoPlanes.HodgeConjecture ∧
      SpecialSextic.planeSpan.HodgeConjecture ∧
        Hassett.planeSpan.HodgeConjecture

/-- Encoding alias of `NamedFourfolds`. Not a new geometric theorem. -/
def FrohmanTwoTwoSpans : Prop := NamedFourfolds

theorem named_fourfolds : NamedFourfolds :=
  ⟨classical_fourfolds,
    Fermat.twoPlanes_hodge,
    SpecialSextic.planeSpan_hodge,
    Hassett.planeSpan_hodge⟩

theorem frohman_two_two_spans : FrohmanTwoTwoSpans :=
  named_fourfolds

theorem frohman_two_two_spans_iff :
    FrohmanTwoTwoSpans ↔ NamedFourfolds :=
  Iff.rfl

end HodgeConjecture
end Hodge
