# UniformConstruct is the missing Clay term

Author: Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Date: 29 September 2026.

## Correct name

```lean
Hodge.Clay.UniformConstruct
```

Type:

```lean
∀ (X : SmoothComplexProjectiveFourfold) (γ : Hdg2 X),
  { z : AlgebraicSpan X // ofAlgebraic z = γ }
```

Forgetful map, written:

```lean
Clay.ofUniformConstruct : UniformConstruct → RationalHodgeCodimTwo
```

A term of `UniformConstruct` *is* the Clay close. No such term is in the
library. `grind` does not produce one from the named constructs below.

## Grind of every existing name

| Existing name | Actual type | Unifies with `UniformConstruct` |
|---|---|---|
| `contains_two_planes` | ring membership on one F | no |
| `closed_membership` | `∀ R, F ∈ I(Π) ∧ F ∈ I(Π_{-1})` | no |
| `CycleSection.construct` | `{v // v ∈ D.hodgeClasses} → Z` after `D` is fixed | no |
| `HodgeConjecture.of_section` | `[CycleSection D] → D.HodgeConjecture` | no |
| `constructP4`, Klein `construct`, `constructProduct` | identity on named islands | no |
| `SpecialSextic.construct` | `id : ℚ×ℚ → ℚ×ℚ` | no |
| `planeSpan_hodge` | `Datum.HodgeConjecture` on `cl = id` | no |
| `named_fourfolds` | finite conjunction | no |

The misnaming was to call any of those `HC` or `RationalHodgeCodimTwo`.
Their correct status is easy-arrow or identity-shadow. The hard arrow is
`UniformConstruct`.

## What would inhabit it

A map that, from an arbitrary smooth complex projective fourfold `X` and
an arbitrary class `γ ∈ Hdg²(X)`, returns finitely many algebraic surfaces
and rationals with `γ = ∑ a_i [Z_i]`.

`CycleSection.construct` is that map *after* a `Datum` is named and after
`cl` has been replaced by `LinearMap.id`. That is a different type.
