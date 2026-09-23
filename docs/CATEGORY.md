# Category fix

Author: Benjamin Stanley Frohman. Apache-2.0.

Two objects. Do not identify them.

## Category A — linear algebra of `Datum`

`zeroCycle` is a gadget:

- `codim = 2`
- `obstruction = 0`
- `cl = 0`

Theorems that mention it:

- `zeroCycle_not_hodge` : `¬ zeroCycle.HodgeConjecture`
- `not_every_codim_ge_two` : `¬ (∀ D, 2 ≤ D.codim → D.HodgeConjecture)`

That is the only job of `zeroCycle`. It shows that an unguarded axiom
quantified over every `Datum` is false as linear algebra. That is why
the unguarded axiom was deleted.

`zeroCycle` is not a scheme, not a hypersurface, and not a point of
any moduli space.

## Category B — geometry of fourfolds

A fourfold in `∓O(d)∓` on `ℕ^5` is a variety. Hodge classes on that
variety are classes in `H^4(X, ℚ) ∩ H^{2,2}(X)`.

Nothing in Category A is a class on such an `X`. Renaming
`zeroCycle` to `genericObstructedFourfold` does not move it into
Category B.

There is no theorem in this repository of the form

    ¬ CycleConstructor X

for a geometric fourfold `X`. Writing one would be a claimed
counterexample to the Hodge conjecture. No such pair `(X, γ)` has
been supplied.

## The guard is not a bridge

`IsVariety` is a sticker on a `Datum`. It keeps Category A from
colliding with the axiom. It does not turn a gadget into a variety.
Putting the sticker on `zeroCycle` would make the axiom plus
`zeroCycle_not_hodge` prove `False` again.
