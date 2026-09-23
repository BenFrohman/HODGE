# Two arrows, correspondences, Lefschetz

Author: Benjamin Stanley Frohman (@BenFrohman).
See also docs/TWO_MAPS.md (cl vs construct). This is not a proof of Hodge.

## The sentence

On a smooth complex projective X,

    Hdg^k(X) = H^{2k}(X, Q) ∩ H^{k,k}(X)

would equal the Q-span of classes [Z] of codimension-k subvarieties.
Easy arrow: cycles give Hodge classes (theorem). Reverse: Hodge conjecture.

## The cut

After Hodge, Hodge classes match cycles. On a product X × Y, an algebraic
Hodge class is a correspondence Z ⊂ X × Y. That is Hodge on the product,
not “every Hodge-structure computation becomes a cycle.”

| Operation | Already algebraic? | Waiting on Hodge? |
|---|---|---|
| Lefschetz L = cup with h | Yes. h = [X ∩ H]. Hard Lefschetz is a theorem. | No |
| Λ = L^{-1} on primitives (Lefschetz standard conjecture / Grothendieck B) | No. It would be a correspondence on X × X. | Yes, and HC on X does not automatically give HC on X × X |
| Künneth / products of divisor classes | Often yes when generated in degree 1 | Only leftover Hodge classes |
| A class γ ∈ Hdg^k(X) | Only after γ = ∑ a_i [Z_i] | That is HC |
| Periods, Gauss–Manin, F^p | Analytic / VHS | HC does not algebraize the period matrix |

L itself is geometric. The operator that waits is a Hodge class on the product
representing Λ, not an arbitrary period computation.

## Repo

Easy arrow: cl, cl_isHodge.
Reverse on islands + special NL sextic: named shadows / surfaces.
Reverse on an unnamed extra-class fourfold: general_fourfold, still a Prop.
A CycleSection on a product Datum is still not general s on a fourfold.
