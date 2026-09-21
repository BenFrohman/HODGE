# Fermat quartic fourfold — planes with ζ^4 = -1

Author of the repository record: Benjamin Stanley Frohman (@BenFrohman).
This is the easy arrow on a special host. It is not a `CycleSection` for
every Hodge class on this fourfold, and it is not the Hodge conjecture.

## Host

    X : z₀^4 + z₁^4 + z₂^4 + z₃^4 + z₄^4 + z₅^4 = 0  ⊂ ℙ^5.

A smooth Fermat quartic fourfold.

## Planes that lie on X

Let ζ ∈ ℂ satisfy ζ^4 = -1 (an eighth root of unity, not i; i^4 = 1).

    Z₁ = { z₀ = ζ z₁, z₂ = ζ z₃, z₄ = ζ z₅ } ≅ ℙ^2,
    Z₂ = { z₀ = -ζ z₁, z₂ = ζ z₃, z₄ = ζ z₅ } ≅ ℙ^2.

Substitution on Z₁:

    (ζ z₁)^4 + z₁^4 + (ζ z₃)^4 + z₃^4 + (ζ z₅)^4 + z₅^4
    = -z₁^4 + z₁^4 - z₃^4 + z₃^4 - z₅^4 + z₅^4
    = 0.

Same for Z₂ because (-ζ)^4 = ζ^4 = -1. So Z₁, Z₂ ⊂ X.

Polynomial form: z₀^4 + z₁^4 = z₀^4 - ζ^4 z₁^4 is divisible by z₀ - ζ z₁.
Hence the Fermat polynomial lies in the ideal of Z₁ (and of Z₂).

## What class this gives

Each plane is an algebraic surface on X. Its fundamental class is a Hodge
class of type (2,2):

    γ₁ = [Z₁],   γ₂ = [Z₂],   γ₁ = 1·[Z₁].

That is the easy arrow: the surface was written into the linear equations,
then checked against f. It does not take an abstract vector in H^4(X, ℚ) ∩ H^{2,2}
and return planes.

The earlier annihilator attempt with P = z₀ z₁ + z₂ z₃ + z₄ z₅ and i = √(-1)
failed because i^4 = 1, so that plane is not on X, and J : (P) contains J.

## What this is not

- Not a uniform constructor on a general fourfold.
- Not Path 2 (a rational Hodge counterexample).
- Not a discharge of `HodgeConjecture.general_fourfold`.
