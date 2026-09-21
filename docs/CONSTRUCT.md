# CycleSection

Author: Benjamin Stanley Frohman. Apache-2.0.

The Prop-valued field `CycleConstructor.construct` says a Hodge class is
algebraic. `CycleSection.construct` returns the cycle.

    construct : {v // v ∈ D.hodgeClasses} → Z
    is_section : D.cl (construct γ) = γ

Instantiated on three islands:

- P^4: constructP4, one coefficient of {x3 = x4 = 0}
- Q^4: construct, two coefficients of Π = σ2 and Π' = σ_{1,1}
- P^2 x P^2: constructProduct, three coefficients of h1^2, h2^2, h1 h2

No instance for a general fourfold. No Chow ring.
