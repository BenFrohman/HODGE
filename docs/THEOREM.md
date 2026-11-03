<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Theorem this repository proves

Author: Benjamin Stanley Frohman
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache-2.0

This file closes the theorem that is actually on disk.
It does not close the Clay Hodge conjecture.
It does not prove Baldi–Klingler–Ullmo Corollary 1.6.
BKU is cited, not coauthored.

## Statement

Let

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6.

Then:

1. F belongs to the ideals I(Π) = <x3, x4, x5> and
   I(Π_{-1}) = <x0+x3, x1+x4, x2+x5>. So both planes lie on V(F)
   subset P^5.
2. The data P^4, Q^4, P^2 × P^2, Fermat two-planes,
   SpecialSextic.planeSpan, and Hassett.planeSpan each admit a
   CycleSection. Their conjunction is named_fourfolds.

Lean names: F_mem_plane, F_mem_plane_minus1, named_fourfolds.

## What it applies to

Those six named hosts, and this one special sextic.
It applies to the classes that were named as coordinates before
cl was set to id. It does not apply to an arbitrary class in
H^4(V(F), Q), which has dimension 2606.

## Why that is larger than the two membership lines

For n = 4 and d ≥ 6, BKU Corollary 1.6 says every positive-dimensional
Hodge component is atypical and algebraic. Plane-containing sextics
are the standard example that the expected-codimension count is not
sharp. This F is an explicit equation on that component, with the
extra classes written as surfaces and kernel-checked. That is a
constructive point on a locus BKU already proved is algebraic. It
is not a replacement for BKU, and it is not ∀X ∀γ.
