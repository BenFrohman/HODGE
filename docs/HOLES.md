<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Holes, filled and left open

Author: Benjamin Stanley Frohman
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache-2.0

Locked host

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6
    X = V(F) subset P^5

## Now in Lean (Hodge/SpecialSextic.lean)

- F_mem_plane : F ∈ <x3, x4, x5>
- F_mem_plane_minus1 : F ∈ <x0+x3, x1+x4, x2+x5>
- F_factors, F_factors_minus1 : ring identities
- five_pow_six : 5^6 = 15625 := by decide
- gram_det_numeral : 6*21*21 - 21 - 21 = 2604 := by decide
- planeSpan : Q^2 shadow of h^2 and [Pi], cl = id
- threeSpan : Q^3 shadow of h^2, [Pi], [Pi_{-1}], cl = id

Certificates for those theorems are ring / decide / rfl.
They are not a Chow-ring proof of the Gram, and they are not Hodge on all of Hdg^2(X).

## Still geometric, not Lean theorems

- Intersection numbers 6, 1, 21, 0 (needs a Chow ring).
- Rank of the intersection form as a theorem about H^4(X).

## Not fillable here

- general_fourfold / Lefschetz (2,2) on an unnamed fourfold.
- A miss class.
- Z = 0.
- Tate on a reduction of V(F).
- EPW Hodge imported onto V(F).

    rho >= 3
    dim im(cl) >= 3
    Z uncomputed
