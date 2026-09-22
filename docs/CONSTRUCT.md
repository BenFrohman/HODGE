# CycleSection

Author: Benjamin Stanley Frohman. Apache-2.0.

The Prop-valued field `CycleConstructor.construct` says a Hodge class is
algebraic. `CycleSection.construct` returns the cycle.

    construct : {v // v ∈ D.hodgeClasses} → Z
    is_section : D.cl (construct γ) = γ

Instantiated on three islands:

- P^4: constructP4, one coefficient of {x3 = x4 = 0}
- Q^4: construct, two coefficients of Π = σ2 and Π' = σ_{1,1}
- P^2 x P^2: constructProduct, three coefficients of h1^2, h2^2, h1 h2

No instance for a general fourfold. No Chow ring.

## Two legal inhabitants of the ∀

Hodge for (2,2) on fourfolds is

    ∀ smooth projective fourfolds X, ∀ γ ∈ Hdg^2(X),
      ∃ finitely many surfaces Z_i and a_i ∈ Q with γ = ∑ a_i [Z_i].

An inhabitant is one of:

1. A uniform construction: from any such (X, γ), write the surfaces and rationals.
   Lean: CycleSection D for every fourfold datum D.
2. A non-constructive existence proof of those surfaces, uniform in X.
   Lean: a term of HodgeConjecture / general_fourfold for every such D,
   possibly classical ∃ without a construct function.

"Does not name X" means the argument does not case-split on a finite list of
hosts. It still proves the statement for every X. It is not "some X exists."
Clay accepts either. Hodge is not "there is an algorithm."

Not an inhabitant: the three islands, Fermat/AMV, the special NL plane,
construct_of_codim_ge_two, Classical.choice, a failed Fermat recipe.
