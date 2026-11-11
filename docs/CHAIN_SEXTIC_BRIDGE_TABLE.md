<!-- Copyright (c) 2026 Benjamin Stanley Frohman. Licensed under Apache-2.0. -->
# Hypothesis-to-paper table for the chain-sextic bridges

Author: Benjamin Stanley Frohman. Apache-2.0. Not a Hodge close.

This table maps every Lean hypothesis in the three named bridges
(`ChainSexticHodgeBridge`, `ChainSexticCharacterBridge` / its shrinkings, and
`SpanBridge`) to the paper assumption it encodes, with a literature citation.
A kernel check is not geometric truth: where Lean proves a combinatorial or
algebraic fact, the table says so; where a field still stands in for a
geometric statement, the table says so.

Citations already used in `paper/hodge_sextic/hodge_sextic.tex` are reused
here. The Griffiths 1969 papers were checked against their DOIs for this note
(Ann. of Math. 90 (1969), 460–495 and 496–541,
[doi:10.2307/1970746](https://doi.org/10.2307/1970746),
[doi:10.2307/1970747](https://doi.org/10.2307/1970747)). Section numbers
inside those works are not claimed.

## What this pull request moves from hypothesis to theorem

In `Hodge/ChainSexticCharacterCore.lean`, two fields of
`ChainSexticCharacterBridge` become theorems:

| Former field | Now a theorem of | Proved from |
|---|---|---|
| `hdg_split` (`Hdg²` splits along `ℚ·h²` and the rational isotypic pieces) | `ChainSexticCharacterCore.hdg_split` | `h22_eq`, `eigen_indep`, `W_complex`, plus the kernel-checked facts that Galois orbits of representatives cover `primChars` and are pairwise disjoint (`coverCheck`, `reps_eq_of_mem_orbit`) |
| `orbit_simple` (`Hdg² ∩ W_O` is `0` or `W_O`) | `ChainSexticCharacterCore.orbit_simple` | the smaller statement `galois_min` (a non-Hodge orbit's type-`(2,2)` sum has no nonzero rational vector) |

`galois_min` is itself a theorem of `ChainSexticCharacterGalois`, from one
remaining geometric/representation-theoretic input: Galois conjugation
permutes the eigenlines the same way it permutes the characters
(`galois`). Then `rho_eq_786` holds for both smaller bundles, via
`toCharacterBridge` / `toCore`.

Nothing in those proofs is the cohomology of `X`. They are linear algebra
and finite combinatorics, conditional on the remaining fields.

## `ChainSexticHodgeBridge` (`Hodge/ChainSexticRank.lean`)

These fields are unchanged in this pull request. The consequences
`2 ≤ ρ ≤ 1752` and `h^{2,2} = 1752` remain theorems *conditional on the
bridge* (`rho_bounds`, `hodgeBridge_h22`). `dim R₁₂ = 1751` is unconditional
Jacobian-ring algebra (`jacobianDeg12_finrank_eq`).

| Lean field | What it encodes | Status in Lean | Literature |
|---|---|---|---|
| `H22` | The Hodge piece `H^{2,2}(X) ⊆ H⁴(X,ℂ) = ℂ ⊗ H⁴(X,ℚ)` | Hypothesis (the ambient Hodge decomposition is not formalized) | Voisin, *Hodge Theory and Complex Algebraic Geometry I*, Cambridge, 2002, [doi:10.1017/CBO9780511615344](https://doi.org/10.1017/CBO9780511615344) (`Voi02` in the paper) |
| `griffiths` | `h^{2,2}(X) = 1 + dim_ℚ R₁₂`: Griffiths residue isomorphism `H^{2,2}_prim(X) ≅ R₁₂` plus the Lefschetz class `h²` | Hypothesis. Once assumed, it is equivalent to `h^{2,2} = 1752` because `dim R₁₂ = 1751` is proved | Griffiths, On the periods of certain rational integrals, I and II, *Ann. of Math.* 90 (1969), 460–495 and 496–541, [doi:10.2307/1970746](https://doi.org/10.2307/1970746), [doi:10.2307/1970747](https://doi.org/10.2307/1970747) |
| `pairing` | The cup-product form on `H⁴(X,ℚ)` | Hypothesis | Voisin, *op. cit.* |
| `h2`, `P` | The classes of `h²` and of the plane `Π = {x3=x4=x5=0}` (which lies on `X` by the already-proved `SpecialSextic.F_mem_plane`) | Hypothesis: Mathlib has no cycle class map | Voisin, *op. cit.*; the existence of a cycle class map is classical and is not formalized here |
| `h2_hodge`, `P_hodge` | Those classes lie in `Hdg²` (algebraic classes are Hodge) | Hypothesis | Voisin, *op. cit.* |
| `h2_h2` | `h²·h² = deg F = 6` | Hypothesis (the numeral 6 is the degree of the polynomial `F`, which is proved; the identification with the cup product is not) | Fulton, *Intersection Theory*, Springer, 1998, [doi:10.1007/978-1-4612-1700-8](https://doi.org/10.1007/978-1-4612-1700-8) (`Ful98`) |
| `h2_P`, `P_h2` | `h²·Π = Π·h² = 1` | Hypothesis | Fulton, *op. cit.* |
| `P_P` | `Π·Π = c₂(N_{Π/X})`, and that Chern number equals the already-proved coefficient `planeSelfIntersection = 21` | Hypothesis. The polynomial identity `planeSelfIntersection = 21` is a theorem; the geometric identification is not | Fulton, *op. cit.*, self-intersection formula |

## `ChainSexticCharacterBridge` and its shrinkings

The original bundle in `Hodge/ChainSexticRho.lean` extends the Hodge bridge.
This pull request keeps that bundle and adds two smaller ones that imply it.

| Lean field | What it encodes | Status in Lean after this PR | Literature |
|---|---|---|---|
| `V`, `V_out`, `V_line`, `eigen_indep` | `H⁴_prim(X,ℂ)` splits as a direct sum of `G = (ℤ/30)³`-eigenlines, indexed by the combinatorial primitive characters, each of dimension 1 | Still a hypothesis | Griffiths residues (Griffiths 1969, as above) together with the diagonal symmetry used by Shioda, The Hodge conjecture for Fermat varieties, *Math. Ann.* 245 (1979), 175–184, [doi:10.1007/BF01428804](https://doi.org/10.1007/BF01428804) (`Shi79`); see also Shioda, An explicit algorithm for computing the Picard number of certain algebraic surfaces, *Amer. J. Math.* 108 (1986), 415–432, [doi:10.2307/2374678](https://doi.org/10.2307/2374678) (`Shi86`) |
| `h22_eq` | `H^{2,2} = ℂ·h² ⊕ ⨁_{q χ = 2} V_χ`, i.e. the residue of character `χ` has Hodge type `(4−q,q)` with `q` equal to the combinatorial function `qv` | Still a hypothesis | Griffiths 1969, as above. **Reported identification, not patched:** Lean's `qv` and `type22` are combinatorial (kernel-checked). That they equal the geometric Hodge types of the residue classes is part of this hypothesis, not a proved equality of two independently formalized maps |
| `W`, `W_complex` | Each Galois orbit `O` gives a rational subspace `W_O ⊆ H⁴_prim(X,ℚ)` with `W_O ⊗ ℂ = ⨁_{χ∈O} V_χ` | Still a hypothesis | Shioda 1979 and 1986, as above (Galois descent of the character decomposition) |
| `hdg_split` | `Hdg²` is the sum of `ℚ·h²` and the intersections `Hdg² ∩ W_O` | **Theorem** of `ChainSexticCharacterCore` | No remaining citation: proved from the fields above and the orbit covering |
| `orbit_simple` | `W_O` is a simple `ℚ[G]`-module, so `Hdg² ∩ W_O` is `0` or `W_O` | **Theorem** of `ChainSexticCharacterCore`, from `galois_min` | The residual geometric input is now `galois_min` / `galois`, not a separate simplicity axiom |
| `galois_min` (new, in `ChainSexticCharacterCore`) | If an orbit is not entirely of type `(2,2)`, its type-`(2,2)` sum contains no nonzero rational vector | Hypothesis in the core bundle; **theorem** of `ChainSexticCharacterGalois` | See `galois` |
| `galois` (new, in `ChainSexticCharacterGalois`) | For each unit `t ∈ (ℤ/30)×` there is `σ ∈ Aut(ℂ/ℚ)` with `(σ ⊗ id)(V_χ) ⊆ V_{tχ}` | Still a hypothesis. Mathlib has the type `ℂ ≃ₐ[ℚ] ℂ` but not the action of such automorphisms on the cohomology of a variety | Shioda 1979 and 1986, as above |

Combinatorial facts used in the proofs, and already theorems (or added as
theorems in this file): `hodgeChars_card = 785`, `type22.card = 1751`,
`orbit_subset`, `rationalHodge_iff`, the group action of `(ℤ/30)×` on the
character cube, `coverCheck` (orbits of representatives cover `primChars`),
`reps_eq_of_mem_orbit` (those orbits are pairwise disjoint). These are
statements about finite sets and the functions `qv`, `act`, `isRep`. They
are not statements about `H⁴(X)`.

A remaining indexing caveat, unchanged from `Hodge/SexticCombinatorics.lean`:
the 25-element list `milnorBasis` for one pair is still taken as input (its
Gröbner-basis claim is not a Lean theorem). Injectivity of `chr` on that
list is kernel-checked. This is independent of the Jacobian-ring theorem
`dim R₁₂ = 1751`, which uses a different standard-monomial set.

## `SpanBridge` (`Hodge/HonestHosts.lean`)

| Lean field | What it encodes | Status in Lean | Literature |
|---|---|---|---|
| `cycles`, `spans` | `n` explicit cycles whose classes under an arbitrary linear map `D.cl` span the Hodge classes of a datum `D` | Named hypothesis. The conclusion `HodgeConjecture` is a theorem *of the hypothesis*. Mathlib has no cycle class map, so this cannot be discharged geometrically in Lean | For `P⁴`, the Klein quadric and `P² × P²`, a spanning statement is classical (cellular / Schubert / Künneth). Those cases are cited, not proved, in the module docstring of `HonestHosts.lean`. A specific numbered theorem is not re-identified here and is left **unverified** as a pinpoint citation |

`named_span_le_algebraic` (the span of named classes is algebraic) is a
theorem for every datum and does not mention Hodge classes. It is not a
stand-in for `SpanBridge`.

## Consistency, and what is not claimed

- `ChainSexticHodgeBridge` already has a linear-algebra inhabitant
  (`hodgeBridge_model`). That model is not the cohomology of the sextic; it
  only shows `rho_bounds` is not vacuous.
- This pull request does **not** yet construct an inhabitant of
  `ChainSexticCharacterCore` or `ChainSexticCharacterBridge`. A model is
  being written in a follow-up file; until it compiles, `rho_eq_786` is
  still formally conditional, and the earlier note in
  `Hodge/ChainSexticBridgeAudit.lean` remains accurate.
- No field is the Hodge conjecture, and nothing here produces algebraic
  cycles for the 660 classes outside the plane span.

## Assessment of what remains

The remaining Hodge, residue, cycle-class and Galois-action fields are not
within reach of a short formalization in current Mathlib (v4.22.0, as
pinned). Mathlib has no Hodge decomposition, no cycle class map, no
Griffiths residue map, and no action of `Aut(ℂ/ℚ)` on the cohomology of a
projective variety. Those are missing foundations, not missing lemmas
about the chain sextic.

What *is* within reach, and is the point of this work, is further shrinking
of the hypothesis bundle by purely algebraic or combinatorial arguments
(orbit counting, Galois-orbit combinatorics, linear algebra of descent),
together with non-vacuity models that do not pretend to be geometry.
