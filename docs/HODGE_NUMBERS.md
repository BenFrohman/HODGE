# Middle Hodge numbers for smooth hypersurfaces in ℝ⁵

**Author:** Benjamin Stanley Frohman (@BenFrohman)  
**Copyright:** © 2026 Benjamin Stanley Frohman  
**License:** Apache-2.0

Source: Griffiths residue / Jacobian ring. Movasati records the sextic
row as (1, 426, 1752, 426, 1).

Very general smooth \(X \subset \mathbb{P}^5\) of degree \(d\). Middle row of
\(H^4(X, \mathbb{C})\):

| \(d\) | \(h^{4,0}\) | \(h^{3,1}\) | \(h^{2,2}\) | \(h^{1,3}\) | \(h^{0,4}\) | \(b_4\) |
|---|---|---|---|---|---|---|
| 3 | 0 | 1 | 21 | 1 | 0 | 23 |
| 4 | 0 | 21 | 142 | 21 | 0 | 184 |
| 5 | 0 | 120 | 581 | 120 | 0 | 821 |
| 6 | 1 | 426 | 1752 | 426 | 1 | 2606 |

## Why the pasted \(H^{3,1}=0\) table is wrong

A circulating table writes \(h^{3,1}=0\) for \(d=3,4,5\). That confuses two
different summands.

Griffiths:

\[
H^{4,0}(X)\cong R_{d-6}(F),\qquad
H^{3,1}(X)\cong R_{2d-6}(F),\qquad
H^{2,2}_{\mathrm{prim}}(X)\cong R_{3d-6}(F).
\]

For a cubic (\(d=3\)), \(R_{d-6}=R_{-3}=0\), so \(h^{4,0}=0\). But
\(R_{2d-6}=R_{0}\) is one-dimensional (constants), so \(h^{3,1}=1\).
A cubic fourfold has a holomorphic \((3,1)\)-class. That is classical
(Hassett, Huybrechts). Quartic and quintic fourfolds likewise have
\(h^{3,1}=21\) and \(120\), not zero.

What turns on at \(d=6\) is \(H^{4,0}\) (the canonical bundle becomes
trivial; \(R_{0}\) appears in bidegree \((4,0)\)). Not \(H^{3,1}\).

The false table is the Hodge diamond of a *Calabi–Yau threefold* or of
\(H^{2}\) of a surface, pasted onto fourfolds. It is removed from this
ledger. The table above is the replacement.

## Primitive piece

On a sextic,
\(H^4(X,\mathbb{Q})=P^4(X,\mathbb{Q})\oplus\mathbb{Q}\,h^2\),
\(\dim_{\mathbb{C}} H^{2,2}=1752\), \(\dim_{\mathbb{C}} H^{2,2}_{\mathrm{prim}}=1751\).
See [PRIMITIVE_COHOMOLOGY.md](PRIMITIVE_COHOMOLOGY.md).

\(d=6\) is Calabi–Yau: \(K_X=\mathcal{O}_X\), so \(h^{4,0}=1\).

Vanishing of extra *rational* classes is \(d\ge 3\) (except quadrics).
BKU level \(\ge 3\) is \(d\ge 6\). See [D_GE_6.md](D_GE_6.md).
