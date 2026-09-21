# T_F on named hosts

Author: Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.

`T_F` is a section of `cl` on Hodge classes: class to cycle.
It is defined only on the hosts below. It is not a map on an unnamed fourfold.

## P^4

    Z = {x3 = x4 = 0}
    T_F(a) = a [Z]

Lean: `Classical.constructP4`.

## Klein quadric Q^4

    Pi  = sigma_2     = {p12 = p13 = p23 = 0}
    Pi' = sigma_{1,1} = {p01 = p02 = p03 = 0}
    T_F(a, b) = a [Pi] + b [Pi']

Lean: `Classical.construct`.

## P^2 x P^2

    T_F(a, b, c) = a h1^2 + b h2^2 + c h1 h2

Lean: `Classical.constructProduct`.

## NL locus (very general d >= 6 in P^5)

    T_F(a h^2) = a [X cap {L1 = L2 = 0}]

No extra class. Not a plane.

## Special plane in a sextic F = x3 A + x4 B + x5 C

    Pi = {x3 = x4 = x5 = 0}
    T_F([Pi]) = Pi

Easy arrow on that one class. Not T_F of every (2,2) class on that X.

## Not defined

    T_F : Hdg^2(X) → cycles    for unspecified X.

That map is the Hodge conjecture. `classical_fourfolds` does not use it.
