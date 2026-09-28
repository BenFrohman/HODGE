<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Written cycles on V(F)

Author: Benjamin Stanley Frohman
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache-2.0

Host:

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6
    X = V(F) subset P^5

## Cycles that are written

1. Hyperplane square h^2.
   Always algebraic. Always type (2,2). Easy arrow.

2. Coordinate plane

       Pi = { x3 = x4 = x5 = 0 }  isomorphic to P^2
       I(Pi) = <x3, x4, x5>

   Membership, proved by ring in Hodge/SpecialSextic.lean:

       F = x3 (x0^5 + x3^5) + x4 (x1^5 + x4^5) + x5 (x2^5 + x5^5)
       so F ∈ I(Pi), so Pi subset X.

   Then [Pi] is Hodge because Pi is a surface. Easy arrow.
   Literature numbers on this host: [Pi] · h^2 = 1, h^4 = 6, [Pi]^2 = 21.
   So [Pi] is not a multiple of h^2.

3. Lean shadow of those two classes: SpecialSextic.planeSpan, cl = id on Q^2.
   construct gamma := gamma. Section by rfl. Named host only.

## What is named but not cut by an ideal in that file

GRAM_BOUNDS.md lists a third class [Pi_{-1}] so that the 3x3 Gram is nondegenerate.
SpecialSextic.lean does not define I(Pi_{-1}). Until that ideal is written,
the third generator is a name, not a cycle in the coordinate ring.

{x0 = x1 = x2 = 0} is not a plane on X: substituting gives x3^6+x4^6+x5^6, not 0.

## What is still missing

A cycle z for an arbitrary Hodge class gamma on this host, or on an unnamed
fourfold, with cl(z) = gamma.

That z is the missing cycle. It is not inserted by renaming [Pi], by cl = id
on Q^2, or by the Gram lower bound.

    rho >= 3 (if the third Gram class is geometric)
    dim im(cl) >= 2 from the two written surfaces (3 if Pi_{-1} is written)
    Z uncomputed

Field 3 empty. Hodge open. Tate not set up on this complex host.
