/-
Copyright (c) 2026 Benjamin Stanley Frohman.
Released under Apache 2.0 license as described in the file LICENSE.
-/

import Mathlib.Algebra.Module.LinearMap.Basic
import Mathlib.LinearAlgebra.Span.Basic
import Mathlib.Algebra.Module.Submodule.Lattice
import Mathlib.Algebra.Field.Rat

/-!
# Geometric cycle class map via Chow groups and Poincaré duality

This module records the classical construction of the cycle class map
as a structure whose fields are the geometric inputs (Chow groups,
singular homology/cohomology, fundamental classes, and Poincaré duality).

Once those fields are supplied, the cycle class map `cl` is defined,
and the easy arrow (algebraic classes land in Hodge classes) is proved.

No claim is made that the fields are currently inhabited in Mathlib.

## Deviations from the text as supplied (compile fixes only)

1. Namespace: the declarations live in `Hodge.GeometricCycleClass`, not `Hodge`,
   because `Hodge.HodgeConjecture` is already a namespace of existing results
   (e.g. `Hodge.HodgeConjecture.klein`, `Hodge.HodgeConjecture.of_section`) about
   `Hodge.Datum.HodgeConjecture`. A new def `Hodge.HodgeConjecture` would still compile,
   but those existing lemmas would then read as if they were about this new def, so
   the new declarations get their own namespace to keep the two notions apart.
2. The `where obstruction : H_coh →ₗ[ℚ] OffDiagonal` clause after the structure fields
   is not valid Lean, and `OffDiagonal` was undefined. It is replaced by ordinary
   structure fields `OffDiagonal : Type`, `[addOff : AddCommGroup OffDiagonal]`,
   `[modOff : Module ℚ OffDiagonal]` and `obstruction : H_coh →ₗ[ℚ] OffDiagonal`, placed
   before `fund_isHodge` (the docstring of the old clause is kept on `obstruction`),
   plus the two matching `attribute [instance]` lines.
3. Imports: `import Mathlib.Algebra.Field.Rat` is added; without it the pinned Mathlib
   (v4.22.0) cannot find the `Semiring ℚ` instance needed for `Module ℚ`.
4. `algebraicClasses` is marked `noncomputable`, because it is built from the
   `noncomputable` `cycleClassMap` and Lean refuses to compile it otherwise.
Every other statement and docstring is as supplied. Nothing here inhabits the
structure; no geometric content is claimed.
-/

namespace Hodge
namespace GeometricCycleClass

/-- A package of the geometric data needed to define the cycle class map
on a smooth complex projective variety of dimension `n`.

- `CH` is the rational Chow group of codimension-`k` cycles.
- `H_sing` is singular homology with rational coefficients in degree `2(n-k)`.
- `H_coh` is singular cohomology with rational coefficients in degree `2k`.
- `fund` sends an irreducible subvariety to its fundamental homology class.
- `PD` is Poincaré duality (an isomorphism).
-/
structure GeometricCycleClassData (n k : ℕ) where
  /-- Rational Chow group of codimension `k`. -/
  CH : Type
  [addCH : AddCommGroup CH]
  [modCH : Module ℚ CH]
  /-- Singular homology \( H_{2(n-k)}(-,\mathbb{Q}) \). -/
  H_sing : Type
  [addHsing : AddCommGroup H_sing]
  [modHsing : Module ℚ H_sing]
  /-- Singular cohomology \( H^{2k}(-,\mathbb{Q}) \). -/
  H_coh : Type
  [addHcoh : AddCommGroup H_coh]
  [modHcoh : Module ℚ H_coh]
  /-- Fundamental class of an irreducible codimension-`k` subvariety. -/
  fund : CH →ₗ[ℚ] H_sing
  /-- Poincaré duality isomorphism. -/
  PD : H_sing ≃ₗ[ℚ] H_coh
  /-- Target of the off-diagonal obstruction (deviation 2: was undefined). -/
  OffDiagonal : Type
  [addOff : AddCommGroup OffDiagonal]
  [modOff : Module ℚ OffDiagonal]
  /-- Placeholder for the off-diagonal obstruction map on cohomology.
  In a full formalization this would come from the Hodge decomposition. -/
  obstruction : H_coh →ₗ[ℚ] OffDiagonal
  /-- The image of the fundamental class under PD lands in the Hodge classes
  (i.e. vanishes on the off-diagonal Hodge pieces).
  This is the classical “algebraic classes are Hodge” statement. -/
  fund_isHodge : ∀ z : CH, obstruction (PD (fund z)) = 0

attribute [instance] GeometricCycleClassData.addCH
attribute [instance] GeometricCycleClassData.modCH
attribute [instance] GeometricCycleClassData.addHsing
attribute [instance] GeometricCycleClassData.modHsing
attribute [instance] GeometricCycleClassData.addHcoh
attribute [instance] GeometricCycleClassData.modHcoh
attribute [instance] GeometricCycleClassData.addOff
attribute [instance] GeometricCycleClassData.modOff

variable {n k : ℕ} (G : GeometricCycleClassData n k)

/-- The cycle class map, defined as Poincaré dual of the fundamental class. -/
noncomputable def cycleClassMap : G.CH →ₗ[ℚ] G.H_coh :=
  G.PD.toLinearMap.comp G.fund

/-- Algebraic classes: the image of the cycle class map. -/
noncomputable def algebraicClasses : Submodule ℚ G.H_coh :=
  LinearMap.range (cycleClassMap G)

/-- Hodge classes: kernel of the off-diagonal obstruction. -/
def hodgeClasses : Submodule ℚ G.H_coh :=
  LinearMap.ker G.obstruction

/-- Easy arrow: every algebraic class is a Hodge class. -/
theorem algebraic_le_hodge :
    algebraicClasses G ≤ hodgeClasses G := by
  intro v hv
  rcases hv with ⟨z, rfl⟩
  exact G.fund_isHodge z

/-- The Hodge conjecture for this package: every Hodge class is algebraic. -/
def HodgeConjecture : Prop :=
  hodgeClasses G ≤ algebraicClasses G

/-- Equivalent formulation via a section of the cycle class map. -/
def hasSection : Prop :=
  ∀ γ ∈ hodgeClasses G, ∃ z : G.CH, cycleClassMap G z = γ

theorem hodgeConjecture_iff_hasSection :
    HodgeConjecture G ↔ hasSection G := by
  constructor
  · intro h γ hγ
    exact h hγ
  · intro h γ hγ
    exact h γ hγ

end GeometricCycleClass
end Hodge
