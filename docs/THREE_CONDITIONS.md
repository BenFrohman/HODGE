# Three conditions for z_of γ := γ

Copyright 2026 Benjamin Stanley Frohman (@BenFrohman).
License: Apache-2.0.

No change to Hodge/Construct.lean or Hodge/Fourfold.lean.
Installing `z_of γ := γ` on variable D is the move this lock forbids.

## When the identity type-checks

`z_of γ := γ` type-checks only when all three hold at once:

1. Z = V
2. D.cl = LinearMap.id
3. D.obstruction = 0

Those three are how a named span is modelled after the surfaces are
chosen. They are not properties of an arbitrary Datum. They are not
properties of geometric H^4(X, Q).

## Forbidden instance

    instance (D : Datum Z V N) (h : D.codim = 2) : CycleSection D where
      construct := fun γ => γ.val
      is_section := fun γ => rfl

The kernel would accept that only if every host is a coordinate shadow.
That is a different problem, not Hodge.

## Correct repo state

    def HodgeConjecture.general_fourfold D h : Prop := D.HodgeConjecture

A term would be z_of plus cl_z_eq_γ for every such D.
Main has that pair only on named hosts.
The missing pair is not released by rewriting the Prop, by rfl, or by
another cl = id file.
