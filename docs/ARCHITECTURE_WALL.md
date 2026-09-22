# Plane vs class-side form

Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.

## Algebraic object

A concrete special sextic containing a plane:

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6
    X = V(F) subset P^5
    Pi = V(x3, x4, x5)

Every term of F is divisible by x3, x4, or x5, so F vanishes on Pi.
`[Pi]` is an algebraic cycle. Easy arrow: `[Pi]` is Hodge.
Self-intersection on this specialized host is the classical count `[Pi]^2 = 21`.

Lean: `SpecialSextic.planeSpan` is the linear shadow of `Q h^2 + Q [Pi]`, not all of Hdg^2(X).

## Class-side form

A 4-form `eta` with `star eta = -eta` is a class (or a representative of a class).
It is not `I(Pi)`. It is not `T_F`.

## Noether–Lefschetz wall

On a **very general** degree-6 hypersurface in P^5 there is no extra primitive
(2,2) class: `Hdg^2 = Q h^2`. That is NL. A Frohmanian form cannot be an extra
Hodge class on that general fiber.

The Hodge / NL locus is the algebraic set of parameters where the Hodge group
jumps (Cattani–Deligne–Kaplan). Special fibers may acquire extra (2,2) classes.
Those classes still need surfaces if Hodge is to hold on that fiber.

## Not identified

- `[Pi]` on the special F above ≠ a form on the general fiber
- Zucker on cubics ≠ `general_fourfold`
- `named_fourfolds` ≠ the `forall` sentence
