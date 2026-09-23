# Jacobian ring graded pieces (Griffiths residues)

Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.

For a smooth hypersurface \(X\subset\mathbb{P}^{5}\) of degree 6, dim \(X=4\),
the Jacobian ring is

    R = C[x0,...,x5] / (\partial F/\partial x0, ..., \partial F/\partial x5).

It is graded. Griffiths residues identify primitive Hodge pieces with
graded pieces of \(R\) (not with ideals \(I(Z_i)\)):

| Hodge piece | Jacobian degree |
|---|---|
| \(H^{4,0}_{\mathrm{prim}}\) | \(R_0\) |
| \(H^{3,1}_{\mathrm{prim}}\) | \(R_6\) |
| \(H^{2,2}_{\mathrm{prim}}\) | \(R_{12}\) |
| \(H^{1,3}_{\mathrm{prim}}\) | \(R_{18}\) |
| \(H^{0,4}_{\mathrm{prim}}\) | \(R_{24}\) |

Socle degree \((d-2)\cdot 6 = 24\). Total dimension of \(R\) is the Milnor
number \(5^6 = 15625\) (`SexticModuli.milnor_number`). That is the formula,
not a Lean `Module.rank` of the quotient.

These pieces are **classes**. They do not write \(T_F\).

The 28 coefficients of \(F\vert_{\{x_3=x_4=x_5=0\}}\) cut out the locus of
**this** plane, naive dimension \(461-28=433\). That is not the whole
Noether–Lefschetz locus.
