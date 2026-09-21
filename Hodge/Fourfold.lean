/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Basic

/-!
# The variety quantifier

The Hodge conjecture, as this skeleton can write it:

  for every gadget `D` that is a variety, `D.HodgeConjecture`.

That is not "for every gadget." `Examples.zeroCycle` is a gadget and the
sentence fails on it. The deleted axiom said the sentence for every gadget.
That axiom is not restored.

`IsVariety D` is a flag the caller attaches to a `Datum` that is supposed
to come from a smooth projective complex variety. The flag is not a scheme.
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

/-- Correct quantifier: every *variety*-gadget satisfies the sentence.
Not every gadget. No axiom. No term. -/
def HodgeConjecture.forVarieties : Prop :=
  ∀ (D : Datum Z V N), IsVariety D → D.HodgeConjecture

/-- Same sentence over an incoming type the caller calls `Variety`. -/
def HodgeConjecture.forAll
    (Variety : Type*)
    (datum : ℕ → Variety → Datum Z V N) : Prop :=
  ∀ k X, (datum k X).HodgeConjecture

/-- If `D` is flagged as a variety and has a constructor, the sentence holds.
The constructor is still the missing term. -/
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
