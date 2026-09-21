# Fourfold claim

`Hodge/Fourfold.lean` records the author claim that every datum of
codimension at least two admits a `CycleConstructor`.

That claim is an **axiom** named `construct_of_codim_ge_two`.
It is not a construction of surfaces from a Hodge class.

After a successful build:

```lean
#print axioms Hodge.HodgeConjecture.general_fourfold
```

is expected to list `construct_of_codim_ge_two` together with the standard
logical axioms. There is no `sorry` in the file.

This does not prove the Hodge conjecture. It packages the claim so the
rest of the skeleton can compile against it.
