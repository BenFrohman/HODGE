# Derived surfaces (named hosts)

Author: Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Status: inventory of algebraic surfaces already in the library,
recorded as objects of D^b(X). Not a Fourier-Mukai partner.
Not CycleSection for unspecified D. Not Clay.

## Rule

If Z is an algebraic surface on a named fourfold X, then O_Z
is an object of D^b(X). Its Mukai / Chern character recovers
cl_X(Z). That is the same cycle already used by CycleSection
on that host.

O_Z is not a miss. [Z] = cl_X(Z) sits in im(cl_X).

## Named surfaces in this library

| Host X | Surface Z | Derived object | Class in H^4 |
|---|---|---|---|
| P^4 | plane {x3=x4=0} | O_Z | generator of Hdg^2 |
| Klein Q^4 | Π, Π' | O_Π, O_Π' | span of Hdg^2 |
| P^2 × P^2 | {pt}×P^2, P^2×{pt}, diagonal-type | O of those | span |
| Fermat quartic | planes Z1, Z2 | O_{Z1}, O_{Z2} | extra algebraic classes |
| Special sextic V(F) | Π = V(x3,x4,x5) | O_Π | [Π] |
| Special sextic V(F) | residual quintic S_{a,b,c} | O_S | h^2 - [Π] |
| Hassett cubic C_d | extra plane | O_Π | extra algebraic class |

Residual theorem (sister repo DerivedCategories):
X ∩ L_{a,b,c} = Π ∪ S_{a,b,c}, [S] = h^2 - [Π].
S is a surface of general type on X. It is not a fourfold Y.

## Empty on purpose

| Object | Status |
|---|---|
| fourfold partner Y ≨ X with ω_Y ≈ O_Y | unwritten |
| kernel E ∈ D^b(X × Y) with Φ_E an equivalence | unwritten |
| instance (D) : CycleSection D | unwritten |
| γ ∈ Hdg^2(X) \ im(cl_X) | unwritten |

Kuznetsov A_X for cubics is literature, not a constructor here.
Bondal-Orlov fails on the locked sextic because K_X ≈ O.
