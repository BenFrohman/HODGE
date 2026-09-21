# Status

Author of the repository record: Benjamin Stanley Frohman (@BenFrohman).

```text
WIP:  HodgeConjecture.general_fourfold (Prop, no general term).
Done: classical_fourfolds, p4, klein, product, k3Surface_hodge.
Pin:  Lean 4.22.0 + mathlib v4.22.0 (79e94a09).
```

The objects below are not missing because they were forgotten.
They are missing because they are not constructed.

## Complete, and in the repository

- Cycle class map as geometry: `docs/CYCLE_CLASS_AND_CONSTRUCTOR.tex`
- Constructor on three classical fourfolds: `Hodge/Classical.lean`,
  `Hodge/Construct.lean`, `docs/CLASSICAL_FOURFOLDS.md`
- Discharged theorem `HodgeConjecture.classical_fourfolds`
  (`#print axioms`: `propext`, `Quot.sound`)
- Named Plücker data and plane ideals: `Hodge/Klein.lean`
- Naming dictionary: `docs/NAMING.md`
- K3 as Lefschetz (1,1) surface: `Hodge/Frontier.lean` (`k3Surface_hodge`)
- Counter-model `zeroCycle`: `Hodge/Examples.lean`
- Mathlib pin: `lakefile.toml`, `lake-manifest.json`

## Not complete

1. An explicit rule `γ ↦ (Z_i, a_i)` on a general fourfold.
2. A term of `HodgeConjecture.general_fourfold D h` for unspecified `D`.
   There is no axiom `construct_of_codim_ge_two`.
3. A Lean Chow ring of `Gr(2,4)` in which `[Π]² = 1` is a theorem.
4. A proof of the Hodge conjecture. Clay is open.

## What will not be committed

- A fake list of surfaces for a general `γ`
- An unguarded axiom on every `Datum` (that plus `zeroCycle` is `False`)
- A title that says the conjecture is proved
- A WIP stamp on `classical_fourfolds` or on `lake-manifest.json`
