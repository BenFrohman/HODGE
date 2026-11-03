<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# EPW sextics are not V(F)

Author: Benjamin Stanley Frohman
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache-2.0

An EPW sextic sits next to the Fano of lines on a cubic. It is not the locked host.

## Definition (cited: Eisenbud–Popescu–Walter, O’Grady)

Let V_6 be 6-dimensional. Then ∧^3 V_6 is 20-dimensional and symplectic.
For a Lagrangian A ⊂ ∧^3 V_6,

    X_A = { [v] in P(V_6) | dim( (v ∧ ∧^2 V_6) ∩ A ) ≥ 1 } ⊂ P^5.

This is a degree-6 hypersurface, typically singular along a surface.
A general X_A has a canonical double cover

    ~X_A → X_A

which is a smooth polarized hyperkähler fourfold of K3^{[2]}-type,
Beauville–Bogomolov square 2. Cite: O’Grady, Duke Math. J. 134 (2006);
Michigan Math. J. 62 (2013).

That family is the EPW analogue of Beauville–Donagi:
double EPW sextics stand to EPW sextics as F(Y) stands to a cubic fourfold.

## Three geometric sources, one HK type

| source | what you get |
|---|---|
| Lagrangian A ⊂ ∧^3 V_6 | EPW sextic X_A, double cover ~X_A of type K3^{[2]} |
| Gushel–Mukai fourfold (Fano of degree 10) | Hilbert scheme of conics yields the same double cover (Iliev–Manivel) |
| special cubic, e.g. C_12 | Mukai flops of F(Y) isomorphic to double EPW sextics |

Hassett-style speciality on the GM side: ~X_A birational to S^{[2]} for a K3 of degree d when a negative Pell equation in d/2 is solvable.

There is also an EPW cube Y_A ⊂ Gr(3, V_6) whose double cover is of K3^{[3]}-type.

## What this is not

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6
    V(F) ⊂ P^5

is a smooth Calabi–Yau sextic. Gradient vanishes only at the origin.
Hodge numbers of V(F):

    h^{4,0} = 1,    h^{3,1} = 426,    h^{2,2} = 1752.

An EPW sextic is singular. Its interesting Hodge theory lives on ~X_A,
which is hyperkähler of K3^{[2]}-type. Hodge for those fourfolds is a
different theorem (Huybrechts, Charles–Markman, …). It does not compute

    Z = ρ − dim im(cl)

on V(F), and it does not inhabit a miss class on V(F).

Shared data only: ambient P^5 and degree 6.

See also docs/EPW_SPECIAL_TYPES.md (types I–III vs locked F as type IV).
