# Known bases of Hdg^k

Author: Benjamin Stanley Frohman (@BenFrohman).

A known basis means you can name cycles Z_i that span Hdg^k(X).
This library encodes cells / Schubert / h^k / a named plane. It does not infer
a basis for a variable X. No Lean instance `[IsCubicFourfold] : CycleSection`.

## Do not equate h^{2,2}=21 with 21 algebraic cycles

On every smooth cubic fourfold in P^5:

    h^{4,0}=0,  h^{3,1}=1,  h^{2,2}=21,  h^{1,3}=1,  h^{0,4}=0,  b_4=23.

That 21 is a complex Hodge number. Hdg^2 = H^4(X,Q) ∩ H^{2,2}(X) is smaller:

- very general cubic: rank Hdg^2 = 1, spanned by h^2
- Hassett special divisor C_d: rank ≥ 2

Zucker: every class that is already a rational Hodge class is algebraic.
On a general cubic that is just h^2. On a special cubic the extras exist as
Hodge classes and are algebraic; this repo does not write their ideals.

## Always known (easy arrow + Lefschetz)

Powers of the hyperplane: h^k = [X ∩ P^{N-k}].
On a fourfold, h^2 is the class of a linear surface section X ∩ P^3.
That is one cycle Z_0, not a basis of all of Hdg^2 unless extras vanish.

## Known because the variety is cellular

- P^4: cells. Hdg^2 = Q h^2. One Z_i: a P^2 linear section.
- Q^4 ≅ Gr(2,4): Schubert. Z_i are the two rulings Π = σ_2, Π' = σ_{1,1}.
  h^2 = [Π] + [Π']. Intersection: [Π]^2 = [Π']^2 = 1, [Π]·[Π'] = 0.
- P^2 × P^2: Künneth. Z_i classes h_1^2, h_2^2, h_1 h_2.

These are the three classical hosts in Hodge/Classical.lean.

## Known on special loci (written span, not necessarily all of Hdg^2)

If X contains a plane Π (or a rational surface, a scroll), then
{h^2, [Π]} is a 2-dimensional algebraic piece.
Special NL sextic through Π = {x3=x4=x5=0}: γ = [Π] is extra.
Hassett C_8 on cubic fourfolds is the same shape.
Full Hdg^2 may be larger than that span.

## Known by a cited theorem (existence of Z_i, not ideals in this repo)

- Lefschetz (1,1): every (1,1) class is a Q-combination of divisors, any X.
- Zucker, Compositio Math. 34 (1977) 199–209: every rational (2,2) class on a
  smooth cubic fourfold X ⊂ P^5 is algebraic. Normal functions; Clemens
  alternate via lines on a cubic threefold. Existence, not an explicit list of
  ideals.
- Voisin: integral Hodge conjecture for cubic fourfolds (literature;
  Voisin 2007 / later surveys). Cite; not formalized here.
- Murre, Indag. Math. (1977): Hodge for unirational fourfolds.
- Conte–Murre, Math. Ann. 238 (1978) 79–88: Hodge for fourfolds covered by
  rational curves (uniruled in that sense).

Cite those papers. Do not add CycleSection from the citation alone.

## Not inferred from the name “fourfold”

- Very general high-degree sextic in P^5: opposite of a hidden extra.
  NL ⇒ Hdg^2 = Q h^2. Basis {h^2}. Vacuous HC. Known by NL, not by extra Z_i.
- Special sextic through a plane: extra class is that plane.
- General Calabi–Yau fourfold, general type fourfold: open.
- S × S and S^{[2]} (K3 type): open in general.

## Repo map

Encoded as Lean terms: three islands + special NL plane membership + Q^2 shadow.
Cited only: Zucker, Voisin, Murre, Conte–Murre.
Open: Z_i for a variable extra-class fourfold = general_fourfold, a Prop.
