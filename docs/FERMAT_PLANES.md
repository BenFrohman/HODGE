# Fermat quartic fourfold — planes with ζ^4 = -1

Author of the repository record: Benjamin Stanley Frohman (@BenFrohman).

This is the easy arrow on a special host. It lives in `Hodge/Attempt/`.
It is not imported by `Hodge.lean`. It does not discharge
`HodgeConjecture.general_fourfold`.

Lean identities: `Hodge/Attempt/FermatIdentities.lean`.
Lean planes: `Hodge/Attempt/FermatPlanes.lean`.

## Host

    X : z₀^4 + z₁^4 + z₂^4 + z₃^4 + z₄^4 + z₅^4 = 0  ⊂ ℙ^5.

A smooth Fermat quartic fourfold. Special in moduli: extra planes exist.
A very general high-degree fourfold has no extra class; that sentence is
Noether–Lefschetz, recorded in [BenFrohman/NoetherLefschetz](https://github.com/BenFrohman/NoetherLefschetz), not here.

## Remainder identity (any commutative ring)

    z^4 + w^4
      = (z - ζ w)(z^3 + ζ z^2 w + ζ^2 z w^2 + ζ^3 w^3)
        + (1 + ζ^4) w^4.

This holds without assuming ζ^4 = -1. When ζ^4 = -1 the remainder is 0,
so z^4 + w^4 lies in the principal ideal (z - ζ w).

## Planes that lie on X

Let ζ ∈ ℂ satisfy ζ^4 = -1 (an eighth root of unity, not i; i^4 = 1).

    Z₁ = V(z₀ - ζ z₁, z₂ - ζ z₃, z₄ - ζ z₅) ≅ ℙ^2,
    Z₂ = V(z₀ + ζ z₁, z₂ - ζ z₃, z₄ - ζ z₅) ≅ ℙ^2.

Three pairs for Z₁:

    F = (z₀ - ζ z₁)(…) + (z₂ - ζ z₃)(…) + (z₄ - ζ z₅)(…).

So F ∈ I(Z₁). For Z₂ the first pair uses -ζ.

Substitution check: (ζ z)^4 + z^4 = -z^4 + z^4 = 0.

## Easy arrow

Each plane is an algebraic surface on X, so its class is Hodge:

    γ₁ = [Z₁] = 1 · [Z₁].

The surface was written into the linear equations, then checked against F.
That does not take an abstract vector in H^4(X, ℚ) ∩ H^{2,2} and return planes.

The earlier annihilator attempt with P = z₀ z₁ + z₂ z₃ + z₄ z₅ and i = √(-1)
failed because i^4 = 1, so that plane is not on X, and J : (P) contains J.

## What this is not

- Not a uniform constructor on a general fourfold.
- Not Path 2 (a rational Hodge counterexample).
- Not Noether–Lefschetz (no extra classes on a very general high-degree host).
- Not a discharge of `HodgeConjecture.general_fourfold`.
