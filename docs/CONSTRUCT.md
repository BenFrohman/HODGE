# CycleSection

Copyright 2026 Benjamin Stanley Frohman (@BenFrohman).
License: Apache-2.0.
Author: Benjamin Stanley Frohman.

The Prop-valued field `CycleConstructor.construct` says a Hodge class is
algebraic. `CycleSection.construct` returns the cycle.

    construct : {v // v ∈ D.hodgeClasses} → Z
    is_section : D.cl (construct γ) = γ

That pair is T_F: input a Hodge class, output a cycle, recover γ under cl.
The mathematical variables of the missing object are Z_i and a_i:

    γ = ∑_i a_i [Z_i]

Z_i  = finitely many codimension-k subvarieties (surfaces when k = 2)
a_i  = rationals
Lean `construct γ` is a stand-in for that finite list. It is not itself Z_i.

## What is supplied

Instantiated on specified hosts:

- P^4: constructP4, one coefficient of {x3 = x4 = 0}
- Q^4: construct, two coefficients of Π = σ2 and Π' = σ_{1,1}
- P^2 × P^2: constructProduct, three coefficients of h1^2, h2^2, h1 h2

Same pattern on Fermat / special-sextic / Hassett spans (named hosts only).

From those instances the library already builds

    theorem HodgeConjecture.of_section (D) [CycleSection D] : D.HodgeConjecture
    theorem HodgeConjecture.classical_fourfolds : ClassicalFourfolds

Faithful use: call `of_section` on every D that already has a section.
That is Hodge on those hosts. It is not a constructor for variable D.

## What is not supplied

    instance (D : Datum Z V N) (h : D.codim = 2) : CycleSection D

That line is not in Construct.lean or Fourfold.lean.

    def HodgeConjecture.general_fourfold D h : Prop := D.HodgeConjecture

is a type. `Iff.rfl` renames it to LefschetzTwoTwo. Neither writes construct.
No instance for a general fourfold. No Chow ring. No term of the ∀.

## Two legal inhabitants of the ∀

Hodge for (2,2) on fourfolds is

    ∀ smooth projective fourfolds X, ∀ γ ∈ Hdg^2(X),
      ∃ Z_i, a_i with γ = ∑ a_i [Z_i].

An inhabitant is one of:

1. A uniform construction: from any such (X, γ), write the Z_i and a_i.
   Lean: CycleSection D for every fourfold datum D.
2. A non-constructive existence proof of those Z_i, uniform in X.
   Lean: a term of HodgeConjecture / general_fourfold for every such D,
   possibly classical ∃ without a construct function.

"Does not name X" means the argument does not case-split on a finite list of
hosts. It still proves the statement for every X. It is not "some X exists."
Clay accepts either. Hodge is not "there is an algorithm."

Not an inhabitant: the three islands, Fermat/AMV, the special NL plane,
construct_of_codim_ge_two, Classical.choice, a failed Fermat recipe,
of_section without an instance, True.intro, or an axiom.
