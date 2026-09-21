# lake build

This agent environment does not ship `lean` or `lake`. A claim of
`lake build → SUCCESS` made in chat was not produced by compiling this
repository here.

## What you can run locally

```
lake exe cache get
lake build
```

Default target is the `Hodge` library (`lakefile.toml`). The root file
`Hodge.lean` imports the islands, `Fourfold`, and examples. It does
**not** import `Hodge.Attempt.*`, so a `sorry` in an attempt file does
not fail the default target unless you add that import.

## What a green build certifies

- The imported modules are well-typed against the pinned Mathlib.
- `#print axioms Hodge.HodgeConjecture.classical_fourfolds` should list
  only standard logical axioms.
- `#print axioms Hodge.HodgeConjecture.general_fourfold` lists
  `construct_of_codim_ge_two`.

It does not certify a `CycleSection` on a general fourfold.

## Attempt files

`Hodge/Attempt/` is a sketch folder. Expect `sorry`. Do not treat a
successful typecheck of those files (if you import them) as Hodge
decomposition or as Hodge.
