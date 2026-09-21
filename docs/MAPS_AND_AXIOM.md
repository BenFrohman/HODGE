# The two maps and the guarded axiom

Author: Benjamin Stanley Frohman. Apache-2.0.

This is the standing account. It is not a proof.

## Status line, not a proof step

`No CycleSection on a general fourfold` is a status line: that instance
does not exist. It is not a step in a proof. It cannot be omitted from a
proof of the Hodge conjecture, because that instance would be the proof
for that fourfold. There is no separate variety proof system next to it.

## The two maps

`cl` is the easy map, already in `Datum`:

    cl : cycles → cohomology

Geometry gives this. Algebraic cycles produce Hodge classes. That is not
the conjecture.

`CycleSection.construct` is the reverse map, when it exists:

    construct : Hodge class → cycle
    is_section : cl (construct γ) = γ

That is the section of `cl`. On P^4, Q^4, and P^2 x P^2 it is the
coefficient rule already written. On a general fourfold it is missing.
Supplying it for every Hodge class on every smooth projective fourfold
is the Hodge conjecture in that degree.

Hodge classes are ker(obstruction). The map in question is a section of
`cl` over that kernel. It is not `cl` itself.

## The guarded axiom is not that map

```lean
axiom construct_of_codim_ge_two
    (D : Datum Z V N) [IsVariety D] (_h : 2 ≤ D.codim) :
    CycleConstructor D
```

It asserts that a constructor exists if `D` carries the `IsVariety`
sticker. It does not return Π, Π', or any other cycle.
`CycleConstructor` is a proof of membership in the image of `cl`, not a
function to cycles.

## Why it is guarded

The unguarded sentence `forall D, 2 ≤ D.codim → HodgeConjecture D` is
false. `zeroCycle` has `codim = 2` and `cl = 0`, and the repo proves
`¬ HodgeConjecture`. Unguarded axiom plus that example is `False`.

`IsVariety` is a sticker. The three classical islands have it.
`zeroCycle` does not. Anyone can write `instance : IsVariety D`. If the
sticker is put on `zeroCycle`, the axiom plus `zeroCycle_not_hodge` is
`False` again. The sticker is not a scheme.

## What is needed

Needed for a proof: a `CycleSection`, or any other term that produces
the cycles.

Not needed for a proof: the axiom. It replaces the missing term with a
claim. Theorems that use it list `construct_of_codim_ge_two` under
`#print axioms`.

## Category fix (do not mix these two objects)

Two objects live in two different categories. Renaming does not move
one into the other.

| Object | What it is | What it can prove | What it cannot prove |
|---|---|---|---|
| `Examples.zeroCycle` | A `Datum` with `cl = 0`, `obstruction = 0`, `codim = 2` | `¬ zeroCycle.HodgeConjecture`. Hence `¬ (∀ D, 2 ≤ D.codim → D.HodgeConjecture)`. | Anything about a fourfold. It is not a point of the moduli space of hypersurfaces in `ℝ^5`. |
| A fourfold `X ⊂ ℝ^5` of degree `d` | A smooth hypersurface, a point of `|ℳ(d)|` | Geometry: Hodge numbers, Noether–Lefschetz, known cases (cubic, uniruled, Fermat, …) | That `zeroCycle` is `X`. |

Correct uses of `zeroCycle`:

- Sentinel for the *skeleton*: do not axiom `HodgeConjecture` for every `Datum`.
- Consistency check: the guard `IsVariety` must not be placed on `zeroCycle`.

Incorrect uses of `zeroCycle`:

- Call it a general fourfold.
- Call it a point of the moduli space of `X_d ⊂ ℝ^5`.
- Conclude `¬ CycleConstructor X` for a geometric fourfold.
- Treat `(1+ζ^4)w^4` plus `zeroCycle` as a Clay counterexample.

A geometric counterexample would be a specific fourfold `X`, a specific
class `γ ∈ H^4(X, ℚ) ∩ H^{2,2}(X)` that is not a rational combination of
surfaces. `zeroCycle` supplies none of those three ingredients.
