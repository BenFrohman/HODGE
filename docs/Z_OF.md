# z_of

Copyright 2026 Benjamin Stanley Frohman (@BenFrohman).
License: Apache-2.0.

z_of is the function that turns a Hodge class into a cycle.

## Mathematics

Fix a fourfold X and write Hdg^2(X) = H^4(X, Q) ∩ H^{2,2}(X). Then

    z_of : Hdg^2(X) → Z^2(X)_Q

is any map that sends γ to a finite rational combination of surfaces

    z_of(γ) = ∑_i a_i [Z_i]

with the recovery identity

    cl(z_of(γ)) = γ.

That pair — the function plus the identity — is a section of cl on Hodge
classes. It is the hard arrow.

## Lean

On a datum D the same pair is the two fields of CycleSection:

    z_of      : { v : V // v ∈ D.hodgeClasses } → Z
    cl_z_eq_γ : ∀ γ, D.cl (z_of γ) = γ.val

In Hodge/Construct.lean they are named

    class CycleSection (D : Datum Z V N) where
      construct := z_of
      is_section := cl_z_eq_γ

construct is z_of. is_section is cl ∘ z_of = id.

## What z_of is on the named spans

After the surfaces are chosen as coordinates, Z = V = Q^n and cl = id, so

    def z_of (γ : Rat × Rat) : Rat × Rat := γ

That is not a geometric algorithm. It is the coefficient list of the
surfaces you already named:

- Fermat twoPlanes: (a, b) ↦ a[Z1] + b[Z2]
- special sextic planeSpan: (a, b) ↦ a h^2 + b[Π]

## What z_of is not

- not a cohomology class
- not ⋆η = −η
- not an eigenvalue q^2
- not LinearMap.id on an unnamed X
- not a field you can fill for variable D without writing the surfaces

On an unnamed fourfold the type of z_of is still the line above.
The definition body is empty. That empty body is why general_fourfold
has no term.

Short form: z_of = CycleSection.construct.
On named hosts: z_of γ := γ because cl = id.
On unspecified D: the type is defined; the function is not.
