# Status

Author of the repository record: Benjamin Stanley Frohman (@BenFrohman).

WIP: `HodgeConjecture.general_fourfold` (no term).
Done: `classical_fourfolds`, `k3Surface_hodge`.
Pin: Lean 4.22.0 + mathlib v4.22.0 (`79e94a09`).

The objects below are not missing because they were forgotten.
They are missing because they are not constructed.

## Complete, and in the repository

- Cycle class map as geometry: `docs/CYCLE_CLASS_AND_CONSTRUCTOR.tex`
- Constructor on three classical fourfolds: `Hodge/Classical.lean`,
  `HodgeConjecture.classical_fourfolds`
- `CycleSection` on `projectiveFourSpace`, `kleinQuadric`, `productOfPlanes`
- Named Plücker data: `Hodge/Klein.lean`
- K3 as Lefschetz (1,1): `k3Surface`, `k3Surface_hodge` in `Hodge/Frontier.lean`
- Naming dictionary: `docs/NAMING.md`
- Counter-model `zeroCycle`: `Hodge/Examples.lean`
- Print-axioms commands: `Hodge/Verify.lean`

## Not complete

1. A rule `γ → (Z_i, a_i)` on a general fourfold.
2. A term of `general_fourfold D h` for arbitrary `IsVariety` `D`.
3. A Lean Chow ring of `Gr(2,4)` with `[Π]² = 1`.
4. A proof of the Hodge conjecture. Clay is open.

There is no axiom `construct_of_codim_ge_two`.

## What will not be committed

- A fake list of surfaces for a general `γ`
- An unguarded axiom on every `Datum`
- A title that says the conjecture is proved
