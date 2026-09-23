/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Mathlib.Algebra.Module.Submodule.Lattice
import Mathlib.LinearAlgebra.Span

/-!
# Interface for the Hodge conjecture

This file records the linear-algebraic shape of the statement. It does not
construct algebraic cycles from Hodge classes.
-/

namespace Hodge

/-- The data needed to *state* the Hodge conjecture on an abstract coefficient
triple:
* `Z` — rational algebraic cycles of a fixed codimension,
* `V` — ambient rational cohomology of even degree,
* `N` — a complement that receives the off-diagonal Hodge pieces.

`cl` is the cycle class map. `obstruction` vanishes on algebraic classes. -/
structure Datum (Z V N : Type*)
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N] where
  /-- The integer `k` in `H^{2k}`. -/
  codim : ℕ
  /-- Projection onto the off-diagonal Hodge pieces. -/
  obstruction : V →ₗ[ℚ] N
  /-- The cycle class map. -/
  cl : Z →ₗ[ℚ] V
  /-- Geometry produces Hodge classes: the easy arrow. -/
  cl_isHodge : ∀ z, obstruction (cl z) = 0

namespace Datum

variable {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]

/-- Hodge classes: the kernel of the off-diagonal obstruction. -/
def hodgeClasses (D : Datum Z V N) : Submodule ℚ V :=
  LinearMap.ker D.obstruction

/-- Algebraic classes: the image of the cycle class map. -/
def algebraicClasses (D : Datum Z V N) : Submodule ℚ V :=
  LinearMap.range D.cl

/-- Every algebraic class is a Hodge class. This is `cl_isHodge` as a
submodule inclusion. -/
theorem algebraicClasses_le_hodgeClasses (D : Datum Z V N) :
    D.algebraicClasses ≤ D.hodgeClasses := by
  intro v hv
  rcases hv with ⟨z, rfl⟩
  exact D.cl_isHodge z

/-- The Hodge conjecture, as a statement about this datum: every Hodge class
is algebraic. -/
def HodgeConjecture (D : Datum Z V N) : Prop :=
  D.hodgeClasses ≤ D.algebraicClasses

/-- Generation form: if a set of algebraic classes already spans the Hodge
classes over `ℚ`, the conjecture holds for `D`. -/
theorem hodgeConjecture_of_generators (D : Datum Z V N)
    (L : Set V)
    (hspan : D.hodgeClasses ≤ Submodule.span ℚ L)
    (hint : L ⊆ (D.algebraicClasses : Set V)) :
    D.HodgeConjecture := by
  intro v hv
  have hv' : v ∈ Submodule.span ℚ L := hspan hv
  exact (Submodule.span_le.mpr hint) hv'

/-- No argument that uses only this interface can see the integer `codim`.
The linear algebra of the skeleton is therefore the same in the solved case
`codim = 1` and in every open case. -/
theorem hodgeConjecture_codim_blind
    (D : Datum Z V N) (k : ℕ) :
    D.HodgeConjecture ↔
      ({D with codim := k} : Datum Z V N).HodgeConjecture :=
  Iff.rfl

end Datum

/-- The missing input, isolated as a typeclass. An instance is a constructor
for algebraic cycles from Hodge classes. -/
class CycleConstructor {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]
    (D : Datum Z V N) : Prop where
  construct : ∀ v ∈ D.hodgeClasses, v ∈ D.algebraicClasses

/-- The typeclass is exactly the conjecture. -/
theorem hodgeConjecture_of_constructor {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]
    (D : Datum Z V N) [CycleConstructor D] :
    D.HodgeConjecture :=
  CycleConstructor.construct

/-- Conversely, the conjecture is exactly the typeclass. The quarantine is
faithful: the hypothesis is not stronger than the claim. -/
theorem constructor_of_hodgeConjecture {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]
    (D : Datum Z V N) (h : D.HodgeConjecture) :
    CycleConstructor D :=
  ⟨h⟩

end Hodge
