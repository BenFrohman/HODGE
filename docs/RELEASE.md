# Release: classical_fourfolds

Author: Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.

The Hodge sentence is discharged on three specified fourfolds X.

## Specified X

| X | T_F |
|---|---|
| P^4 | T_F(a) = a [Z], Z = {x3 = x4 = 0} |
| Q^4 subset P^5 | T_F(a,b) = a [Pi] + b [Pi'], Pi = sigma_2, Pi' = sigma_{1,1} |
| P^2 x P^2 | T_F(a,b,c) = a h1^2 + b h2^2 + c h1 h2 |

Lean term:

    HodgeConjecture.classical_fourfolds

#print axioms: propext, Quot.sound.

On each of these X, every Hodge class in the model is algebraic:

    gamma = sum a_i [Z_i].

That is Hodge for these three specified X.

## Not in this release

An unspecified fourfold is not one of these X.
This is not a Clay close.
