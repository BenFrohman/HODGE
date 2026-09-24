# Findings inventory (session lock)

Author: Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
What this library actually produced during the working sessions,
versus what remains literature or open. Not a Clay discharge.

## A. Proved in Lean in this library (no sorry)

1. CycleSection on three cellular hosts:
   P^4, Q^4 ≃ Gr(2,4), P^2 × P^2.
   Files: Hodge/Classical.lean, Hodge/Construct.lean, Hodge/Klein.lean.
2. Named sextic host
       F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6
   in P^5, degree 6, K_X ≃ O.
   F_mem_plane / fixed_sextic_in_plane_ideal: F ∈ ⟨x3, x4, x5⟩.
   Plane Π = {x3 = x4 = x5 = 0} lies on V(F) by algebra.
   File: Hodge/SpecialSextic.lean. Note: docs/F_HOST.md.
3. gradient_only_origin / affine_cone_isolated_at_origin:
   ∇F = 0 only at the origin (case split; smoothness of the affine cone).
4. five_pow_six: 5^6 = 15625 by decide. Not Jacobian finrank of R(F).
5. planeSpan: Q h^2 ⊕ Q [Π] with cl = id on this host.
   Coordinates (a,b) mean a h^2 + b [Π]. construct γ := γ on that Q^2 shadow.
   Special ⇒ extra algebraic surface, visible to Lean. Not full H^{2,2}.
   Not Hassett C_d (those are cubics). Partner is the NL locus of sextics
   through this plane.
6. named_fourfolds (Hodge/NamedFamilies.lean): finite conjunction
       ClassicalFourfolds ∧ Fermat.twoPlanes ∧ SpecialSextic.planeSpan
       ∧ Hassett.planeSpan.
   Fermat and planeSpan sit here, not in classical_fourfolds.
   cl = id pipeline on named spans is finished. See docs/NAMED_FOURFOLDS.md.
   Not ∀ X. Next unnamed fourfold has no z_of.

## B. Sister-repo theorems (Lean or ring identities)

- FermatPlanes: pair identities with remainder
      z^4 + w^4 = (z − ζ w)(cubic) + (1+ζ^4) w^4
  and the degree-6 analogue. At ζ^4 = −1 the remainder vanishes.
  Easy-arrow planes on the Fermat quartic. Not a global constructor.
- StandardConjectures: theorem
      IsHodge(Λ) ∧ HodgeOnProduct ⇒ LefschetzB(Λ).
  Application of Hodge on X×X to the one class Λ = L^{-1}.
  Not a proof of Hodge. Not a proof of B. No term of HodgeOnProduct.
- NoetherLefschetz: statement of NL for very general high-degree
  fourfolds in P^5 (d ≥ 6 in this project). Literature axiom / vacuous HC
  when extras vanish. Not a proof of Hodge in general.
- CubicFourfold: Hodge numbers and scope. Zucker cited, not replayed.
- TateConjecture: sentence only. Not proved.

## C. Documentation findings (locks, not new geometry theorems)

- Named fourfolds lock (docs/NAMED_FOURFOLDS.md):
  cl = id after surfaces are named; halt that pipeline.
  Fermat twoPlanes ≠ full Hdg^2 (AMV is literature).
  Special sextic planeSpan ≠ general sextic ≠ general_fourfold.
- Known bases taxonomy (docs/KNOWN_BASES.md):
  always h^k; cellular Schubert/Künneth; special-locus plane span;
  cited Zucker / Murre / Conte–Murre / Lefschetz (1,1).
  h^{2,2}=21 on a cubic is a complex Hodge number, not 21 algebraic cycles.
  Very general cubic: rank Hdg^2 = 1 (only h^2). Hassett C_d: rank ≥ 2.
- Correspondences (docs/CORRESPONDENCES.md, docs/TWO_MAPS.md):
  easy arrow is a theorem; reverse is Hodge.
  After Hodge, Hodge classes on products become correspondences.
  L = cup h is already algebraic. Λ waits on Hodge on X×X / Lefschetz B.
  Periods and filtrations stay analytic.
- Derived lock (docs/DERIVED.md, docs/DERIVED_TORELLI.md):
  D^b does not write I(Z_i) from a Hodge class on F.
  O_Π is the same cycle as F_mem_plane.
  Mukai–Orlov derived Torelli is for K3 Mukai lattices, not for F.
  Bondal–Orlov off because K_F ≃ O.
  C_8 has d = 8 ≡ 0 (mod 4), so a Hodge-theoretic associated K3 exists;
  that is not A_X ≃ ordinary D^b(S) in general. Do not write 4 ∤ 8.
- Standard conjectures (docs/STANDARD_CONJECTURES.md):
  A/B/C/D + Hodge-standard. Hodge-standard over C is Hodge index,
  not Clay Hodge. HC in char 0 ⇒ B, C, D. B does not ⇒ HC on a fourfold.
- Construct inhabitants (docs/CONSTRUCT.md):
  ∀X ∀γ ∃ Z_i, a_i is the Prop general_fourfold.
  Inhabitant 1 = CycleSection for every D.
  Inhabitant 2 = uniform existence proof.
  Neither is in the repo.
- Missing instance ≠ counterexample:
  no instance (D) : CycleSection D is a library gap, not ¬Hodge.
  A Clay counterexample is one named X, one named γ, proof no Z_i exist.
  F is the opposite: extra class [Π] is algebraic.

## D. Cited, not proved in this library

Lefschetz (1,1); Zucker 1977 cubics; Voisin integral HC cubics;
Murre 1977 unirational fourfolds; Conte–Murre 1978 uniruled fourfolds;
Mukai–Orlov derived Torelli; Bondal–Orlov reconstruction;
Kuznetsov / Addington–Thomas / BLMNPS on cubics;
Noether–Lefschetz; Aljovin–Movasati–Villaflor Fermat spanning.

## E. Still open

- Hodge conjecture: ∀X ∀γ ∃ Z_i, a_i.
  HodgeConjecture.general_fourfold remains a Prop with no term.
- instance (D : Datum) : CycleSection D.
- Grothendieck Lefschetz B / C / D for a general X.
- Tate conjecture.
- Derived Torelli for a general Calabi–Yau fourfold / for V(F).
- Rationality of a very general cubic fourfold.
- Jacobian ring finrank = 5^6 as a theorem (needs regular sequence + Macaulay).
- Lean Chow ring of Gr(2,4) with [Π]^2 = 1.

No clay-solved tag. No ¬Hodge. No global construct.

## F. Paper map

| Finding | Paper / note |
|---|---|
| Cycle class vs constructor | docs/CYCLE_CLASS_AND_CONSTRUCTOR.tex |
| F, plane, planeSpan | docs/F_HOST.md, docs/EXTRA_CLASS_SEXTIC.md |
| Named fourfolds / cl = id stop | docs/NAMED_FOURFOLDS.md, Hodge/NamedFamilies.lean |
| Known bases | docs/KNOWN_BASES.md |
| Correspondences / two arrows | docs/CORRESPONDENCES.md, docs/TWO_MAPS.md |
| Derived vs F | docs/DERIVED.md, docs/DERIVED_TORELLI.md |
| Standard conjectures | docs/STANDARD_CONJECTURES.md, BenFrohman/StandardConjectures |
| Fermat remainders | BenFrohman/FermatPlanes |
| NL vacuous extras | BenFrohman/NoetherLefschetz |
| Cubics cited | docs/CUBIC_FOURFOLD.md, BenFrohman/CubicFourfold |
| This inventory | docs/FINDINGS.md |
