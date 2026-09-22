# Jacobian length 5^6

Author: Benjamin Stanley Frohman (@BenFrohman).

## Data

Six variables. Six homogeneous degree-5 forms f0..f5 (the partials of the named sextic).
R(F) = C[x0..x5] / (f0..f5).

## What is proved in Hodge/SpecialSextic.lean

- F ∈ ⟨x3,x4,x5⟩
- ∇F = 0 in A^6 only at the origin (char ≠ 2,3,5)
- 5^6 = 15625

Isolated vanishing of ∇F is the geometric input for “the partials are a regular sequence” over C (Nullstellensatz + homogeneity). That last glue is not a Lean theorem here.

## What would be a real finrank theorem

**Lemma (homogeneous complete intersection length).**
Let k be a field and f0..f_{n-1} ∈ k[x0..x_{n-1}] homogeneous of degree d.
If (f0..f_{n-1}) is a regular sequence, then

    dim_k k[x]/(f0..f_{n-1}) = d^n.

Reason: Hilbert series ∏_i (1 − t^{deg fi}) / (1 − t)^n, or the monomial
basis { x^a : 0 ≤ a_i < d } after a linear change to a regular sequence of
pure powers in the associated graded (Macaulay).

For n = 6, d = 5: dim = 5^6 = 15625.

Mathlib has `IsRegular` / Koszul pieces and Krull-dimension drop along a
regular sequence. It does not currently supply this vector-space count as
one lemma we can `exact`.

## This pass does not hit that output

A term of

    finrank k (MvPolynomial ⁄ J_F) = 15625

needs that lemma plus “partials of this F are a regular sequence.”
`gradient_only_origin` is necessary and not sufficient in Lean without
Nullstellensatz. No axiom, no sorry, no Classical.choice.

This length is not h^{2,2}, not rank Hdg^2, not a CycleSection.
