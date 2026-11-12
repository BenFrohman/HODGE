/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Mathlib.LinearAlgebra.Finsupp.Defs
import Mathlib.LinearAlgebra.Finsupp.VectorSpace
import Mathlib.LinearAlgebra.Dimension.Constructions
import Mathlib.Data.Fintype.Option
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.Fintype.Card
import Mathlib.LinearAlgebra.FiniteDimensional.Defs

/-!
# The 27001-dimensional model space, in compact form

The full linear-algebra ambient space of the character-bridge model is the
rational function space on the index type

  `Idx := Option (Fin 30 × Fin 30 × Fin 30)`,

which has `1 + 30³ = 27001` points: one slot for `h²`, and one slot for each
character in the cube `[0,30)³`.  The dense type `Idx → ℚ` has this dimension,
but it must not be *materialized* as a 27001-tuple (that is what blew the
memory of an earlier draft).

The working type is the compact encoding `ModelH := Idx →₀ ℚ`.  Every vector
is stored by its finitely many nonzero coefficients.  Because `Idx` is finite,
this is the *same* space as `Idx → ℚ`:
`Finsupp.linearEquivFunOnFinite` is a linear equivalence, and both sides have
`finrank 27001`, proved from the product/option cardinal formulas, not by
enumerating the cube.

Nothing in this file is the cohomology of the chain sextic.  It is the
ambient vector space of a linear-algebra model.
-/

open Module Fintype

namespace Hodge
namespace ChainSexticCharacterModel

/-- The character cube `[0,30)³`. -/
abbrev Cube : Type := Fin 30 × Fin 30 × Fin 30

/-- Index set of the model: `none` is the `h²` slot, `some c` a character. -/
abbrev Idx : Type := Option Cube

/-- Compact encoding of the full model space: finitely supported functions
`Idx → ℚ`.  Nonzero coefficients only are stored. -/
abbrev ModelH : Type := Idx →₀ ℚ

/-- The dense function space of the same dimension.  Used only as the
codomain of `equivDense`; the model itself is `ModelH`. -/
abbrev DenseH : Type := Idx → ℚ

/-- `30³ = 27000`, from the product formula, not by listing the cube. -/
theorem card_cube : card Cube = 27000 := by
  simp [Cube, card_prod, card_fin]

/-- `1 + 30³ = 27001`, from `card_option` and `card_cube`. -/
theorem card_idx : card Idx = 27001 := by
  rw [card_option, card_cube]

/-- Compact and dense encodings are linearly equivalent (finite index). -/
noncomputable def equivDense : ModelH ≃ₗ[ℚ] DenseH :=
  Finsupp.linearEquivFunOnFinite ℚ ℚ Idx

/-- The compact space has dimension `27001`. -/
theorem finrank_modelH : finrank ℚ ModelH = 27001 := by
  rw [finrank_finsupp_self, card_idx]

/-- The dense space has the same dimension, again from the card formula. -/
theorem finrank_denseH : finrank ℚ DenseH = 27001 := by
  rw [finrank_pi, card_idx]

/-- Transport of dimension along the compact-to-dense equivalence. -/
theorem finrank_eq_of_equivDense : finrank ℚ ModelH = finrank ℚ DenseH :=
  LinearEquiv.finrank_eq equivDense

theorem equivDense_finrank : finrank ℚ ModelH = 27001 ∧ finrank ℚ DenseH = 27001 :=
  ⟨finrank_modelH, finrank_denseH⟩

/-- The standard Finsupp basis: `single i 1`.  Abstract, not an enumerated list. -/
noncomputable def modelBasis : Basis Idx ℚ ModelH :=
  Finsupp.basisSingleOne

theorem modelBasis_apply (i : Idx) : modelBasis i = Finsupp.single i 1 :=
  rfl

/-- Coordinate functional on the compact space. -/
noncomputable def coord (i : Idx) : ModelH →ₗ[ℚ] ℚ :=
  Finsupp.lapply i

theorem coord_single (i j : Idx) (a : ℚ) :
    coord i (Finsupp.single j a) = if i = j then a else 0 := by
  simp [coord, Finsupp.single_apply, eq_comm (a := i) (b := j)]

/-- The standard basis vector of index `i`. -/
noncomputable def e (i : Idx) : ModelH :=
  Finsupp.single i 1

theorem coord_e (i j : Idx) : coord i (e j) = if i = j then 1 else 0 := by
  simp [e, coord_single]

theorem e_ne_zero (i : Idx) : e i ≠ 0 := by
  intro h
  have := coord_e i i
  simp [h] at this

instance : FiniteDimensional ℚ ModelH :=
  FiniteDimensional.of_fintype_basis modelBasis

instance : FiniteDimensional ℚ DenseH :=
  FiniteDimensional.of_fintype_basis (Pi.basisFun ℚ Idx)

end ChainSexticCharacterModel
end Hodge
