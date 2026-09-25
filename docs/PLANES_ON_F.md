# Coordinate linear spaces on V(F)

Author: Benjamin Stanley Frohman (@BenFrohman).
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Not Field 2. Not a miss.

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6

A coordinate P^2 = V(xi, xj, xk) lies on X = V(F) iff every monomial
of F uses at least one of {xi, xj, xk}.

Among the C(6,3) = 20 coordinate planes, exactly one works:

    Pi = V(x3, x4, x5).

No coordinate P^3 = V(xi, xj) lies on X: two vanishing coordinates
never cover all six monomials.

Three-block symmetry does *not* produce three coordinate planes.
The blocks are (x0,x3), (x1,x4), (x2,x5). Setting the three "tail"
variables x3=x4=x5=0 kills F. Setting the three "head" variables
x0=x1=x2=0 leaves x3^6+x4^6+x5^6, which is not identically zero.

The written algebraic span remains Q h^2 + Q [Pi]. Residual [S] =
h^2 - [Pi] lives in that same span. No new named direction.

This does not prove that Hdg^2(X) equals that span. It proves that
the obvious coordinate search adds no extra plane class.
