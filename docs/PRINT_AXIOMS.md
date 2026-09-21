# What `#print axioms` lists

Author: Benjamin Stanley Frohman. Apache-2.0.

`construct_of_codim_ge_two` is deleted. It is not an axiom and not a theorem.

    #print axioms Hodge.HodgeConjecture.classical_fourfolds

Expected: no extra axiom. Proof goes through `CycleSection` on the three
islands.

    #print axioms Hodge.HodgeConjecture.general_fourfold

This is a `def` of type `Prop`, not a theorem. Lean will not print a
proof-axiom list for a definition of a proposition. There is no term to
discharge.

That is not a proof of the Hodge conjecture. It is the removal of a
hypothesis that was standing in for a missing constructor.
