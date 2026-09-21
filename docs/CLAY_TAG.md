# Clay tag

Author: Benjamin Stanley Frohman. Apache-2.0.

Git tag name: `clay-statement-open`

This tag marks the Lean *statement* of the Hodge conjecture in this
repository. Clay status of the problem: **open**.

It does not mark a proof. It does not mark a counterexample.
`HodgeConjecture.general_fourfold` still prints the axiom
`construct_of_codim_ge_two`.

Lean toolchain: leanprover/lean4:v4.22.0
Mathlib pin: v4.22.0 (not master).

Instance from the axiom is introduced by `letI`, not by a named
`(inst := …)` argument.
