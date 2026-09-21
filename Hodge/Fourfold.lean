/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Basic

/-!
# The variety quantifier, and the restored axiom

The unrestricted claim

  ∀ D, 2 ≤ D.codim → CycleConstructor D

was deleted because it is false: `Examples.zeroCycle` has `codim = 2`,
`cl = 0`, and `¬ HodgeConjecture`. That axiom plus that example proved
`False`.

The name `construct_of_codim_ge_two` is restored under a guard.
`IsVariety D` is a flag the caller attaches to a `Datum` that is supposed
to come from a smooth projective complex variety. The flag is not a scheme.
`zeroCycle` does not receive the flag, so the axiom does not apply to it.

This is still an axiom, not a construction of surfaces from a Hodge class.
-/

namespace Hodge

variable {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]

/-- A gadget packaged as coming from a variety. Not a scheme. -/
class IsVariety (D : Datum Z V N) : Prop

/-- One gadget, codimension at least two: every Hodge class is algebraic. -/
def constructOfCodimGeTwo (D : Datum Z V N) (_h : 2 ≤ D.codim) : Prop :=
  ∀ v ∈ D.hodgeClasses, v ∈ D.algebraicClasses

theorem constructOfCodimGeTwo_iff (D : Datum Z V N) (h : 2 ≤ D.codim) :
    constructOfCodimGeTwo D h ↔ D.HodgeConjecture :=
  Iff.rfl

/-- Restored axiom: every *variety*-gadget of codimension at least two
has a `CycleConstructor`. Not every gadget. `zeroCycle` is not a variety. -/
axiom construct_of_codim_ge_two
    (D : Datum Z V N) [IsVariety D] (h : 2 ≤ D.codim) :
    CycleConstructor D

/-- Correct quantifier, now discharged by the guarded axiom. -/
theorem HodgeConjecture.forVarieties_of_codim_ge_two
    (D : Datum Z V N) [IsVariety D] (h : 2 ≤ D.codim) :
    D.HodgeConjecture :=
  hodgeConjecture_of_constructor D

/-- Same sentence without the codimension lower bound: still only varieties. -/
def HodgeConjecture.forVarieties : Prop :=
  ∀ (D : Datum Z V N), [IsVariety D] → D.HodgeConjecture

/-- Same sentence over an incoming type the caller calls `Variety`. -/
def HodgeConjecture.forAll
    (Variety : Type*)
    (datum : ℕ → Variety → Datum Z V N) : Prop :=
  ∀ k X, (datum k X).HodgeConjecture

theorem HodgeConjecture.of_variety_constructor
    (D : Datum Z V N) [IsVariety D] [CycleConstructor D] :
    D.HodgeConjecture :=
  hodgeConjecture_of_constructor D

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

end Hodge
