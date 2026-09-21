# Status

Author of the repository record: Benjamin Stanley Frohman (@BenFrohman).

This file exists so the next request to "complete everything" has a
place to look. The objects below are not missing because they were
forgotten. They are missing because they are not constructed.

## Complete, and in the repository

- Cycle class map as geometry: `docs/CYCLE_CLASS_AND_CONSTRUCTOR.tex`
- Constructor on three classical fourfolds: `Hodge/Classical.lean`,
  `docs/CLASSICAL_FOURFOLDS.md`
- Named Plücker data and plane ideals: `Hodge/Klein.lean`
- Naming dictionary and bilingual identities: `docs/NAMING.md`
- Amplituhedron as a cousin, not a renaming: `docs/AMPLITUHEDRON.md`
- Guarded axiom `construct_of_codim_ge_two` on `IsVariety`:
  `Hodge/Fourfold.lean`
- Counter-model `zeroCycle` and
  `¬ (∀ D, 2 ≤ D.codim → D.HodgeConjecture)`: `Hodge/Examples.lean`

## Not complete, and not completable by adding a file

1. An explicit rule `γ ↦ (Z_i, a_i)` on a general fourfold.
   The sentence that such a finite collection exists is the Hodge
   conjecture in its first open case. Writing the surfaces down from
   `γ` would be a section of `cl`. That section is not in this
   repository.

2. A term of type `CycleConstructor` for a general fourfold, obtained
   without an axiom. `constructOfCodimGeTwo` is a proposition. The
   restored axiom supplies a term only after the caller flags the
   datum `IsVariety`. That is a hypothesis, not a construction.

3. A Lean Chow ring of `Gr(2,4)` in which `[Π]² = 1` is a theorem.
   `Hodge/Klein.lean` is Level 1 naming. Mathlib does not supply the
   Klein quadric as a projective variety in this repository. The
   intersection matrix remains in the geometric note.

4. A proof of the Hodge conjecture.
   The Clay problem is open. This skeleton does not close it.

## What will not be committed under those headings

- A fake list of surfaces for a general `γ`
- An unguarded axiom on every `Datum` (that plus `zeroCycle` is `False`)
- `[Pi]^2 = 1` as a Lean theorem with no Chow ring
- A title that says the conjecture is proved
