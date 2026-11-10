# Are the "algebraic spans" certified? A kernel check

Author: Benjamin Stanley Frohman. Lean file: `Hodge/AlgebraicSpanChecks.lean`.
Toolchain: `leanprover/lean4:v4.22.0`, Mathlib `v4.22.0`. No `sorry`, `admit`,
`native_decide`, or new axioms. Every new theorem's `#print axioms` output is a subset of
`propext`, `Classical.choice`, `Quot.sound` (see `AxiomAudit.lean`).

## The short answer

**No.** The surfaces named in the Cycle Class Map records are genuine algebraic surfaces,
and the algebra around them checks out in the Lean kernel. But no Lean statement says
"the cohomology class of this surface is this vector". That step needs the cycle class map,
Poincaré duality, and intersection theory on complex projective varieties, and Mathlib does
not have them. So the spans are *established in the source* (standard algebraic geometry
plus the arithmetic checked here). They are not *certified* by a machine.

The earlier `…_hodge` / `…HodgeConjecture` theorems for the named fourfolds use coefficient
shadows with `cl := LinearMap.id`, so they hold by `rfl` whatever the geometry is. They do
not certify algebraicity either.

## What was checked, claim by claim

| Claim (records / source) | Lean | Verdict |
|---|---|---|
| Klein quadric: σ-plane Π and ρ-plane Π′ lie on Q | `Hodge.Klein.pi_on_quadric`, `pi'_on_quadric` (existing) | kernel-checked true |
| Q is smooth | `Klein.plucker_smooth` | kernel-checked true |
| [Π]·[Π′] = 0 | `Klein.pi_pi'_disjoint` (Π ∩ Π′ = ∅) | geometric input kernel-checked; value 0 is then standard |
| h² = [Π] + [Π′] | `Klein.h2_section_splits`, `rhoPlane_on_quadric` (Q ∩ {p12=p13=0} = Π ∪ ρ-plane) | the polynomial identity is kernel-checked; equality of classes is not (needs cl) |
| [Π′]² = 1 | `Klein.rhoPlanes_meet_in_point` (two ρ-planes meet in one point) | geometric input kernel-checked |
| Gram I₂, h⁴ = 2 = deg Q, h²·Π = 1 | `Klein.gram_det`, `degree_checks` | kernel-checked true (consistency) |
| P²×P²: basis h₁², h₁h₂, h₂² | `ProductOfPlanes.gram_det` (= −1), `segre_degree` (h⁴ = 6) | kernel-checked true (consistency) |
| Hassett C₈: Π on X, Gram [[3,1],[1,3]] | `HassettC8.cubic_mem_plane`, `gram_det` (= 8) | kernel-checked true |
| [Π]² = d² − 3d + 3 (= 21 for d = 6) | `PlaneInHypersurface.chern_product`, `selfIx_values` | Chern arithmetic kernel-checked; the self-intersection formula itself is not |
| Fermat quartic: Z₁, Z₂ lie on X | existing `fermatQuartic_mem_surfaceZ1`; new `fermatQuartic_mem_surfaceZ2`, `two_planes_exist` (ζ exists in ℂ) | kernel-checked true (Z₂ was not proved before) |
| Fermat quintic contains a plane | `FermatQuintic.quintic_mem_plane` | kernel-checked true |
| Chain sextic: Π, Π₋₁ lie on X; X smooth | existing `contains_two_planes`, `gradient_only_origin` | kernel-checked true |
| All 8 diagonal planes lie on X | `ChainSextic.F_mem_diagPlane` | kernel-checked true |
| [Π]·[Π₋₁] = 0 | `ChainSextic.pi_piMinus1_disjoint` | geometric input kernel-checked |
| [S] = h² − [Π], deg S = 5 | `ChainSextic.residual_factor`, `residual_split` | polynomial identity kernel-checked |
| Only Π among the 20 coordinate planes; no coordinate P³ | `ChainSextic.coordinate_planes`, `no_coordinate_P3`, `F_cast` | kernel-checked true |
| Gram det 125 and 2604 | `ChainSextic.gram2_det`, `gram3_det` (actual `Matrix.det`) | kernel-checked true |
| 8×8 plane Gram, det 24461180928; with h², rank 9 | `ChainSextic.gram8Z_rule`, `gram8_det`, `gram9_det` (LU certificates) | kernel-checked true |
| These classes are linearly independent in H⁴(X, ℚ) | `GramRealization.finrank_span`, `rank_nine`, `rank_three`, `klein_rank_two`, `productOfPlanes_rank_three`, `hassettC8_rank_two` | proved **conditional** on the stated cup products (`GramRealization`); `rank_nine_nonvacuous` shows the hypothesis can be satisfied |
| The vector used is the cycle class of the surface | — | **not machine-checkable yet**: no cycle class map in Mathlib |
| Every Hodge class on X is in the span | — | not claimed here; Hodge-theoretic, not formalized |

No checked claim came out false.
