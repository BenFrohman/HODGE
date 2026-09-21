# Special non-Fermat sextic and the extra class [Π]

Author: Benjamin Stanley Frohman (@BenFrohman).
Not a CycleSection for an unnamed fourfold. Not the Fermat sextic.

## Ambient and coordinate ideal

Coordinates on ℝ⁵: [x₀ : x₁ : x₂ : x₃ : x₄ : x₅].

    Π = { x₃ = x₄ = x₅ = 0 } ≅ ℝ²
    I(Π) = ⟨x₃, x₄, x₅⟩

Three independent linear forms: dim Π = 5 − 3 = 2. No twelfth root.

## Structural membership

    F = x₃ A + x₄ B + x₅ C,    deg A,B,C = 5

Then F ∈ I(Π) by writing. For general smooth F of this shape, X = V(F)

is a smooth sextic fourfold containing Π.

## Extra class

    [Π] · h² = 1,    h⁴ = 6,    [Π]² = 21 ≠ 1/6.

So γ := [Π] is not a multiple of h², and γ = 1 · [Π]. Easy arrow:

the plane is in the equation of X.

## Firewall

- This host is not ∑ z_i⁶ = 0. Do not put ζ in I(Π).
- Membership here does not give instance [IsVariety D] : CycleSection D.
- HodgeConjecture.general_fourfold stays a Prop.
