<!--
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Author: Benjamin Stanley Frohman
-->

# Planes on V(F): two proved in Lean, eight mixed by writing

**Author:** Benjamin Stanley Frohman (@BenFrohman)
**License:** Apache-2.0
**Clay tag:** `clay-statement-open`

Host:

```
F = x3(x0^5 + x3^5) + x4(x1^5 + x4^5) + x5(x2^5 + x5^5).
```

## Lean-closed members

1. `Π = {x3=x4=x5=0}` — `F_mem_plane`
2. `Π_{-1} = {x0+x3=x1+x4=x2+x5=0}` — `F_mem_plane_minus1`

Gram of `(h^2, [Π], [Π_{-1}])` has det 2604. Proved floor: `ρ ≥ 3`.

## Mixed eight (membership by writing, Gram uncomputed)

For each pair independently, take either `x_{i+3}=0` or `x_i+x_{i+3}=0`.
All eight combinations make F vanish, because each summand of F dies
if either factor dies. These eight include `Π` and `Π_{-1}`.
Mixed pairs typically meet in a line. Their 8×8 intersection matrix
is **not** computed. Membership ≠ rank 8. Do not write `1751-8`.

## Pure sign eight (only one works)

Planes `{x0=ε0 x3, x1=ε1 x4, x2=ε2 x5}` with `ε_i=±1`.
The `(x0,x3)` pair contributes `x3^6(ε0^5+1)`. Only `ε_i=-1` for all
three pairs works. That plane is `Π_{-1}`.

`{x0=x1=x2=0}` gives `F=x3^6+x4^6+x5^6`, not on V(F).

## Container vs remainder

`dim_C R_12 = 1751` is the primitive `(2,2)` container.
It is not `Z`. No 2606-period matrix is supplied. `Z` uncomputed.
