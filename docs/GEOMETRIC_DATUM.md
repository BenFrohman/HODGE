# GeometricDatum boundary

`zeroCycle` is an abstract linear-algebraic sentinel. It is not a geometric counterexample to the Clay Hodge conjecture.

## What `zeroCycle` shows

In `Hodge/Examples.lean` the term

```lean
def zeroCycle : Datum Rat Rat Rat where
  codim := 2
  obstruction := 0
  cl := 0
  cl_isHodge := by intro _; rfl
```

proves

```lean
theorem not_every_codim_ge_two :
    ¬ (∀ D : Datum Rat Rat Rat, 2 ≤ D.codim → D.HodgeConjecture)
```

The only hypothesis used is `D.codim = 2`. On any smooth complex projective variety of dimension at least 2 the hyperplane power has nonzero class, so the geometric cycle class map is never the zero map. Consequently `zeroCycle` cannot arise from a geometric variety. It certifies only that a proof of `HodgeConjecture.general_fourfold` must use geometric input beyond the codimension label.

## GeometricDatum

`Hodge/GeometricDatum.lean` refines `Datum` by a field

```lean
nonvanishing_cycle : ∃ z : Z, cl z ≠ 0
```

The theorem `not_geometric_zeroCycle` shows that no such refinement can equal `zeroCycle`. The one-dimensional span `hyperplaneSquareSpan` (obstruction = 0, cl = id, witness 1) is a `GeometricDatum` and satisfies `HodgeConjecture.general_fourfold` by the same identity argument used for the other named spans.

## What remains open

A `GeometricDatum` whose underlying modules are the actual Chow group and cohomology of a smooth sextic fourfold, with `cl` the geometric cycle class map, is still an unspecified datum. `HodgeConjecture.general_fourfold` for that datum is the Hodge conjecture in codimension 2 for that fourfold. No term is supplied.

Copyright (c) 2026 Benjamin Stanley Frohman. Apache License 2.0.
