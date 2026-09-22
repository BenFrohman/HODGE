# Known bases of Hdg^k

Author: Benjamin Stanley Frohman (@BenFrohman).
A known basis means you can name cycles Z_i that span Hdg^k(X).
This library encodes cells / Schubert / h^k / a named plane. It does not infer
a basis for a variable X. No Lean instance [IsCubicFourfold] : CycleSection.

## Do not confuse h^{2,2} with Hdg^2

On every smooth cubic fourfold X ⊂ P^5:
  h^{4,0}=0, h^{3,1}=1, h^{2,2}=21, h^{1,3}=1, h^{0,4}=0, b_4=23.

h^{2,2}=21 is a COMPLEX Hodge number. It is not 21 algebraic cycles.

Hdg^2(X) = H^4(X,Q) ∩ H^{2,2}(X) is the rational Hodge lattice.
- Very general cubic: rank Hdg^2 = 1, spanned by h^2.
- Special Hassett divisor C_d: rank Hdg^2 ≥ 2 (extra algebraic surfaces).
Zucker says: whatever classes already sit in Hdg^2 are algebraic.
On a general cubic that is just h^2. On a special cubic the extras are algebraic
without this repo listing their ideals.

## Always known (easy arrow + Lefschetz)

Powers of the hyperplane: h^k = [X ∩ P^{N-k}].
On a fourfold, h^2 = [X ∩ P^3]. One cycle Z_0. Not a basis of all of Hdg^2
unless extras vanish.

## Known because the variety is cellular

- P^4: cells. Hdg^2 = Q h^2. Z_i: a P^2 linear section.
- Q^4 ≅ Gr(2,4): Schubert. Z_i = Π = σ_2 and Π' = σ_{1,1}.
  h^2 = [Π]+[Π']. [Π]^2=[Π']^2=1, [Π]·[Π']=0.
- P^2 × P^2: Künneth. Z_i classes h_1^2, h_2^2, h_1 h_2.

These are Hodge/Classical.lean.

## Known on special loci (written span may be smaller than Hdg^2)

Plane Π ⊂ X ⇒ {h^2, [Π]} is a 2-dimensional algebraic piece.
Special NL sextic through {x3=x4=x5=0}: γ = [Π].
Hassett C_8: same shape. Full Hdg^2 may be larger than that span.

## Known by a cited theorem (existence of Z_i, not ideals here)

- Lefschetz (1,1): divisors, any X.
- Zucker, Compositio Math. 34 (1977) 199–209: rational HC for every smooth
  cubic fourfold in P^5. Normal functions; Clemens via lines on a cubic threefold.
- Voisin: integral Hodge conjecture for cubic fourfolds (literature, not Lean).
- Murre, Indag. Math. (1977): unirational fourfolds.
- Conte–Murre, Math. Ann. 238 (1978) 79–88: fourfolds covered by rational curves.

Citation is not a CycleSection.

## Not inferred from the name “fourfold”

- Very general high-degree sextic in P^5: NL ⇒ Hdg^2 = Q h^2. Basis {h^2}.
  Vacuous HC. Not a hidden extra class.
- Special sextic through a plane: extra class is that plane.
- General Calabi–Yau fourfold, general type fourfold: open.
- S × S and S^{[2]}: open in general.

## Repo map

Lean terms: three islands + special NL plane + Q^2 shadow.
Cited only: Zucker, Voisin, Murre, Conte–Murre.
Open: Z_i for a variable extra-class fourfold = general_fourfold, a Prop.
