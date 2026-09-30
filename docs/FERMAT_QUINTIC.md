<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Fermat quintic fourfold, not the illegal product host

**Author:** Benjamin Stanley Frohman (@BenFrohman)
**License:** Apache-2.0
**Clay tag:** `clay-statement-open`

## What is legal in P^5

The Fermat quintic fourfold is the homogeneous degree-5 hypersurface

```text
X_5 :  x0^5 + x1^5 + x2^5 + x3^5 + x4^5 + x5^5 = 0  ⊂ P^5.
```

Jacobian generators: `∂_i G = 5 x_i^4`. On a domain with `5 ≠ 0` the only
common zero is the origin. That is Field 1 for this named host.
Lean: `Hodge/FermatQuintic.lean`.

This is **not** the Fermat quintic threefold `∑_{i=0}^4 z_i^5 = 0 ⊂ P^4`,
which is Lefschetz (1,1) and not the open fourfold case.

## What is illegal as a projective host

```text
G_bad = ∑_{i=0}^5 x_i^5 - 5 ∏_{i=0}^5 x_i
```

is not homogeneous: the sum has degree 5 and the product of six variables
has degree 6. It does not define a projective hypersurface in `P^5`.
The classical Dwork family uses five variables in `P^4`:

```text
∑_{i=0}^4 z_i^5 - 5ψ ∏_{i=0}^4 z_i = 0  ⊂ P^4   (threefold).
```

Do not paste that product into `P^5` and call the result `SmoothComplexProj`.

## Hodge numbers (smooth quintic fourfold in P^5)

From `docs/HODGE_NUMBERS.md` / Griffiths `R_{2d-6}=R_4`, `R_{3d-6}=R_9`:

```text
h^{4,0} = 0
h^{3,1} = 120     (not 0)
h^{2,2} = 581     (prim 580 + h^2)
b_4     = 821
K_X     = O_X(-1)   (Fano, not Calabi–Yau)
```

`H^{3,1}=0` is the false table already rejected in `docs/HODGE_NUMBERS.md`.
Degree 5 is below the Calabi–Yau threshold `d=6`, which turns on `h^{4,0}`,
not which kills `h^{3,1}`.

## Literature, not a miss

Aljovín–Movasati–Villaflor (2019): linear algebraic cycles generate the
Hodge lattice on the Fermat quartic *and* Fermat quintic fourfolds.
Shioda: Hodge holds for Fermat varieties `X_m^n` when `m` is prime or `m=4`.
Here `m=5` is prime. This host is an island where Hodge is known.
It does not compute ledger `Z` on the chain sextic `V(F)`.
It does not inhabit `ClayDisproofTerm`.
`HodgeConjecture.general_fourfold` stays a `Prop`.

## Name lock

Do not call this host `T_F`. In this repository `T_F` already means
`CycleSection.construct`. Use `X_5` / `FermatQuintic.G` / label `V(sum x_i^5)`.
