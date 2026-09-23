# Findings ledger (this work)

Author: Benjamin Stanley Frohman (@BenFrohman).
Map of what was built, where it lives, and what it is not.
Not a list of solved Millennium problems.

## A. Proved in Lean in HODGE

| Finding | Where |
|---|---|
| CycleSection on P^4, Q^4, P^2 x P^2 | Hodge/Construct.lean, Hodge/Classical.lean, Hodge/Fourfold.lean (classical_fourfolds) |
| F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6 lies in <x3,x4,x5> | Hodge/SpecialSextic.lean (F_mem_plane / hypersurface_contains_the_plane) |
| Affine cone of F isolated at the origin | Hodge/SpecialSextic.lean (gradient_only_origin) |
| 5^6 = 15625 | Hodge/SpecialSextic.lean (five_pow_six) |
| planeSpan = Q h^2 + Q [Pi], cl = id | Hodge/SpecialSextic.lean |

Paper: docs/CYCLE_CLASS_AND_CONSTRUCTOR.tex (three islands);
addendum docs/PAPER_ADDENDUM.md and docs/F_HOST.md (F).

## B. Written as geometry of this host F (not Hassett)

| Finding | Where |
|---|---|
| F is the one fourfold in the library written as a polynomial with proved plane membership | docs/F_HOST.md |
| Shape F = x3 A + x4 B + x5 C forces Pi = {x3=x4=x5=0} on a degree-6 fourfold in P^5 | docs/F_HOST.md, docs/EXTRA_CLASS_SEXTIC.md |
| planeSpan is the algebraic lattice of this special NL sextic, not full H^{2,2}, not a K3 lattice, not F_d, not C_d | docs/F_HOST.md |
| Partner is the NL locus of sextics through this plane (naive dim 433). Analogue of a Hassett divisor, not C_d | docs/F_HOST.md |
| h^{3,1} ~ 426 on a sextic fourfold; no Kuznetsov A_X ≃ D^b(S) | docs/DERIVED.md, docs/F_HOST.md |

## C. Classification / cuts locked in docs

| Finding | Where |
|---|---|
| Official variables of the missing object: Z_i surfaces, a_i rationals | docs/CONSTRUCT.md |
| Two legal inhabitants of the Hodge forall: uniform construct, or uniform existence. Named hosts are neither | docs/CONSTRUCT.md |
| Known bases: cells/Schubert/h^k/named plane/cited Zucker. Not inferred from "fourfold" | docs/KNOWN_BASES.md |
| Cubic h^{2,2}=21 is a complex Hodge number, not 21 algebraic cycles. Very general cubic: rank Hdg^2 = 1. Hassett C_d: rank ≥ 2 | docs/CUBIC_FOURFOLD.md, docs/KNOWN_BASES.md |
| Very general high-degree sextic: NL ⇒ Hdg^2 = Q h^2. Not a hidden extra class | docs/KNOWN_BASES.md, NoetherLefschetz sister |
| Easy arrow is a theorem. Reverse is Hodge. Correspondences live on products | docs/CORRESPONDENCES.md, docs/TWO_MAPS.md |
| L = cup h is already algebraic. Lefschetz B is algebraicity of Lambda on X x X | docs/STANDARD_CONJECTURES.md |
| Missing Lean instance ≠ Hodge false ≠ Clay counterexample | docs/CONSTRUCT.md |
| D^b / FM kernel does not write I(Z_i) from a Hodge class on F | docs/DERIVED.md |
| Derived Torelli (Mukai–Orlov) is K3 Mukai-lattice isometry, not a constructor on F | docs/DERIVED_TORELLI.md |

## D. Sister repos

| Repo | Finding |
|---|---|
| FermatPlanes | Remainder identity z^4+w^4 = (z-ζw)(cubic)+(1+ζ^4)w^4. Not a global constructor |
| NoetherLefschetz | Literature bound d ≥ 6 ⇒ no extra class on a very general X ⊂ P^5 |
| CubicFourfold | d=3, h^{2,2}=21; Hodge on this family is Zucker 1977 (cited) |
| StandardConjectures | Theorem: Hodge on X x X in the class of Lambda implies Lefschetz B. B itself not proved |

## E. Not proved (still open)

- Hodge conjecture: ∀X ∀γ ∃ Z_i, a_i. general_fourfold remains a Prop.
- instance (D : Datum) : CycleSection D
- Grothendieck A/B/C/D
- Derived Torelli as a new theorem
- Rationality of a cubic fourfold
- Jacobian finrank = 15625 as a Macaulay theorem (five_pow_six is the integer identity only)
