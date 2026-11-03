<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Geometric origin of Gram rank 3

Author: Benjamin Stanley Frohman
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache-2.0

Numbers: docs/GRAM_VALUES.md.

On X = V(F) subset P^5 the three classes

    h^2,  [Pi],  [Pi_{-1}]  in  H^4(X,Q) cap H^{2,2}(X)

are paired by intersection of surfaces. The Gram is

    G = [[6, 1, 1], [1, 21, 0], [1, 0, 21]],  det = 2604,  rank_Q = 3.

A nondegenerate Gram on three vectors means those classes are linearly
independent over Q. That is the rank.

## Entries

- h^4 = 6: degree of a sextic in P^5.
- h^2 . [plane] = 1: each plane is a linear P^2, O(1)^2 is one point.
- [Pi]^2 = [Pi_{-1}]^2 = 21: c2 of the normal bundle from
  0 → N → O(1)^3 → O(6) → 0, so c(N) = (1+h)^3 / (1+6h) = 1-3h+21h^2.
- [Pi] . [Pi_{-1}] = 0: the two planes miss in P^5.

Leading minors 6 and 125 already give independence of {h^2} and {h^2,[Pi]}.
The third plane is not in that span: it meets [Pi] in 0 while [Pi]^2 = 21.

## What the rank is not

    rho >= 3,    dim im(cl) >= 3,    Z uncomputed.

Not rho = 3. Not Z = 0. Extra (2,2) classes can still sit outside
Q h^2 + Q[Pi] + Q[Pi_{-1}].
