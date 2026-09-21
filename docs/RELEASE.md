# Release: the open fourfold sentence

Author: Benjamin Stanley Frohman (@BenFrohman).

Published claim in `Hodge/Fourfold.lean`:

```lean
def HodgeConjecture.general_fourfold
    (D : Datum Z V N) [IsVariety D] (_h : D.codim = 2) : Prop :=
  D.HodgeConjecture
```

This is the Hodge conjecture in the first open case: every Hodge class
on a tagged fourfold of codimension 2 is algebraic.

It is a `Prop`. It is not a theorem. There is no general `CycleSection`.
There is no axiom `construct_of_codim_ge_two` on this release.

## Released as theorems (not the general sentence)

- `HodgeConjecture.classical_fourfolds`
- `CycleSection` on `P^4`, `Q^4`, `P^2 × P^2`
- `KleinPairing`: numerical Identity B on `Rat × Rat`

## Not released as proved

A map `s` sending an arbitrary extra class on an arbitrary fourfold to
surfaces. That remains the missing term.
