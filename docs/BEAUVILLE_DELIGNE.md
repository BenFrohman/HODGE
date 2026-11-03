<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Beauville names the group; Deligne names the invariants

Author: Benjamin Stanley Frohman  
Copyright (c) 2026 Benjamin Stanley Frohman  
License: Apache-2.0

Beauville, *Le groupe de monodromie des hypersurfaces unirationnelles*, LNM 1194 (1986).  
Deligne, théorème de la partie fixe, SGA 7 / Hodge II (1971).

Neither paper writes a list of matrices of size 2605.

## Beauville

On the space `U` of smooth sextics in `ℙ⁵`, even middle degree,

```
Mon(U) = O^#(L),    L = H^4_prim(X, ℤ),   rank L = 2605.
```

`O^#` is an index-2 subgroup of the full orthogonal group (spinor norm / orientation). That *names* the group. It does not list the 18750 Picard–Lefschetz reflections of a pencil.

## Deligne

Invariants in a fibre are the classes that come from a compactification of the total space. For the full family of smooth sextics that total space is a projective bundle, so

```
H^4(X, ℚ)^{Mon(U)} = ℚ h².
```

That is variational Noether–Lefschetz: a very general sextic has no extra rational Hodge class.

## This host

| Base | Group | Invariants |
|---|---|---|
| all smooth sextics `U` | `O^#(L_2605)` | `ℚ h²` |
| sextics through `Π` | a proper subgroup `Mon_Π` | at least `ℚ h² + ℚ[Π]` |

`V(F)` sits on the thinner base. Deligne’s invariant subspace is therefore larger, and `[Π]` is the extra named class.

## `planeSpan_hodge` does not mention `H^4(V(F), ℚ)`

The geometric cycle class map is

```
cl : Z²(X)_ℚ → H^4(X, ℚ),     X = V(F) ⊂ ℙ⁵,
```

with `b_4 = 2606`, `rank H^4_prim = 2605`, `h^{2,2} = 1752`.

`planeSpan` is a `Datum` on `ℚ × ℚ` with `cl = LinearMap.id`. The theorem `planeSpan_hodge` says every pair `(a,b)` is already `a h² + b[Π]` *in that model*. It never mentions the group `H^4(V(F), ℚ)`.

A Chow computation of `h^4 = 6`, `[Π]² = 21`, `[Π]·[Π_{-1}] = 0` would justify the Gram *inputs*. It would still not produce `Mon` or a `CycleSection` for unspecified `D`.
