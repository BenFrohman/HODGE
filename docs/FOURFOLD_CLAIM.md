# Fourfold claim — the axiom is gone

An earlier version of `Hodge/Fourfold.lean` recorded

```lean
axiom construct_of_codim_ge_two
    (D : Datum Z V N) (h : 2 ≤ D.codim) :
    ∀ v ∈ D.hodgeClasses, v ∈ D.algebraicClasses
```

That statement is not the Hodge conjecture. It is false as linear algebra.
`Examples.zeroCycle` has `codim = 2`, `cl = 0`, and
`¬ zeroCycle.HodgeConjecture`. The axiom plus that example proved `False`.

The correction, already in `Hodge/Fourfold.lean`:

- drop the axiom;
- keep the *type* `constructOfCodimGeTwo` as a proposition;
- do not supply a term.

Known cases (`Classical.projectiveFourSpace`, `Classical.kleinQuadric`,
`Classical.productOfPlanes`) still carry `CycleConstructor` instances.
A general fourfold does not. `zeroCycle` remains the formal witness that
the `Datum` interface does not imply the conjecture.

```lean
#print axioms Hodge.Examples.zeroCycle_not_hodge
```

is expected to list only standard logical axioms.
