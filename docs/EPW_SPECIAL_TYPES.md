# Special types — EPW singular strata and the locked smooth sextic

Author of the ledger: Benjamin Stanley Frohman
Email: frohmanbenjamin@gmail.com
ORCID: 0009-0006-7068-3718
GitHub: BenFrohman
X: @Investor0x
Copyright (c) 2026 Benjamin Stanley Frohman. License: CC BY 4.0.
Date: 26 September 2026.

This file records four types. The first three are O’Grady / literature.
The fourth is the locked host V(F). They are not the same variety.
Frohman authorship is the comparison table and the empty-singularity row
for F. Frohman did not discover EPW sextics.

## Step 0 — ambient symplectic space

Let V = C^6. A volume form vol: ∧6 V → C makes ∧3 V a 20-dimensional
symplectic vector space via

    (α, β)_V := vol(α ∧ β).

LG(∧3 V) is the Lagrangian Grassmannian. A point A ∈ LG(∧3 V) is a
10-dimensional isotropic subspace.

## Step 1 — the degeneracy map

On P(V) there is a Lagrangian subbundle F ⊂ ∧3 V ⊗ O, fibre

    F_{[v]} = v ∧ ∧2 V.

Compose inclusion with the quotient by A:

    λ_A : F → (∧3 V / A) ⊗ O_{P(V)}.

Ranks match, so det λ_A is a section of O(6) because det F ≃ O(-6).
Define

    Y_A := V(det λ_A) ⊂ P^5.

If det λ_A is not identically zero, Y_A is a sextic hypersurface.
That is an Eisenbud–Popescu–Walter sextic.

## Step 2 — the degeneracy stratification

    Y_A^{≥ k} := { [v] ∈ P(V) : dim(F_{[v]} ∩ A) ≥ k }.

Then Y_A = Y_A^{≥ 1} when it is a hypersurface. If P(A) ∩ Gr(3, V) = ∅,

    Sing(Y_A) = Y_A^{≥ 2},

and Sing(Y_A^{≥ 2}) = Y_A^{≥ 3}, a finite set.

## Step 3 — the double cover (literature name, not a partner of F)

For A with P(A) ∩ Gr(3, V) = ∅ there is a unique double cover

    f_A : X_A → Y_A

branched along Y_A^{≥ 2}, with (f_A)_* O_{X_A} ≃ O_{Y_A} ⊕ R(-3)
for the first Lagrangian cointersection sheaf R. When A lies in the
open set LG(∧3 V)_0, X_A is smooth of K3^{[2]}-type.
This cover is of the singular EPW sextic. It is not a cover of V(F).

## The four types

### Type I — generic EPW

Host: Y_A for A ∈ LG(∧3 V)_0.
Singular set: Y_A^{≥ 2}, a smooth irreducible surface of degree 40,
of general type. Normal slice: A_1 (ordinary double point × the surface).
X_A smooth HK, (H, H)_BB = 2.
Source: O’Grady, Dual double EPW-sextics; Double covers of EPW-sextics.

### Type II — Δ \ Σ

Host: special EPW, A on the divisor Δ minus Σ.
Singular set: the generic degree-40 surface plus a point of multiplicity
three. The double cover is no longer smooth. A small resolution can
contract a Lagrangian plane.
Source: O’Grady, EPW-sextics: taxonomy, Manuscripta Math. 138 (2012).

### Type III — Vinberg / Donten-Bury–van Geemen–Kapustka–Wiśniewski

Host: a very symmetric EPW sextic Y ⊂ P^5 obtained as the image of a
generically 2:1 map from S^{[2]}, S the Vinberg K3.
Singular set: 60 planes (singular locus of degree 60, not 40) and 16
points of multiplicity four whose tangent cone is the Igusa quartic.
Twenty of the planes form a complete incident family (Morin’s bound).
Source: arXiv:1509.06214, Geom. Topol. 21 (2017).

### Type IV — locked F (this ledger)

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6,
    X = V(F) ⊂ P^5.

The six partials vanish simultaneously only at the origin in A^6, so X
is smooth. Singular set: empty.
Hodge: h^{2,0}=0, h^{4,0}=1, h^{3,1}=426, h^{2,2}=1752, b2=1, b4=2606.
Contains the plane Π = V(x3, x4, x5). Residual general S is a smooth
quintic of general type, K_S ≃ O_S(1).
Equivalence: D^b(X) ≃ HMF^{gr}(F) (Orlov 2005/2009).
This row is not an EPW type. It is recorded so it is not glued onto I–III.

## Table

| type | host | singular set |
|---|---|---|
| generic EPW | Y_A, A ∈ LG_0 | smooth surface, deg 40, slice A_1 |
| Δ \ Σ | special EPW | extra triple point |
| Vinberg / DB–vG–K–W | very special EPW | 60 planes + 16 Igusa points |
| locked F | smooth CY | empty |

## What this ledger does not say

- Type IV is not Type I, II, or III.
- Π is not Y_A^{≥ 2}.
- Y_A is not a Fourier–Mukai partner of V(F).
- X_A is not a partner of V(F): Hodge numbers do not match.
- Slots 1, 2, 5 for this F stay empty.
