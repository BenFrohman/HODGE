# Host B — EPW sextic and double EPW fourfold

Author: Benjamin Stanley Frohman
Email: frohmanbenjamin@gmail.com
ORCID: 0009-0006-7068-3718
GitHub: BenFrohman
X: @Investor0x
Copyright (c) 2026 Benjamin Stanley Frohman. License: Apache-2.0. See LICENSE.
Date: 26 September 2026.

Status: literature lock on a *different* fourfold from V(F).
Does not rewrite F, Π, or the residual quintic theorem.
Does not inhabit rational_hodge_conjecture_is_false.

Sister record on the locked CY host:
BenFrohman/DerivedCategories docs/TWO_FOURFOLDS.md and docs/LOCKED_RECORD.md.

## Construction (O’Grady after Eisenbud–Popescu–Walter)

Let V = C^6. The form (α,β) ↦ vol(α ∧ β) makes ∧3 V symplectic.
For a Lagrangian A ⊂ ∧3 V, the degeneracy locus

    Y_A = { [v] ∈ P(V) | dim(A ∩ (v ∧ ∧2 V)) ≥ 1 } ⊂ P^5

is a sextic when det λ_A ≠ 0. This is an EPW sextic.
A general Y_A is singular along a smooth surface S = Sing(Y_A).

O’Grady, Duke Math. J. 134 (2006):

    f : X_A → Y_A

the double cover branched along that surface, when smooth, is an irreducible
holomorphic symplectic fourfold of K3^{[2]}-type. Polarization f^* O(1) has
Beauville–Bogomolov square 2. The family is 20-dimensional and locally complete
for deformations keeping that class of type (1,1).

No specific A is written here. Inventing a matrix and calling it F is fake.

## Hodge numbers of a general double EPW / K3^{[2]}

    h^{2,0} = 1,    h^{1,1} = 21,    b2 = 23,
    h^{4,0} = 1,    h^{3,1} = 21,    h^{2,2} = 232,    b4 = 276.

Diamond:

                    1
               0         0
          1        21        1
      0        0         0        0
    1      21      232      21      1
      0        0         0        0
          1        21        1
               0         0
                    1

The holomorphic symplectic form generates H^{2,0}. That slot is 0 on V(F).

## What this is not

| Object | Host B | Locked Host A |
|---|---|---|
| equation | Lagrangian A ⊂ ∧3 C^6 | F = x0^5 x3 + x3^6 + … |
| smooth hypersurface in P^5 | no (Y_A singular) | yes |
| HK | X_A yes | no |
| h^{2,0} | 1 | 0 |
| h^{3,1} | 21 | 426 |
| Orlov HMF^{gr}(F) | not this polynomial | yes |
| written surfaces | not Π ⊂ V(F) | Π and residual S |

Bridgeland stability / moduli dictionaries that produce HK fourfolds run on
cubic Kuznetsov pieces and on K3^{[2]} geometry. They run here, on Host B.
They do not run on V(F).

## Hodge status on Host B

An extra algebraic class on a special double EPW is still the easy arrow.
A missing Lean instance is not ¬Hodge. Clay remains open on fourfolds.
Beauville–Voisin type results constrain Chow, they do not fill
rational_hodge_conjecture_is_false.

Keep V(F) in DerivedCategories. Keep this file as the Host B ledger.
