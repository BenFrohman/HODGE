# Extra (2,2) classes on degree ≥ 6 fourfolds

Author: Benjamin Stanley Frohman. Apache-2.0.

The missing object for the last open bullet is one of these two:

1. A specific fourfold X ⊂ P^5 of degree ≥ 6, a specific class
   γ ∈ H^4(X, Q) ∩ H^{2,2}(X) that is not a multiple of h^2, and finitely
   many surfaces Z_i ⊂ X with γ = ∑ a_i [Z_i].
2. A uniform rule that produces those surfaces for every such γ on every
   such X.

This repository contains neither as a Lean term. The three classical
CycleSection instances are not this object.

## One named example from the literature, not formalized here

Let X be the Fermat sextic fourfold

    x0^6 + x1^6 + x2^6 + x3^6 + x4^6 + x5^6 = 0  in P^5.

Shioda proved the rational Hodge conjecture for this X. A spanning set of
primitive algebraic (2,2) classes is described by Villaflor et al. as
1751 cycles: 1001 linear, 720 Aoki–Shioda, 30 of type 3.

One linear surface:

    C = { x0 − μ x1 = x2 − μ x3 = x4 − μ x5 = 0 }

with μ = exp(π i / 6). The rest of the linear family is the Aut(X)-orbit
of C, Aut(X) = S_6 ⋆ (Z/6)^5.

That is example (1) for this one X. It is not example (2). It is not a
CycleSection in this repository. Encoding Shioda's argument and the 1751
cycles is a separate formalization project.

## What this does not settle

- Very general degree ≥ 6 fourfolds already have no extra Hodge classes
  (Noether–Lefschetz). No extra surfaces are required there.
- Special degree ≥ 6 fourfolds other than this Fermat example remain
  case-by-case.
- Dimension ≤ 3 is a different theorem and is already known.
