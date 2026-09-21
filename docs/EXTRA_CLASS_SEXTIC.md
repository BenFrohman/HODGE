# Extra Hodge classes as surfaces — what can be written down

Author of the repository record: Benjamin Stanley Frohman (@BenFrohman).
This is not a uniform constructor and not a proof of the Hodge conjecture.

The request was: a fourfold `X ⊂ ℙ⁵` of degree `≥ 6`, an extra class
`γ ∈ H⁴(X, ℚ) ∩ H^{2,2}(X)` that is not a multiple of `h²`, and surfaces
with `γ = ∑ a_i [Z_i]`. Or a uniform rule for every such `γ`.

## Very general `X`: there is no extra class

For a very general hypersurface `X ⊂ ℙ⁵` of degree `d ≥ 6`,
Noether–Lefschetz / variational Hodge theory gives

    Hdg²(X) = ℚ h².

The only Hodge class is a multiple of the hyperplane square. The section of
`cl` is `γ = a h²`, and `h²` is the class of `X ∩ ℙ³`. There are no extra
classes to write as extra surfaces.

## Special `X` that contains a plane: one extra class, one surface

Let coordinates on `ℙ⁵` be `[x₀ : x₁ : x₂ : x₃ : x₄ : x₅]`. Let

    Π = { x₃ = x₄ = x₅ = 0 } ≅ ℙ².

A hypersurface of degree `d` contains `Π` if and only if its equation lies
in the ideal `(x₃, x₄, x₅)`:

    F = x₃ A + x₄ B + x₅ C,    deg A,B,C = d-1.

Take `d = 6` and a general such `F` that is smooth. Then `X = V(F)` is a
smooth sextic fourfold containing the plane `Π`.

Let `h = c₁(O_X(1))`. Intersection on `X`:

    [Π] · h² = 1,    h⁴ = 6.

The self-intersection of the plane comes from the normal sequence
`0 → N_{Π/X} → O_Π(1)³ → O_Π(6) → 0`:

    [Π]² = c₂(N_{Π/X}) = 3 - 3d + d² = 21.

If `[Π] = λ h²` then `λ = 1/6` and `[Π]² = 1/6`, which is not `21`.
So

    γ := [Π]

is an extra Hodge class, not a multiple of `h²`, and the surface is `Π`
itself:

    γ = 1 · [Π].

That is the easy arrow: the surface was written into the equation of `X`.
It is not a decode of an abstract period class.

## What this is not

It is not a uniform rule that takes an arbitrary `γ ∈ Hdg²(X)` on an
arbitrary (or even an arbitrary special) fourfold and returns surfaces.
If `γ` is presented only as a Hodge class — a vector in `H⁴`, not as the
class of a known subvariety — writing `Z_i` with `γ = ∑ a_i [Z_i]` is
the Hodge conjecture for that `X`. That constructor is not supplied.
