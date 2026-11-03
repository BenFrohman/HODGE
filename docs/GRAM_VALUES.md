<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Computed intersection values on THIS host

Author: Benjamin Stanley Frohman
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache-2.0

Host: F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6, X = V(F) subset P^5.

    h^4 = 6
    [Pi] . h^2 = 1
    [Pi_{-1}] . h^2 = 1
    [Pi]^2 = 21
    [Pi_{-1}]^2 = 21
    [Pi] . [Pi_{-1}] = 0

Gram on (h^2, [Pi], [Pi_{-1}]):

    [ 6  1  1 ]
    [ 1 21  0 ]
    [ 1  0 21 ]

    det = 2604
    leading 1x1 = 6
    leading 2x2 = 125
    rank_Q = 3

F(1,2,3,0,0,0) = 0           (point of Pi)
F(1,2,3,-1,-2,-3) = 0        (point of Pi_{-1})
F(1,1,1,1,1,1) = 6           (generic, not zero)

rho >= 3, dim im(cl) >= 3, Z uncomputed. Not Z = 0.
