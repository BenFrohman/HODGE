<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# CycleSection construction (live bodies)

**Author:** Benjamin Stanley Frohman (@BenFrohman)
**License:** Apache-2.0
**Sources:** `Hodge/Construct.lean`, `Hodge/Classical.lean`,
`Hodge/SpecialSextic.lean`, `Hodge/Basic.lean`

This note records the compiled class and the named-island bodies.
It does not inhabit `general_fourfold`.
It does not add

```lean
instance (D) (h : D.codim = 2) : CycleSection D
```

## Class

```lean
class CycleSection (D : Datum Z V N) where
  construct : { v : V // v ∈ D.hodgeClasses } → Z
  is_section : ∀ γ, D.cl (construct γ) = γ.val
```

`construct` lives in `Type`. It returns a vector in `Z`.
`is_section` says that vector is a section of `cl` on `ker obstruction`.

## Promotion

```lean
instance (D) [CycleSection D] : CycleConstructor D where
  construct := fun v hv =>
    ⟨CycleSection.construct ⟨v, hv⟩, CycleSection.is_section ⟨v, hv⟩⟩
```

So `CycleSection` ⇒ `CycleConstructor` ⇔ `D.HodgeConjecture`.
The existential `z` is computed, then forgotten into a membership witness.

## How a body is written on a named island

The geometry is named first. Then the `Datum` is the coordinate span of
those surfaces with `obstruction = 0` and `cl = LinearMap.id`. After that,

```lean
construct γ := γ.val
is_section := fun _ => rfl
```

typechecks because `Z = V` and `cl` is the identity. The surfaces are not
reconstructed by `rfl`. They were chosen before `cl` was set to `id`.

## Live bodies

| Host | Lean construct | Geometry sitting outside the Datum |
|---|---|---|
| `projectiveFourSpace` | `(constructP4 γ.val).coeff`, `constructP4 γ = ⟨γ⟩` | `{x₃ = x₄ = 0} ⊂ ℝ⁴` |
| `kleinQuadric` | `construct γ.val` with `construct γ := γ` | `σ₂`, `σ₁₁` |
| `productOfPlanes` | `match (a,b,c) => (a,b,c)` | `h₁²`, `h₂²`, `h₁ h₂` |
| `planeSpan` | `construct γ := γ` | `h²`, `[Π]` on `V(F)` |
| `threeSpan` | `constructThree γ := γ` | `h²`, `[Π]`, `[Π₋₁]` |

`contains_two_planes` is not a `CycleSection` field. It is

```text
F ∈ planeIdeal x3 x4 x5  ∧  F ∈ planeIdealMinus1 …
```

That is why `Π` and `Π₋₁` were allowed into `threeSpan`.
It does not fill `construct` on unspecified `D`.

## What is not compiled

`docs/UNIVERSAL_INSTANCE.md` still has holes `?z_of` and `?cl_z_eq`.
`Examples.not_every_codim_ge_two` shows that an unguarded

```lean
instance (D) (_h : D.codim = 2) : CycleConstructor D
```

is false: `zeroCycle` has `codim = 2`, `cl = 0`, and `¬ HodgeConjecture`.

`#print axioms Hodge.HodgeConjecture.named_fourfolds` is expected to list
`propext` and `Quot.sound` only. See `docs/PRINT_AXIOMS.md`.
