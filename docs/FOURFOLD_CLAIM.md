# Fourfold claim

An earlier version of `Hodge/Fourfold.lean` recorded the author claim
that every `Datum` of codimension at least two admits a
`CycleConstructor`, as an axiom named `construct_of_codim_ge_two`.

That statement is not the Hodge conjecture. Combined with
`Examples.zeroCycle` it proved `False`:

- `zeroCycle` has `codim = 2`, `obstruction = 0`, and `cl = 0`;
- `zeroCycle_not_hodge` proves `¬ zeroCycle.HodgeConjecture`;
- the axiom asserted `HodgeConjecture` for every such datum.

That is a type/logic bug, not a missing geometric proof.

The axiom has been removed. `Hodge/Fourfold.lean` now keeps only the
*type* of the missing constructor:

```lean
def constructOfCodimGeTwo (D : Datum Z V N) (_h : 2 ≤ D.codim) : Prop :=
  ∀ v ∈ D.hodgeClasses, v ∈ D.algebraicClasses
```

This is definitionally `D.HodgeConjecture`. No term is supplied.
Known cases (`Classical.projectiveFourSpace`, `Classical.kleinQuadric`,
`Classical.productOfPlanes`) still carry `CycleConstructor` instances
proved by linear algebra. A general fourfold does not.
