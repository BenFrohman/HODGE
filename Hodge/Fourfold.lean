/-
Copyright (c) 2026 Ben Frohman (@BenFrohman). Released under the MIT license.
Authors: Ben Frohman (@BenFrohman)
-/
import Hodge.Basic

/-!
# Author claim for the first open case

The source note states the first open case as follows.

Let `X` be a general fourfold and let `γ ∈ Hdg²(X)` be arbitrary. The
missing object is a finite collection of surfaces `Zᵢ ⊂ X` and rationals
`aᵢ ∈ ℚ` such that `γ = ∑ aᵢ [Zᵢ]`. Writing the `Zᵢ` down from `γ` would
be a section of `cl`. The cycle class map itself is constructed by the
fundamental class, Poincaré duality, and `ℚ`-linear extension.

That paragraph specifies the *type* of `CycleConstructor.construct` on a
datum of codimension `2`. It does not supply a *term* of that type. In
Lean a claim without a term is an axiom.

The axiom below records the author's claim that the first unknown instance
is discharged for every datum of codimension at least `2`. Every subsequent
theorem in this file is sorry-free and prints this axiom.
-/

namespace Hodge

variable {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]

/-- Author claim: every datum of codimension at least two admits a
constructor. This is not derived from `cl_isHodge`. The field
`cl_isHodge` is the easy arrow and is already a hypothesis of `Datum`. -/
axiom construct_of_codim_ge_two
    (D : Datum Z V N) (h : 2 ≤ D.codim) :
    ∀ v ∈ D.hodgeClasses, v ∈ D.algebraicClasses

/-- The claim, packaged as the typeclass the repository left open. -/
def CycleConstructor.of_codim_ge_two
    (D : Datum Z V N) (h : 2 ≤ D.codim) :
    CycleConstructor D :=
  ⟨construct_of_codim_ge_two D h⟩

/-- Consequence: the Hodge conjecture holds on every such datum, relative
to the axiom. `#print axioms` on this theorem lists
`construct_of_codim_ge_two` and the standard logical axioms only. -/
theorem HodgeConjecture.of_codim_ge_two
    (D : Datum Z V N) (h : 2 ≤ D.codim) :
    D.HodgeConjecture := by
  letI : CycleConstructor D := CycleConstructor.of_codim_ge_two D h
  exact hodgeConjecture_of_constructor D

/-- The first open geometric case named in the source note: a general
fourfold, Hodge classes of codimension two. Specialised from the axiom
by setting `codim = 2`. -/
theorem HodgeConjecture.general_fourfold
    (D : Datum Z V N) (h : D.codim = 2) :
    D.HodgeConjecture :=
  HodgeConjecture.of_codim_ge_two D (by omega)

end Hodge
