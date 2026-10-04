# Claim fix

Author: Benjamin Stanley Frohman. Apache-2.0. Not a Hodge close.

## What the code proves

`Hodge/SpecialSextic.lean` proves `contains_two_planes`: both named planes lie on `V(F)` for

```text
F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6.
```

It also proves `affine_cone_isolated_at_origin` on a domain with `5 ≠ 0` and `6 ≠ 0`.

`gram_det_numeral` is only `(6 : Nat) * 21 * 21 - 21 - 21 = 2604`.
The module header must not be read as a proved intersection matrix of `(h², [Π], [Π_{-1}])`.

## Containers

For a smooth sextic in `P^5`, the Jacobian ring is `(1+t+⋯+t^4)^6`:

```text
dim R_6 = 426,  dim R_12 = 1751,  dim R_18 = 426,
h^{2,2} = 1752,  b_4 = 2606.
```

These are complex dimensions. They are not `ρ` and not `Z`.

The Fermat quintic `F_5 = sum x_i^5` has partials `5 x_i^4` and container `h^{3,1} = 120`.
That certificate does not transfer to the chain sextic.

`docs/HODGE_NUMBERS.md` titles the ambient space `R^5`. The hypersurface lives in `P^5`.

`Z` on the chain sextic remains uncomputed.
