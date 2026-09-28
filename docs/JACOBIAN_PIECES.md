# Jacobian pieces of a smooth sextic

**Author:** Benjamin Stanley Frohman  
**Copyright:** © 2026 Benjamin Stanley Frohman  
**License:** Apache-2.0

For a smooth sextic in \(\mathbb{P}^5\) the partial derivatives form a regular sequence of degree \(5\). The Jacobian ring therefore has Hilbert series

\[
\sum_k \dim R_k\, t^k=(1+t+t^2+t^3+t^4)^6.
\]

Griffiths' residue map identifies the primitive Hodge pieces with five of those graded pieces:

| piece | degree | dimension | type |
|---|---|---|---|
| \(R_0\) | \(0\) | \(1\) | \(H^{4,0}\) |
| \(R_6\) | \(6\) | \(426\) | \(H^{3,1}\) |
| \(R_{12}\) | \(12\) | \(1751\) | \(H^{2,2}_{\mathrm{prim}}\) |
| \(R_{18}\) | \(18\) | \(426\) | \(H^{1,3}\) |
| \(R_{24}\) | \(24\) | \(1\) | \(H^{0,4}\) |

The sum is \(2605\). One more class, \(h^2\), is not primitive, so

\[
h^{2,2}=1751+1=1752,\qquad b_4=2606.
\]

## The line \(\mathbb{Q}\,h^2\)

The non-primitive summand is the line \(\mathbb{Q}\,h^2\), not the single vector \(h^2\).

For a smooth sextic \(X\subset\mathbb{P}^5\), Lefschetz gives \(H^2(X,\mathbb{Q})=\mathbb{Q}\,h\). The primitive part of \(H^2\) is zero, so the Lefschetz decomposition of middle cohomology collapses to

\[
H^4(X,\mathbb{Q})=P^4(X,\mathbb{Q})\oplus\mathbb{Q}\,h^2.
\]

The class \(h^2\) has type \((2,2)\). Therefore both numbers sit on the same line:

\[
\dim_{\mathbb{C}} H^{2,2}(X)=1752
\qquad\text{and}\qquad
\dim_{\mathbb{C}} H^{2,2}_{\mathrm{prim}}(X)=1751.
\]

The integer \(1751\) is a complex dimension of the primitive piece. It is not

\[
\dim_{\mathbb{Q}}\bigl(H^4(X,\mathbb{Q})\cap H^{2,2}(X)\bigr).
\]

These dimensions are the same for every smooth sextic, including \(V(F)\) if that sextic is smooth. They do not count rational Hodge classes. The plane class \([\Pi]\) is one rational direction inside the \(1751\)-dimensional space \(R_{12}\), not an extra dimension of it. Subtracting the rank of \(\{h^2,[\Pi]\}\) from \(1751\) is not a count of missed classes.

CSV: [docs/tables/jacobian_hodge.csv](tables/jacobian_hodge.csv).

The cyclic groups of order \(30\) and the indices \(5\) and \(2\) are the Milnor monodromy of the chain atom. They are recorded in ChainAtom-u5v-v6. They do not act on \(R_{12}\).
