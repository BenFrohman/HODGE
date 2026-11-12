<!-- Copyright (c) 2026 Benjamin Stanley Frohman. Licensed under Apache-2.0. -->
# Chain sextic: ρ_Hdg = 786, what Lean proves

Author: Benjamin Stanley Frohman. Apache-2.0. Not a Hodge close.

File: `Hodge/ChainSexticRho.lean`. It builds on `Hodge/ChainSexticRank.lean` (PR #41).

## What 786 is

`scripts/hodge_rank.py` computes `dim_Q (H^4_prim(X,Q) ∩ H^{2,2}) = 785` for
`X = V(x0^5x3 + x3^6 + x1^5x4 + x4^6 + x2^5x5 + x5^6) ⊂ P^5`. So `ρ_Hdg(X) = 786` (adding h²).
This is a claimed exact value, obtained from Griffiths residues and Shioda's
diagonal-symmetry/Galois method. It is a statement about Hodge classes. It does not assume
the Hodge conjecture, and it says nothing about which of these classes are algebraic.
A re-run on 2026-11-09 printed `[1, 426, 1751, 426, 1]`, `785 from 122 Galois orbits`,
and `786`.

## How the argument goes

1. The group `G = (Z/30)^3` acts on X. The primitive cohomology splits into 2605 eigenlines
   `V_χ`, and the characters are pairwise distinct. Each line has pure type `(4-q, q)`.
2. Galois `(Z/30)^*` permutes the characters. Each Galois orbit O gives a rational piece
   `W_O` with `W_O ⊗ C = ⊕_{χ∈O} V_χ`, and `W_O` is a simple `Q[G]`-module.
3. Therefore `Hdg²_prim = ⊕ { W_O : every χ in O has q = 2 }`. That is 122 orbits and
   785 characters.

## Proven outright in Lean (kernel `decide`, no `native_decide`)

- `hodgeChars_card = 785`, via `hodgeChars_eq` and the existing `rational_hodge_dim`.
  The kernel checks are `orbitCheck`, `hodgeOrbitCheck` and `repCheck`.
- `orbit_subset` and `rationalHodge_iff`.
- All of the linear algebra in steps 2–3 and the final count: `finrank_cx`,
  `finrank_biSup_of_indep`, `W_le_hdg_of_hodge`, `hodge_of_W_le_hdg`, `hdg_eq`,
  `cx_hdg_eq`, `rho_eq_786`.

## Hypotheses (`ChainSexticCharacterBridge`, not axioms)

- The eigenline decomposition with multiplicity one: `V`, `V_out`, `V_line`, `eigen_indep`.
- Griffiths type: `h22_eq`.
- Galois descent of the isotypic pieces: `W`, `W_complex`.
- G-stability of Hdg²: `hdg_split`.
- Simplicity of each `W_O`: `orbit_simple`.

The structure extends `ChainSexticHodgeBridge`, so the same ρ satisfies `2 ≤ ρ ≤ 1752`
(`rho_bounds_and_eq`).

## Not proven

- The bridge facts above, and the Gröbner basis of the Milnor algebra.
  PR #41 proves only that the standard monomials span it.
- Anything about the 660 classes outside the plane span, or the Hodge conjecture.

## Update, 2026-11-11

`Hodge/ChainSexticCharacterCore.lean` proves `hdg_split` and `orbit_simple`
from a smaller hypothesis `galois_min`, and proves `galois_min` from Galois
conjugation of the eigenlines (`ChainSexticCharacterGalois`). The exact
count `ρ = 786` therefore holds for that smaller bundle. The eigenline
decomposition, Griffiths type, and rational descent of the isotypic pieces
are still hypotheses. See `docs/CHAIN_SEXTIC_BRIDGE_TABLE.md`.
