# Named fourfolds: finished cl = id pipeline

Copyright 2026 Benjamin Stanley Frohman (@BenFrohman).
License: Apache-2.0.

This is the proven record for the shadow model. It is not Clay.

## The model

On each named span the library does not compute H^4(X, Q). It replaces
that cohomology by a tiny rational vector space whose basis is already
the named surfaces.

    obstruction = 0     ⇒  every vector is a Hodge class
    cl = LinearMap.id   ⇒  a coordinate tuple is already a cycle class
    Z = V = Q^n         ⇒  construct γ := γ has the right type
    id (construct γ) = γ is definitional (rfl)

So γ = ∑ a_i [Z_i] holds in the shadow because the coordinates are the
coefficients of the named surfaces. That is Hodge for that finite span.

rfl is a proof inside this model, not a cheat: the surfaces were named
before cl was set to id.

## Legal instances

    instance : CycleSection Classical.projectiveFourSpace
    instance : CycleSection Classical.kleinQuadric
    instance : CycleSection Classical.productOfPlanes
    instance : CycleSection Fermat.twoPlanes
    instance : CycleSection SpecialSextic.planeSpan
    instance : CycleSection Hassett.planeSpan

`of_section` then gives `D.HodgeConjecture` for those D only.

Fermat `twoPlanes` and SpecialSextic / Hassett `planeSpan` sit in
`NamedFourfolds`, not in `ClassicalFourfolds`.

## The theorem on main

File: `Hodge/NamedFamilies.lean`.

    def NamedFourfolds : Prop :=
      ClassicalFourfolds ∧
        Fermat.twoPlanes.HodgeConjecture ∧
          SpecialSextic.planeSpan.HodgeConjecture ∧
            Hassett.planeSpan.HodgeConjecture

    theorem named_fourfolds : NamedFourfolds

`#print axioms named_fourfolds` is expected to list only standard logical
axioms (propext / Quot.sound). No sorry. No axiom named Hodge.

## Host table — pipeline stop

| Host | Basis chosen | Further Lean step |
|---|---|---|
| P^4 | one plane | none |
| Q^4 | Π, Π' | none |
| P^2 × P^2 | h1^2, h2^2, h1 h2 | none |
| Fermat quartic | [Z1], [Z2] on twoPlanes | none on that span |
| special sextic F | h^2, [Π] | none on that span |
| Hassett C_8 | plane span | none on that span |

Stop there: the named-host sequence is finished.

## What the last two columns are not

- Fermat column: not all of Hdg^2(X) as a kernel term. AMV spanning of
  the Hodge lattice is literature, not `twoPlanes`.
- Sextic column: not a general sextic, and not `general_fourfold`.

Both spans use the legal instances above. `of_section` gives Hodge on
that finite span: the two Fermat plane classes, and Q h^2 ⊕ Q [Π] on F.

## Corrected stop sentence

The next unnamed fourfold still has no z_of. There is no further
cl = id file to write for that host until surfaces are named.

`general_fourfold` remains a Prop. That is a different process. It does
not start from LinearMap.id.
