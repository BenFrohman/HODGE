# Variety, Hodge class, algebraic cycle

Author: Benjamin Stanley Frohman.
Copyright \u00a9 2026 Benjamin Stanley Frohman.
License: Apache-2.0.

## Variety

A smooth projective complex variety is a smooth irreducible projective scheme
over \u2102. This repository does not construct that object.

What Lean stores is `Hodge.Geometry.Variety`: a name, a dimension, and one
`Datum` (three \u211a-vector spaces and two \u211a-linear maps in one even degree).

## Algebraic cycles

Fix a variety X and a codimension k. An algebraic cycle of codimension k is a
finite formal \u2124-linear combination of closed irreducible subvarieties of X of
codimension k. Rational equivalence produces CH^k(X). The rational cycle space
is Z := CH^k(X) \u2297 \u211a.

In Lean this is the parameter Z, named `AlgebraicCycles`. CH^k is not built.

## Hodge classes

H^{2k}(X, \u2102) = \u2295_{p+q=2k} H^{p,q}(X). A rational class is a Hodge class when
its complexification lives in H^{k,k}(X). Equivalently it is killed by
projection onto N := \u2295_{p+q=2k, p\u2260k} H^{p,q}(X).

In Lean: V is `Cohomology`, N is `OffDiagonal`, `hodgeObstruction` is that
projection, and `HodgeClass` is `{ v : V // v \u2208 ker obstruction }`.
Hodge decomposition is not built.

## The two maps

- cycleClass : Z \u2192 V. Poincar\u00e9 dual of the fundamental class, extended linearly.
- hodgeObstruction : V \u2192 N. Projection off H^{k,k}.
- cycleClass_is_hodge: obstruction \u2218 cl = 0.

## The sentence

ker(hodgeObstruction) \u2286 range(cycleClass).

That is `Variety.HodgeConjecture`. It holds on three packaged toys because cl
is the identity and obstruction is zero. It is not a proof of the Hodge
conjecture on varieties.
