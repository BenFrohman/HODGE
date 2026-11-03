# Two theorems that share the number 6

**Author:** Benjamin Stanley Frohman  
**Copyright:** © 2026 Benjamin Stanley Frohman  
**License:** Apache-2.0

This file records the split. It does not prove the Hodge conjecture.

## The false table

A circulating table says \(H^{3,1}(X)=0\) for smooth hypersurfaces \(X\subset\mathbb{P}^5\) of degree \(d=3,4,5\). That table is wrong.

Griffiths residues: for a smooth degree-\(d\) fourfold in \(\mathbb{P}^5\),

\[
H^{4,0}\cong R_{d-6},\qquad
H^{3,1}\cong R_{2d-6},\qquad
H^{2,2}_{\mathrm{prim}}\cong R_{3d-6}.
\]

Middle Hodge numbers (already in [HODGE_NUMBERS.md](HODGE_NUMBERS.md)):

| \(d\) | \(h^{4,0}\) | \(h^{3,1}\) | \(h^{2,2}\) | \(b_4\) |
|---|---|---|---|---|
| 3 | 0 | 1 | 21 | 23 |
| 4 | 0 | 21 | 142 | 184 |
| 5 | 0 | 120 | 581 | 821 |
| 6 | 1 | 426 | 1752 | 2606 |

A cubic fourfold has \(h^{3,1}=1\). Quartic and quintic fourfolds also have \(h^{3,1}\neq 0\). What turns on at \(d=6\) is \(H^{4,0}\), not \(H^{3,1}\).

## Theorem A — vanishing of extra rational classes

Let \(X\subset\mathbb{P}^5\) be a very general smooth hypersurface of degree \(d\ge 3\). Geometric monodromy is Zariski-dense in the orthogonal group of the vanishing cohomology (Beauville). A rational Hodge class on a very general fibre is monodromy-invariant (Deligne). The only invariants in \(H^4\) are powers of \(h\). Therefore

\[
H^4(X,\mathbb{Q})\cap H^{2,2}(X)=\mathbb{Q}\,h^2.
\]

This already holds for cubics, quartics, and quintics. It fails for quadrics: every smooth quadric fourfold contains planes.
On that host \(\Delta_{\mathrm{Hdg}}=\emptyset\), hence \(\Delta_{\mathrm{miss}}=\emptyset\). That is vacuous Hodge on one locus. It is not Hodge for every fourfold.

## Theorem B — algebraicity of the positive-dimensional Hodge locus

Baldi–Klingler–Ullmo, Invent. Math. **235** (2024), Corollary 1.6, arXiv:2107.08838.

A special subvariety \(Z\subset U_{n,d}\) is *atypical* when

\[
\operatorname{codim}_{\Gamma\backslash\mathcal{D}}\Phi(Z)
\;<\;
\operatorname{codim}_{\Gamma\backslash\mathcal{D}}\Phi(U_{n,d})
\;+\;
\operatorname{codim}_{\Gamma\backslash\mathcal{D}}(\Gamma_Z\backslash\mathcal{D}_Z).
\]

If the primitive VHS has level at least \(3\), the typical Hodge locus is empty and \(\mathrm{HL}_{\mathrm{pos}}\) is a finite union of maximal atypical special subvarieties, hence algebraic.

For fourfolds in \(\mathbb{P}^5\) the level is at least \(3\) precisely when \(h^{4,0}\neq 0\), i.e. when \(d\ge 6\). Quintic fourfolds have level \(2\) and are excluded. A sextic has \(h^{4,0}=1\), so level \(4\).

That is why the number \(6\) appears in recent papers. It is not the threshold at which extra rational classes vanish.

## This host

On a smooth sextic,

\[
H^4(X,\mathbb{Q})=P^4(X,\mathbb{Q})\oplus\mathbb{Q}\,h^2,
\qquad
\dim_{\mathbb{C}} H^{2,2}(X)=1752,
\qquad
\dim_{\mathbb{C}} H^{2,2}_{\mathrm{prim}}(X)=1751.
\]

See [PRIMITIVE_COHOMOLOGY.md](PRIMITIVE_COHOMOLOGY.md). The integer \(1751\) is a complex dimension. It is not the rational Hodge rank.

\(V(F)\) contains a plane, so it is a special point of the Hodge locus. The extra class \(\beta=h^2-6[\Pi]\) is algebraic. That is the opposite of a miss.

## What this file does not contain

- a term of \(\mathrm{CE}\)
- a value of \([\mathrm{Mon}:\mathrm{Mon}_{\Pi}]\)
- a proof of Hodge for every fourfold
