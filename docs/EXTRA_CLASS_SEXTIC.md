# Extra class on a special sextic fourfold: verified codimension framework

Author: Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.

Permanent record of the linear-plane count. Not a `CycleSection` on an
unnamed fourfold. Not a proof of Hodge.

`HodgeConjecture.general_fourfold` stays a `Prop`.

## Ambient dimension

Host: a hypersurface fourfold

    X = V(F) ⊂ ℕ^5,    deg F = 6,    dim X = 4.

Coordinates `[x₀ : x₁ : x₂ : x₃ : x₄ : x₅]`.

A linear subspace of dimension `k` in `ℕ^5` is the vanishing of
`5 − k` independent linear forms.

| Object in `ℕ^5` | Independent linear forms | Dimension |
|---|---|---|
| hyperplane `ℕ^4` | 1 | 4 |
| `ℕ^3` | 2 | 3 |
| linear plane `ℕ^2` | **3** | 2 |
| line `ℕ^1` | 4 | 1 |
| point | 5 | 0 |

## Verified count: a linear plane on `X`

A **linear plane** `Π ⊂ X` is a linearly embedded `ℕ^2` contained in `X`.
In the ambient space that means three independent linear forms:

    I(Π) = ⟨L₁, L₂, L₃⟩,    dim Π = 5 − 3 = 2.

Containment `Π ⊂ X` is ideal membership `F ∈ I(Π)`, i.e.

    F = L₁ A + L₂ B + L₃ C

with `deg A,B,C = 5`. That identity lives in
[BenFrohman/FermatPlanes](https://github.com/BenFrohman/FermatPlanes)
(`Membership.lean` for the quartic host; the same count for a special
non-Fermat sextic is the writing `F = x₃ A + x₄ B + x₅ C` below).

Standard coordinate plane used as the extra-class example:

    Π = { x₃ = x₄ = x₅ = 0 } ≅ ℕ^2,
    I(Π) = ⟨x₃, x₄, x₅⟩.

No twelfth root is required for this plane. Do not put `ζ` in `I(Π)`.

## Two forms are not a linear plane

Two independent linear forms cut

    V(L₁, L₂) ≅ ℕ^3 ⊂ ℕ^5.

That is a linear threefold in the ambient space, not a surface on `X`.

`X ∩ ℕ^3` is a degree-6 surface in that `ℕ^3` when the intersection is
proper. It is **not** a linear plane. Calling that complete intersection
`Π` is a dimension error.

One univariate factor `z − ζ w` is one form. Two such factors are two
forms. Neither count is three. The factorization therefore cannot name `Π`.

## What `Z₁ ⊔ Z₂` is not

On the **Fermat quartic** host, `Z₁` and `Z₂` are two named linear planes
(`FermatPlanes/LinearPlanes.lean`). Their disjoint union is two algebraic
cycles. Easy arrow: each `[Z_i]` is Hodge because each `Z_i` is algebraic.

`Z₁ ⊔ Z₂` is **not**:

- a `CycleSection` for an arbitrary Hodge class `γ`,
- a constructor on a general fourfold,
- a section of `cl` on `HodgeConjecture.general_fourfold`.

`CycleSection` in this repository exists only on named hosts:

- `ℕ^4` — `constructP4`
- `Q^4` — `construct` (`Π = σ₂`, `Π' = σ_{1,1}`)
- `ℕ² × ℕ²` — `constructProduct`
- cited Fermat quartic datum — `Hodge/Fermat.lean` (`cl = id` packaging
  the Shioda / Aljovin–Movasati–Villaflor spanning statement; coefficients
  not expanded)

## Invertibility of `1 − ζη` does not upgrade to Hodge

A unit in the coefficient ring (or invertibility of a remainder prefactor)
is an algebraic identity condition. It does not:

- produce three independent linear forms,
- prove a class is of type `(2,2)`,
- supply a `CycleSection`,
- discharge `HodgeConjecture.general_fourfold`.

## Univariate factorization: termination boundary

Recorded in `FermatPlanes/SexticPair.lean` for the Fermat sextic host
`∑ z_i^6 = 0`:

    z^6 + w^6
      = (z − ζ w) · cofactor₆(z,w,ζ) + (1 + ζ^6) w^6.

At `ζ^6 = −1` the remainder vanishes and **one pair** of sixth powers lies
in the principal ideal `(z − ζ w)`.

**Termination.** That identity factors one pair. It names one linear form.
It does not name `I(Π)`. It does not glue to a surface. It does not map
to a splitting rule `s(X, γ)`.

The same boundary for degree 4 is `FermatIdentities.lean` /
`docs/REMAINDER_CORRECTION.md`: remainder `(1 + ζ^4) w^4` tracks whether
one named pair lies on the Fermat quartic. It does not track other surfaces
on other fourfolds.

## Special non-Fermat sextic (easy arrow only)

If `F = x₃ A + x₄ B + x₅ C` with `deg A,B,C = 5` and `X = V(F)` smooth,
then `Π ⊂ X` by writing. Literature intersection numbers on that host:

    [Π] · h² = 1,    h^4 = 6,    [Π]² = 21 ≠ 1/6.

So `γ := [Π]` is not a multiple of `h²`, and `γ = 1 · [Π]`. That is the
easy arrow on this one plane. It is not a constructor for every extra
`(2,2)` class on every degree-≥-6 fourfold.

This host is not `∑ z_i^6 = 0`. Do not mix the two sextics.

## Firewall

- Ideal membership stays in FermatPlanes.
- `CycleSection` stays on the named hosts listed above.
- `general_fourfold` stays a `Prop`.
- No axiom `construct_of_codim_ge_two`.
- Clay is open.
