/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Basic
import Hodge.Fourfold

/-!
# Clay sentence (geometric, uninhabited)

This file is the official type of the rational Hodge conjecture in
codimension 2. It is a `Prop`. It has no constructor and no theorem.

It is *not* `SpecialSextic.contains_two_planes`.
It is *not* `Datum.HodgeConjecture` on an identity shadow (`cl = id`).
It is *not* `HodgeConjecture.named_fourfolds`.

A term of `Clay.RationalHodgeCodimTwo` would be a Clay close.
No such term is supplied.
-/

namespace Hodge
namespace Clay

/-- Geometric fourfold. Not a linear-algebra `Datum`. -/
opaque SmoothComplexProjectiveFourfold : Type

/-- Rational Hodge classes of type (2,2): `Hdg²(X) ⊂ H⁴(X, ℚ)`. -/
opaque Hdg2 (X : SmoothComplexProjectiveFourfold) : Type

/-- Finite `ℚ`-span of classes of algebraic surfaces on `X`. -/
opaque AlgebraicSpan (X : SmoothComplexProjectiveFourfold) : Type

/-- Cycle-class arrow from the algebraic span into `Hdg²(X)`. -/
opaque ofAlgebraic {X : SmoothComplexProjectiveFourfold} :
    AlgebraicSpan X → Hdg2 X

/-- Clay sentence, first open geometric case:

    ∀ X smooth complex projective fourfold,
    ∀ γ ∈ Hdg²(X),
    ∃ z in the algebraic span with ofAlgebraic z = γ.

    Quantifiers: `∀ X, ∀ γ, ∃ z`.
    No theorem of this type exists in this library. -/
def RationalHodgeCodimTwo : Prop :=
  ∀ (X : SmoothComplexProjectiveFourfold) (γ : Hdg2 X),
    ∃ z : AlgebraicSpan X, ofAlgebraic z = γ

/-- Official geometric name of the same uninhabited sentence. -/
def LefschetzTwoTwo : Prop := RationalHodgeCodimTwo

/-- Skeleton form on a *given* `Datum`. This is `D.HodgeConjecture`.
    It can hold for `cl = LinearMap.id` without proving Clay. -/
def skeleton_on {Z V N : Type*}
    [AddCommGroup Z] [Module Rat Z]
    [AddCommGroup V] [Module Rat V]
    [AddCommGroup N] [Module Rat N]
    (D : Datum Z V N) (h : D.codim = 2) : Prop :=
  HodgeConjecture.general_fourfold D h

theorem skeleton_on_iff {Z V N : Type*}
    [AddCommGroup Z] [Module Rat Z]
    [AddCommGroup V] [Module Rat V]
    [AddCommGroup N] [Module Rat N]
    (D : Datum Z V N) (h : D.codim = 2) :
    skeleton_on D h ↔ D.HodgeConjecture :=
  Iff.rfl

end Clay
end Hodge
