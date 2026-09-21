# Locus 1: linear section on a very general high-degree fourfold

Author: Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.

Not extra class. Not `CycleSection` on an unnamed extra `gamma`.
Not `HodgeConjecture.general_fourfold`.

## Host

Very general hypersurface fourfold

    X = V(F) subset P^5,    deg F = d >= 6.

Noether-Lefschetz: `Hdg^2(X) = Q * h^2`.
There is no extra Hodge class. The constructor is one surface.

## Equations

Let `L1, L2` be linearly independent linear forms on `P^5`:

    L1 = sum_{j=0}^5 c1_j x_j,
    L2 = sum_{j=0}^5 c2_j x_j.

Independence is linear independence of the two coefficient vectors in `C^6`.
It is **not** `L1 * L2 ≠ L2 * L1` (those are equal in a commutative ring).

Ambient ideal of the surface in `P^5`:

    I(Z)_{P^5} = <L1, L2, F>.

On the coordinate ring of `X`:

    I(Z) = <L1, L2>  subset  C[x0,...,x5] / <F>.

Geometry: `V(L1, L2) ≅ P^3` in `P^5`, and

    Z = X cap P^3

is a surface of degree `d` in that `P^3`.

## Class

    [Z] = h^2.

For `gamma` in `Hdg^2(X)` one has `gamma = a h^2 = a [Z]` for a unique `a` in `Q`.
No plane. No `zeta`. No factorization of `F`.

This list has length one. It is the whole constructor on this locus.
It does not write surfaces for extra classes off this locus.
