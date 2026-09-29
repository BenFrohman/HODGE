<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# AMV, cited not coauthored

Author: Benjamin Stanley Frohman
License: Apache-2.0

This repository does not prove Hodge for the whole Fermat quartic.
The Lean file Fermat.lean inhabits only the two-plane span.
Hodge for every class on that fourfold is literature.

## Cite

Aljovin–Movasati–Villaflor (AMV):
Enzo Aljovin, Hossein Movasati, and Roberto Villaflor,
*Integral Hodge conjecture for Fermat varieties*,
arXiv:1711.02628.
Computer verification that linear algebraic cycles generate the
Hodge lattice for the quartic and quintic Fermat fourfolds.

Related, also cited not coauthored:

- T. Shioda, *The Hodge conjecture for Fermat varieties*, Math. Ann. 245 (1979).
- N. Aoki, *Some new algebraic cycles on Fermat varieties*,
  J. Math. Soc. Japan 39 (1987), 385–396.
  (Aoki–Shioda cycles.)

## What this file does not do

It does not replay the AMV algorithm, the period matrix, or the
elementary-divisor comparison. It does not import their basis into
`named_fourfolds`.

The last row of the status table remains empty:

    ∀ D, D.codim = 2 ⇒ D.HodgeConjecture

AMV on one Fermat host is still one named X. It is not that ∀.
