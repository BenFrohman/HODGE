<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Hodge numbers of a smooth sextic fourfold are constant

Author: Benjamin Stanley Frohman  
Copyright © 2026 Benjamin Stanley Frohman  
License: Apache-2.0

On the smooth locus they depend only on the pair `(d,n)=(6,5)`, not on which equation you pick.

## Why the numbers cannot jump

A smooth sextic `X ⊂ P^5` is a fibre of the universal family over the complement of the discriminant in `P H^0(O(6))`. Ehresmann: that family is `C^∞`-locally trivial, so Betti numbers are constant.

Griffiths identifies the primitive Hodge pieces with Jacobian graded pieces

```
H^{4-q,q}_prim(X) ≅ R_{6q}.
```

For every smooth degree-6 form the six partials are a regular sequence of quintics. The Hilbert series is therefore forced:

```
H_R(t) = (1 + t + t^2 + t^3 + t^4)^6.
```

That series does not see the coefficients of `F`. So

```
h^{4,0} = 1
h^{3,1} = 426
h^{2,2}_prim = 1751
h^{2,2} = 1752
b_4 = 2606
```

on every smooth sextic fourfold, including the three-chain host.

Hirzebruch’s generating function for hypersurface Hodge numbers depends only on degree and ambient dimension; it gives the same table.

## What can jump

The rational lattice `Hdg^2(X) = H^{2,2}(X) ∩ H^4(X,Q)` can enlarge on a Noether–Lefschetz locus. That is a jump in the rank of a Q-vector space sitting inside a complex vector space of fixed dimension 1752. It is not a jump of `h^{p,q}` and not a jump of `dim R_12`.

See `docs/JACOBIAN_PRINTOUT.md` and `docs/R12.md`. Sister note: `NoetherLefschetz`.
