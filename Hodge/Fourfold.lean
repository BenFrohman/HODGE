/-
Copyright (c) 2026 Ben Frohman (@BenFrohman). Released under the MIT license.
Authors: Ben Frohman (@BenFrohman)
-/
import Hodge.Basic

/-!
# Binders for the Hodge conjecture

The geometric sentence is:

  for every smooth projective complex variety X,
  for every natural number k,
  for every class γ in H^{2k}(X, ℚ) ∩ H^{k,k}(X),
  there exist finitely many codimension-k subvarieties Z_i of X
  and rationals a_i with γ = ∑ a_i [Z_i].

This file writes that sentence in the only language the skeleton has.
It does not prove it. It does not assume it.

`axiom construct_of_codim_ge_two` is not restored. That axiom said the
sentence is true for every `Datum`. `Examples.zeroCycle` shows it is not.
-/

namespace Hodge

variable {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]

/-- One variety, one degree: every Hodge class of `D` is algebraic. -/
def constructOfCodimGeTwo (D : Datum Z V N) (_h : 2 ≤ D.codim) : Prop :=
  ∀ v ∈ D.hodgeClasses, v ∈ D.algebraicClasses

theorem constructOfCodimGeTwo_iff (D : Datum Z V N) (h : 2 ≤ D.codim) :
    constructOfCodimGeTwo D h ↔ D.HodgeConjecture :=
  Iff.rfl

/-- Same sentence, every degree and every object of an incoming type
`Variety`. The skeleton does not construct varieties. `datum k X` is
the caller's packaging of X in degree k as a `Datum`. -/
def HodgeConjecture.forAll
    (Variety : Type*)
    (datum : ℕ → Variety → Datum Z V N) : Prop :=
  ∀ k X, (datum k X).HodgeConjecture

/-- `CycleConstructor D` is the same sentence restricted to one `D`.
An instance is a proof for that `D` only. -/
theorem HodgeConjecture.of_constructor (D : Datum Z V N)
    [CycleConstructor D] : D.HodgeConjecture :=
  hodgeConjecture_of_constructor D

/-- The three classical toys prove `HodgeConjecture` for those three
`Datum` values. They are not terms of `HodgeConjecture.forAll`. -/
def HodgeConjecture.codimTwo (D : Datum Z V N) (_h : D.codim = 2) : Prop :=
  D.HodgeConjecture

theorem HodgeConjecture.codimTwo_iff (D : Datum Z V N) (h : D.codim = 2) :
    HodgeConjecture.codimTwo D h ↔ D.HodgeConjecture :=
  Iff.rfl

theorem codim_two_ge_two (D : Datum Z V N) (h : D.codim = 2) :
    2 ≤ D.codim :=
  h ▸ Nat.le_refl 2

end Hodge
