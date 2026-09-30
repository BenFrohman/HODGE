<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Hodge–Riemann on the named span

**Author:** Benjamin Stanley Frohman (@BenFrohman)
**License:** Apache-2.0
**Related:** `docs/GRAM_VALUES.md`, `docs/PRIMITIVE.md`,
`docs/PRIMITIVE_COHOMOLOGY.md`

This note records the pairing on the named span of `V(F)`.
It does not identify `Hdg²(V(F))`.
It does not write `CycleSection.construct` for a general class in `R₁₂`.

## Polarized pairing

On a polarized smooth projective `n`-fold the primitive pairing on `H^{p,q}`
with `p+q = k` is

```text
Q(α, β) = i^{p-q} ∫_X α ∪ β̄ ∪ h^{n-k}
```

up to the standard Weil-operator convention. Hodge–Riemann: `Q` is definite
on each primitive Hodge piece.

## Fourfold, middle degree

`n = 4`. Raw cup product on `H⁴`:

```text
⟨α, β⟩ = ∫_X α ∪ β
```

Lefschetz decomposition of type `(2,2)`:

```text
H^{2,2} = ℂ·h²  ⊕  h·H^{1,1}_prim  ⊕  H^{2,2}_prim
```

The raw cup-product signature on the whole of `H^{2,2}` is mixed.
Hodge–Riemann is the definite statement on each primitive summand separately.

## On `V(F)`

Host numbers (already in `docs/GRAM_VALUES.md`):

```text
h⁴ = 6
h² · [Π] = 1
h² · [Π₋₁] = 1
[Π]² = 21
[Π₋₁]² = 21
[Π] · [Π₋₁] = 0
```

`[Π]` is not primitive: `h² · [Π] = 1`.
Primitive projections:

```text
[Π]^prim     = [Π]     - (1/6) h²
[Π₋₁]^prim = [Π₋₁] - (1/6) h²
```

Pairings:

```text
⟨[Π]^prim, [Π]^prim⟩         = 21 - 1/6 = 125/6
⟨[Π]^prim, [Π₋₁]^prim⟩     = -1/6
```

Compiled Gram on `⟨h², [Π], [Π₋₁]⟩`:

```text
[ 6  1  1 ]
[ 1 21  0 ]
[ 1  0 21 ]

det = 2604
```

This is the Chow / cohomology pairing on that span, not the primitive
Hodge–Riemann matrix. Nondegeneracy gives linear independence over `ℚ`.
It does not identify `Hdg²(V(F))`.

Hodge index on a surface is the `n = 2`, `k = 1` case: `D² < 0` on `h^⊥`.
That does not forbid `[Π]² = 21` on a fourfold, because `[Π]` is a surface
class with a component along `h²`.
