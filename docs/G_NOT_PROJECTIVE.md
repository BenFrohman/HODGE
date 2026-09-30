# The requested G is not a projective hypersurface

**Author:** Benjamin Stanley Frohman (@BenFrohman)
**License:** Apache-2.0
**Clay tag:** `clay-statement-open`

## Refusal

```
G = ∑_{i=0}^5 x_i^5 - 5 ∏_{i=0}^5 x_i
```

is not homogeneous. Degree 5 versus degree 6. It does not define
`V(G) ⊂ P^5`.

Euler check (compiled in `Hodge/FermatQuintic.lean`):

```
∑ x_i ∂_i G - 5 G = -5 ∏ x_i.
```

The classical Dwork family is the quintic *threefold* in `P^4`:

```
∑_{i=0}^4 z_i^5 - 5 ψ ∏_{i=0}^4 z_i = 0.
```

That host has dimension 3. Lefschetz (1,1). Not the open case.

## Legal stand-in from the CSV

```
X_5 : ∑_{i=0}^5 x_i^5 = 0 ⊂ P^5,    ∂_i F5 = 5 x_i^4.
```

Smooth as an affine cone isolated at the origin when `5 ≠ 0`.
Hodge numbers of every smooth quintic fourfold in `P^5`:

| h^{4,0} | h^{3,1} | h^{2,2} | h^{1,3} | h^{0,4} | b_4 |
|---|---|---|---|---|---|
| 0 | 120 | 581 | 120 | 0 | 821 |

`H^{3,1}=0` is false. Griffiths: `H^{3,1} ≅ R_{2d-6}=R_4`.

AMV (2019): integral Hodge holds on Fermat X_4 and X_5.
This is an island. Not a miss factory. Not `general_fourfold`.

Do not call this host `T_F`. That name is `CycleSection.construct`.

Sextic `V(F)` stays frozen. Ledger `Z` uncomputed. Clay open.
