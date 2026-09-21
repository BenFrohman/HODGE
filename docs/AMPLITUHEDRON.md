# The amplituhedron is not a renaming of the two planes

Author of the repository record: Ben Frohman (@BenFrohman).
The amplituhedron is a linear image of a positive Grassmannian. It is a
cousin of `Gr(2,4)`, not another name for the two planes on `Q^4`.
The rulings stay `Π = σ_2` and `Π' = σ_{1,1}` as in `docs/NAMING.md`.

## Positive Grassmannian

A point of `Gr(k,n)` is a `k`-plane in `ℝ^n`, written as a `k × n` matrix
`C` up to `GL(k)`. Its Plücker coordinates are the `k × k` minors. The
totally nonnegative Grassmannian is the closed semi-algebraic set

    Gr_{≥0}(k,n) = { C ∈ Gr(k,n) : every Plücker coordinate is ≥ 0 }.

The open stratum with all minors `> 0` is the positive Grassmannian
`Gr_{>0}(k,n)`. Postnikov stratified `Gr_{≥0}(k,n)` into positroid cells,
indexed by decorated permutations (or equivalently by plabic graphs /
on-shell diagrams). Each cell is specified by which minors vanish and
which stay positive.

This is not the complex Klein quadric. `Q^4 = Gr(2,4)_ℂ` is the complex
Grassmannian of lines in `ℙ³`. `Gr_{≥0}(2,4)` is a real subset of the
real Grassmannian, cut out by sign conditions on the same six Plücker
coordinates.

## The tree amplituhedron

Fix integers `k, m, n` with `k + m ≤ n`, and a matrix `Z` of size
`n × (k+m)` whose maximal minors are all positive. Right multiplication
by `Z` sends `k`-planes in `ℝ^n` to `k`-planes in `ℝ^{k+m}`:

    Z̃ : Gr_{≥0}(k,n) → Gr(k, k+m),    C ↦ C Z.

The tree amplituhedron is the image

    A_{n,k,m}(Z) = { C Z : C ∈ Gr_{≥0}(k,n) } ⊂ Gr(k, k+m).

It is a closed semi-algebraic set of dimension `k m`. Combinatorics is
expected to be independent of a generic positive `Z`.

Three special cases are ordinary geometry:

- `k = 1`: `A_{n,1,m}(Z)` is a cyclic polytope in `ℙ^m`.
- `k + m = n`: `Z̃` is an isomorphism and `A_{n,k,n-k}` is the positive
  Grassmannian.
- `m = 1`: the bounded complex of a cyclic hyperplane arrangement.

## Where this sits relative to Q^4

`A_{n,k,m}` lives in `Gr(k, k+m)`. For the ambient space to be the Klein
quadric one needs

    k = 2,    k + m = 4    ⇒    m = 2.

So the amplituhedra that actually live in `Gr(2,4)` are the family
`A_{n,2,2}(Z) ⊂ Q^4(ℝ)`. Ranestad–Sinn–Telen proved that these tree
amplituhedra of lines in `ℙ³` are positive geometries: they carry a unique
canonical form with logarithmic poles on the boundary.

The physical tree amplituhedron of planar N=4 SYM is the other family

    A_{n,k,4}(Z) ⊂ Gr(k, k+4),

with `m = 4` matching four-dimensional spacetime. That object does not sit
in `Q^4` except in tiny `(k, m)` slots. The two rulings `Π`, `Π'` of the
complex Klein quadric are not cells of `A_{n,k,m}`.

## Cells, tiles, BCFW

A positroid cell `S ⊂ Gr_{≥0}(k,n)` of dimension `k m` on which `Z̃` is
injective maps to a tile of the amplituhedron. A collection of tiles whose
interiors are disjoint and whose union is `A_{n,k,m}` is a tiling.

For `m = 4`, BCFW recursion produces a specific collection of such cells.
Even-Zohar–Lakrec–Parisi–Sherman-Bennett–Tessler–Williams proved that those
BCFW cells really tile `A_{n,k,4}`, and that the facets of BCFW tiles are
cut out by compatible cluster variables of `Gr(4,n)` (cluster adjacency).
That is the original geometric conjecture of Arkani-Hamed–Trnka, now a
theorem.

On-shell diagrams are the plabic graphs of those cells. They are a language
for the same positroid stratification, not a new space.

## Canonical form

A positive geometry `(X, X_{≥0})` is a complex variety with a semi-algebraic
positive part that admits a unique meromorphic top form `Ω` with logarithmic
poles along each boundary component, such that the residue on every facet is
the canonical form of that facet, and `Ω` has no poles in the interior.
For `Gr_{>0}(k,n)`,

    Ω(Gr_{>0}(k,n)) = μ_Gr / ∏_{j=1}^n p_{I_j},

the Grassmannian volume form divided by the `n` consecutive cyclic minors.

The physical claim is that the tree amplitude of planar N=4 SYM is the
canonical form of `A_{n,k,4}`. That identification is still a conjecture in
full generality, even though BCFW tilings are now known: one still has to
match the sum of tile forms to the amplitude. The statement that every
`A_{n,k,m}` is a positive geometry is likewise open outside special `(k, m)`.

## Cluster, tropical, and winding

- Cluster algebras. For even `m`, tiles are expected to be regions where a
  clique of cluster variables of `Gr(m,n)` has definite signs. Proved for
  all tiles when `m = 2`, and for BCFW tiles when `m = 4`.
- Tropicalization. The tropical amplituhedron studies the image of the
  tropical positive Grassmannian; it controls leading terms of canonical
  forms and some tiling counts.
- Winding. Projecting the external data through `Y ∈ A_{n,k,m}` produces a
  point configuration in `ℙ^{m-1}` of prescribed winding number. For `m = 4`
  that winding is a function of `k` only.

## What this is not

It is not a constructor for Hodge classes on a general fourfold. It is not
a renaming of `σ_2` and `σ_{1,1}`. The Grassmannian that appears is real and
totally nonnegative; the map `Z̃` is a positive linear projection; the output
lives in `Gr(k, k+m)`. The two planes on the complex Klein quadric remain the
two rulings of `Q^4`, in every language already recorded in `docs/NAMING.md`.
