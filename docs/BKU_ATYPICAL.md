<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# BKU atypical Hodge locus — citation only

Author of this note: Benjamin Stanley Frohman (@BenFrohman)
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache-2.0

This file cites Baldi–Klingler–Ullmo. It does not list Frohman as a coauthor of their paper.

## The theorem that is theirs

Gregorio Baldi, Bruno Klingler, Emmanuel Ullmo,
*On the distribution of the Hodge locus*,
Inventiones mathematicae **235** (2023), 441–487.
arXiv:2107.08838.

**Corollary 1.6.** Let `U_{n,d}` be the moduli of smooth degree-`d` hypersurfaces in `P^{n+1}`, and let `V` be the primitive ZVHS `H^n_prim`. If

- `n = 3` and `d ≥ 5`,
- `n = 4` and `d ≥ 6`,
- or the other listed pairs in that corollary,

then the level of `V` is at least 3, and therefore the Hodge locus of positive period dimension in `U_{n,d}` is algebraic.

By their Theorem 1.5, that locus is a finite union of maximal **atypical** special subvarieties. For fourfolds of degree `≥ 6` the typical Hodge locus is empty: every positive-dimensional Hodge component is atypical.

Atypical means the period image is thinner than the naive count:

    codim Φ(Z)  <  codim Φ(S) + codim(Γ_Z \ D_Z).

## What that is not

This is **not** vanishing of extra classes on a very general fibre.
That vanishing is monodromy / Deligne fixed part, already for `d ≥ 3` in this setting: a very general smooth sextic still has only `Q h^2`.

Plane-containing sextics are the standard example that the expected-codimension count is not sharp (Griffiths).

## What this repository adds (Frohman)

One named point on that atypical locus:

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6
    Π     = V(x3, x4, x5)
    Π_{-1} = V(x0+x3, x1+x4, x2+x5)

Lean: `F_mem_plane`, `F_mem_plane_minus1`, and `CycleSection` on the named span `Q h^2 + Q[Π]` (and the three-span with `Π_{-1}`), plus the classical hosts `P^4`, `Q^4`, `P^2 × P^2`.

That is an explicit equation of a plane-containing sextic. It is not a proof of Corollary 1.6. It is not the Hodge conjecture. It is not a counterexample. Do not title this file “Hodge is false.”
