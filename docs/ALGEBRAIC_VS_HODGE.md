# Algebraic cycles and Hodge cycles

Author of the repository record: Benjamin Stanley Frohman (@BenFrohman).
This is the definition of the maps. It is not a `CycleSection` on a
general fourfold, and it is not a proof of the Hodge conjecture.

Let `X` be a smooth projective complex variety of dimension `n`.

## Algebraic cycles

A codimension-`p` algebraic cycle is a finite rational combination of
irreducible closed subvarieties of codimension `p`:

    Z = ∑ a_i Z_i,    a_i ∈ ℚ.

The cycle class map sends each such cycle to cohomology:

    cl : Z^p(X)_ℚ → H^{2p}(X, ℚ),    Z ↦ [Z].

These are the shapes cut out by polynomial equations.

## Hodge cycles

Hodge theory splits the complex cohomology

    H^{2p}(X, ℂ) = ⊕_{r+s=2p} H^{r,s}(X).

A Hodge class of codimension `p` is a rational class that lands in the
middle summand:

    Hdg^p(X) = H^{2p}(X, ℚ) ∩ H^{p,p}(X).

## The easy arrow and the reverse arrow

Geometry gives `im(cl) ⊆ Hdg^p(X)`. That is not the conjecture.

The Hodge conjecture asserts that `cl` is surjective onto `Hdg^p(X)`:

every Hodge class is a rational combination of algebraic cycles.

Clay's wording: for projective algebraic varieties, Hodge cycles are
rational linear combinations of algebraic cycles.

## What is in this repository

- `cl` as the easy arrow, in `Datum`.
- `CycleSection` on `ℙ⁴`, `Q⁴`, and `ℙ² × ℙ²` only. Those are known
  cases. They are not the conjecture in dimension 4.
- Guarded axiom `construct_of_codim_ge_two` as a named hypothesis on
  `IsVariety`. It is not a construction.
- Lefschetz (1,1) and dimension `≤ 3` are theorems elsewhere. This repo
  does not refocus on those.

Listing "finitely many surfaces Z_i and γ = ∑ a_i [Z_i]" is the type of
the missing term. It is not the term.
