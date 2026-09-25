# The two terms (permanent ink)

Copyright 2026 Benjamin Stanley Frohman (@BenFrohman).
License: Apache-2.0.

    Δ_miss(X) = (H^4(X, Q) ∩ H^{2,2}(X)) \\ im(cl_X)
              = Hdg^2(X) \\ im(cl_X).

H^4 is the ambient middle cohomology. It is not the leftover summand.
See docs/PRIMITIVE.md for P^4 / Lefschetz reduction.

Clay on fourfolds at (2,2) is released by inhabiting exactly one of
Term A or Term B. Not both. Not a header without fields.

------------------------------------------------------------------------
TERM A — Hodge is a theorem
------------------------------------------------------------------------

Kind: proof.

    ∀ smooth complex projective fourfolds X,
    ∀ γ ∈ Hdg^2(X),
      Δ_miss(X) = ∅.

Unfolded: γ = ∑ a_i [Z_i].

Lean shape of a constructive term of A:

    instance (D) (h : D.codim = 2) : CycleSection D where
      construct := ?z_of
      is_section := ?cl_z_eq

Then of_section is a term of general_fourfold D h.

That header is the shape of Arrow A. It is not a term of A.
The fields ?z_of and ?cl_z_eq are not supplied for variable D.
Adding the instance line without those fields is not sorry-free.
Adding construct γ := γ.val is the three-conditions dummy, not A.

Status: no term. Prop only.

------------------------------------------------------------------------
TERM B — Hodge is false
------------------------------------------------------------------------

Kind: proof.

    ∃ X ∃ γ ∈ Hdg^2(X),  γ ∉ im(cl_X).

Status: no term. Type only.

------------------------------------------------------------------------
WHAT IS FINISHED (not A, not B)
------------------------------------------------------------------------

named_fourfolds: CycleSection on a finite list.
Finite conjunction. Not ∀ D.

------------------------------------------------------------------------
INK
------------------------------------------------------------------------

Arrow A open. Arrow B open.
Neither inhabited. clay-statement-open.
