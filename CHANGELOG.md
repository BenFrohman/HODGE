# Changelog

Author: Benjamin Stanley Frohman (@BenFrohman).

## 2026-09-29 type separation

- Undo the collapse of `contains_two_planes` with the Hodge conjecture.
- New official Clay type: `Hodge.Clay.RationalHodgeCodimTwo` (`∀ X ∀ γ ∃ z`). Uninhabited.
- New release surface: `Hodge.Release.contains_two_planes` (closed) and `Hodge.Release.ClaySentence` (open, no theorem).
- `SpecialSextic.ClosedMembership` packages the ring identity. Not Clay.
- `planeSpan_identity_shadow` is the honest name of the `cl = id` discharge. `planeSpan_hodge` is retained as an alias and is not Clay.
- Record: `docs/TYPE_SEPARATION.md`.
- Tag remains `clay-statement-open`. Not a Clay close.

## 2026-09-22 trichotomy

- `docs/TRICHOTOMY.md`: Hodge (`∀X ∀γ ∃Z`), counterexample (`∃X ∃γ ∀Z`), missing Lean instance.
- `F_mem_plane` stays the easy arrow on the named sextic. Not Hodge. Not a counterexample.
- No Clay tag change. Status remains open.

## 2026-09-21 architecture snapshot

- Three-row ledger: `docs/VERIFICATION.md`
- Core: guarded axiom on `IsVariety` (`Hodge/Fourfold.lean`)
- Islands: `CycleSection` via `cl = LinearMap.id` (`Hodge/Classical.lean`)
- Lefschetz (1,1): class in `Hodge/Frontier.lean`
- Fermat identities: sister repo BenFrohman/FermatPlanes (`ring`)
- Fermat *ideal membership* in `Hodge/Attempt/FermatPlanes.lean`: still `sorry`
- NL: BenFrohman/NoetherLefschetz, axiom uses `isVeryGeneral` and `d ≥ 6`
- Hodge numbers: `docs/HODGE_NUMBERS.md` (sextic 1,426,1752,426,1)
- Row 3 sentence: `Hodge/Attempt/ClayStatement.lean`, not a theorem
- CI builds `Hodge`; forbids `import Hodge.Attempt` in `Hodge.lean`

Not tagged v1.0.0-verified as a Clay close.
