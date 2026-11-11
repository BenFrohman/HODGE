# Progress: chain-sextic bridge decomposition

Live branch: `formalize/chain-sextic-bridge-decomposition`, from `origin/main` at `4c76889`.
No merge, tag, force-push or Zenodo work.

## Checkpoint 1 (this file, first push)

- `Hodge/ChainSexticCharacterCore.lean` builds clean. `#print axioms` on
  `hdg_split`, `orbit_simple`, both `rho_eq_786`, `rationalPoints_eq_bot_of_conj`
  and `coverCheck` uses only `propext`, `Classical.choice`, `Quot.sound`
  (or no axioms, for `coverCheck`).
- Moved from hypothesis to theorem: `hdg_split` and `orbit_simple`, and
  then `galois_min` from the Galois-conjugation field.
- Docs: `docs/CHAIN_SEXTIC_BRIDGE_TABLE.md`.
- Not in this commit: `Hodge/ChainSexticCharacterModel.lean` (draft
  non-vacuity model; it does not yet compile, mainly memory pressure from
  a 27001-dimensional coordinate space). That file is left untracked until
  it builds.

## Still assumed (plain words)

The geometric meaning of `H^{2,2}`, the Griffiths residue identification,
the cycle class of `h²` and of the plane, the cup-product numbers, the
eigenline decomposition of primitive cohomology, and the Galois descent
of those lines onto rational subspaces. Mathlib has none of this
foundational Hodge theory, so those fields stay hypotheses. A kernel
check of character counts is not geometric truth.
