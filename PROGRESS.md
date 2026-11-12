# Progress: chain-sextic bridge decomposition

Live branch: `formalize/chain-sextic-bridge-decomposition`.
Draft PR: https://github.com/BenFrohman/HODGE/pull/51
No merge, tag, force-push or Zenodo work.

## Checkpoint 1 (pushed)

- `Hodge/ChainSexticCharacterCore.lean` builds clean. `#print axioms` on
  `hdg_split`, `orbit_simple`, both `rho_eq_786`, `rationalPoints_eq_bot_of_conj`
  and `coverCheck` uses only `propext`, `Classical.choice`, `Quot.sound`
  (or no axioms, for `coverCheck`).
- Moved from hypothesis to theorem: `hdg_split` and `orbit_simple`, and
  then `galois_min` from the Galois-conjugation field.
- Docs: `docs/CHAIN_SEXTIC_BRIDGE_TABLE.md`.

## Checkpoint 3 (character-core model)

- `Hodge/ChainSexticCharacterModel/` constructs a linear-algebra inhabitant
  of `ChainSexticCharacterCore` and `ChainSexticCharacterBridge` on the
  compact 27001-dimensional space `Idx →₀ ℚ`.
- Proved in Lean: `equivDense : ModelH ≃ₗ[ℚ] DenseH`,
  `finrank ModelH = finrank DenseH = 27001` from counting formulas
  (`card Cube = 27000`, `card Idx = 27001`), not by enumerating the cube
  or materializing a dense 27001-dimensional `Pi` space. The bridge
  hypotheses are inhabited on `ModelH` and transported along `equivDense`
  to `DenseH`. In both models, `rho = 786`.
- Memory peaks with `LEAN_NUM_THREADS=1` (RSS GiB): Space 2.054, Roots
  2.796, Lines 5.155, Indep 4.868, GaloisMin 4.952, Bridge 5.017. All well
  under GitHub Actions' ~16 GB; no workflow swap step is needed.
- `ChainSexticCharacterGalois` is not inhabited. Mathlib has no action of
  `Aut(ℂ/ℚ)` on the cohomology of a variety, and this work does not fake
  one. The core bundle does not require that action.
- This is not the cohomology of the sextic, and combinatorial `type22` /
  `qv` is not identified with geometric Hodge type.

## Still assumed (plain words)

The geometric meaning of `H^{2,2}`, the Griffiths residue identification,
the cycle classes of `h²` and of the plane, the cup-product numbers, the
eigenline decomposition of primitive cohomology, and the Galois descent
of those lines onto rational subspaces. Mathlib has none of this
foundational Hodge theory, so those fields stay hypotheses even though a
linear-algebra model shows they are jointly satisfiable. A kernel check
of character counts is not geometric truth.
