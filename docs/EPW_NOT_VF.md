<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# EPW sextics are not V(F)

Author: Benjamin Stanley Frohman
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache-2.0

An EPW sextic is a special singular sextic in P^5. It is not V(F), and its
double cover is a hyperkähler fourfold, not a Calabi–Yau hypersurface.

## Definition

Let V_6 be a 6-dimensional complex vector space. Then ⋄^3 V_6 is
20-dimensional and carries a natural symplectic form. An EPW sextic is
attached to a Lagrangian subspace A ⊂ ⋄^3 V_6:

    X_A = { [v] in P(V_6) | dim((v ∧ ⋄^2 V_6) ∩ A) ≥ 1 } ⊂ P^5.

This is a degree-6 hypersurface, typically singular along a surface.
Eisenbud–Popescu–Walter introduced these as Lagrangian degeneracy loci.
O’Grady proved that a general X_A has a canonical double cover

    ~X_A → X_A

which is a smooth polarized hyperkähler fourfold of K3^{[2]}-type, with
Beauville–Bogomolov square 2.

## Three geometric sources, one HK type

- Lagrangian A ⊂ ⋄^3 V_6 → EPW sextic X_A, double cover of type K3^{[2]}.
- Gushel–Mukai fourfold (Fano of degree 10) → Hilbert scheme of conics
  produces the same double cover (Iliev–Manivel).
- Special cubic fourfold, e.g. C_12 → Mukai flops of F(Y) isomorphic to
  double EPW sextics.

## What this is not

V(F) is a smooth Calabi–Yau sextic cut by one explicit polynomial.
An EPW sextic is a singular special sextic cut by a Lagrangian condition.
The interesting Hodge theory lives on the double cover ~X_A, which has
Hodge numbers of K3^{[2]}-type, not

    h^{4,0}=1,  h^{3,1}=426,  h^{2,2}=1752.

Hodge for K3^{[n]}-type fourfolds is a different theorem. It does not cap
Z = ρ − dim im(cl) on V(F), and it does not inhabit a miss class on the
locked host. An EPW sextic and V(F) share only the ambient P^5 and the degree.
