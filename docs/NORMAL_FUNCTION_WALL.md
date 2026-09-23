# Normal functions: what they catch, what they do not

Author of the repository record: Benjamin Stanley Frohman (@BenFrohman).
This is an exposition of a known attack and its wall. It is not a
`CycleSection` and not a proof of the Hodge conjecture.

Theorems cited below belong to Griffiths, Zucker, Schmid,
Cattani–Kaplan–Schmid, Carlson–Green–Griffiths–Harris, and Voisin.
They are citations, not coauthorship, and not a Frohman theorem.

## Lefschetz pencil

Hyperplane sections of a fourfold `X` are threefolds `Y_t`. Restriction
is `H^4(X) → H^4(Y_t)`, identified with curve classes on `Y_t`. Hodge
is known in dimension 3, so those classes are algebraic curves `C_t`.
After subtracting a fixed algebraic part so that the remainder is
homologically trivial, Abel–Jacobi gives a normal function
`ν : B → J^3`.

Griffiths transversality is the horizontality of that section.
Schmid's nilpotent orbit theorem controls the Hodge filtration as `t → 0`.
The Jacobian ring of a hypersurface slice `Y = V(f) ⊂ ℙ^4`,

    R(f) = ℂ[z0,...,z4] / (∂f/∂z0, ..., ∂f/∂z4),

governs infinitesimal Torelli of the *slice*, not a surface on `X`.

## Where Sing(ν) lives

`Sing(ν)` is a locus in the base `B` (or its boundary). It is a set of
parameters at which `Y_t` degenerates. Cattani–Kaplan–Schmid and later
work on singularities of normal functions make that locus algebraic in
the base. It is not a surface inside `X`.

## The extension problem

Even if `ν(t) = AJ(Z_t)` for some curves `Z_t ⊂ Y_t`, Abel–Jacobi is
not injective. Many 1-cycles share a point of `J^3(Y_t)`. There is no
canonical way to choose `Z_t` so that they glue to a surface `Y ⊂ X`
with class `γ`. A nonzero residue at a node of `Y_s` records vanishing
cycles on the *slice*. It does not write equations of a 2-cycle of
class `γ` on the fourfold.

## What is not claimed

Pairing leading coefficients of a nilpotent orbit with graded pieces of
`R(f)` does not extract those equations. `R(f)` is the Jacobian ring of
the threefold. Vanishing cycles at the degeneration are not the missing
surfaces on `X`.

The missing term remains a `CycleSection` for `γ ∈ Hdg^2(X)`.
