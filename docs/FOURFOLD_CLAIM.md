# Fourfold claim — the axiom is gone

`axiom construct_of_codim_ge_two` has been removed from `Hodge/Fourfold.lean`.

It was a named assumption, not a map from Hodge classes to cycles. The actual
terms in the repository are the `CycleSection` instances on `ℕ⁴`, `Q⁴`, and
`ℕ² × ℕ²` (`Hodge/Construct.lean`). Those are constructions on those three
fourfolds.

`HodgeConjecture.general_fourfold` is now a proposition, not a theorem.
`#print axioms` is a diagnostic: after a build, run it on the island sections.
It will not invent a `CycleSection` for a general fourfold.

Needed for a proof: a `CycleSection` on that fourfold.
Not needed: an axiom that replaces the missing term with a claim.
