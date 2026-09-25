# The two terms (permanent ink)

Copyright 2026 Benjamin Stanley Frohman (@BenFrohman).
License: Apache-2.0.

Notation: middle cohomology is H^4, not P^4.

    Δ_miss(D) := D.hodgeClasses \\ D.algebraicClasses
               = ker(D.obstruction) \\ im(D.cl)

On a geometric fourfold X:

    Δ_miss(X) = (H^4(X, Q) ∩ H^{2,2}(X)) \\ im(cl_X).

Clay on fourfolds at (2,2) is released by inhabiting exactly one of
the next two terms. Not both. Not a third dummy.

------------------------------------------------------------------------
TERM A — Hodge is a theorem
------------------------------------------------------------------------

Kind: proof.

Sentence:

    ∀ smooth complex projective fourfolds X,
    ∀ γ ∈ H^4(X, Q) ∩ H^{2,2}(X),
      Δ_miss(X) = ∅.

Unfolded:

    ∀ X ∀ γ ∈ Hdg^2(X),  ∃ finitely many surfaces Z_i ⊂ X
                          and a_i ∈ Q
                          with γ = ∑ a_i [Z_i].

Lean name: HodgeConjecture.general_fourfold D h
           (= D.HodgeConjecture when D.codim = 2).

What a term of A is:

  either T_F for every such D
    instance (D) (h : D.codim = 2) : CycleSection D
    with construct : HodgeClass D → Z
         is_section : ∀ γ, D.cl (construct γ) = γ.val,
    then of_section is the proof;

  or a non-constructive proof of the ∃, uniform in X.

Status: no term. Prop only.

------------------------------------------------------------------------
TERM B — Hodge is false
------------------------------------------------------------------------

Kind: proof.

Sentence:

    ∃ smooth complex projective fourfold X,
    ∃ γ ∈ H^4(X, Q) ∩ H^{2,2}(X),
      γ ∉ im(cl_X).

Unfolded:

    ∃ X ∃ γ ∈ Hdg^2(X),
      ∀ surfaces Z_i ⊂ X,  ∀ a_i ∈ Q,
        γ ≠ ∑ a_i [Z_i].

Lean name (sister): a term of ClayDisproofTerm / isHodgeDisproof
                    on a geometric host — not a linear gadget.

What a term of B is: one named X, one named γ, and a proof that
no Q-combination of surfaces equals γ.

Status: no term. Type only.

------------------------------------------------------------------------
NOT A TERM OF A OR B
------------------------------------------------------------------------

- named_fourfolds / cl = id shadows
- F with γ = [Π]  (that class is algebraic)
- NL vacuous extras
- Zucker / Murre citations
- missing instance (D) : CycleSection D
- genericObstructed / cl = 0 gadget
- construct γ := γ.val on variable D
- sorry, axiom, Classical.choice, True.intro

------------------------------------------------------------------------
INK
------------------------------------------------------------------------

A and B are the only two releasing terms.
Neither is in this repository.
clay-statement-open.
