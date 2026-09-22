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

## Krull dimension 0 is not 15625

Localize at the irrelevant maximal ideal: R = k[x0,...,x_{n-1}]_{(x)}.
A regular sequence of length n drops Krull dimension by n, so the quotient
has Krull dimension 0 and is artinian. That is finite *length as a module*,
not the integer d^n.

Mathlib's regular-sequence lemmas give that drop. They do not give:

- `IsRegular` for these six partials (needs Nullstellensatz + homogeneity
  from ∇F = 0 only at 0),
- the Hilbert series ∏ (1-t^d)/(1-t)^n,
- dim_k = d^n = 15625.

Krull dimension 0 plus "finite as a k-module" (graded, high degrees vanish)
says the Jacobian ring is a finite-dimensional k-algebra. The number 15625
is the extra Macaulay / Hilbert count of a basis
{ x^a : 0 ≤ a_i ≤ 4 }.

## Glue still missing

Nullstellensatz: only-zero in A^6 ⇒ `IsRegular` over C.
Hilbert/Macaulay: `IsRegular` + homogeneous type (5)^6 ⇒ vector-space dim 15625.

## Hodge progression (unchanged)

- Islands + named Fermat quartic + special sextic plane: local sections / easy arrow.
- `general_fourfold`: still a Prop.
- Jacobian length does not produce surfaces or inhabit that Prop.
