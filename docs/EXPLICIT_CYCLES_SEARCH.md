# Explicit-cycle search for the 45 cited orbits (v1.3 finding: negative)

Status after this search: **0 of the 360 cited dimensions are explicit.** All 45 D24 orbits stay `cited`
(Aoki/Shioda HC for X^4_30 + descent). The CSV, report and paper are unchanged.

## 1. Isotrivial fibration (verified symbolically)
Ψ(X;a,b,c) = (abcX0, bcX1, acX2, abX3, a^6bX3, ab^6X3) (w=1) maps S5 × W → X, where
- S5 = {X0^5+X1^5+X2^5+X3^5=0}
- W = {c^5 = a^30+b^30+w^30} ⊂ P(1,1,6,1)

sympy gives F∘Ψ = X3·a^6b^6c^5·S5 + X3^6a^6b^6·(a^30+b^30+1−c^5).

## 2. Graph surfaces: 144 candidates, exact projections
Γ_g = Ψ(graph g), with g = π∘q∘σ, q(a,b,c,w) = (a^6 : b^6 : −c : w^6), π ∈ S4 permuting S5 coordinates, and σ ∈ S3 permuting (a,b,w).
The Künneth component (ψ,θ) of a graph is nonzero iff θ = (ψ∘τ)^{-1}, where τ is the torus map induced by g. Both eigenspaces are 1-dimensional.
Each component is pushed to an X-character through the torus of Ψ.

`scripts/explicit_cycles_graphs.py` finds:
- no non-(2,2) hits (sanity check);
- 13 orbits hit, **all already explicit** (plane span);
- **0 cited orbits hit.**

## 3. Why the other natural families cannot reach these orbits
- **Unit entries.** Every cited orbit has a Fermat-alpha entry that is a unit mod 30 (45/45, checked in the script). The quadruples come from 12 types, e.g. (6,29,6,19). A cycle pulled back through a power map x_j → x_j^k (k>1) has a character whose x_j entry is ≡ 0 mod k. So that coordinate must enter at full degree. This rules out sub-Fermat surfaces and complete intersections defined through powers, as well as the D → C5 maps ρ ↦ ρ^6 and ρ ↦ ρ^15.
- **Cones and joins.** A cone over a curve C ⊂ Y_jk = V(f_j+f_k), with vertex on the trivial or split pair, has the pair-character behaviour of the plane witnesses. So it is explicit exactly when [C] has a nonzero ψ-component on Y_jk. Lines give only the plane span. The search therefore reduces to finding a non-monomial curve on the sextic surface Y_jk (or a non-monomial correspondence F30/μ6 ↔ Fermat quintic curve).
- **Aoki's 3-standard cycles.** None of the (Z/30)^× multiples of the 12 quadruples has the form (a, a+10, a+20, −3a). So Aoki's explicit p-standard cycles (J. Math. Soc. Japan 39, 1987) do not apply directly.

## Open
Find an explicit curve on Y = {x^5y+y^6+z^5w+w^6=0} with a nonzero component on one of the 12 quadruple types. Such a curve exists by Lefschetz (1,1). Its cone then gives an explicit surface on X for the corresponding orbits.
