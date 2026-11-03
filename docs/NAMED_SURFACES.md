# Datum does not carry surfaces

Copyright 2026 Benjamin Stanley Frohman (@BenFrohman).
License: Apache-2.0.

Do not put surfaces on Datum. That would hide the missing map inside the type.

## What Datum is for

    codim, obstruction : V →ₗ N, cl : Z →ₗ V, cl_isHodge

That is the linear skeleton of the sentence. It has to make sense for an
unnamed fourfold, where the surfaces are not known. If every D is required
to carry Z_i, then forming D already assumes Hodge.

## What naming surfaces actually is

A different structure, only on hosts you already named:

    structure NamedSurfaces (D : Datum Z V N) where
      ideals : List …
      coeffs : { v // v ∈ D.hodgeClasses } → List Rat
      cl_sum : ∀ γ, D.cl (∑ coeffs γ * [Z_i]) = γ.val

Existing non-dummy objects (not fields of Datum):

- SpecialSextic: I(Π) = ⟨x3, x4, x5⟩ and F ∈ I(Π)
- Klein: Π, Π'
- Islands: P4Cycle / FormalCycle / ProductCycle

They sit next to the cl = id shadow.

## What that does not do

- It does not change Z from Q^n to CH^2(X)_Q in Mathlib.
- It does not turn is_section into a theorem in H^4(X, Q).
- It does not fill ?z_of for variable D.

Replacing the dummy on a named host means construct returns those ideals
and coefficients, and cl is a map from that cycle type to V. That is a
refactor of the islands already in the library. It is not an update of
Basic.lean.

Leave Datum alone. Keep ideals in the host files. Do not add
`surfaces : List _` to every fourfold datum. The universal holes stay
empty until an unnamed X comes with its own Z_i.
