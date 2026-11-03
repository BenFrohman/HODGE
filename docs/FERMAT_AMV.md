<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Fermat fourfolds and AMV (cited, not proved here)

Author: Benjamin Stanley Frohman
License: Apache-2.0

This note records what the literature says about Fermat hypersurface
fourfolds, and what this repository actually compiles.

## Two different hosts

Both live in P^5. Both are fourfolds.

    X_4 :  x0^4 + x1^4 + x2^4 + x3^4 + x4^4 + x5^4 = 0   (quartic)
    X_5 :  x0^5 + x1^5 + x2^5 + x3^5 + x4^5 + x5^5 = 0   (quintic)

Neither is Fermat's Last Theorem. Neither is the Fermat quintic
threefold in P^4.

## What AMV proved (literature)

Aljovin–Movasati–Villaflor, J. Symbolic Computation 95 (2019):
linear algebraic cycles generate the lattice of Hodge cycles on the
quartic and quintic Fermat fourfolds. So the *integral* Hodge
conjecture holds for those two named hosts.

Shioda–Ran: Hodge holds for all Fermat varieties X_m^n when m is
prime or m = 4.

Those theorems are theirs. This repo does not replay the lattice
computation.

## What this repo compiles

Hodge/Fermat.lean is a CycleSection on a two-plane *span*, with
cl = id. That is Term A on one named span, packaged inside
named_fourfolds. It is not AMV, and it is not

    ∀ D, D.codim = 2 → D.HodgeConjecture.

## Why this does not close Clay

A plane that lies on X_4 or X_5 is an algebraic cycle on that host.
A plane that does *not* lie on some other fourfold is simply not a
cycle on that other fourfold. Neither fact is Term B, and neither
fact is Term A for every fourfold.

AMV is one more named island. Official close unchanged:
contains_two_planes and named_fourfolds.
