<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Griffiths Jacobian ring of a sextic fourfold

Author: Benjamin Stanley Frohman  
License: Apache-2.0

This file records the *projective* Hodge package. It is not the affine Steenbrink spectrum of the isolated singularity of \(F\) at the origin in \(\mathbb{C}^6\). That package lives in `BenFrohman/SingularityLab` and `BenFrohman/ChainAtom-u5v-v6`.

## Residue isomorphism (Griffiths)

Let \(X=V(F)\subset\mathbb{P}^5\) be a smooth sextic fourfold (\(n=4\), \(d=6\)). Primitive middle Hodge groups are graded pieces of the Jacobian ring

$$
R=\mathbb{C}[x_0,\ldots,x_5]/(\partial_0 F,\ldots,\partial_5 F)
$$

by

$$
H^{4-q,q}_{\mathrm{prim}}(X)\;\simeq\; R_{(q+1)d-n-2}=R_{6q}.
$$

The degree named in the session note is the \((2,2)\) slot:

$$
3d-n-2=18-4-2=12,\qquad H^{2,2}_{\mathrm{prim}}(X)\simeq R_{12}.
$$

The other middle slots:

| Hodge type | Jacobian degree | formula |
|---|---|---|
| \(H^{4,0}\) | \(R_0\) | \(d-n-2=0\) |
| \(H^{3,1}\) | \(R_6\) | \(2d-n-2=6\) |
| \(H^{2,2}_{\mathrm{prim}}\) | \(R_{12}\) | \(3d-n-2=12\) |
| \(H^{1,3}\) | \(R_{18}\) | \(4d-n-2=18\) |

A general sextic has \(h^{3,1}=426\) (the moduli count \(\dim H^0(\mathcal{O}_{\mathbb{P}^5}(6))-\dim\mathrm{PGL}(6)\)). A special host such as the three-chain \(F\) lies on a Noether–Lefschetz locus, so those numbers can jump. This file does not compute \(h^{2,2}(V(F))\).

## Firewall

- \(\dim_{\mathbb{C}} R=\mu(F)=15625\) is the *total* Jacobian length of the affine isolated singularity. It is not \(h^{2,2}\).
- \(R_{12}\) is one graded piece. The Steenbrink list of \(W\) and \(T_F\) on \(H^5(M_F)\) are a different mixed Hodge structure.
- Neither package writes \(\gamma_{\mathrm{bad}}\) or a miss witness \(p\).
