# Eight-step ledger (21 September 2026)

Author of this record: Benjamin Stanley Frohman (@BenFrohman).

This file records **every** claim from the four notes of this session.
It does not omit them. After each block is a referee so the record is
complete and not silently rewritten.

This is not a Clay proof, not a Clay disproof, and not a proof that Hodge
is independent of ZFC.

---

## Note A — Distinction from a Clay counterexample

Claim recorded: the work has not disproved rational Hodge. A Clay
counterexample would need one smooth projective X, one rational Hodge
class γ, and a proof that no Q-combination of algebraic cycles equals γ.
The work does not show Z_i do not exist. It shows that some local recipes
for writing equations do not see them.

Referee: that distinction is correct.

---

## Note A — “Failure of global constructive algebra”

Claims recorded:

1. Remainder R = (1+ζ^4)w^4 is nonzero off ζ^4 = -1, so the Fermat planes
   leave the host under that deformation of the linear forms.
2. An *unguarded* axiom “every Datum of codim ≥ 2 has CycleConstructor”
   is illegal in this skeleton, because zeroCycle makes it False.
3. A computer program that only tracks the Fermat linear recipe cannot
   spit out planes for a generic Hodge class on an open dense set of hosts.

Referee:

1. True for *this* recipe. Not a proof that no other surfaces exist.
2. True in Lean: `not_every_codim_ge_two` in `Hodge/Examples.lean`.
   The *guarded* axiom `construct_of_codim_ge_two` with `[IsVariety D]`
   is still present as a hypothesis. It is not “illegal”; it is unproved.
3. True of the Fermat recipe. Not a metamathematical theorem that no
   proof of Hodge can exist.

---

## Note A — Eight-step architecture (recorded in full)

1. Statement: cl : CH^k_Q → H^{2k} ∩ H^{k,k} is surjective.
2. Easy arrow: algebraic cycles are Hodge. Fermat planes and the special
   sextic plane are this arrow.
3. Lefschetz (1,1): Hodge in codimension 1. Literature.
4. Classical islands: P^4, Q^4, P^2×P^2. Schubert / linear sections.
5. Noether–Lefschetz: very general high-degree X ⊂ P^5 has Hdg^2 = Q h^2.
   Vacuous extra-class problem. Literature, stated in BenFrohman/NoetherLefschetz.
6. Open step: extra class γ not written into the equation of X; produce Z_i, a_i.
7. Lean discharge of general_fourfold would be a CycleSection term with no axiom.
   Current theorem lists construct_of_codim_ge_two under #print axioms.
8. Clay disproof path: one X and one γ not algebraic over Q. None known.
   Integral Hodge is already false in the literature (different statement).

Referee: this map of the field is correct. There is no Step 9 that closes Clay.

---

## Note A — Verdict paragraph (recorded)

Claim recorded: no unconstructible cycle was found; limits of one constructive
recipe were exposed; the easy arrow does not stretch across all moduli;
Step 6 remains open.

Referee: that verdict is the right one if and only if it stops there.
The phrase “any proof of Hodge cannot be a purely local algebraic recipe”
is a methodological remark, not a theorem. The zeroCycle *sentinel Option
wrapper* is not the live firewall. The live firewall is `[IsVariety D]`.

---

## Note B — safeConstructCycle = None (recorded, not imported)

The Lean that defines zeroCycleBlock as Verified iff IsFermatOrClassical,
then returns None otherwise, then proves that implication, is a tautology
of its own `if`. It is not in Hodge/Fourfold.lean and is not on CI.
It does not mention H^{2,2}. Recorded here so it is not omitted.

---

## Note C — no automatic IsVariety for every Datum

Claim recorded: ¬(∀ D, IsVariety D), else the guarded axiom would apply to
a “generic obstructed fourfold” and contradict an axiom that Hodge fails there.

Referee: the *shape* matches the live theorem `not_every_codim_ge_two`.
The live proof uses Examples.zeroCycle, a linear gadget that is not a variety,
not a geometric fourfold with an extra class. Do **not** add

    axiom not_every_codim_ge_two : ¬ HodgeConjecture genericObstructedFourfold

as if that Datum were a smooth projective fourfold. That axiom would be a
claimed Clay counterexample. It is not supplied.

Live instances of IsVariety: only projectiveFourSpace, kleinQuadric,
productOfPlanes. No instance for zeroCycle. No ∀ D instance.

---

## Note D — grading of a fourfold in P^5

Claims recorded:

- Smooth X ⊂ P^5 has complex dimension 4.
- Middle algebraic cycles are surfaces: dimension 2, codimension 2.
- That integer 2 does not depend on the degree d of X.
- The parameter count of hypersurfaces grows like binom(d+5,5).

Referee: the grading lemmas are true and elementary. Degree independence of
the number “codim = 2” does not prove that remainder terms “explode” into a
universal obstruction at d = 6. At d ≥ 6, Noether–Lefschetz says a *very
general* X has no extra class (easy arrow / vacuous). Special sextics can
still contain a plane (different easy arrow, no ζ).

---

## What was compiled into the repository tonight

- Fermat remainder identity (sister repo + Attempt copies)
- NL as a statement (sister repo)
- Fourfold.lean quoted as guarded axiom + three IsVariety instances
- AUTHORS / loci notes; no sentinel on CI
- This ledger

## What was not compiled

- IsFermatOrClassical as a core typeclass
- safeConstructCycle in Fourfold.lean
- genericObstructedFourfold as a Clay counterexample
- A proof or disproof of rational Hodge
