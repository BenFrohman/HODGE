<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Claim versus proof

Author: Benjamin Stanley Frohman
License: Apache-2.0

A definition writes a sentence. A theorem writes a proof of a sentence.
Those are different declarations.

## The sentence

```lean
def HodgeConjecture.general_fourfold
    (D : Datum Z V N) (_h : D.codim = 2) : Prop :=
  D.HodgeConjecture
```

On a datum `D` with `D.codim = 2`,

```
D.HodgeConjecture
  :↔
  ∀ γ ∈ D.hodgeClasses, ∃ z ∈ Z, D.cl z = γ.
```

In geometry: every rational Hodge class of type (2,2) is a finite
rational combination of surfaces,

```
γ = ∑ a_i [Z_i].
```

Clay is that sentence for every smooth complex projective fourfold.

`LefschetzTwoTwo` is the same sentence. `Iff.rfl` only says the names match.

## The type of a proof

A proof is a function that, given `D` and given `γ`, returns a cycle `z`
and the identity `cl z = γ`.

That function is already a class field in `Hodge/Construct.lean`:

```lean
class CycleSection (D : Datum Z V N) where
  construct  : { v : V // v ∈ D.hodgeClasses } → Z
  is_section : ∀ γ, D.cl (construct γ) = γ.val
```

An `instance : CycleSection D` is Hodge for that `D`.
The missing object is

```
∀ D, D.codim = 2 → CycleSection D.
```

There is no such instance. Naming the hole `HodgeResolution` does not
write `construct`.

## The theorem that exists

`named_fourfolds` is Hodge on six specified spans, after those files set
`Z = V = ℚ^n` and `cl = id`:

- ℝ^4
- Q^4
- ℝ^2 × ℝ^2
- Fermat quartic, span ℚ[Z_1] + ℚ[Z_2]
- special sextic, span ℚ h^2 + ℚ[Π]
- Hassett C_8, same span

`contains_two_planes` is the two named planes on the Fermat host.

AMV / Shioda–Ran are literature for the whole Fermat quartic and quintic
fourfolds. They are not replayed here.

## Official close

Released: `named_fourfolds` and `contains_two_planes`.

Not released: a term of `general_fourfold D h` for unspecified `D`.
