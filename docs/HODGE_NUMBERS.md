# Middle Hodge numbers for smooth hypersurfaces in ℙ⁵

Author of the repository record: Benjamin Stanley Frohman (@BenFrohman).
Source of the table: Griffiths residue / Jacobian ring; Movasati records the
sextic row as (1, 426, 1752, 426, 1).

Very general smooth X ⊂ ℙ⁵ of degree d. Middle row of H^4(X, ℂ):

| d | h^{4,0} | h^{3,1} | h^{2,2} | h^{1,3} | h^{0,4} | b_4 |
|---|---|---|---|---|---|---|
| 3 | 0 | 1 | 21 | 1 | 0 | 23 |
| 4 | 0 | 21 | 142 | 21 | 0 | 184 |
| 5 | 0 | 120 | 581 | 120 | 0 | 821 |
| 6 | 1 | 426 | 1752 | 426 | 1 | 2606 |

d=6 is Calabi–Yau: K_X = O_X, so h^{4,0} = 1.

Primitive H^4 is this row minus the ambient class h^2 ∈ H^{2,2}.
Hodge classes of type (2,2) are H^{2,2} ∩ H^4(X, ℚ), a rational subspace.
Larger h^{2,2} is not the Fermat remainder R = (1+ζ^4)w^4.
R does not depend on these dimensions.

Noether–Lefschetz (very general, high degree) says that rational (2,2)
lattice is ℚ h^2. That is a statement in BenFrohman/NoetherLefschetz,
not a proof that IsExtraClass is definitionally False.
