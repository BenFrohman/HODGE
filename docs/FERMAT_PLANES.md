# Fermat planes containment and remainder identity

Author of the repository record: Benjamin Stanley Frohman (@BenFrohman).

Easy arrow on a special host. Not imported by `Hodge.lean`.
Does not discharge `HodgeConjecture.general_fourfold`.

Lean: `Hodge/Attempt/FermatIdentities.lean`, `Hodge/Attempt/FermatPlanes.lean`.
Standalone: [BenFrohman/FermatPlanes](https://github.com/BenFrohman/FermatPlanes).
NL sibling: [BenFrohman/NoetherLefschetz](https://github.com/BenFrohman/NoetherLefschetz).

## 1. Unconditional identity

For any commutative ring and any ζ:

    z^4 + w^4
      = (z - ζ w)(z^3 + ζ z^2 w + ζ^2 z w^2 + ζ^3 w^3)
        + (1 + ζ^4) w^4.

Expansion: (z - ζ w)(…) = z^4 - ζ^4 w^4. Adding the remainder:

    z^4 - ζ^4 w^4 + (1 + ζ^4) w^4 = z^4 + w^4.

## 2. Root ζ^4 = -1

Remainder = (1 + (-1)) w^4 = 0. Then each pair of fourth powers lies in the
principal ideal of its linear factor:

    z_{2k}^4 + z_{2k+1}^4 ∈ (z_{2k} - ζ z_{2k+1}).

(ζ is an 8th root of unity. Not i; i^4 = 1.)

## 3. Three pairs

Host F = ∑_{i=0}^5 z_i^4.

Z₁ = V(z₀ - ζ z₁, z₂ - ζ z₃, z₄ - ζ z₅):

    F = (z₀ - ζ z₁)(…) + (z₂ - ζ z₃)(…) + (z₄ - ζ z₅)(…).

Z₂ = V(z₀ + ζ z₁, z₂ - ζ z₃, z₄ - ζ z₅), first pair at -ζ:

    F = (z₀ + ζ z₁)(z₀^3 - ζ z₀^2 z₁ + ζ^2 z₀ z₁^2 - ζ^3 z₁^3)
      + (z₂ - ζ z₃)(…) + (z₄ - ζ z₅)(…).

## 4. Boundaries

- Easy arrow: [Z_i] is Hodge because Z_i is algebraic.
- A very general high-degree fourfold in ℙ^5 has no extra class (NL, other repo).
- A special host such as Fermat can have extra planes; that does not prove Hodge in general.
