# Official space is H, not P

Author: Benjamin Stanley Frohman (@BenFrohman).
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.

Change P to H for the problem statement.

## Type-correct ambient

Hodge classes of codimension 2 on a fourfold live in middle cohomology:

    Hdg^2(X) := H^4(X, Q) ∩ H^{2,2}(X).

Term A and Term B quantify over that space:

    A:  ∀ X ∀ γ ∈ Hdg^2(X),  γ ∈ im(cl_X)
    B:  ∃ X ∃ γ ∈ Hdg^2(X),  γ ∉ im(cl_X)

    Δ_miss(X) = Hdg^2(X) \\ im(cl_X).

That is the category of the intended problem: rational Hodge classes
inside H^4, not primitive cohomology as a separate type.

## What P^4 is

    P^4(X) = ker(L : H^4 → H^6)

is a summand of H^4, not H^4. After Lefschetz (1,1) and Hard Lefschetz,
non-primitive (2,2) classes are algebraic, so

    Δ_miss on Hdg^2  =  Δ_miss on (P^4 ∩ H^{2,2})

as *sets of missing classes*. Equivalence of work, not equality of
vector spaces, and not a change of the official sentence.

Do not write P^4 when you mean Hdg^2.
Do not write H^4 when you mean the Lefschetz leftover.

## Status unchanged

Term A empty. Term B empty. named_fourfolds is a finite list.
