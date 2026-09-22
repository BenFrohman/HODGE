# Jacobian length 5^6

Author: Benjamin Stanley Frohman (@BenFrohman).
Lean scaffold: `Hodge/JacobianLength.lean` (not imported by `Hodge.lean`).

## Named hypotheses

- `JacobianLength.PartialsRegular` — stand-in for Mathlib `Sequence.IsRegular` on the six partials. No instance.
- `JacobianLength.HomogeneousCILength` — stand-in for
  (regular sequence of n homogeneous degree-d forms in n variables) ⇒ dim = d^n.
  No instance. This is **not** Mathlib's Krull-dimension drop.

`length_num_of_hyps` only rewrites 5^6 = 15625 under those classes. It does not
construct `finrank (MvPolynomial ⁄ J_F)`.

## Proved nearby

`SpecialSextic.gradient_only_origin`, `SpecialSextic.five_pow_six`.

## Glue still missing

Nullstellensatz: only-zero in A^6 ⇒ `IsRegular` over C.
Hilbert/Macaulay: `IsRegular` + homogeneous type (5)^6 ⇒ vector-space dim 15625.

## Hodge progression (unchanged)

- Islands + named Fermat quartic + special sextic plane: local sections / easy arrow.
- `general_fourfold`: still a Prop.
- Jacobian length does not produce surfaces or inhabit that Prop.
