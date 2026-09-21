# Contributing to HODGE

Copyright 2026 Benjamin Stanley Frohman. Apache-2.0.

## This repository

1. Open a branch off `main`.
2. Keep Lean files free of `sorry`, `admit`, and `axiom` unless the file
   comment states that the axiom is a named hypothesis, not a theorem.
3. Do not assert `HodgeConjecture` for every `Datum`. `Examples.zeroCycle`
   is a counterexample to that sentence.
4. Open a pull request against `main` with a title that says what changed
   and a body that says what did not change (in particular: this is not a
   proof of the Hodge conjecture).

## mathlib4 and lean4

Do not open a pull request against `leanprover-community/mathlib4` or
`leanprover/lean4` with this interface. Those projects require:

- discussion on the Lean Zulip *before* a new-theory PR,
- Mathlib style, naming, and review,
- no unsupervised AI-authored theory PRs.

This repository\u2019s `Variety` is a name plus a `Datum`. It is not Hodge theory
in Mathlib. A PR of this file to Mathlib would be closed.

If a future formalization of schemes, Hodge decomposition, or Chow rings
reaches Mathlib quality, discuss it on Zulip first and follow
https://leanprover-community.github.io/contribute/
