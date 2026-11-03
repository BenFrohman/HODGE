# Claim versus proof

Author: Benjamin Stanley Frohman (@BenFrohman).
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.

This file locks the two objects that must not be identified.

## The sentence (Clay at codimension 2)

```lean
def HodgeConjecture.general_fourfold
    (D : Datum Z V N) (_h : D.codim = 2) : Prop :=
  D.HodgeConjecture
```

On a datum `D` with `D.codim = 2`,

```text
D.HodgeConjecture
  :⇔  ∀ γ ∈ D.hodgeClasses, ∃ z ∈ Z, D.cl z = γ.
```

In geometry that is: every rational Hodge class of type (2,2) is a finite
rational combination of surfaces,

```text
γ = ∑_i a_i [Z_i].
```

Clay is that sentence for every smooth complex projective fourfold, not for
a finite list of named hosts.

`LefschetzTwoTwo D h` is the same Prop. `Iff.rfl` only says the names match.
It does not write a surface, a coefficient, or a `CycleSection`.

## The type of a proof

A proof of the sentence is a function that, given `D` and given `γ`, returns
the cycle `z` and the identity `cl(z) = γ`.

```lean
class CycleSection (D : Datum Z V N) where
  construct  : { v : V // v ∈ D.hodgeClasses } → Z
  is_section : ∀ γ, D.cl (construct γ) = γ.val
```

An `instance : CycleSection D` is Hodge for that `D`.

The missing object is

```text
∀ D,  D.codim = 2  ⇒  CycleSection D.
```

That instance is not in this repository. `HodgeResolution` is a name, not a
constructor. `cl = id` is legal only after a host is named and an algebraic
basis is taken as coordinates.

## Official close of this repository

Released terms:

- `HodgeConjecture.named_fourfolds` — Hodge on six specified spans
  (`P^4`, `Q^4`, `P^2 × P^2`, Fermat two-plane span, special-sextic plane
  span, Hassett `C_8` plane span).
- `Fermat.contains_two_planes` — the Fermat quartic host carries two named
  linear planes `Z1`, `Z2` and a `CycleSection` on `Q[Z1] + Q[Z2]`.

Not released:

- a term of `general_fourfold D h` for unspecified `D`
- `theorem general_fourfold_holds ...`
- `instance (D) (_h : D.codim = 2) : CycleSection D`

A finite conjunction is a list. Clay is `∀ D`. Packaging the list does not
become `∀ D`.
