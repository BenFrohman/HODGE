# Cubic fourfolds (citation only)

Author: Benjamin Stanley Frohman (@BenFrohman).
Sister pointer: https://github.com/BenFrohman/CubicFourfold
Not imported by Hodge.lean. No Lean instance [IsCubicFourfold] : CycleSection.

## Numbers

Smooth cubic X ⊂ P^5:
  h^{4,0}=0, h^{3,1}=1, h^{2,2}=21, h^{1,3}=1, h^{0,4}=0, b_4=23.

h^{2,2}=21 is a complex Hodge number, not 21 algebraic cycles.

Hdg^2 = H^4(Q) ∩ H^{2,2}:
- very general cubic: rank 1, spanned by h^2
- Hassett special divisor C_d: rank ≥ 2

Moduli of cubics is F_d in Hassett's notation. C_d ⊂ F is the Noether–Lefschetz
divisor of cubics whose Hdg^2 has extra rank. C_8 is cubics containing a plane.

## Cited theorems (not constructors in this repo)

- Zucker, Compositio Math. 34 (1977) 199–209: every rational (2,2) class on a
  smooth cubic fourfold is algebraic.
- Voisin: integral Hodge conjecture for cubic fourfolds (literature).
- Hassett, Compositio 2000: special cubic fourfolds / C_d.

A plane on a C_8 cubic is the same *shape* as the plane on the special sextic
F below (extra class [Π]). It is a different family: degree 3, h^{3,1}=1,
Kuznetsov partner possible. F is degree 6, h^{3,1} ≈ 426, no Kuznetsov K3.
Do not identify F with C_d or F_d.

## What this file does not do

Does not inhabit general_fourfold.
Does not list Z_i as ideals for a general cubic.
Does not add CycleSection from Zucker.
