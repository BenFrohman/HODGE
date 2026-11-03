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
`dim_Q im(cl) ≥ 3`. Ledger `Z` uncomputed.

## Mixed eight (membership by writing, Gram uncomputed)

For each pair independently, take either `x_{i+3}=0` or `x_i+x_{i+3}=0`.
All eight combinations make F vanish, because each summand of F dies
if either factor dies. These eight include `Π` and `Π_{-1}`.

Label `ε = (ε0,ε1,ε2) ∈ {0,-1}^3`:

```
Π_ε = { x3 = ε0 x0, x4 = ε1 x1, x5 = ε2 x2 } ⊂ P^5.
```

Each choice is three independent linear forms, so each `Π_ε` is a
linear plane. Membership is not a rank statement and is not `ρ ≥ 8`.

## Ambient dimension in P^5 is Hamming

The three pairs `(x0,x3)`, `(x1,x4)`, `(x2,x5)` use disjoint coordinates,
so ranks add. If `ε` and `δ` agree on a pair, that pair contributes
rank 1. If they disagree, both variables of the pair vanish and the
pair contributes rank 2. With Hamming distance `d_H(ε,δ)`:

```
rank = 3 + d_H(ε,δ)
dim_P5(Π_ε ∩ Π_δ) = 2 - d_H(ε,δ)
```

| d_H | ambient intersection | dimension |
|---|---|---|
| 0 | same plane | 2 |
| 1 | a line | 1 |
| 2 | a point | 0 |
| 3 | empty in P^5 | -1 |

Checks:

- `Π_000 ∩ Π_00-1 = {[x0:x1:0:0:0:0]}`, a line.
- `Π_000 ∩ Π_0-1-1 = {[x0:0:0:0:0:0]}`, a point.
- `Π_000 ∩ Π_-1-1-1` forces all six coordinates to 0, empty in P^5.

Order: `000, 00-, 0-0, 0--, -00, -0-, --0, ---`.

```
       000  00-  0-0  0--  -00  -0-  --0  ---
 000     2    1    1    0    1    0    0   -1
 00-     1    2    0    1    0    1   -1    0
 0-0     1    0    2    1    0   -1    1    0
 0--     0    1    1    2   -1    0    0    1
 -00     1    0    0   -1    2    1    1    0
 -0-     0    1   -1    0    1    2    0    1
 --0     0   -1    1    0    1    0    2    1
 ---    -1    0    0    1    0    1    1    2
```

Unordered counts on the cube `{0,-1}^3`:

- 8 identical planes (`d_H = 0`);
- 12 pairs meet in a line (`d_H = 1`);
- 12 pairs meet in a point (`d_H = 2`);
- 4 complementary pairs are empty (`d_H = 3`).

Antipodes:

```
000 ↔ ---
00- ↔ --0
0-0 ↔ -0-
0-- ↔ -00
```

In particular `Π ∩ Π_{-1} = ∅` in P^5, compatible with the recorded
Gram off-diagonal 0.

## What this table is not

Ambient dimension in P^5 is not the intersection product on `X = V(F)`.

- Self-intersection `[Π]^2 = 21` is a normal-bundle number on the
  sextic fourfold. It is not the ambient dimension 2.
- Meeting in a line does not give pairing 1.
- Meeting in a point does not give pairing 1 until multiplicity on `X`
  is computed.
- The 8×8 intersection matrix on `X` is **not** computed.
- Membership ≠ rank 8. Do not write `ρ ≥ 8`. Do not write `1751-8`.

Linear dependence of the eight classes in `H^4(V(F), Q)` is uncomputed.

## Pure sign eight (only one works)

Planes `{x0=ε0 x3, x1=ε1 x4, x2=ε2 x5}` with `ε_i=±1`.
The `(x0,x3)` pair contributes `x3^6(ε0^5+1)`. Only `ε_i=-1` for all
three pairs works. That plane is `Π_{-1}`.

`{x0=x1=x2=0}` gives `F=x3^6+x4^6+x5^6`, not on V(F).

## Container vs remainder

`dim_C R_12 = 1751` is the primitive `(2,2)` container.
It is not `Z`. No 2606-period matrix is supplied. `Z` uncomputed.

The definition

```
Z = dim_Q( Hdg^2(V(F)) / (im(cl) ∩ Hdg^2) )
```

is a rational dimension. If every rational Hodge class lies in the
algebraic span then `Z = 0`. If one transcendental rational class
escapes then `Z ≥ 1`. Neither alternative is computed. No coefficient
list for a class `γ_tr` is supplied. Geometric `CycleClassData` on
`V(F)` remains a hole.

Clay remains open.
