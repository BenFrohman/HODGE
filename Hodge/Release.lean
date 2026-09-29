/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.SpecialSextic
import Hodge.NamedFamilies
import Hodge.Clay

/-!
# Release surface — two types, two statuses

Closed:
  `SpecialSextic.contains_two_planes`
  `SpecialSextic.closed_membership`
  `Release.named_host_shadows`   (finite identity shadows; not Clay)

Open:
  `Clay.RationalHodgeCodimTwo`
  `HodgeConjecture.general_fourfold` on an unspecified `Datum`

A term of the first group does not have the type of the second group.
Writing `contains_two_planes` as a proof of Clay is a type error.
-/

namespace Hodge
namespace Release

/-- Official closed name of the two-plane membership theorem. -/
abbrev ContainsTwoPlanes : Prop := SpecialSextic.ClosedMembership

theorem contains_two_planes : ContainsTwoPlanes :=
  SpecialSextic.closed_membership

/-- Finite list of identity-shadow discharges. Not `∀ X ∀ γ`. -/
abbrev NamedHostShadows : Prop := HodgeConjecture.NamedFourfolds

theorem named_host_shadows : NamedHostShadows :=
  HodgeConjecture.named_fourfolds

/-- Clay sentence. Uninhabited. No theorem of this name. -/
abbrev ClaySentence : Prop := Clay.RationalHodgeCodimTwo

/-- Status bookkeeping. Not a mathematical implication. -/
inductive Status where
  | closed
  | open
  deriving DecidableEq, Repr

def status_contains_two_planes : Status := .closed
def status_named_host_shadows : Status := .closed
def status_clay : Status := .open

theorem status_separation :
    status_contains_two_planes = .closed ∧
      status_named_host_shadows = .closed ∧
        status_clay = .open :=
  ⟨rfl, rfl, rfl⟩

end Release
end Hodge
