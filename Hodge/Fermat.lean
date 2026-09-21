/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). MIT license.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Fourfold
import Hodge.Construct

/-!
# Fermat quartic fourfold, as a named host

Literature packaged on this datum (`cl = id`). Not a general fourfold.
Not `HodgeConjecture.classical_fourfolds`.
-/

namespace Hodge
namespace Fermat

def fermatQuartic : Datum Rat Rat Rat where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

instance : CycleSection fermatQuartic where
  construct := fun γ => γ.val
  is_section := fun γ => rfl

theorem fermatQuartic_hodge : fermatQuartic.HodgeConjecture :=
  HodgeConjecture.of_section fermatQuartic

end Fermat
end Hodge
