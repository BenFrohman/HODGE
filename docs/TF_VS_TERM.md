# T_F is not the term of general_fourfold

Copyright 2026 Benjamin Stanley Frohman (@BenFrohman).
License: Apache-2.0.

Three different objects. Mixing them is the essential error.

| Object | Kind | Lean |
|---|---|---|
| T_F / z_of | function (section of cl) | CycleSection.construct |
| cl ∘ T_F = id | identity | CycleSection.is_section |
| general_fourfold D h | proposition | def ... : Prop := D.HodgeConjecture |
| of_section | proof term of that Prop, given an instance | HodgeConjecture.of_section |

## The error

False: “a term of general_fourfold is T_F.”

T_F has type HodgeClass D → Cycle D.
general_fourfold D h has type Prop.
A function is not a proof of a proposition.

## The correction

    theorem HodgeConjecture.of_section (D) [CycleSection D] :
        D.HodgeConjecture

If T_F exists for that D (an instance CycleSection D), then of_section
is a term of general_fourfold D h.
T_F is the witness map the proof uses:

    z_of = T_F,    cl ∘ T_F = id.

T_F = CycleSection.construct (the function).
of_section consumes an instance of that function and returns a proof of
D.HodgeConjecture.
Named-host T_F already gives named_fourfolds. That pipeline is finished.

## Universal header

A T_F for every D would be an instance of the form

    instance (D) (h : D.codim = 2) : CycleSection D

That is the right header for constructive Clay. It is not in the library.

The header is not a license to fill the fields with
`construct γ := γ.val` and `is_section := rfl`. Those fields need, for
each D, surfaces Z_i and the identity cl(∑ a_i [Z_i]) = γ. Without that,
the instance is the three-conditions dummy, not Hodge.
See docs/THREE_CONDITIONS.md and docs/UNIVERSAL_INSTANCE.md.

## Two quantifiers

    named_fourfolds
      = of_section on the finite list of named hosts
      (classical islands, Fermat.twoPlanes, SpecialSextic.planeSpan,
       Hassett.planeSpan).

    ∀ D, general_fourfold D h
      = T_F for every such D.
      Constructive Clay. Not in the library.

Named-host T_F gives named_fourfolds, not the ∀.
