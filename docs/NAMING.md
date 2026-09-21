# Names of the two planes

Author of the repository record: Ben Frohman (@BenFrohman).
The two planes already have names. Every row below is a relabelling of
the same two objects. Constructor identities do not depend on the row.

## The two planes on Q^4

| Language | First family Π | Second family Π' |
|---|---|---|
| Incidence in P^3 | lines through a fixed point | lines in a fixed plane |
| Schubert | σ_2 | σ_{1,1} |
| Plücker | {p12 = p13 = p23 = 0} | {p01 = p02 = p03 = 0} |
| Classical nicknames | σ-plane, α-plane, star | ρ-plane, β-plane, ruled |
| Klein quadric | one ruling by P^2s | the opposite ruling |
| Twistor / Minkowski | α-plane (point of PT) | β-plane (plane of PT) |

Pieri's name for their sum is the hyperplane class:

    h^2 = σ_1^2 = σ_2 + σ_{1,1} = [Π] + [Π'].

Do not use the nickname "σ-plane" as if it meant σ_{1,1}. That is the pun
already excluded.

## Bilingual card: same two identities, two writings

Use both writings. They are the same two identities on Q^4, not two theorems.
Do not bind the constructor to one column's names.
Dictionary: Π = σ_2 = α = star, Π' = σ_{1,1} = β = ruled.

**Identity A — the rulings sum to the hyperplane square**

| Math (constructor) | Physics / Schubert |
|---|---|
| h^2 = [Π] + [Π'] | σ_1^2 = σ_2 + σ_{1,1} |
| two algebraic planes span H^{2,2} | an α-plane and a β-plane through a point give the light cone |

**Identity B — the intersection form**

| Math (constructor) | Physics / Schubert |
|---|---|
| [Π]^2 = [Π']^2 = 1, [Π]·[Π'] = 0 | σ_2·σ_2 = σ_{1,1}·σ_{1,1} = 1, σ_2·σ_{1,1} = 0 |
| orthogonal Q-basis of Hdg^2(Q) | same family meets in a Minkowski point; opposite families meet in a light ray |

## Both bases

The orthogonal ruling basis both communities already use:

    γ = (γ · [Π]) [Π] + (γ · [Π']) [Π']
      = (γ · σ_2) σ_2 + (γ · σ_{1,1}) σ_{1,1}.

The duality-adapted basis both communities also use, writing a = γ · [Π]
and b = γ · [Π']:

    { h^2 , [Π] − [Π'] },
    γ = ((a+b)/2) h^2 + ((a-b)/2) ([Π] − [Π']).

The first basis is what the constructor writes down. The second is what you
use when you want a class even under point–plane duality and a class odd
under it. Together they cover every vector in H^4(Q, Q) = Hdg^2(Q).

That is the whole middle cohomology of this one fourfold. It is not a
general fourfold, and it is not a general amplituhedron A_{n,k,m}.
Physics constructions still do not rename the rulings.
Constructor identities remain incidence-free in docs/CLASSICAL_FOURFOLDS.md.

## Correspondence objects, with the point/line row unswapped

Identify Q = Gr(2,4) ⊂ P^5 with compactified complexified Minkowski space
CM in the usual Klein correspondence.

| Geometric object | Name |
|---|---|
| Gr(2,4) ⊂ P^5 | Klein quadric Q^4, and CM |
| Ambient P^3 of lines | projective twistor space PT |
| Real null locus in PT | PN, space of light rays |
| A *point* of Q | a point of CM |
| A *line* CP^1 ⊂ Q | a light ray (null geodesic); a point of PN |
| The Π ruling (σ_2) | α-planes in CM; points of PT |
| The Π' ruling (σ_{1,1}) | β-planes in CM; planes of PT |

The inverted sentence "a line CP^1 ⊂ Q is a point of compactified
Minkowski space" swaps point and line. A point of Q is a Minkowski point.
A line on Q is a light ray.

## Physics constructions built from Grassmannians

These use a Grassmannian. They do not rename Π and Π' on Q^4.

| Object | Name |
|---|---|
| Gr_{≥0}(k,n) | positive (totally nonnegative) Grassmannian |
| Image of that under a positive matrix Z | amplituhedron A_{n,k,m}(Z) |
| Cells of Gr_{≥0}(k,n) labelled by permutations | on-shell diagrams |
| Instanton data as maps into a Grassmannian | ADHM data |
| Holomorphic bundle on CP^3 | Ward correspondence of a self-dual connection |
| Target U(N)/(U(k)×U(N-k)) | Grassmannian sigma model |

In every language the two planes remain the two rulings of the Klein
quadric: σ_2 and σ_{1,1}.
