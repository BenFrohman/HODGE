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

Public name of this list: **Frohman (2,2) Spans**.
Lean name: `FrohmanTwoTwoSpans`.

It is `NamedFourfolds`. It is not Lefschetz. It is not `general_fourfold`.
-/

namespace Hodge
namespace HodgeConjecture

def NamedFourfolds : Prop :=
  ClassicalFourfolds ∧
    Fermat.twoPlanes.HodgeConjecture ∧
      SpecialSextic.planeSpan.HodgeConjecture ∧
        Hassett.planeSpan.HodgeConjecture

/-- Public name of the proved finite list. Same Prop as `NamedFourfolds`. -/
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
