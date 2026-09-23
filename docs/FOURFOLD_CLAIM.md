# Fourfold claim

`construct_of_codim_ge_two` is a guarded axiom. It is a named hypothesis.
It is not a `CycleSection`.

```lean
axiom construct_of_codim_ge_two
    (D : Datum Z V N) [IsVariety D] (h : 2 ≤ D.codim) :
    CycleConstructor D
```

Why it is important: theorems can name the claim.
`#print axioms Hodge.HodgeConjecture.general_fourfold` is expected to list
`construct_of_codim_ge_two`.

Why it is not a proof: it does not return cycles. The real terms are the
`CycleSection` instances on `ℙ⁴`, `Q⁴`, and `ℙ² × ℙ²`.

The unguarded form is not present. Together with `zeroCycle` it is `False`.
