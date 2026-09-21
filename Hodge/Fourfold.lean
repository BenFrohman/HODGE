/-
Copyright (c) 2026 Ben Frohman (@BenFrohman). Released under the MIT license.
Authors: Ben Frohman (@BenFrohman)
-/
import Hodge.Basic

/-!
# The first open case, as a type — not as an axiom

The source note states the first open case as follows.

Let `X` be a general fourfold and let `γ ∈ Hdg²(X)` be arbitrary. The
missing object is a finite collection of surfaces `Zᵢ ⊂ X` and rationals
`aᵢ ∈ ℚ` such that `γ = ∑ aᵢ [Zᵢ]`. Writing the `Zᵢ` down from `γ` would
be a section of `cl`.

That paragraph specifies the *type* of `CycleConstructor.construct` on a
datum of codimension `2`. It does not supply a *term* of that type.

An earlier version of this file recorded the missing term as
`axiom construct_of_codim_ge_two`, quantified over every `Datum` with
`2 ≤ D.codim`. That statement is not the Hodge conjecture. It is false
as linear algebra: `Examples.zeroCycle` has `codim = 2`, `cl = 0`, and
`¬ HodgeConjecture`. The axiom plus that example proved `False`.

The correction is to keep the type and drop the assertion. Known cases
(`Classical.projectiveFourSpace`, `Classical.kleinQuadric`,
`Classical.productOfPlanes`) still carry `CycleConstructor` instances.
A general fourfold does not.
-/

namespace Hodge

variable {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]

/-- The open problem, as a proposition on a datum of codimension at least two.
This is not an axiom and not a theorem. No term is supplied. -/
def constructOfCodimGeTwo (D : Datum Z V N) (_h : 2 ≤ D.codim) : Prop :=
  ∀ v ∈ D.hodgeClasses, v ∈ D.algebraicClasses

/-- That proposition is exactly `HodgeConjecture` on the same datum. -/
theorem constructOfCodimGeTwo_iff (D : Datum Z V N) (h : 2 ≤ D.codim) :
    constructOfCodimGeTwo D h ↔ D.HodgeConjecture :=
  Iff.rfl

/-- If a constructor exists, the conjecture holds. This is the easy direction
already in `Basic`. It does not produce the constructor. -/
theorem HodgeConjecture.of_constructor (D : Datum Z V N)
    [CycleConstructor D] : D.HodgeConjecture :=
  hodgeConjecture_of_constructor D

/-- Specialisation to the first open geometric case named in the source note:
a datum of codimension two. Still a proposition, not a proof. -/
def HodgeConjecture.codimTwo (D : Datum Z V N) (_h : D.codim = 2) : Prop :=
  D.HodgeConjecture

theorem HodgeConjecture.codimTwo_iff (D : Datum Z V N) (h : D.codim = 2) :
    HodgeConjecture.codimTwo D h ↔ D.HodgeConjecture :=
  Iff.rfl

/-- From `codim = 2` one has `2 ≤ D.codim` by rewriting. No `omega`. -/
theorem codim_two_ge_two (D : Datum Z V N) (h : D.codim = 2) :
    2 ≤ D.codim :=
  h ▸ Nat.le_refl 2

end Hodge
