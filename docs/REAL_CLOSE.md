# Real close

Author: Benjamin Stanley Frohman (@BenFrohman).
Apache-2.0.
Copyright (c) 2026 Benjamin Stanley Frohman.

This note records the *type* of a real close of Hodge at (2,2) on fourfolds.
It does not inhabit that type for unspecified `D`.
Clay tag: open.

## Geometric sentence

A real close is an inhabitant of

∀ smooth projective fourfolds X,
∀ γ ∈ H⁴(X, ℚ) ∩ H^{2,2}(X),
∃ surfaces Z_i ⊂ X and a_i ∈ ℚ with γ = ∑ a_i [Z_i].

## Lean type

`CycleSection` on a datum `D` with `D.codim = 2`, both fields filled:

```lean
construct  : {v // v ∈ D.hodgeClasses} → Z
is_section : ∀ γ, D.cl (construct γ) = γ.val
```

`construct γ` is the finite list `(Z_i, a_i)`.

Also legal: a term of `HodgeConjecture.general_fourfold D h` for every
smooth projective fourfold datum `D` (classical `∃` allowed).

Wrapper in `Hodge/RealClose.lean`:

```lean
structure HodgeConjecture.RealClose
    (D : Datum Z V N) (h : D.codim = 2) where
  section : CycleSection D
```

`of_realClose` sends that wrapper to `general_fourfold`.
`realClose_of_section` packages an *existing* `[CycleSection D]`.
Neither is `∀ D`.

## Two legal inhabitants of the ∀

1. A uniform construction: from any such `(X, γ)`, write the `Z_i` and `a_i`.
   Lean: `CycleSection D` for every fourfold datum `D`.
2. A non-constructive existence proof of those `Z_i`, uniform in `X`.
   Lean: a term of `HodgeConjecture` / `general_fourfold` for every such `D`.

"Does not name `X`" means the argument does not case-split on a finite list
of hosts. It still proves the statement for every `X`.

## Not a close

- Named islands: `P^4`, `Q^4`, `P^2 × P^2`, Fermat / special-sextic / Hassett spans
- `cl = id` after naming a host so that `construct γ := γ` typechecks
- `sorry`, `admit`, a user `axiom`, `True.intro`, `Classical.choice`
- Treating the type as the term (`Proof.` under the ∀ with no `Z_i`)
- The ungated instance `instance (D) (_h : D.codim = 2) : CycleSection D`
  (false on `Examples.zeroCycle`; see `not_every_codim_ge_two`)
- `HodgeConjecture.named_fourfolds` / `FrohmanTwoTwoSpans`

## Still open

- `?z_of` and `?cl_z_eq` in `docs/UNIVERSAL_INSTANCE.md`
- A term of `HodgeConjecture.general_fourfold D h` for unspecified `D`
- Step 6 of `docs/EIGHT_STEP_LEDGER.md`
- The rational Hodge conjecture. Clay remains open.
