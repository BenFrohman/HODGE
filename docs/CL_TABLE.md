# Cycle class map — released table

Author: Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.

## Named hosts (compiled identification)

On these data, `Z = V = ℚ^n` and `cl := LinearMap.id`.

| Host | Z = V | Identification |
|---|---|---|
| P^4 | Q | cl(a) = a |
| Q^4 | Q^2 | cl(a,b) = (a,b) |
| P^2 × P^2 | Q^3 | cl(a,b,c) = (a,b,c) |
| Fermat two-planes | Q^2 | cl = id |
| special sextic planeSpan | Q^2 | cl = id |
| Hassett C_8 span | Q^2 | cl = id |

## Unspecified fourfold (geometric map, not id)

| Host | Z | V | Identification |
|---|---|---|---|
| unnamed X / variable D | Z^k(X)_Q | H^{2k}(X,Q) | cl : Z → V, not LinearMap.id |

This last row is the definition of the cycle class map. It is not a compiled
`LinearMap.id`. It does not supply CycleSection on D. It belongs in the table
so the two meanings of cl are not collapsed.
