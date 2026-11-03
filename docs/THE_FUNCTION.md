<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# The function (already committed)

Author: Benjamin Stanley Frohman
License: Apache-2.0
File: Hodge/Construct.lean

The function the leftover object names is already a class field:

```lean
class CycleSection (D : Datum Z V N) where
  construct : { v : V // v ∈ D.hodgeClasses } → Z
  is_section : ∀ γ, D.cl (construct γ) = γ.val
```

That is the type. Committing the type does not inhabit it for every D.

## Bodies that exist

`construct` has a body only on named hosts, where Z = V = ℚ^n and cl = id:

- Classical.projectiveFourSpace
- Classical.kleinQuadric
- Classical.productOfPlanes
- Fermat.twoPlanes
- SpecialSextic.planeSpan
- Hassett.planeSpan

Those bodies are `construct γ := γ` (or `.coeff`). Official close:
`named_fourfolds` and `contains_two_planes`.

## Body that does not exist

There is no

```lean
instance (D : Datum Z V N) (_h : D.codim = 2) : CycleSection D
```

On unspecified D, Z is cycles, V is cohomology, and cl is not id.
Writing `construct γ := γ.val` is a type error. Writing True.intro,
an axiom, or sorry either changes the sentence or assumes the claim.

That missing body is the Hodge conjecture. It is not in this repository.
