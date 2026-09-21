# Proof trees in Hodge/Fourfold.lean

Author: Benjamin Stanley Frohman (@BenFrohman).

Live source, not a rewrite.

| Theorem | Next step | Uses `construct_of_codim_ge_two`? |
|---|---|---|
| `HodgeConjecture.general_fourfold` | `of_variety_codim_ge_two` with `inst := construct_of_codim_ge_two D h` | yes |
| `HodgeConjecture.classical_fourfolds` | `of_section` on the three island `CycleSection` terms | no |

`#print axioms general_fourfold` must list `Hodge.construct_of_codim_ge_two`.
`Hodge.lean` does not import Attempt.
No `v1.0` / stable-Clay tag.
