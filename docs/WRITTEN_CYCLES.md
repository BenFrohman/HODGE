<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Written cycles on THIS host V(F)

Author: Benjamin Stanley Frohman
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache-2.0

Host (same polynomial as Hodge/SpecialSextic.lean):

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6
    X = V(F) subset P^5

## Cycle 1 -- h^2

Always algebraic. Type (2,2). Easy arrow.

## Cycle 2 -- Pi, cut in Lean

    I(Pi) = <x3, x4, x5>
    Theorems: F_factors, F_mem_plane, hypersurface_contains_the_plane
    Tactic: ring + Ideal.span

## Cycle 3 -- Pi_{-1}, cut in Lean

    I(Pi_{-1}) = <x0+x3, x1+x4, x2+x5>
    Theorems: F_factors_minus1, F_mem_plane_minus1,
              hypersurface_contains_the_sign_plane
    Tactic: ring + Ideal.span

{x0=x1=x2=0} is still not a plane on X.

## Shadows (named hosts only)

    planeSpan   Q^2   h^2, [Pi]              CycleSection by rfl
    threeSpan   Q^3   h^2, [Pi], [Pi_{-1}]    CycleSection by rfl

    gram_det_numeral : 6*21*21 - 21 - 21 = 2604 := by decide

That decide lemma is arithmetic, not an intersection theorem.

## Certificate shape

#print axioms F_mem_plane_minus1
#print axioms threeSpan_hodge
#print axioms gram_det_numeral

Expected: propext, Quot.sound only (ring / decide / rfl / constructor packaging).
No sorry. No axiom construct_of_codim_ge_two.

## Still missing

A cycle for an arbitrary Hodge class. Z uncomputed. Not Z = 0.
