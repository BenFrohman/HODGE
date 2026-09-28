<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Live ledger

Author: Benjamin Stanley Frohman
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache-2.0

Host: F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6, X = V(F) subset P^5.

## Kernel-checked on this host

- F_mem_plane : F in I(Pi) = <x3, x4, x5>
- F_mem_plane_minus1 : F in I(Pi_{-1}) = <x0+x3, x1+x4, x2+x5>
- gram_det_numeral : 6 * 21 * 21 - 21 - 21 = 2604
- planeSpan : Datum on Q^2, cl = id
- threeSpan : Datum on Q^3, cl = id
- CycleSection instances only for named hosts

## Inputs to the numeral, not Chow theorems

h^4 = 6, [Pi]^2 = 21, [Pi] . [Pi_{-1}] = 0.
Geometry: c2 of N_{Pi/X} from 0 → N → O(1)^3 → O(6) → 0 gives (1+h)^3/(1+6h) = 1-3h+21 h^2.
Not a Lean lemma in a Chow ring.

## planeSpan_hodge is not Hodge on H^4(X)

planeSpan.HodgeConjecture is: every vector of Q^2 is in the image of cl, because cl was defined to be id after naming the two coordinates. threeSpan_hodge is the same sentence on Q^3. Neither statement mentions H^{2,2}(X) or an arbitrary class gamma in H^4(X,Q).

## Empty on purpose

- Mon : pi1(U) → O(L), L = (h^2)^perp of rank 2605
- a matrix of size 2605
- CycleSection for unspecified D
- OmegaZero34 Omega_0 identified with the intersection form of V(F)

Sister [OmegaZero34](https://github.com/BenFrohman/OmegaZero34) fills those four slots on Z^4 only. See docs/SISTER_REPOS.md.

No True.intro. No axiom. No sorry as a stand-in for those empty slots.
