# H^4 versus primitive leftover

Copyright 2026 Benjamin Stanley Frohman (@BenFrohman).
License: Apache-2.0.

## Two different spaces

H^4(X, Q) is the full middle cohomology of a fourfold.

P^4(X) (primitive middle cohomology, relative to a polarization h)
is the Lefschetz leftover: classes killed by the right power of L = (∪ h),
inside H^4. They are not the same vector space.

    H^4 = (non-primitive / Lefschetz summands) ⊕ P^4.

On a polarized fourfold the non-primitive (2,2) summand is spanned by
h^2 = [X ∩ P^{N-2}], which is algebraic. So

    Δ_miss(X) = ∅ on all of Hdg^2(X)
      ⟹
    Δ_miss(X) = ∅ on the primitive part of Hdg^2(X),

once Lefschetz (1,1) and Hard Lefschetz are granted.

Writing H^4 for the ambient group and P^4 for the leftover summand is
consistent. Do not write P^4 when you mean H^4.

## What that means for a Clay close

It narrows the *work*, not the *status*.

If every primitive rational (2,2) class is algebraic, then every class
in Hdg^2 is algebraic (h^2 already is). Term A on a polarized fourfold
reduces to the primitive miss.

That reduction is not Term A. It does not inhabit
instance (D) (h : D.codim = 2) : CycleSection D.
It does not produce Z_i for an unnamed primitive class.

Clay is still released only by a term of A or a term of B.
Primitive language does not fill ?z_of.

## What is not a close

- named_fourfolds
- the instance header without fields
- identifying Hdg^2 \\ im(cl) with primitive miss, as a slogan, without
  a proof of the primitive case
