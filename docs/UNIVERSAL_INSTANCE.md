# Universal T_F: header vs body

Copyright 2026 Benjamin Stanley Frohman (@BenFrohman).
License: Apache-2.0.

No change to Hodge/Construct.lean or Hodge/Fourfold.lean.
This file records the type of the missing instance. It does not inhabit it.

## Three objects (unchanged)

| Object | Kind | Status |
|---|---|---|
| T_F = z_of | function HodgeClass D → Cycle D | named hosts only |
| general_fourfold D h | Prop: ∀ γ, γ ∈ hodgeClasses → ∃ z, cl z = γ | uninhabited for variable D |
| of_section | proof D.HodgeConjecture from [CycleSection D] | runs only after an instance exists |

Named-host T_F yields named_fourfolds. That pipeline is finished.
T_F for every D would yield ∀ D, general_fourfold D h.

## What an existing instance would have to be

The universal map, as a typeclass instance, is exactly this header:

    instance (D : Datum Z V N) (h : D.codim = 2) : CycleSection D where
      construct := ?z_of
      is_section := ?cl_z_eq

That header is not on main. of_section cannot run for variable D until
both fields are filled.

## What the body must inhabit (types)

From Hodge/Construct.lean:

    class CycleSection (D : Datum Z V N) where
      construct : { v : V // v ∈ D.hodgeClasses } → Z
      is_section : ∀ γ, D.cl (construct γ) = γ.val

So for every D with D.codim = 2 the body must supply:

1. `construct` — a function
       ?z_of : { v : V // v ∈ LinearMap.ker D.obstruction } → Z
   Input is a Hodge class (a vector in V that lies in ker obstruction).
   Output is a cycle (an element of Z).
   Z is the cycle module of that datum. It is not assumed equal to V.

2. `is_section` — a proof
       ?cl_z_eq : ∀ γ, D.cl (?z_of γ) = γ.val
   Recovery: the cycle class map applied to the output cycle equals the
   input class.

Those are the only two fields. Nothing else type-checks as CycleSection.

## What a legal body has to use (geometry)

Variable D carries only codim, obstruction, cl, cl_isHodge.
It does not carry equations of X, a basis of Hdg^2(X), or ideals I(Z_i).

A legal `construct` for geometric D must therefore be defined from data
that is not in Datum: named surfaces Z_i and rationals a_i with

    ?z_of γ  =  ∑_i a_i(γ) [Z_i]     in Z
    D.cl (?z_of γ) = γ.val            in V

Until those Z_i are written, ?z_of has no closed-form expression in D.

## Illegal body (three-conditions dummy)

    construct := fun γ => γ.val
    is_section := fun γ => rfl

Type-checks only if Z = V, D.cl = LinearMap.id, and (for the Hodge-class
subtype to be all of V) D.obstruction = 0. That is the named-span model
after surfaces are chosen as coordinates. It is not true of geometric
H^4(X, Q). Forbidden on variable D. See docs/THREE_CONDITIONS.md.

## After a legal body exists

    theorem HodgeConjecture.of_section (D) [CycleSection D] :
        D.HodgeConjecture

would fire for every such D, and general_fourfold D h would have a term.
That is constructive Clay. The body is what is missing. The header alone
is not a proof.
# Type of a universal CycleSection instance

Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman).
License: Apache-2.0.

This file records the type a missing instance would have to inhabit.
It does not add the instance. `Hodge/Construct.lean` is unchanged.

## What already exists

```lean
class CycleSection (D : Datum Z V N) where
  construct : { v : V // v ∈ D.hodgeClasses } → Z
  is_section : ∀ γ, D.cl (construct γ) = γ.val
```

An instance for a *fixed* `D` is a pair of terms of those two field types.
Named hosts have such a pair. Variable `D` does not.

## What the universal instance would have to be

```lean
instance (D : Datum Z V N)
    [AddCommGroup Z] [Module Rat Z]
    [AddCommGroup V] [Module Rat V]
    [AddCommGroup N] [Module Rat N]
    (h : D.codim = 2) : CycleSection D where
  construct := ?z_of
  is_section := ?cl_z_eq
```

Lean would demand inhabitants of these two holes, *uniformly in* `Z`, `V`,
`N`, and `D`:

```lean
?z_of    : { v : V // v ∈ D.hodgeClasses } → Z
?cl_z_eq : ∀ γ : { v : V // v ∈ D.hodgeClasses },
             D.cl (?z_of γ) = γ.val
```

That is the complete type. After those holes are filled, `of_section`
produces a term of `general_fourfold D h`.

## What a body would have to entail, typewise

`Datum` exposes only

```lean
D.codim       : ℕ
D.obstruction : V →ℓ[Q] N
D.cl          : Z →ℓ[Q] V
D.cl_isHodge  : ∀ z, D.obstruction (D.cl z) = 0
```

From that data the only maps you can write in Lean without extra structure
are compositions of `cl`, `obstruction`, and module operations on `Z`, `V`,
`N`. None of those maps goes `V → Z`.

A section of `cl` is a right inverse. Existence of a right inverse for an
arbitrary linear map `cl : Z → V` is equivalent to `cl` being surjective onto
its image, which is tautological, and onto `ker obstruction`, which is
`D.HodgeConjecture`. So a closed-form `?z_of` built from the record fields
either:

1. assumes `D.cl` is already a linear isomorphism `Z ≅ V` with
   `obstruction = 0` — the named-host model `cl = id`, or
2. is a choice function on the fibres of `cl`, which is exactly the
   proposition being proved.

There is no third closed term.

The identity body

```lean
construct := fun γ => γ.val
```

type-checks if and only if `Z = V`. Then `is_section` is `rfl` if and only if
`D.cl = LinearMap.id`. Both equalities are extra structure, not consequences
of `D.codim = 2`.

## What a geometric body would still have to supply

Even if `Z`, `V` were specialized to geometric cycles and cohomology, a body
would still need, for every fourfold `X` and every `γ ∈ Hdg²(X)`:

1. equations of `X`, so ideals `I(Z_i)` can be written,
2. a presentation of `γ` (basis of `Hdg²(X)`, or periods),
3. a rule taking that presentation to those ideals,
4. a proof that `cl(∑ a_i [Z_i]) = γ`.

`Datum` does not carry (1)–(3). That is why the holes stay empty.

## What is not committed

```lean
instance (D) (h : D.codim = 2) : CycleSection D
```

is not in `Hodge/Construct.lean` and must not be added with `sorry`, `id`,
`True.intro`, or an axiom.
