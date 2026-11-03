# Type separation: membership is not Clay

Author: Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Date: 29 September 2026.

This record undoes the collapse of two sentences.

## Closed type

```lean
Hodge.SpecialSextic.contains_two_planes
Hodge.SpecialSextic.closed_membership
Hodge.Release.contains_two_planes
```

Meaning: for every commutative ring `R` and all coordinates,

    F ∈ ⟨x₃, x₄, x₅⟩ ∧ F ∈ ⟨x₀+x₃, x₁+x₄, x₂+x₅⟩.

Proof: `ring`. No `sorry`. No `axiom`.

This is the easy arrow `Π, Π_{-1} ⊂ V(F)`.

## Open type

```lean
Hodge.Clay.RationalHodgeCodimTwo
Hodge.Clay.LefschetzTwoTwo
Hodge.HodgeConjecture.general_fourfold
```

Meaning: for every smooth complex projective fourfold `X` and every
class `γ ∈ Hdg²(X)`, there is a finite rational combination of
algebraic surfaces whose cycle class is `γ`.

Quantifiers: `∀ X, ∀ γ, ∃ z`.

No theorem of this type is supplied.

## Why a term of the first is not a term of the second

`contains_two_planes` has type

    {R : Type*} → [CommRing R] → (x0 … x5 : R) →
      F ∈ planeIdeal ∧ F ∈ planeIdealMinus1.

`Clay.RationalHodgeCodimTwo` has type `Prop`, unfolded as

    ∀ X : SmoothComplexProjectiveFourfold,
    ∀ γ : Hdg2 X,
    ∃ z : AlgebraicSpan X, ofAlgebraic z = γ.

These are not definitionally equal. Assigning the membership proof
to the Clay name is a type error.

`planeSpan.HodgeConjecture` is a third type: `Datum.HodgeConjecture`
on the identity shadow `cl = LinearMap.id`. It is discharged by `rfl`.
Official name: `planeSpan_identity_shadow`. It is not Clay.

## Release names

| Lean name | Status |
|---|---|
| `Release.contains_two_planes` | closed |
| `Release.named_host_shadows` | closed as a finite list |
| `Release.ClaySentence` | open; no theorem |

Tag remains `clay-statement-open`. Do not tag `clay-solved`.
