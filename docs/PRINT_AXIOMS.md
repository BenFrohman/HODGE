# What `#print axioms` lists

Author: Benjamin Stanley Frohman. Apache-2.0.

`construct_of_codim_ge_two` is deleted.

    #print axioms Hodge.HodgeConjecture.classical_fourfolds

Expected: `propext`, `Quot.sound`. No Hodge axiom.
Proof is `CycleSection` on the three islands.

    #print axioms Hodge.HodgeConjecture.general_fourfold

This is a `def` of type `Prop`. No proof term. No extra axiom to list.
