# Derived surfaces (named hosts)

Author: Benjamin Stanley Frohman (@BenFrohman).
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Status: inventory of algebraic surfaces already in the library,
recorded as objects of D^b(X). Not a Fourier-Mukai partner.
Not CycleSection for unspecified D. Not Clay.

## Three categories (do not mix)

| Category | Variety | Dimension | Canonical | Partners? |
|---|---|---|---|---|
| D^b(S) | residual quintic | 2 | ample | no (Bondal-Orlov) |
| D^b(X) | X = V(F) | 4 | trivial | allowed, not constructed |
| D^b(Y) | partner fourfold | 4 | would be trivial | unwritten |

O_S ∈ D^b(X) is the surface as a sheaf on the fourfold.
D^b(S) is the derived category of the surface.
K_S ≃ O_S(1) is very ample, so Bondal-Orlov reconstructs S from D^b(S).
That does not write Y.

## Rule

If Z is an algebraic surface on a named fourfold X, then O_Z
is an object of D^b(X). Its Chern character recovers cl_X(Z).
O_Z is not a miss. [Z] = cl_X(Z) sits in im(cl_X).

## Named surfaces in this library

| Host X | Surface Z | Derived object | Class in H^4 |
|---|---|---|---|
| P^4 | plane {x3=x4=0} | O_Z | generator of Hdg^2 |
| Klein Q^4 | Pi, Pi' | O_Pi, O_Pi' | span of Hdg^2 |
| P^2 × P^2 | rulings | O of those | span |
| Fermat quartic | planes Z1, Z2 | O_Z1, O_Z2 | extra algebraic classes |
| Special sextic V(F) | Pi = V(x3,x4,x5) | O_Pi | [Pi] |
| Special sextic V(F) | residual quintic S | O_S | h^2 - [Pi] |
| Hassett cubic | extra plane | O_Pi | extra algebraic class |

## Empty on purpose

Y, kernel E, instance (D) : CycleSection D, Term B miss.
