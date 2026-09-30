<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# The proposed G does not cut a projective fourfold

**Author:** Benjamin Stanley Frohman (@BenFrohman)
**License:** Apache-2.0
**Clay tag:** `clay-statement-open`

A requested new host was

```text
G = x0^5 + x1^5 + x2^5 + x3^5 + x4^5 + x5^5 - 5 x0 x1 x2 x3 x4 x5.
```

This note records why that polynomial is not a Field-1 fourfold in `P^5`.
It does not inhabit `ClayDisproofTerm`. It does not compute ledger `Z`.

## Not homogeneous

- `sum_i x_i^5` is degree 5.
- `prod_{i=0}^5 x_i` is degree 6 (six factors).
- `G` is therefore not a homogeneous element of `C[x0,...,x5]`.
- Euler check: `sum_i x_i ∂_i G - 5 G = -5 prod_i x_i ≠ 0`.

A non-homogeneous equation does not define a closed subscheme of `P^5`.
`V(G)` is not a projective hypersurface, not a fourfold, and not a legal
`SmoothComplexProj` presentation.

## What the Dwork polynomial actually is

The classical Dwork family is a *threefold* in `P^4`:

```text
sum_{i=0}^4 z_i^5 - 5 ψ prod_{i=0}^4 z_i = 0.
```

Five variables, both terms degree 5. That is the Calabi–Yau quintic threefold
family. It is not a fourfold, and Lefschetz (1,1) already covers its (1,1)
classes. It is not the open Clay case.

A homogeneous cyclic deformation in `P^5` would have to replace the six-factor
product by a degree-5 monomial (or a sum of the six five-factor products
`prod_{i ≠ j} x_i`). That polynomial was not supplied, and smoothness for a
special scalar is not proved here.

## The legal quintic fourfold from the inventory table

```text
X_5 : x0^5 + x1^5 + x2^5 + x3^5 + x4^5 + x5^5 = 0  subset P^5.
```

Partials `5 x_i^4`. On a domain with `5 ≠ 0`, the affine cone is isolated at
the origin. Hodge numbers of any smooth quintic fourfold in `P^5`:

```text
h^{4,0}=0, h^{3,1}=120, h^{2,2}=581, h^{1,3}=120, h^{0,4}=0, b_4=821.
```

Griffiths: `H^{3,1} ≅ R_{2d-6} = R_4`. Dimension 120, not 0.
The claim `H^{3,1}(Y)=0` because `d=5` is below the Calabi–Yau threshold is
false. What vanishes at `d=5` is `H^{4,0} ≅ R_{d-6} = R_{-1}`, not `H^{3,1}`.
See `docs/HODGE_NUMBERS.md`.

## Why X_5 is an island, not a miss factory

Aljovin–Movasati–Villaflor (JSC 2019): the integral Hodge conjecture holds
on the Fermat quartic and Fermat quintic fourfolds. A host on which every
integral Hodge class is already algebraic cannot carry
`false_of_geometric_miss` for the rational conjecture either.

`T_F` in this repository already means `CycleSection.construct` on a named
span (`Hodge/Fermat.lean`). It is not a host name.

## Status

Sextic `V(F)` stays frozen with ledger `Z` uncomputed.
`HodgeConjecture.general_fourfold` stays a `Prop`.
Clay remains **open**.
