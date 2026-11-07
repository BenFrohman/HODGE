# Contributing to HODGE

Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Author: Frohman, Benjamin Stanley (@BenFrohman).

See `docs/BRANCH_RULES.md`.

## This repository

1. Open a branch off `main`.
2. Add no `sorry`, `admit`, or `axiom` declarations to the checked library.
   External classical inputs must remain clearly documented and, where used
   conditionally, explicit theorem hypotheses rather than new axioms.
3. Do not assert `HodgeConjecture` for every `Datum`. `Examples.zeroCycle`
   is a counterexample to that sentence.
4. Do not identify the residual quintic surface `S` with the partner fourfold `Y`.
   `S` has dimension 2. `Y`, if written, has dimension 4.
5. Open a pull request against `main` with a title that says what changed
   and a body that says what did not change (in particular: this is not a
   full geometric Lean proof of the Hodge conjecture).

## mathlib4 and lean4

Do not open a pull request against `leanprover-community/mathlib4` or
`leanprover/lean4` with this interface. Those projects require:

- discussion on the Lean Zulip *before* a new-theory PR,
- Mathlib style, naming, and review,
- no unsupervised AI-authored theory PRs.

This repository's `Variety` is a name plus a `Datum`. It is not Hodge theory
in Mathlib. A PR of this file to Mathlib would be closed.

If a future formalization of schemes, Hodge decomposition, or Chow rings
reaches Mathlib quality, discuss it on Zulip first and follow
https://leanprover-community.github.io/contribute/

## Incremental residue formalization checks

Run the README's pinned build, exact-certificate and `ResidueAxiomAudit.lean`
commands. Regenerate `Hodge/ExplicitResidueCertificates.lean` with the checked-in
generator and require a clean diff. Review the final theorem assumptions: a
certificate is not completed by assuming its desired nonvanishing conclusion.
No `native_decide` shortcut may be presented as an ordinary kernel proof.
Keep genuine polynomial/ideal statements separate from unimplemented geometric
realizations; never rename arbitrary vector spaces or maps as the actual cycles
or cohomology of X. Preserve all existing mathematical work and license notices.

Use `SECURITY.md` for potentially sensitive vulnerabilities rather than public
issues. Existing `CITATION.cff` records the historical archived work; do not mint
release identifiers or change release dates as part of an unreleased proof PR.
