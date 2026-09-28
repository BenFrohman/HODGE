<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Gram values on this host

Author: Benjamin Stanley Frohman
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache-2.0

Host: F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6, X = V(F) subset P^5.

Surfaces: h^2, Pi = {x3=x4=x5=0}, Pi_{-1} = {x0+x3=x1+x4=x2+x5=0}.

## Intersection numbers

    h^4 = 6
    [Pi] · h^2 = 1
    [Pi_{-1}] · h^2 = 1
    [Pi]^2 = 21
    [Pi_{-1}]^2 = 21
    [Pi] · [Pi_{-1}] = 0

Reasons:
- h^4 = deg(X) = 6.
- A linear P^2 meets O(1)^2 in one point: [plane] · h^2 = 1.
- 0 → N_{Pi/X} → O(1)^3 → O(6) → 0 on Pi ≅ P^2 gives
  c(N) = (1+h)^3 / (1+6h) = 1 - 3h + 21 h^2, so [Pi]^2 = c2 = 21.
  Same for Pi_{-1}.
- Pi ∩ Pi_{-1} = empty in P^5, hence [Pi] · [Pi_{-1}] = 0.

## Matrix

        h^2     [Pi]   [Pi_{-1}]
    h^2    6       1        1
    [Pi]    1      21        0
    [Pi_{-1}] 1      0       21

    det = 2604 ≠ 0
    rank = 3

## Ledger

    rho >= 3
    dim im(cl) >= 3
    Z uncomputed

Not Z = 0. Hodge open.
