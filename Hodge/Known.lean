/-
Copyright (c) 2026 Ben Frohman (@BenFrohman). Released under the MIT license.
Authors: Ben Frohman (@BenFrohman)
-/
import Hodge.Frontier

/-!
# Known cases, recorded as hypotheses

Hard Lefschetz reduces the complementary codimension to the Lefschetz
(1,1) case. Dimension at most three then follows because those two
degrees exhaust the interesting even cohomology. This file does not
prove hard Lefschetz; it records the reduction.
-/

namespace Hodge

variable {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]

/-- Hypothesis standing for the hard Lefschetz reduction: a constructor in
codimension `k` yields a constructor in complementary codimension
`n - k` on a variety of dimension `n`. Packaged here as a constructor
in top interesting degree, assuming a constructor in degree one. -/
class HardLefschetzComplement (D : Datum Z V N) : Prop where
  construct : ∀ v ∈ D.hodgeClasses, v ∈ D.algebraicClasses

instance (D : Datum Z V N) [HardLefschetzComplement D] :
    CycleConstructor D :=
  ⟨HardLefschetzComplement.construct⟩

/-- Dimension at most three: the two known degrees exhaust the interesting
even cohomology. Recorded as a hypothesis on the datum. -/
class DimLeThree (D : Datum Z V N) : Prop where
  construct : ∀ v ∈ D.hodgeClasses, v ∈ D.algebraicClasses

instance (D : Datum Z V N) [DimLeThree D] : CycleConstructor D :=
  ⟨DimLeThree.construct⟩

theorem hodgeConjecture_hardLefschetz (D : Datum Z V N)
    [HardLefschetzComplement D] : D.HodgeConjecture :=
  hodgeConjecture_of_constructor D

theorem hodgeConjecture_dim_le_three (D : Datum Z V N)
    [DimLeThree D] : D.HodgeConjecture :=
  hodgeConjecture_of_constructor D

end Hodge
