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

These dimensions are the same for every smooth sextic, including \(V(F)\). They do not count rational Hodge classes. The plane class \([\Pi]\) is one rational direction inside the \(1751\)-dimensional space \(R_{12}\), not an extra dimension of it.

CSV: [docs/tables/jacobian_hodge.csv](tables/jacobian_hodge.csv).

The cyclic groups of order \(30\) and the indices \(5\) and \(2\) are the Milnor monodromy of the chain atom. They are recorded in ChainAtom-u5v-v6. They do not act on \(R_{12}\).
