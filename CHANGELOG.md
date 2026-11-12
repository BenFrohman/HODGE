<!-- Copyright (c) 2026 Benjamin Stanley Frohman. Licensed under Apache-2.0. -->
# Changelog

Author: Benjamin Stanley Frohman (@BenFrohman).

## 2026-11-11 Non-vacuity model of the chain-sextic character core

- New `Hodge/ChainSexticCharacterModel/`: a linear-algebra inhabitant of `ChainSexticCharacterCore` (and therefore of `ChainSexticCharacterBridge`) on the compact encoding `ModelH := Idx →₀ ℚ` of the full 27001-dimensional space. `equivDense : ModelH ≃ₗ[ℚ] DenseH` and `finrank = 27001` are proved from counting formulas, not by materializing a dense 27001-dimensional `Pi` space. The bridge hypotheses are transported along the equivalence to `DenseH`. In the model, `rho = 786`.
- Mixed type-`(2,2)` eigenlines are twisted by distinct powers of a root of `X^8-2`, so `galois_min` holds; this is linear algebra, not an `Aut(ℂ/ℚ)` action. `ChainSexticCharacterGalois` is not inhabited.
- Standard axioms only; no `sorry`, `admit`, `native_decide` or new axioms. This is not the cohomology of the sextic, and combinatorial `type22` is not identified with geometric Hodge type.
- `AxiomAudit.lean`: 747 `#print axioms` lines (731 before, plus 16 new), standard axioms only.

## 2026-11-11 Shrink the chain-sextic character bridge; hypothesis table

- New `Hodge/ChainSexticCharacterCore.lean`: `hdg_split` and `orbit_simple` are theorems of a smaller bundle `ChainSexticCharacterCore` (from `galois_min`), and `galois_min` is a theorem of `ChainSexticCharacterGalois` (from Galois conjugation of the eigenlines). `rho_eq_786` holds for both. Standard axioms only; no `sorry`, `admit`, `native_decide` or new axioms.
- The eigenline decomposition, Griffiths type, and Galois descent of the isotypic pieces remain hypotheses. Nothing here is the cohomology of the sextic, and Mathlib still has no cycle class map.
- New `docs/CHAIN_SEXTIC_BRIDGE_TABLE.md`: every bridge field mapped to the paper assumption it encodes, with checked citations. Identifications that Lean does not prove (combinatorial `qv` versus geometric Hodge type; the polynomial `21` versus `Π·Π`) are reported, not patched.
- `AxiomAudit.lean`: 731 `#print axioms` lines (699 before, plus 32 new).

## 2026-11-10 dim R_12 = 1751 in Lean; Delsarte paper v1.5

- New `Hodge/ChainSexticR12.lean`: `jacobianDeg12_finrank_eq : finrank ℚ jacobianDeg12 = 1751`. The lower bound comes from an explicit normal-form map `Φ` that vanishes on the Jacobian ideal and fixes the standard monomials (`stdMonomial_linearIndependent`, also for all 15625 standard monomials); `jacobianDeg12_basis` is an explicit basis. Non-vacuity checks included.
- New `Hodge/ChainSexticR12Bridge.lean`: the Griffiths field is equivalent to `h^{2,2} = 1752` (`griffiths_iff`, `hodgeBridge_h22`); the necessary condition of `characterBridge_forces_R12` holds. `rho_eq_786` remains conditional on `ChainSexticCharacterBridge`; no inhabitant is constructed.
- `AxiomAudit.lean`: 699 `#print axioms` lines (646 before, plus 53 new), standard axioms only.
- Docs: `docs/R12_EQUALITY.md` (every step), `docs/R12.md`, `docs/GLOSSARY.md`, `docs/CHAIN_SEXTIC_RANK.md`, `docs/VACUITY_AUDIT.md`, README.
- Paper v1.5: "Corrections in v1.5"; `dim R_12 = 1751` is now marked [Lean] with the full proof written out; the Griffiths identification stays [Cited].

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
