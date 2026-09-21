# Locus 1: linear section on the Noether–Lefschetz host

Author: Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.

Not a `CycleSection` on `general_fourfold`. Not Clay.

## Host

    X = V(F) subset P^5,    deg F = d >= 6,    X very general.

Coordinates `[x0 : x1 : x2 : x3 : x4 : x5]`.

Noether–Lefschetz: `Hdg^2(X) = Q h^2`. There is no extra class.

## Surface

Two independent linear forms

    L1 = sum_{j=0}^5 c_{1j} x_j,
    L2 = sum_{j=0}^5 c_{2j} x_j.

In `P^5`:

    I(Z)_{P^5} = <L1, L2, F>.

On `X`:

    I(Z) = <L1, L2>  subset  C[x0,...,x5] / <F>.

`V(L1, L2)` is a linear `P^3` in `P^5`.
`Z = X cap P^3` is a surface of degree `d` in that `P^3`.

    [Z] = h^2,    gamma = a [Z].

No third linear form (that would be a plane). No `zeta`.
Two forms are not a linear plane; they are this linear section.

## What this is not

- Not the special sextic plane `I(Pi) = <x3, x4, x5>`.
- Not `Z1 sqcup Z2` on the Fermat quartic.
- Not a constructor for extra `(2,2)` classes (NL says those are 0 here).
- Not `HodgeConjecture.general_fourfold`.
