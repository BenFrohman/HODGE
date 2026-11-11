# Progress: chain-sextic bridge decomposition

Live branch: `formalize/chain-sextic-bridge-decomposition`.
Draft PR: https://github.com/BenFrohman/HODGE/pull/51
Head: `ec2937d99ecaf06f5d985037a6791262da5131b2` (from `origin/main` at `4c76889`).
No merge, tag, force-push or Zenodo work.

## Checkpoint 1 (pushed)

- `Hodge/ChainSexticCharacterCore.lean` builds clean. `#print axioms` on
  `hdg_split`, `orbit_simple`, both `rho_eq_786`, `rationalPoints_eq_bot_of_conj`
  and `coverCheck` uses only `propext`, `Classical.choice`, `Quot.sound`
  (or no axioms, for `coverCheck`).
- Moved from hypothesis to theorem: `hdg_split` and `orbit_simple`, and
  then `galois_min` from the Galois-conjugation field.
- Docs: `docs/CHAIN_SEXTIC_BRIDGE_TABLE.md`.

## CI on `ec2937d` (all green, America/Chicago)

- Lean `build`: success (run 43111565116)
- Lean `attempt`: success
- Lean certificate `certify`: success (also a second certify check, both success)
- Paper: success

## Checkpoint 2 (not pushed)

A non-vacuity model is drafted in the untracked file
`Hodge/ChainSexticCharacterModel.lean`. It is not in the PR because it does
not yet compile. An earlier version used a 27001-dimensional `Pi` space and
ran out of memory. The rewrite uses the finite span of `1 + 2605` standard
vectors inside `Option Ch →₀ ℚ`, so Lean does not enumerate a `Fintype` of
the character cube, and it uses `Finset.attach` to avoid a decidable
computation of `shiftedSet`. The file is still incomplete (it ends at `N`,
with `#exit`) and earlier compiles either failed on small algebraic goals or
hit the memory cap while elaborating. It will be pushed only after a clean
build on standard axioms.

## Still assumed (plain words)

The geometric meaning of `H^{2,2}`, the Griffiths residue identification,
the cycle classes of `h²` and of the plane, the cup-product numbers, the
eigenline decomposition of primitive cohomology, and the Galois descent
of those lines onto rational subspaces. Mathlib has none of this
foundational Hodge theory, so those fields stay hypotheses. A kernel
check of character counts is not geometric truth.
