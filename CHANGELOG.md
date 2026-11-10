<!-- Copyright (c) 2026 Benjamin Stanley Frohman. Licensed under Apache-2.0. -->
# Changelog

Author: Benjamin Stanley Frohman (@BenFrohman).

## 2026-11-10 Delsarte paper v1.4 (Lean status of dim R_12)

- Paper v1.4: the numerals $(1,426,1751,426,1)$ are labelled as a kernel-checked Hilbert-series / character-count computation, not a proof that $\dim R_{12}=1751$ for the formalized Jacobian module.
- Lean proves only $1 \le \dim R_{12} \le 1751$; the matching lower bound is not formalized.
- The explicit-cycle projection step is marked as pen-and-paper and not Lean-formalized.
- New section ``Corrections in v1.4'', reproducibility block (commit, Lean/Mathlib versions, axiom output, `lake build`), and affiliation Independent Researcher, Texas, United States on this version.

## 2026-11-04 explicit cycles for the 45 D24 orbits (v1.3)

- Added `Hodge/ExplicitCurve.lean`: the section identity and containment on X, proved with linear_combination and standard axioms.
- Added `scripts/explicit_cycles_curve.py`: exact sympy checks, orbit coverage 45/360, and a numeric check.
- `per_class_report`: 785/785 explicit (425 planes + 360 elliptic-correspondence).
- Paper v1.3: new section "Search for explicit cycles on the cited orbits".
- Caveat: the nonzero-projection step is pen-and-paper.

## 2026-09-29 type separation

- Undo the collapse of `contains_two_planes` with the Hodge conjecture.
- New official Clay type: `Hodge.Clay.RationalHodgeCodimTwo` (`∀ X ∀ γ ∃ z`). Uninhabited.
- New release surface: `Hodge.Release.contains_two_planes` (closed) and `Hodge.Release.ClaySentence` (open, no theorem).
- `SpecialSextic.ClosedMembership` packages the ring identity. Not Clay.
- `planeSpan_identity_shadow` is the honest name of the `cl = id` discharge. `planeSpan_hodge` is retained as an alias and is not Clay.
- Record: `docs/TYPE_SEPARATION.md`.
- Tag remains `clay-statement-open`. Not a Clay close.
## 2026-10-06 green head lock

- Head `bc1abdfa`. Lean CI run 37561876445 succeeded on `leanprover/lean4:v4.22.0`.
- `Hodge/SpecialSextic.lean` at `311bebe0`: `F_mem_plane` and `F_mem_plane_minus1`.
- `*` associates left, so `a * g * p = (a * g) * p`. The sign-plane generator is the middle factor. Peel `p` with `Ideal.mul_mem_right`, then `a` with `Ideal.mul_mem_left`.
- `contains_two_planes` says both named planes lie on `V(F)`. It is not a Hodge-class statement and not a Clay close.
- `Hodge/Klein.lean`: `initialize` is a Lean keyword. The map is `cycleOf`. Theorems `cycleOf_coeff`, `cycleOf_construct`.
- Clay tag unchanged: `clay-statement-open`. Status remains open.

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

## 2026-11-04 explicit-cycle search (negative)

- `scripts/explicit_cycles_graphs.py`: symbolic check of the fibration Ψ: S5 × W → X, plus exact character projections of 144 graph surfaces. These hit only plane-span orbits; **0 of the 45 cited orbits (0/360 dims)**.
- `docs/EXPLICIT_CYCLES_SEARCH.md`: the obstructions (unit alpha entries, cone reduction to curves on Y_jk, Aoki 3-standard non-match) and the open target.
- No status changes: the cited orbits stay cited.
