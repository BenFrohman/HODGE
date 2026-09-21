# The two maps and the guarded axiom

Author of the repository record: Benjamin Stanley Frohman (@BenFrohman).
This is not a proof of the Hodge conjecture.

## Short answers

"No `CycleSection` on a general fourfold" is not a step in a proof. It is a
status line: that instance does not exist. You cannot omit it from a proof of
the Hodge conjecture, because that instance would be the proof for that
fourfold. There is no separate variety proof system sitting next to it.

The guarded axiom is not that map. It does not send a class to a cycle. It
asserts that a constructor exists.

## The two maps

`cl` is the easy map, already in `Datum`:

    cl : cycles → cohomology

Geometry gives this. Algebraic cycles produce Hodge classes. That is not the
conjecture.

`CycleSection.construct` is the reverse map, when it exists:

    construct : Hodge class → cycle
    is_section : cl (construct γ) = γ

That is the section of `cl`. On `ℕ⁴`, `Q⁴`, and `ℕ²×ℕ²` it is the coefficient
rule already written. On a general fourfold it is missing. Supplying it for
every Hodge class on every smooth projective fourfold is the Hodge conjecture
in that degree.

Hodge classes are `ker(obstruction)`. The map in question is a section of `cl`
over that kernel. Not "Hodge identically."

## What the guarded axiom is

```lean
axiom construct_of_codim_ge_two
    (D : Datum Z V N) [IsVariety D] (_h : 2 ≤ D.codim) :
    CycleConstructor D
```

It says: if someone has flagged `D` with `IsVariety`, then every Hodge class of
`D` is algebraic.

It does not return `Π`, `Π'`, or any other cycle. `CycleConstructor` is a proof
of membership in the image of `cl`, not a function to cycles.

## Why it is guarded

The unguarded sentence was `∀ D, 2 ≤ D.codim → HodgeConjecture D`. That is
false. `zeroCycle` has `codim = 2` and `cl = 0`, and the repo proves
`¬ HodgeConjecture`. Unguarded axiom plus that example is `False`.

The guard `IsVariety` is a sticker you put on a `Datum`. The three classical
islands have the sticker. `zeroCycle` does not. So the axiom no longer
contradicts `zeroCycle`.

The sticker is not a scheme and not a test for "this came from a variety."
Anyone can write `instance : IsVariety D`. If you put the sticker on
`zeroCycle`, the axiom plus `zeroCycle_not_hodge` is `False` again.

## Is it a key element of a proof?

It is a named assumption. Theorems that use it — `HodgeConjecture.general_fourfold`
in the same file — are the assumption restated. They are not constructions.
`#print axioms` on those theorems will list `construct_of_codim_ge_two`.

Needed for a proof: a `CycleSection` (or any other term that produces the cycles).
Not needed for a proof: the axiom. It replaces the missing term with a claim.
