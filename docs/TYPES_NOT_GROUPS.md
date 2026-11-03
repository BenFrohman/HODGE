<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Types: ranks are not groups

Author: Benjamin Stanley Frohman
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache-2.0

Corrected types for the numbers that keep getting identified.

## Integers that are ranks or determinants

| Name | Type | Value | Meaning |
|---|---|---|---|
| b_4 | Betti number | 2606 | dim_Q H^4(X) for any smooth sextic fourfold |
| rank L_prim | rank of a lattice | 2605 | rank of (h^2)^perp inside H^4 |
| gram_det_numeral | Nat arithmetic | 2604 | 6*21*21 - 21 - 21 on the 3x3 Gram |
| disc of plane span | Nat arithmetic | 125 | 6*21 - 1^2 |
| beta^2 | intersection number | 750 | (h^2 - 6[Pi])^2 |
| |Aut_diag(X)| | order of a finite group | 4500 | diagonal autos of this fibre in PGL(6) |

2604 is not 2605. 2604 is not Mon. 2605 is not OmegaZero34.

## Objects that are groups or representations

| Name | Type | Lattice it acts on |
|---|---|---|
| Mon(U) | representation pi_1(U) -> O(L_prim) | rank 2605, not computed |
| Aut_diag(X) | finite subgroup of Aut(X) | this fibre; preserves Pi; not Mon |
| OmegaZero34 | subgroup of SL(4,Z) | Z^4 of Delta(3,4,inf); form Omega_0 type (1,6) |

Omega_0 is alternating of rank 4. H^4(X) is orthogonal of rank 2606.
Identifying either Gram, or Omega_0, with O(L_2605) is a type error.

## Visible algebraic span on this host

Written surfaces: h^2, Pi, Pi_{-1}.
Lower bound: dim im(cl) >= 3, so the orthogonal complement inside H^4 has rank at most 2603.
MONODROMY.md still prints 2604 for the complement of the *two*-class span Q h^2 + Q[Pi]. Both numbers can sit in the ledger if the span is named:

    rank (Q h^2 + Q[Pi]) = 2     complement 2604
    rank (Q h^2 + Q[Pi] + Q[Pi_{-1}]) >= 3     complement <= 2603

Neither complement is a monodromy group.
