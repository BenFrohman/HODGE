# An explicit residue certificate for the sextic fourfold

## Statement and proof boundary

For `X: sum_(j=0)^2 (x_j^5 y_j+y_j^6)=0` over **C**, the primitive
classes of the diagonal-group translates of the seven surfaces below span
`H^4(X,Q) intersect H^(2,2)(X)` modulo `Q h^2`, of dimension 785.
Four seeds are planes; three are reduced complete intersections of degrees
(1,2,3), transported by explicit diagonal coordinate isomorphisms.
Their supports have sizes 425 and 480, with intersection 120. Thus the
nonlinear surfaces supply precisely 360 additional independent dimensions.

This is a classical proof using a **published cycle-class theorem**, together
with a reproducible exact polynomial/character certificate. It is **not** a
Lean formalization of cohomology, not a proof of integral HC, and not a result
about arbitrary varieties. No novelty assertion is made. The earlier elliptic
correspondence identification and cone-pushforward argument are not used.

Run, from the repository root:

```sh
python3 -m pip install sympy==1.14.0
python3 scripts/explicit_projection_certificate.py
```

The certificate uses rational arithmetic and the exact Gaussian unit `I`, no
floating point. It does not read `per_class_report.json`, precomputed ranks,
or asserted D2/D24 labels. The section data are shared with the older
exploratory script; all five coefficient polynomials and the modulus are also
compared with the actual definitions in `Hodge/ExplicitCurve.lean`.

## 1. The external theorem actually used

Roberto Villaflor Loyola, *Periods of complete intersection algebraic cycles*,
[Theorem 1.1](https://arxiv.org/html/1812.03964#S1),
[published DOI](https://doi.org/10.1007/s00229-021-01290-x).
Its assumptions are: X is a smooth degree-d hypersurface of even dimension n;
Z is a complete intersection in the ambient projective space, with its
**actual homogeneous ideal** `I(Z)=(f_1,...,f_(n/2+1))`; and
`F=sum f_j g_j`. It states, with `H=(f_1,g_1,...,f_(n/2+1),g_(n/2+1))`,

`[Z] = (deg Z/d) h^(n/2) - ((n/2)!/d) res(det Jac(H) Omega/F^(n/2+1))^(n/2,n/2)`.

Here n=4,d=6, so the primitive class is `-1/3` times the residue of the
**degree-12** determinant. The theorem does not require Z to be smooth;
its proof handles such complete intersections by deformation (Section 5).
We nevertheless verify that our ideal is reduced below; we do not replace
`I(Z)` with a nonreduced ideal without justification. Griffiths' Jacobian-ring
identification, recalled in Section 3 of that paper, is the other geometric
input: the degree-6q graded piece represents `H^(4-q,q)_prim`.

## 2. The Milnor basis and characters, independently enumerated

For `f_k(x,y)=k x^5 y+y^6`, k nonzero, the binary Jacobian quotient has relations

`x^4 y=0, x^5=-(6/k)y^5, y^6=0`.

A Groebner basis in lexicographic order is `(x^5+(6/k)y^5,x^4 y,y^6)`.
For k=1 the script verifies this against the actual two partial derivatives.
For general nonzero k it follows by rescaling x. Its 25 standard monomials are
`x^a y^b`, `0<=a<=3, 0<=b<=5`, together with `x^4`.
The three-pair quotient is their tensor product. The gradients of the three
binary summands vanish only at their origins, so X is smooth.

Let `zeta` be a primitive 30th root of unity. In each pair the automorphism is
`(x,y) -> (zeta x,zeta^(-5)y)`. It preserves f_k. The residue character of a
binary monomial, **including the volume-form factor**, is

`chi(a,b)=a-5b-4 mod 30`.

These 25 characters are distinct. Consequently the three-component characters
are multiplicity-free in all primitive cohomology, not merely in one Hodge
piece. The common scalar kernel in `(mu_30)^3` acts trivially on projective
space and does not identify distinct occurring characters. All occurring
characters descend to that quotient, since their total exponent is divisible
by 6. Degree 6q corresponds to Hodge type `(4-q,q)`.

The script enumerates every tensor monomial, not just listed Hodge orbits.
The five Hodge dimensions are `(1,426,1751,426,1)`. A character in degree 12
belongs to the rational Hodge subspace exactly when all of its conjugates
under `(Z/30)^*` have degree 12. This gives 785 characters.

Why this rationality test suffices: the group acts Q-linearly on singular
cohomology even when its automorphisms are not defined over Q. The rational
Hodge subspace is stable under that group. A multiplicity-free rational
representation of a finite abelian group splits into the rational irreducible
summands indexed by cyclotomic Galois orbits. Such a summand is wholly of type
(2,2) exactly when every one of its characters has that type. This is not an
assertion that arbitrary individual residue monomials are rational classes.

## 3. Equations of the nonlinear surfaces

Use the exact `m,b,c,d,e,g` in `scripts/explicit_section_data.py`, identical
to the Lean coefficient definitions. For **any** complex root k of m,

`H=x^2+bxy+cy^2`, `G=x^3+dx^2y+exy^2+gy^3`,

satisfy `G^2-H^3=f_k`. The certificate checks every coefficient modulo m.
Also k is nonzero because m(0) is nonzero. Choose a fifth root rho of k.
In the first pair use f_1(u,v), in the other two use f_k(x,y), f_k(z,w).
This hypersurface is isomorphic to X via
`(u,v,x,y,z,w) -> (u,v,rho*x,y,rho*z,w)`.
The isomorphism commutes with the diagonal group; it rescales eigenvectors
but cannot create or remove any character support.

Write `H_1=H(x,y), G_1=G(x,y), H_2=H(z,w), G_2=G(z,w)`. Set

```
L = u+v
D = v(u^4-u^3 v+u^2 v^2-u v^3+v^4)
Q = H_2+H_1
A = -(H_2^2-H_2 H_1+H_1^2)
C = G_2+i G_1
B = G_2-i G_1
```

Then exactly `F_k=L D+Q A+C B`. Define `S=(L=Q=C=0)` and transport it to X.
Permuting which pair supplies L gives the three nonlinear seeds. This is the
existing section construction with `mu=i`, an allowed root of `mu^6=-1`.
It need not be irreducible: for example the correspondence contains the line
`(z,w)=i(x,y)`. The **whole reduced complete-intersection cycle** is used,
so no irreducibility assumption or deletion of a component is hidden.

### The homogeneous ideal really is the required complete-intersection ideal

The certificate computes Bezout identities over Q[k] showing that each of
`b^2-4c` and `Res_t(H(t,1),G(t,1))` is coprime to m. Thus these quantities
are nonzero at **every** root k, not merely at a chosen numerical root.
Since H and G are monic in x, they have no common root at infinity either.

The quadratic Q has rank four, because the binary H is nondegenerate.
Thus Q is irreducible. C cannot be divisible by Q: multiplying Q by a linear
form would produce mixed bidegrees (2,1) or (1,2), absent from C. Hence Q,C
are a regular sequence, defining a pure curve Gamma in P^3.

Neither pair vanishes anywhere on Gamma, since that would force H and G to
vanish on the other nonzero pair. Both projections Gamma -> P^1 are therefore
morphisms. They have finite fibers: the polynomial map `(z,w)->(H(z,w),G(z,w))`
is finite, since its homogeneous generators have no common projective zero.
Equivalently its quotient by `(H,G)` is finite-dimensional, so the graded
coordinate ring is finite over `C[H,G]`. On fixing a first-pair direction and
normalizing a nonzero coordinate to 1, the equations prescribe both H and G
of the other pair, giving a finite fiber.

Every curve component consequently dominates the first P^1. Put
`W=det Jac(H,G)`. It is a nonzero cubic (its x^3 coefficient is k).
On each component W(x,y) is generically nonzero. The Jacobian minor of Q,C
in the first two variables is `i W(x,y)`, so Gamma is generically smooth on
every component. A complete-intersection ring is Cohen--Macaulay and has no
embedded associated primes; generically reduced therefore implies reduced.
This proves that `(Q,C)` is radical. It is also saturated: its quotient has
depth two at the irrelevant ideal. Eliminating L shows that the homogeneous
coordinate ring of S is a polynomial extension of this reduced ring, hence
is reduced and Cohen--Macaulay of dimension three. Thus `(L,Q,C)=I(S)` and
S has degree 6. All hypotheses of the cited theorem are met; the cone vertex
and possible intersections of curve components cause no exception.

## 4. Nonzero projections from the actual class determinant

In increasing powers of x the coefficients of W are

```
w_0 = 3bg-2ce
w_1 = 6g+be-4cd
w_2 = 4e-bd-6c
w_3 = 2d-3b = k.
```

Reduce `HW` in the binary Jacobian ring. Its surviving degree-5 coefficients
in positions `x^a y^(5-a)`, a=0,1,2,3, are

```
u_0 = c w_0-6
u_1 = b w_0+c w_1
u_2 = w_0+b w_1+c w_2
u_3 = w_1+b w_2+c k.
```

The `-6` is essential: the x^5 term of HW is `k x^5=-6 y^5`.
The x^4 y term vanishes. The certificate constructs and verifies **eight
Bezout identities** `a_j(k) w_j(k)+b_j(k)m(k)=1` and their u analogues.
All eight coefficients are therefore nonzero at every complex root of m;
nonzero remainders alone would not have been sufficient without irreducibility.

The chain rule, in coordinates `(H_1,G_1,H_2,G_2)`, gives

`det Jac(Q,A,C,B) = 6i (H_2-H_1) W_1 W_2`.

The certificate checks this small outer determinant symbolically. The binary
chain-rule blocks contribute W_1 and W_2. Also

`P_L=det Jac(L,D)=u^4-6u^3 v+6u^2 v^2-6u v^3+6v^4`.

Consequently the actual class determinant, reduced modulo the Jacobian ideal,
is

`P_S = 6i P_L (W_1 U_2-U_1 W_2)`, where `U=HW mod J(f_k)`.

There are **160 nonzero distinct monomials**: five in P_L, four in W,
four in U, and two disjoint degree patterns `(4,3,5)` and `(4,5,3)`.
Every product coefficient is nonzero, and the opposite sign cannot cancel
between distinct multidegrees. Permuting the distinguished pair gives three
disjoint 160-character supports, total 480. This computes nonzero projections
of the **surface class itself**, without identifying an elliptic correspondence
or assuming a cone pushforward is injective.

## 5. Plane seeds, exact coverage, and rank

One plane seed is `x_j+y_j=0` for all three pairs. Its class determinant is
the product of three P_L factors and has support 125.

For each choice of distinguished pair use L in that pair, and the two linear
relations `z=i x,w=i y` in the other pairs. They define a plane on X because
`f(i x,i y)=-f(x,y)`. For those two pairs decompose

```
f(x,y)+f(z,w) = (z-i x) A_0+(w-i y) B_0
A_0 = w sum_(j=0)^4 z^(4-j)(i x)^j
B_0 = (i x)^5+sum_(j=0)^5 w^(5-j)(i y)^j.
```

The certificate differentiates this exact decomposition, reduces the
four-variable determinant, and obtains 25 nonzero monomials. Multiplying
by P_L and using all three distinguished-pair choices gives, together with
the coordinate seed, exactly 425 distinct characters. All lie in the 785
rational Hodge characters computed independently in Section 2.

The nonlinear supports intersect the plane support in exactly 120 characters.
The script verifies **set equality**, not just equality of sizes:

`plane_support union surface_support = rational_Hodge_support`.

To pass from supports to independence, for a finite diagonal group use its
Fourier idempotents `e_chi=|G|^-1 sum_g chi(g)^-1 g`. For a vector v with
nonzero component in a multiplicity-one character space, `e_chi v` is a
nonzero vector spanning that space and lies in the complex span of Gv.
Thus translates of each seed span exactly its support; combining the seeds
spans precisely their union. All actual cycle classes and their primitive
projections are rational cohomology classes, and group actions preserve that
Q-structure. Rank over Q is therefore equal to rank after extending scalars
to C. The resulting primitive rank is `425+480-120=785`. Adding the algebraic
class h^2 handles the nonprimitive summand. Standard Lefschetz results handle
the other codimensions of this fourfold.

This proves the stated explicit spanning result using the specified classical
inputs. The prior Fermat-HC descent route is preserved as an independent
conditional proof; its assumption (F) is **not** needed in this residue route.
The genuinely external dependencies here are Griffiths' identification,
Villaflor Loyola's theorem, and standard commutative algebra/Hodge theory;
none have been silently replaced by Lean axioms or by computational examples.
