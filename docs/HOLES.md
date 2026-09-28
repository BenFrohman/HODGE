<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Holes, filled and left open

Author: Benjamin Stanley Frohman
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache-2.0

Crystallized ledger for the locked host

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6
    X = V(F) subset P^5

## Filled this pass (geometry + docs)

- I(Pi) = <x3,x4,x5>, F in I(Pi) by ring (Lean: F_mem_plane).
- I(Pi_{-1}) = <x0+x3, x1+x4, x2+x5>, F in I(Pi_{-1}) by x^5+y^5 factorization.
- Gram of (h^2, [Pi], [Pi_{-1}]): det 2604, rank 3.
- Hodge numbers of every smooth sextic fourfold constant: 1, 426, 1751, 1752.
- EPW sextic is a different fourfold (singular; double cover is K3^{[2]}).
- Tate is a different conjecture (finite fields). Ledger only.

## Fillable and still thin in Lean

- F_mem_plane_minus1 should be a ring theorem next to F_mem_plane.
- planeSpan is still Q^2 (h^2 and [Pi]). A Q^3 shadow would match the Gram, still cl = id, still a named host only.
- Intersection numbers 6, 1, 21, 0 are geometric, not theorems in a Chow ring.

## Not fillable here (do not fake)

- general_fourfold / Lefschetz (2,2) on an unnamed fourfold.
- A miss class gamma with cl(z) != gamma for all cycles z.
- Z = 0 (Hodge on this host).
- Tate constructor on a reduction of V(F).
- EPW Hodge imported onto V(F).

    rho >= 3
    dim im(cl) >= 3
    Z uncomputed
