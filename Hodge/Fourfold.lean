/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Basic
import Hodge.Classical

/-!
# The first open case, as a type — not as an axiom

`axiom construct_of_codim_ge_two` has been removed.

That axiom asserted a `CycleConstructor` for every `IsVariety` gadget of
codimension at least two. It did not return a cycle. Replacing it with an
actual `CycleSection` on a general fourfold would be the Hodge conjecture.
That term is not supplied.

The real terms in the repository are the `CycleSection` instances on the
three classical islands (`Hodge/Construct.lean`). `#print axioms` on those
is expected to list only standard logical axioms.
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

/-- The open problem, as a proposition. No axiom. No term. -/
def constructOfCodimGeTwo (D : Datum Z V N) (_h : 2 ≤ D.codim) : Prop :=
  ∀ v ∈ D.hodgeClasses, v ∈ D.algebraicClasses

theorem constructOfCodimGeTwo_iff (D : Datum Z V N) (h : 2 ≤ D.codim) :
    constructOfCodimGeTwo D h ↔ D.HodgeConjecture :=
  Iff.rfl

/-- If a constructor exists, the conjecture holds. This does not produce
the constructor. -/
theorem HodgeConjecture.of_constructor (D : Datum Z V N)
    [CycleConstructor D] : D.HodgeConjecture :=
  hodgeConjecture_of_constructor D

/-- Specialisation to codimension two. Still a proposition. -/
def HodgeConjecture.codimTwo (D : Datum Z V N) (_h : D.codim = 2) : Prop :=
  D.HodgeConjecture

theorem HodgeConjecture.codimTwo_iff (D : Datum Z V N) (h : D.codim = 2) :
    HodgeConjecture.codimTwo D h ↔ D.HodgeConjecture :=
  Iff.rfl

theorem codim_two_ge_two (D : Datum Z V N) (h : D.codim = 2) :
    2 ≤ D.codim :=
  h ▸ Nat.le_refl 2

/-- The first open geometric case, as a proposition on a variety-gadget of
codimension two. No proof is supplied. -/
def HodgeConjecture.general_fourfold (D : Datum Z V N)
    [IsVariety D] (_h : D.codim = 2) : Prop :=
  D.HodgeConjecture

end Hodge
