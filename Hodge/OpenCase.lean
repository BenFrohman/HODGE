/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/

/-!
# Hodge.OpenCase

Machine-checked Lean 4 module.

The structure `Fourfold` and the proposition `ExtraRational22` below are copied unchanged from the
original skeleton (preserved, uncompiled, in `drafts/OpenCase.lean`). That skeleton tried to prove
`ExtraRational22` and stopped at the goal `∃ z : X.Cycle, X.cl z = γ`.

What this module proves:
* `ExtraRational22` is **false** as stated (`not_extraRational22`). The reason is formal, not geometric:
  `Fourfold` is an abstract record (types `Cycle`, `Class`, a map `cl`, two predicates). Nothing ties it
  to a variety, to rational cohomology, or to Hodge theory, so the record `noCycleFourfold` (no cycles,
  one extra class) satisfies every field while having an extra class that is not in the image of `cl`.
  The original `theorem extra_rational_22 : ExtraRational22` therefore can never be completed.
* Non-vacuity: `Fourfold` is inhabited, the record used for the refutation really has an extra class,
  and the per-fourfold property `ExtraAlgebraic` holds for some fourfold that has an extra class
  (`idFourfold`) and fails for another (`noCycleFourfold`).

What this module does **not** say: nothing here is about the Hodge conjecture for actual fourfolds.
Refuting `ExtraRational22` refutes only this abstract formulation; it neither proves nor disproves
any statement about algebraic cycles on a projective variety.
-/

namespace OpenCase

structure Fourfold where
  Cycle : Type
  Class : Type
  cl : Cycle → Class
  h2 : Class
  isHodge22 : Class → Prop
  isExtra : Class → Prop
  extra_not_h2 : ∀ γ, isExtra γ → γ ≠ h2
  extra_is_hodge : ∀ γ, isExtra γ → isHodge22 γ

/-- Every extra rational (2,2)-class is algebraic. -/
def ExtraRational22 : Prop :=
  ∀ X : Fourfold,
    ∀ γ : X.Class,
      X.isExtra γ →
        ∃ z : X.Cycle, X.cl z = γ

/-- The per-fourfold form of `ExtraRational22`: every extra class of `X` is in the image of `X.cl`. -/
def ExtraAlgebraic (X : Fourfold) : Prop :=
  ∀ γ : X.Class, X.isExtra γ → ∃ z : X.Cycle, X.cl z = γ

/-- `ExtraRational22` is exactly `ExtraAlgebraic` for every `Fourfold`. -/
theorem extraRational22_iff_forall_extraAlgebraic :
    ExtraRational22 ↔ ∀ X : Fourfold, ExtraAlgebraic X :=
  Iff.rfl

/-- A `Fourfold` record with no cycles and one extra class (`true`). Every field is satisfied. -/
def noCycleFourfold : Fourfold where
  Cycle := Empty
  Class := Bool
  cl := fun z => nomatch z
  h2 := false
  isHodge22 := fun _ => True
  isExtra := fun γ => γ = true
  extra_not_h2 := fun _ h => h ▸ Bool.noConfusion
  extra_is_hodge := fun _ _ => trivial

/-- A `Fourfold` record whose cycle class map is the identity, with one extra class (`true`). -/
def idFourfold : Fourfold where
  Cycle := Bool
  Class := Bool
  cl := id
  h2 := false
  isHodge22 := fun _ => True
  isExtra := fun γ => γ = true
  extra_not_h2 := fun _ h => h ▸ Bool.noConfusion
  extra_is_hodge := fun _ _ => trivial

/-- Non-vacuity: the structure `Fourfold` is inhabited. -/
instance : Nonempty Fourfold := ⟨noCycleFourfold⟩

/-- Non-vacuity: `noCycleFourfold` has an extra class. -/
theorem noCycleFourfold_hasExtra : ∃ γ : noCycleFourfold.Class, noCycleFourfold.isExtra γ :=
  ⟨true, rfl⟩

/-- Non-vacuity: `idFourfold` has an extra class. -/
theorem idFourfold_hasExtra : ∃ γ : idFourfold.Class, idFourfold.isExtra γ :=
  ⟨true, rfl⟩

/-- The extra class `true` of `noCycleFourfold` is not the class of any cycle. -/
theorem noCycleFourfold_not_extraAlgebraic : ¬ ExtraAlgebraic noCycleFourfold :=
  fun h => (h true rfl).elim fun z _ => nomatch z

/-- `ExtraAlgebraic` is satisfiable by a fourfold that has an extra class. -/
theorem idFourfold_extraAlgebraic : ExtraAlgebraic idFourfold :=
  fun γ _ => ⟨γ, rfl⟩

/-- Non-vacuity of the per-fourfold property: it holds for some `Fourfold` with an extra class and
fails for another one. -/
theorem extraAlgebraic_nonvacuous :
    (∃ X : Fourfold, (∃ γ, X.isExtra γ) ∧ ExtraAlgebraic X) ∧
      (∃ X : Fourfold, (∃ γ, X.isExtra γ) ∧ ¬ ExtraAlgebraic X) :=
  ⟨⟨idFourfold, idFourfold_hasExtra, idFourfold_extraAlgebraic⟩,
    ⟨noCycleFourfold, noCycleFourfold_hasExtra, noCycleFourfold_not_extraAlgebraic⟩⟩

/-- `ExtraRational22`, as stated for the abstract structure `Fourfold`, is false.
This is a statement about the abstract record only; it is not a statement about the Hodge conjecture. -/
theorem not_extraRational22 : ¬ ExtraRational22 :=
  fun h => noCycleFourfold_not_extraAlgebraic (h noCycleFourfold)

end OpenCase
