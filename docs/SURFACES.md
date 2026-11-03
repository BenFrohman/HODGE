# Named surfaces

Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman).
License: Apache-2.0.

Every surface this repository actually writes. Finite list. Not `z_of`
for unspecified `D`.

## 1. Projective 4-space

- Host: `X = ℕ⁴`
- Surface: `Z = {x₃ = x₄ = 0} ≅ ℕ²`
- Ideal: `I(Z) = ⟨x₃, x₄⟩` (`Classical.p4PlaneIdeal`)
- Rule: `T_F(a) = a [Z]`
- Lean: `Classical.constructP4`

## 2. Klein quadric `Q⁴ ⊂ ℕ⁵`

- Host: Plücker quadric `p₀₁ p₂₃ − p₀₂ p₁₃ + p₀₃ p₁₂ = 0`
- Surfaces:
  - `Π = σ₂ = {p₁₂ = p₁₃ = p₂₃ = 0}` (lines through a point)
  - `Π' = σ₁₁ = {p₀₁ = p₀₂ = p₀₃ = 0}` (lines in a plane)
- Rule: `T_F(a,b) = a[Π] + b[Π']`
- Pieri: `h² = σ₁² = σ₂ + σ₁₁`
- Lean: `Classical.construct`

## 3. Product of planes

- Host: `ℕ² × ℕ²`
- Surfaces: `{pt}×ℕ²`, `ℕ²×{pt}`, `ℕ¹×ℕ¹`
- Classes: `h₁²`, `h₂²`, `h₁ h₂`
- Rule: `T_F(a,b,c) = a h₁² + b h₂² + c h₁ h₂`
- Lean: `Classical.constructProduct`

## 4. Fermat quartic fourfold

- Host: `X = V(z₀⁴ + z₁⁴ + z₂⁴ + z₃⁴ + z₄⁴ + z₅⁴) ⊂ ℕ⁵`
- Pairing: `(z₀,z₁)`, `(z₂,z₃)`, `(z₄,z₅)`
- Roots: `μ⁴ = ν⁴ = ρ⁴ = -1`
- Surfaces:
  - `Z₁`: `z₁ = μ₀ z₀`, `z₃ = ν₀ z₂`, `z₅ = ρ₀ z₄` (`Fermat.Z1`)
  - `Z₂`: same pairing, next root on the first pair (`Fermat.Z2`)
- Ideal of a linear plane: `⟨z₁ − μ z₀, z₃ − ν z₂, z₅ − ρ z₄⟩`
- Identity: `z₀⁴ + (μ z₀)⁴ + z₂⁴ + (ν z₂)⁴ + z₄⁴ + (ρ z₄)⁴ = 0` when those fourth powers are `-1`
- Rule on this span: `T_F(a,b) = a[Z₁] + b[Z₂]`
- Lean: `Fermat.twoPlanes`
- Not the full AMV basis of `Hdg²(X)`

## 5. Special NL sextic

- Host: `F = x₀⁵ x₃ + x₃⁶ + x₁⁵ x₄ + x₄⁶ + x₂⁵ x₅ + x₅⁶`
- Surface: `Π = {x₃ = x₄ = x₅ = 0}`, `I(Π) = ⟨x₃, x₄, x₅⟩`
- Identity: `F = x₃(x₀⁵ + x₃⁵) + x₄(x₁⁵ + x₄⁵) + x₅(x₂⁵ + x₅⁵)` (`F_factors`, `F_mem_plane`)
- Linear section: `⟨x₀, x₁⟩` tracking `h²`
- Rule: `T_F(a,b) = a h² + b[Π]`
- Lean: `SpecialSextic.planeSpan`

## 6. Hassett divisor `C₈`

- Host: cubic `F = x₃ A + x₄ B + x₅ C` with `deg A,B,C = 2`
- Surface: `Π = {x₃ = x₄ = x₅ = 0}` (`Hassett.planeIdeal`)
- Linear section: `⟨x₀, x₁⟩` (`Hassett.hyperplaneSectionIdeal`)
- Rule: `T_F(a,b) = a[X ∩ {x₀ = x₁ = 0}] + b[Π]`
- Lean: `Hassett.planeSpan`
- Not Zucker's theorem for every class on a cubic

## What this list is not

- not `instance (D) (h : D.codim = 2) : CycleSection D`
- not a Chow map `A²(X) → H⁴(X, ℚ)`
- not surfaces for `S×S`, `S^{[2]}`, a very general sextic with no plane, or an unnamed Calabi–Yau fourfold

Those hosts are not on the list because their `Z_i` were not written. Adding them requires equations first, then a new `CycleSection` instance, then a longer finite conjunction. That still is not `∀ D`.
