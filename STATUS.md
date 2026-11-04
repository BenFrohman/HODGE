# Status: chain sextic X = V(F) ⊂ P^5

F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6 (`Hodge/SpecialSextic.lean`), smooth
(`gradient_only_origin`). Each pair contributes y(x^5+y^5) = y·∏(x − ηy), η^5 = −1, so X
contains 6^3 = 216 planes; the 8 diagonal planes Π_abc (a,b,c ∈ {0,−1}: y = 0 or x + y = 0
per pair) are defined over Q.

## Plane intersections (`scripts/plane_intersections.py`, exact)

Planes differing in k pairs: k=0 → Π² = c₂(N) = 21 (c(N) = (1+h)³/(1+6h));
k=1 (meet in a line, excess formula) → −3 − 1 = −4; k=2 (one transverse point) → 1; k=3 → 0.
h²·h² = 6, h²·Π = 1. The 8×8 matrix of Π_abc has det 24461180928, rank 8;
⟨h², Π_abc⟩ has rank 9. All 216 planes with h²: rank 126 (primitive 125).

## Hodge classes (`scripts/hodge_rank.py`, exact)

Griffiths residues + the (Z/30)³ diagonal symmetry give a multiplicity-free character
decomposition of H⁴_prim (1, 426, 1751, 426, 1). Galois orbits under (Z/30)^* entirely of
type (2,2): dim H⁴_prim(X,Q) ∩ H^{2,2} = **785**, so ρ₂(X) = 786.

**Z (Hodge classes outside the span of h² and the 216 planes) has dimension 785 − 125 = 660.**
That is an exact count, not a proof either way: whether those 660 dimensions are algebraic
(other cycles than planes) is not decided here. The Hodge conjecture for X is not claimed.
