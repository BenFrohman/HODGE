# Changelog

Author: Benjamin Stanley Frohman (@BenFrohman).

## 2026-09-30 Fermat quintic fourfold X_5

- `Hodge/FermatQuintic.lean`: `G = ∑ x_i^5`, partials `5 x_i^4`, origin isolation.
- Rejected as projective: `∑ x_i^5 - 5 ∏ x_i` (degrees 5 and 6).
- `h^{3,1}=120`, not 0. AMV island, not a miss. Not `T_F`.
- `docs/FERMAT_QUINTIC.md`.

## 2026-09-30 Jacobian generators of F

- `Hodge/SpecialSexticJacobian.lean`: named partials of the chain sextic.
- `docs/JACOBIAN_GENERATORS.md`.
- `HodgeConjecture.general_fourfold` stays a `Prop`.
- Ledger `Z` uncomputed. Clay tag `clay-statement-open`.

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
- Hodge numbers: `docs/HODGE_NUMBERS.md` (sextic 1,426,1752,426,1; quintic 0,120,581,120,0)
- Row 3 sentence: `Hodge/Attempt/ClayStatement.lean`, not a theorem
- CI builds `Hodge`; forbids `import Hodge.Attempt` in `Hodge.lean`

Not tagged v1.0.0-verified as a Clay close.
