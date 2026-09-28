<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# jacobian_hodge.py printout

Author: Benjamin Stanley Frohman
License: Apache-2.0

Command:

    python3 scripts/jacobian_hodge.py

Printed values (verified):

    0 1
    6 426
    12 1751
    18 426
    24 1
    sum prim 2605
    plus h2 2606

Dictionary:

- R_0 = 1 = h^{4,0}
- R_6 = 426 = h^{3,1}
- R_12 = 1751 = h^{2,2}_prim
- R_18 = 426 = h^{1,3}
- R_24 = 1 = h^{0,4}
- sum of those five = 2605 = dim H^4_prim
- plus the Lefschetz class h^2: h^{2,2} = 1752 and b_4 = 2606

The Hilbert series is (1+t+t^2+t^3+t^4)^6. Total length H(1)=5^6=15625 is the affine Jacobian rank, not b_4.

R_12 is a dimension. It is not a miss class and not a list of surfaces.
See docs/R12.md and docs/tables/griffiths_hilbert.csv.
