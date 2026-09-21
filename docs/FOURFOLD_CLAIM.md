# Fourfold claim

`Hodge/Fourfold.lean` restores `axiom construct_of_codim_ge_two`.

The unrestricted form

```lean
axiom construct_of_codim_ge_two
    (D : Datum Z V N) (h : 2 ≤ D.codim) : CycleConstructor D
```

is **not** restored. Together with `Examples.zeroCycle` it proved `False`.

The restored form is guarded:

```lean
axiom construct_of_codim_ge_two
    (D : Datum Z V N) [IsVariety D] (h : 2 ≤ D.codim) :
    CycleConstructor D
```

`IsVariety` is a flag, not a scheme. The classical islands carry it.
`zeroCycle` does not. After a successful build:

```lean
#print axioms Hodge.HodgeConjecture.general_fourfold
```

is expected to list `construct_of_codim_ge_two` together with the standard
logical axioms.

This packages the claim. It does not construct surfaces from a Hodge class
on a general fourfold.
