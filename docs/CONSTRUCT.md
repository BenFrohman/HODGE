# CycleSection

Author: Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Copyright (c) 2026 Benjamin Stanley Frohman.

The Prop-valued field `CycleConstructor.construct` says a Hodge class is
algebraic. `CycleSection.construct` returns the cycle.

    construct : {v // v ∈ D.hodgeClasses} → Z
    is_section : D.cl (construct γ) = γ

That pair is the map `T_F`. It is a type of function. It is inhabited after
`X` is named. It is not inhabited for variable `D`.

The mathematical variables of the missing object are `Z_i` and `a_i`:

    γ = ∑_i a_i [Z_i]

`Z_i` = finitely many codimension-k subvarieties (surfaces when `k = 2`)
`a_i` = rationals
Lean `construct γ` is a stand-in for that finite list. It is not itself `Z_i`.

## Faithful use

Call `HodgeConjecture.of_section` on the instances that exist.
Those instances give `D.HodgeConjecture` for those `D` only.

Do **not** add:

    instance (D) [IsVariety D] : CycleSection D
    instance (D) (h : D.codim = 2) : CycleSection D
    theorem HodgeConjecture.general_fourfold_holds ... := ?term

Using the class as if it were already an instance for every fourfold treats
the type as the term.

Instantiated on named hosts:

- `P^4`: `constructP4`, one coefficient of `{x3 = x4 = 0}`
- `Q^4`: `construct`, two coefficients of `Π = σ₂` and `Π' = σ_{1,1}`
- `P^2 × P^2`: `constructProduct`, three coefficients of `h1^2`, `h2^2`, `h1 h2`
- Fermat two-planes, special-sextic plane span, Hassett `C_8` plane span:
  the same `cl = id` pattern on those specified spans

No instance for a general fourfold. No Chow ring.
`general_fourfold D h` remains `D.HodgeConjecture` with no term.

## Two legal inhabitants of the ∀

Hodge for `(2,2)` on fourfolds is

    ∀ smooth projective fourfolds X, ∀ γ ∈ Hdg^2(X),
      ∃ Z_i, a_i with γ = ∑ a_i [Z_i].

An inhabitant is one of:

1. A uniform construction: from any such `(X, γ)`, write the `Z_i` and `a_i`.
   Lean: `CycleSection D` for every fourfold datum `D`.
2. A non-constructive existence proof of those `Z_i`, uniform in `X`.
   Lean: a term of `HodgeConjecture` / `general_fourfold` for every such `D`,
   possibly classical `∃` without a construct function.

"Does not name `X`" means the argument does not case-split on a finite list of
hosts. It still proves the statement for every `X`. It is not "some `X` exists."
Clay accepts either. Hodge is not "there is an algorithm."

Not an inhabitant: the named islands, Fermat/AMV, the special NL plane,
`construct_of_codim_ge_two`, `Classical.choice`, a failed Fermat recipe.
