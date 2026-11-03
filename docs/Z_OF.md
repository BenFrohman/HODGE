# z_of

Copyright 2026 Benjamin Stanley Frohman (@BenFrohman).
License: Apache-2.0.

z_of is the function that turns a Hodge class into a cycle.
z_of = CycleSection.construct = T_F.

See docs/TF_VS_TERM.md for the function / Prop / proof-term split.

## Mathematics

Fix a fourfold X and write Hdg^2(X) = H^4(X, Q) ∩ H^{2,2}(X). Then

    z_of : Hdg^2(X) → Z^2(X)_Q

is any map that sends γ to a finite rational combination of surfaces

    z_of(γ) = ∑_i a_i [Z_i]

with the recovery identity

    cl(z_of(γ)) = γ.

That pair is a section of cl on Hodge classes. It is the hard arrow.

## Complete type on unspecified D

Fix Q-modules Z, V, N and a datum

    D : Datum Z V N
    h : D.codim = 2

Write

    HodgeClass D := { v : V // v ∈ D.hodgeClasses }
    Cycle      D := Z

The functional is any pair

    z_of      : HodgeClass D → Cycle D
    cl_z_eq_γ : ∀ γ : HodgeClass D, D.cl (z_of γ) = γ.val

Unfolded against Basic.lean:

    ∀ γ : V, γ ∈ D.hodgeClasses → ∃ z : Z, D.cl z = γ

plus a chosen witness z for each γ. The class packages the choice:

    class CycleSection (D : Datum Z V N) where
      construct : HodgeClass D → Cycle D
      is_section : ∀ γ, D.cl (construct γ) = γ.val

So the fitting functional on unspecified D is

    z_of,D : { v ∈ V | v ∈ D.hodgeClasses } → Z
    D.cl ∘ z_of,D = id

That is the complete type. Nothing is missing from the signature.

## Why there is no body

To write `z_of γ := …` you need data that variable D does not carry:

1. equations of X (so ideals I(Z_i) can be written),
2. a presentation of γ (a basis of Hdg^2(X), or periods),
3. a rule taking that presentation to those ideals.

Datum has cl, obstruction, and codim. It does not have a polynomial F,
a Chow ring, or a period matrix. There is no expression in D that
returns surfaces.

The only closed-form body that type-checks for every D with
cl = LinearMap.id and Z = V is

    z_of γ := γ

That identity is legal only after the surfaces are named and chosen as
coordinates. Installing it on variable D assumes what Hodge asks you
to prove.

## Named hosts

After the surfaces are chosen as coordinates, Z = V = Q^n and cl = id, so
`z_of γ := γ` is definitional (rfl).

- Fermat twoPlanes: (a, b) ↦ a[Z1] + b[Z2]
- special sextic planeSpan: (a, b) ↦ a h^2 + b[Π]
- P^4, Q^4, P^2 × P^2: same pattern

## Function vs proposition vs proof

T_F / z_of is a function.
general_fourfold D h is a proposition.
of_section, given [CycleSection D], is a proof term of that proposition.

False: “a term of general_fourfold is T_F.”
True: if T_F exists for that D, of_section is the term.
Named-host T_F gives named_fourfolds, not ∀ D.

## What z_of is not

- not a cohomology class
- not ⋆η = −η
- not an eigenvalue q^2
- not LinearMap.id on an unnamed X
- not a proof of general_fourfold
- not a field you can fill for variable D without writing the surfaces

## What grind unspecified D produces

    def HodgeConjecture.general_fourfold
        (D : Datum Z V N) (_h : D.codim = 2) : Prop :=
      D.HodgeConjecture
    -- unfolds to
    -- ∀ γ, γ ∈ D.hodgeClasses → ∃ z, D.cl z = γ

That is the functional, written as a proposition. A term of it would be
of_section applied to a CycleSection instance for every such D.
Main has that instance only for named hosts. The body of z_of stays empty.
