<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Sister repo: OmegaZero34

Author: Benjamin Stanley Frohman
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache-2.0

Repo: https://github.com/BenFrohman/OmegaZero34

## What it supplies

A Lean-checked monodromy computation on a rank-4 lattice:

- group: Delta(3,4,inf)
- representation: T1, T2, T0 in SL(4,Z)
- invariant form: Omega_0, alternating, type (1,6), det 36
- theorem: that form is unique up to scalar among T1,T2-invariant alternating forms

That is a template for the *shape* of a monodromy certificate:
explicit generators, an invariant bilinear form, a uniqueness lemma.

## What it does not supply

Mon of the locked sextic. The missing object in HODGE remains

    Mon : pi_1(U,*) -> O(L)
    L = (h^2)^perp subset H^4(V(F), Z)
    rank L = 2605

To write that map you still need a basis of L, a loop in the space of
smooth sextics, a vanishing cycle, and its intersections. OmegaZero34
has none of those four.

## Type wall

    Omega_0 : alternating form on Z^4
    intersection form of H^4(V(F)) : symmetric form on Z^{2606}

Do not import Omega_0 into Hodge.SpecialSextic or into threeSpan.
Do not rename the 3x3 Gram G3 as O(L).

## Next step that would actually grow HODGE

Name another fourfold and write CycleSection for that Datum.
Or, separately, start a Tate ledger on a named reduction of a named X.
Neither of those is a copy of Omega_0.
