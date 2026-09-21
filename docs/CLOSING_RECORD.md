# Closing record of this development

Author of the repository record: Benjamin Stanley Frohman (@BenFrohman).
Date: 21 September 2026.

This is not a proof of the Hodge conjecture and not a Clay submission.
It records what this project constructed, what it refuted inside its own
formalization, and what remains missing.

## 1. The sentence that is still open

For a general fourfold X and γ ∈ Hdg²(X),

    γ = ∑ a_i [Z_i]

with finitely many surfaces Z_i ⊂ X and a_i ∈ ℚ. That is the first open
geometric case of the rational Hodge conjecture. A Lean term of type
`CycleSection` with `cl (construct γ) = γ` for every such pair is the same
object. **That term was not supplied.**

## 2. Constructors that do exist (exact list)

These are the only constructors written down.

1. Classical islands (`Hodge/Classical.lean`, `Hodge/Construct.lean`):
   ℙ⁴, Q⁴ = Gr(2,4), ℙ²×ℙ². On Q⁴ the section is the ruling formula
   γ = (γ·[Π])[Π] + (γ·[Π′])[Π′]. This is Schubert calculus, already a theorem.
2. Special sextic containing a coordinate plane Π (`docs/EXTRA_CLASS_SEXTIC.md`):
   F = x₃ A + x₄ B + x₅ C, γ = [Π]. Linear membership, no ζ remainder.
3. Fermat quartic planes (`FermatPlanes`, `Hodge/Attempt/FermatIdentities.lean`):
   remainder identity, then ζ^4 = -1, then three pairs for Z₁ and Z₂.
   Easy arrow on that host.

No fourth constructor for a general extra class on a general fourfold.

## 3. Lean identity audit (Fermat)

The file uses the names `pair_with_remainder` and `pair_vanishing`, not
`fermat_pair_identity`. The algebra is the same layout:

    z^4 + w^4 = (z - ζ w)(…) + (1 + ζ^4) w^4     (any CommRing)
    remainder = 0 when ζ^4 = -1
    same at -ζ for Z₂
    sum of three pairs = F

That matches `docs/FERMAT_PLANES.md`.

## 4. Sextic audit

`docs/EXTRA_CLASS_SEXTIC.md` has no remainder term and does not need one.
Containment is F ∈ (x₃, x₄, x₅) by construction of F. Different easy arrow.

## 5. What this project proved or disproved

Proved, in this repository:

- The Fermat pair identity and the three-pair expansions (algebra).
- Planes Z₁, Z₂ lie on the Fermat quartic when ζ^4 = -1.
- An unguarded axiom “every Datum of codim ≥ 2 has CycleConstructor” plus
  `zeroCycle` yields `False`. That form of the axiom is not restored.
- `HodgeConjecture.classical_fourfolds` from the three island `CycleSection`s
  (relative to the skeleton’s linear algebra, not a Chow ring of Gr(2,4)).

Recorded from the literature, not proved here:

- Lefschetz (1,1): Hodge in codimension 1.
- Noether–Lefschetz: very general high-degree hosts have Hdg² = ℚ h².
- Integral Hodge conjecture is false (Atiyah–Hirzebruch, Kollár, Totaro, Voisin).

Not proved, not disproved:

- The rational Hodge conjecture.
- A general fourfold `CycleSection`.
- Rota, Mason ultra-log-concavity, Dowling–Wilson (those are other authors’
  papers; this project only inventoried them).
- Weil conjectures (Deligne; different problem).
- Tate conjecture (different cohomology).

## 6. Architecture that stays

    BenFrohman/HODGE            fourfold sentence, guarded axiom, islands
    BenFrohman/FermatPlanes     easy-arrow Fermat identity
    BenFrohman/NoetherLefschetz NL as a theorem, not Clay

`Hodge.lean` does not import Attempt. `HodgeConjecture.general_fourfold`
lists `construct_of_codim_ge_two` under `#print axioms` if that axiom stays.
That is bookkeeping of a hypothesis, not a construction.
