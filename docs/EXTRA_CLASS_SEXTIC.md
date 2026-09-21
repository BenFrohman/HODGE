# Extra class on a special non-Fermat sextic

Author: Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.

Permanent record of the verified *codimension* framework for one
named plane on one special sextic fourfold in ℙ⁵. This is the easy
arrow: a plane written into the equation of X. It is not a
`CycleSection` on an unnamed fourfold. It is not the Fermat sextic.
`HodgeConjecture.general_fourfold` stays a `Prop`.

## Verified dimension count in ℙ⁵

Ambient: ℙ⁵ with coordinates `[x₀ : x₁ : x₂ : x₃ : x₄ : x₅]`.

A linear subspace cut by *r* independent linear forms has dimension
`5 − r`.

| Independent linear forms | Locus in ℙ⁵ | Dimension | On a fourfold X ⊂ ℙ⁵ |
|---|---|---|---|
| 1 | hyperplane ℙ⁴ | 4 | a threefold if it meets X properly |
| 2 | linear ℙ³ | 3 | **not a surface**. Two forms do not cut a plane. |
| 3 | linear ℙ² | 2 | a plane. A surface on X if and only if the plane lies on X. |
| 4 | line ℙ¹ | 1 | a curve, not a (2,2) cycle |

A linear plane on X ⊂ ℙ⁵ is **three** independent linear forms whose
common zero locus Π ≅ ℙ² is contained in X. Two forms cut a ℙ³ in
ℙ⁵, not a surface on X.

## The named plane

```text
Π = { x₃ = x₄ = x₅ = 0 } ≅ ℙ²
I(Π) = ⟨x₃, x₄, x₅⟩
```

Three independent linear forms. No twelfth root. No ζ. No η.

## Structural membership (easy arrow)

Write a degree-6 form that already lies in the plane ideal:

```text
F = x₃ A + x₄ B + x₅ C,    deg A, B, C = 5.
```

Then `F ∈ I(Π)` by writing. For a general smooth F of this shape,
`X = V(F)` is a smooth sextic fourfold containing Π. The class

```text
γ := [Π] ∈ H⁴(X, ℚ) ∩ H²,²(X)
```

is algebraic by the easy arrow: the plane is in the equation of X.

Recorded intersection numbers on this host (geometric note, not a
Lean Chow-ring theorem):

```text
[Π] · h² = 1,    h⁴ = 6,    [Π]² = 21 ≠ 1/6.
```

So γ is not a multiple of `h²`. The coefficient is `a = 1`: `γ = 1 · [Π]`.

This host is **not** `∑ z_i⁶ = 0`. Do not put ζ in `I(Π)`.

## What the univariate sextic identity is not

`BenFrohman/FermatPlanes/SexticPair.lean` factors one binomial

```text
z⁶ + w⁶ = (z − ζ w) · cofactor₆ + (1 + ζ⁶) w⁶.
```

That identity **terminates** at one linear factor in two variables.
It does not produce three independent linear forms. It does not cut
Π. Vanishing at `ζ⁶ = −1` is pair membership on the Fermat sextic
host only. Ideal membership for planes stays in FermatPlanes.

## Firewall (do not upgrade)

- `Z₁ ⊔ Z₂` is a pair of labeled planes on the cited Fermat *quartic*
  (`LinearPlanes.lean`, `ζ⁴ = −1`). It is not a `CycleSection`.
  Disjoint union of two planes is not a section of `cl` on any unnamed
  fourfold.
- Invertibility of `1 − ζη` is a ring identity. It does not upgrade
  `Z₁`, `Z₂`, `Π`, or `SexticPair` to Hodge. It does not produce a
  term of `HodgeConjecture.general_fourfold`.
- `CycleSection` in `BenFrohman/HODGE` stays on the named hosts only:
  `ℙ⁴`, `Q⁴`, `ℙ² × ℙ²`, and the cited Fermat quartic in
  `Hodge/Fermat.lean`. No instance for this special sextic datum.
- Membership of F in a plane ideal stays in `BenFrohman/FermatPlanes`.
- `HodgeConjecture.general_fourfold` stays a `Prop`. No axiom
  `construct_of_codim_ge_two`.
