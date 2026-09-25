# Discovery overview

**Author:** Benjamin Stanley Frohman (@BenFrohman)
**Copyright:** (c) 2026 Benjamin Stanley Frohman. All rights reserved in the text;
code and documentation released under the Apache License 2.0.
**License:** Apache-2.0. See `LICENSE`, `NOTICE`, `AUTHORS.md`.

This page is an author record of how the locked objects were isolated.
It is not a Clay close. Term A empty. Term B empty.

## What was isolated (not invented as a theorem)

A special sextic fourfold was already on the ledger:

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6
    X = V(F) ⊂ P^5,   Π = V(x3,x4,x5) ⊂ X

The accident was reading F as three copies of one local recipe

    W(u,v) = u^5 v + v^6

instead of as an indivisible global polynomial. Once that split is written,
the Berglund–Hübsch transpose of one block is forced:

    W^T = u^5 + u v^6
    F^T = x0^5 + x0 x3^6 + x1^5 + x1 x4^6 + x2^5 + x2 x5^6

Milnor number of the atom: μ(W) = 30. Three-block product: 30^3 = 27000.
Central charge of one block: 4/3. Three blocks: 4, matching a CY fourfold.

That is a *classification* discovery: the right object at the right scale.
It is not a missing Hodge class, not a Fourier–Mukai partner Y, and not
vacuous Hodge (vacuous Hodge lives on a very general high-degree host).

## How it was accidentally found

1. The host X = V(F) was locked because it contains a plane, so it is
   special (Noether–Lefschetz does not kill extra classes).
2. Residual geometry produced a second algebraic surface S with
   [S] = h^2 − [Π]. Both classes hit im(cl). Term B Field 3 failed.
3. Asking what F^T could be (partner? miss? mirror?) forced the exponent
   matrix of F to be written down. The matrix is block-diagonal of three
   chain 2×2 blocks. The atom fell out of that bookkeeping.
4. Mirror-program theorems were then checked against the atom's actual
   number of variables. Two-variable theorems apply. Three-variable
   strange duality does not, unless one changes the germ (W + z^2).

The accident is the split. The discipline is not renaming the split as Y
or as a miss.

## Author page facts

| Item | Value |
|---|---|
| Author | Benjamin Stanley Frohman |
| GitHub | [@BenFrohman](https://github.com/BenFrohman) |
| License | Apache License 2.0 |
| Year | 2026 |
| Status of rational Hodge | open |
| Field 1 of Term B | X = V(F), written |
| Fields 2 and 3 | empty |

Sister pages: `docs/HDG2_NOT_H2.md`, `docs/HODGE_NUMBERS.md`,
BenFrohman/ChainAtom-u5v-v6, BenFrohman/DerivedCategories,
BenFrohman/NoetherLefschetz, BenFrohman/HODGE-DISPROOF.
