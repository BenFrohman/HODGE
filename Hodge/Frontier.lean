/-
Copyright (c) 2026 Ben Frohman (@BenFrohman). Released under the MIT license.
Authors: Ben Frohman (@BenFrohman)
-/
import Hodge.Basic

/-!
# The frontier

Lefschetz (1,1) is the one case in which a constructor is known in
mathematics. This file records that fact as a hypothesis on data of
codimension one. It does not reconstruct the exponential sequence or GAGA.
-/

namespace Hodge

variable {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]

/-- Hypothesis standing for Lefschetz (1,1): on any datum of codimension one,
every Hodge class is algebraic. -/
class LefschetzOneOne (D : Datum Z V N) : Prop where
  is_codim_one : D.codim = 1
  construct : ∀ v ∈ D.hodgeClasses, v ∈ D.algebraicClasses

instance (D : Datum Z V N) [LefschetzOneOne D] : CycleConstructor D :=
  ⟨LefschetzOneOne.construct⟩

/-- Codimension one is settled, relative to the Lefschetz (1,1) hypothesis. -/
theorem hodgeConjecture_codim_one (D : Datum Z V N) [LefschetzOneOne D] :
    D.HodgeConjecture :=
  hodgeConjecture_of_constructor D

end Hodge
