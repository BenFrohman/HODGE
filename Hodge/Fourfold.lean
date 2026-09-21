/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Basic
import Hodge.Classical

/-!
# construct_of_codim_ge_two

Restored axiom, with the guard that was missing when the unrestricted
version proved `False`.

`Examples.zeroCycle` has `codim = 2` and `¬ HodgeConjecture`. An axiom
quantified over every `Datum` of codimension at least two is therefore
false as linear algebra. That version is not restored.

This file restores the name as an axiom on data flagged `IsVariety`.
The flag is not a scheme. `zeroCycle` does not carry it. The three
classical islands do.
-/

namespace Hodge

variable {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]

/-- A gadget packaged as coming from a smooth projective complex variety.
Not a scheme. -/
class IsVariety (D : Datum Z V N) : Prop

instance : IsVariety Classical.projectiveFourSpace := {}
instance : IsVariety Classical.kleinQuadric := {}
instance : IsVariety Classical.productOfPlanes := {}

/-- Restored axiom. Guarded: only data flagged `IsVariety`.
Not every `Datum` of codimension at least two. -/
axiom construct_of_codim_ge_two
    (D : Datum Z V N) [IsVariety D] (_h : 2 ≤ D.codim) :
    CycleConstructor D

/-- The open problem, as a proposition, without the axiom. -/
def constructOfCodimGeTwo (D : Datum Z V N) (_h : 2 ≤ D.codim) : Prop :=
  ∀ v ∈ D.hodgeClasses, v ∈ D.algebraicClasses

theorem constructOfCodimGeTwo_iff (D : Datum Z V N) (h : 2 ≤ D.codim) :
    constructOfCodimGeTwo D h ↔ D.HodgeConjecture :=
  Iff.rfl

/-- From the restored axiom: a variety-gadget of codimension at least two
satisfies the conjecture. Depends on `construct_of_codim_ge_two`. -/
theorem HodgeConjecture.of_variety_codim_ge_two
    (D : Datum Z V N) [IsVariety D] (h : 2 ≤ D.codim) :
    D.HodgeConjecture :=
  hodgeConjecture_of_constructor D (inst := construct_of_codim_ge_two D h)

theorem HodgeConjecture.of_constructor (D : Datum Z V N)
    [CycleConstructor D] : D.HodgeConjecture :=
  hodgeConjecture_of_constructor D

def HodgeConjecture.codimTwo (D : Datum Z V N) (_h : D.codim = 2) : Prop :=
  D.HodgeConjecture

theorem HodgeConjecture.codimTwo_iff (D : Datum Z V N) (h : D.codim = 2) :
    HodgeConjecture.codimTwo D h ↔ D.HodgeConjecture :=
  Iff.rfl

theorem codim_two_ge_two (D : Datum Z V N) (h : D.codim = 2) :
    2 ≤ D.codim :=
  h ▸ Nat.le_refl 2

/-- Named packaging of the restored axiom on a variety-gadget of
codimension two. -/
theorem HodgeConjecture.general_fourfold
    (D : Datum Z V N) [IsVariety D] (h : D.codim = 2) :
    D.HodgeConjecture :=
  HodgeConjecture.of_variety_codim_ge_two D (codim_two_ge_two D h)

end Hodge
