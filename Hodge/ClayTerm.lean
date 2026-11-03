/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Clay
import Hodge.Construct
import Hodge.SpecialSextic
import Hodge.Release

/-!
# The missing Clay term, under its correct name

`RationalHodgeCodimTwo` is a `Prop` (`∀ X ∀ γ, ∃ z`).
The missing *term* is a section of `ofAlgebraic`:

    UniformConstruct :
      ∀ X ∀ γ, { z : AlgebraicSpan X // ofAlgebraic z = γ }

A term of `UniformConstruct` forgets to a term of `RationalHodgeCodimTwo`.
That forgetful map is written. The section itself is not.

Wrong names for this object (existing terms that do *not* unify):

* `SpecialSextic.contains_two_planes` — ring membership on one host
* `CycleSection.construct` on a named `Datum` — section after `X` is fixed
* `HodgeConjecture.of_section` — implication `[CycleSection D] → D.HodgeConjecture`
* `planeSpan_hodge` / `planeSpan_identity_shadow` — `cl = id` on coefficients
* `HodgeConjecture.named_fourfolds` — finite list

`grind` cannot turn any of those into `UniformConstruct`.
-/

namespace Hodge
namespace Clay

/-- Correct name of the missing Clay object.
    A term of this type is a Clay close. No term is supplied. -/
def UniformConstruct : Type :=
  ∀ (X : SmoothComplexProjectiveFourfold) (γ : Hdg2 X),
    { z : AlgebraicSpan X // ofAlgebraic z = γ }

/-- Forgetting the subtype witness yields the Clay `Prop`. -/
def ofUniformConstruct (t : UniformConstruct) : RationalHodgeCodimTwo :=
  fun X γ => ⟨(t X γ).1, (t X γ).2⟩

/-- Skeleton analogue: a section on one `Datum` implies that datum's Prop.
    This is not a uniform section. -/
theorem of_section_is_not_uniform {Z V N : Type*}
    [AddCommGroup Z] [Module Rat Z]
    [AddCommGroup V] [Module Rat V]
    [AddCommGroup N] [Module Rat N]
    (D : Datum Z V N) [CycleSection D] :
    D.HodgeConjecture :=
  HodgeConjecture.of_section D

end Clay

namespace Release

/-- Inventory: every named construct, with the type it actually has. -/
structure NamedTerm where
  name : String
  isUniformConstruct : Bool

def inventory : List NamedTerm :=
  [ { name := "SpecialSextic.contains_two_planes", isUniformConstruct := false }
  , { name := "SpecialSextic.closed_membership", isUniformConstruct := false }
  , { name := "SpecialSextic.planeSpan_identity_shadow", isUniformConstruct := false }
  , { name := "SpecialSextic.construct", isUniformConstruct := false }
  , { name := "Classical.constructP4", isUniformConstruct := false }
  , { name := "Classical.construct", isUniformConstruct := false }
  , { name := "Classical.constructProduct", isUniformConstruct := false }
  , { name := "Fermat.construct", isUniformConstruct := false }
  , { name := "Hassett.construct", isUniformConstruct := false }
  , { name := "HodgeConjecture.of_section", isUniformConstruct := false }
  , { name := "HodgeConjecture.named_fourfolds", isUniformConstruct := false }
  , { name := "Release.contains_two_planes", isUniformConstruct := false }
  , { name := "Clay.UniformConstruct", isUniformConstruct := true }
  ]

theorem inventory_uniform_count :
    (inventory.filter (·.isUniformConstruct)).length = 1 := by
  native_decide

theorem only_uniformConstruct_is_flagged :
    (inventory.filter (·.isUniformConstruct)).map (·.name) =
      ["Clay.UniformConstruct"] := by
  native_decide

/-- The flagged name is a type, not a theorem. There is still no inhabitant. -/
def missingTermType : Type := Clay.UniformConstruct

end Release
end Hodge
