<!--
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Author: Benjamin Stanley Frohman
-->

# Two planes on V(F), not eight

**Author:** Benjamin Stanley Frohman (@BenFrohman)
**License:** Apache-2.0
**Clay tag:** `clay-statement-open`

Host:

```
F = x3(x0^5 + x3^5) + x4(x1^5 + x4^5) + x5(x2^5 + x5^5).
```

## Proved members

1. `Π = {x3=x4=x5=0}` — `F_mem_plane`
2. `Π_{-1} = {x0+x3=x1+x4=x2+x5=0}` — `F_mem_plane_minus1`

Gram of `(h^2, [Π], [Π_{-1}])` has det 2604. `ρ ≥ 3`.

## Eight sign patterns

Planes of type `{x0=ε0 x3, x1=ε1 x4, x2=ε2 x5}` with `ε_i=±1`.
Substitute into F: the `(x0,x3)` pair contributes `x3^6(ε0^5 + 1)`.
`(+1)^5+1=2 ≠ 0`. `(-1)^5+1=0`.
Only `(ε0,ε1,ε2)=(-1,-1,-1)` lies on V(F). That is `Π_{-1}`.

`{x0=x1=x2=0}` gives `F=x3^6+x4^6+x5^6`, not identically zero.

An 8×8 Gram, or `1751-8`, is not a theorem of this host.

## Container vs remainder

`dim_C R_12 = 1751` is the primitive `(2,2)` container.
It is not `Z`. No 2606-period matrix is supplied. `Z` uncomputed.
