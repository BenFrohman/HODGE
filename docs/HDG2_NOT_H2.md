# Hdg^2 is not H^2

Author: Benjamin Stanley Frohman (@BenFrohman).
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.

A common mix-up writes Term B as a (1,1)-class in H^2 and then
invokes Lefschetz (1,1) to say Field 3 is impossible.

That is the wrong degree.

## Official space on a fourfold

    Hdg^2(X) := H^4(X, Q) ∩ H^{2,2}(X).

Codimension 2. Middle cohomology. Type (2,2).

    cl_X : CH^2(X)_Q → H^4(X, Q).

Term B:

    ∃ X ∃ γ ∈ Hdg^2(X),  γ ∉ im(cl_X).

Lefschetz (1,1) says every class in H^2(X,Q) ∩ H^{1,1}(X) is algebraic.
It says nothing about H^4 ∩ H^{2,2}. Field 3 is not blocked.
It is also not written. Rational Hodge on fourfolds is open.

## What does not inhabit Field 3

- Voisin (2002): compact Kähler, not projective. Wrong category.
- Atiyah–Hirzebruch / Kollár: integral Hodge. Wrong coefficients.
- zeroCycle / cl = 0. Not a variety.
- [Π] and [S] = h^2 - [Π] on V(F). Those hit the image.

## Hodge numbers of a very general sextic (classical)

    h^{4,0}=1, h^{3,1}=426, h^{2,2}=1752, h^{1,3}=426, h^{0,4}=1
    h^{1,1}=1, h^{2,1}=0, b_4=2606.

Source: Griffiths residue / Jacobian ring. See docs/HODGE_NUMBERS.md.
Chiodo–Ruan matches *dimensions* of state spaces under LG/CY.
1752 is not a list of algebraic cycles and is not a new computation here.
