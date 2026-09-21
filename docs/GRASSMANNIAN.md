# Grassmannians, the Klein quadric, and what Lean initializes

Author of the repository record: Ben Frohman (@BenFrohman).
Mathematical credit: Plücker, Schubert, Lefschetz. This is not a proof
of the Hodge conjecture.

A Grassmannian is the parameter space of linear subspaces. The fourfold
in the constructor note is the first nontrivial example.

## Definition and dimension

Let `V` be a complex vector space of dimension `n`. The Grassmannian
`Gr(k,V)`, also written `Gr(k,n)`, is the set of `k`-dimensional linear
subspaces of `V`. Projectively, `Gr(k+1,n+1)` parametrizes `k`-planes in
`P^n`.

The tangent space at a point `W ⊂ V` is `Hom(W, V/W)`, so

    dim Gr(k,n) = k(n-k).

The first values are familiar: `Gr(1,n) = P^{n-1}`, and
`Gr(n-1,n) ≅ P^{n-1}` by duality. The first example that is not a
projective space is

    Gr(2,4),    dim = 2·2 = 4,

the space of lines in `P^3`. That is the Klein quadric in the constructor.

## Plücker embedding

A `k`-plane `W ⊂ V` determines a line `∧^k W ⊂ ∧^k V`. That assignment

    Gr(k,n) → P(∧^k C^n)

is a closed embedding. For `Gr(2,4)`, `∧^2 C^4` is six-dimensional, so
the target is `P^5`. If `W` is spanned by the rows of a `2×4` matrix, the
six `2×2` minors are the Plücker coordinates

    (p01 : p02 : p03 : p12 : p13 : p23).

They satisfy the single quadratic relation

    p01 p23 - p02 p13 + p03 p12 = 0.

That hypersurface is smooth. It is the Klein quadric `Q^4 ⊂ P^5`.

## Two families of planes

A smooth quadric fourfold contains two families of linear `P^2`s. On
`Gr(2,4)` they have an incidence meaning.

- Lines through a fixed point `p ∈ P^3` form a `P^2` in `Q`. That class
  is `σ₂`. In Plücker coordinates, lines through `[1:0:0:0]` are
  `Π = {p12 = p13 = p23 = 0}`.
- Lines contained in a fixed plane `P ⊂ P^3` form another `P^2` in `Q`.
  That class is `σ_{1,1}`. Lines in `z0 = 0` are
  `Π' = {p01 = p02 = p03 = 0}`.

Linear duality of `P^3` interchanges the two families and therefore
interchanges `σ₂` with `σ_{1,1}`. The geometry is isomorphic; the names
are not. The constructor identities do not use the names:

    h² = [Π] + [Π']
    [Π]² = [Π']² = 1
    [Π] · [Π'] = 0
    γ = (γ · [Π]) [Π] + (γ · [Π']) [Π']

## What Lean initializes

`Hodge.Classical.kleinQuadric` is the linear-algebra shadow: a
two-dimensional rational vector space with vanishing obstruction and
identity cycle map.

`Hodge.Klein` names the missing geometric objects, without claiming they
are schemes:

- `Coord` — the six Plücker coordinates;
- `pluckerEval` — the quadratic `p01 p23 - p02 p13 + p03 p12`;
- `piIdeal`, `pi'Ideal` — the two linear vanishing lists;
- `pi_on_quadric`, `pi'_on_quadric` — if the plane coordinates vanish,
  the quadratic vanishes (`Π ⊂ Q` and `Π' ⊂ Q` as point-sets);
- `FormalCycle` and `initialize` — the map `(a, b) ↦ a Π + b Π'`.

Those are naming lemmas. They are not `[Π]² = 1` in the Chow ring of
`Gr(2,4)`.

Mathlib does not supply `Gr(2,4)` as a projective variety in this
repository. Initializing the planes as subschemes, and proving the
intersection matrix inside Lean, is a different project.

`construct_of_codim_ge_two` remains an axiom. A general fourfold has no
Schubert cell decomposition and no two-plane basis of `H^4`.
