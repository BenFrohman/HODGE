/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Hodge.ChainSexticCharacterModel.GaloisMin
import Hodge.ChainSexticBridgeAudit
import Mathlib.LinearAlgebra.Matrix.ToLin
import Mathlib.LinearAlgebra.BilinearForm.Basic
import Mathlib.LinearAlgebra.TensorProduct.Tower

/-!
# A compact inhabitant of the chain-sextic character core

This file packages the compact 27001-dimensional model into an inhabitant of
`ChainSexticCharacterCore` (and, via `toCharacterBridge`, of
`ChainSexticCharacterBridge`).  The ambient space is `ModelH := Idx →₀ ℚ`,
which is linearly equivalent to the dense space `DenseH := Idx → ℚ` and has
`finrank 27001` by a counting formula, not by enumeration.

The inhabitant is linear algebra, not the cohomology of the sextic.  Mathlib
still has no cycle class map, Hodge decomposition, or Griffiths residue map;
those remain hypotheses, satisfied here only in the model.

The pairing is the Gram form `[[6, 1], [1, 21]]` on the coordinates of `h²`
and the plane class, copied from `hodgeBridge_model`.  Griffiths' count uses
the already-proved identities `type22.card = 1751` and
`jacobianDeg12_finrank_eq`.
-/

open Module TensorProduct Matrix
open Hodge.ChainSexticRank Hodge.SexticCombinatorics Hodge.ChainSexticRho
open Hodge.ChainSexticCore

noncomputable section

namespace Hodge
namespace ChainSexticCharacterModel

open Classical

set_option maxHeartbeats 800000

/-! ## Pairing -/

/-- Coordinate projection onto the span of `h²` and the model plane class. -/
def toPlane : ModelH →ₗ[ℚ] Fin 2 → ℚ where
  toFun v := ![coord none v, coord (charIdx hodgeChar) v]
  map_add' := by
    intro x y
    ext i
    fin_cases i <;> simp [coord]
  map_smul' := by
    intro a x
    ext i
    fin_cases i <;> simp [coord]

/-- Gram matrix of `(h², [Π])`. -/
def modelGram : Matrix (Fin 2) (Fin 2) ℚ := !![6, 1; 1, 21]

/-- Cup-product pairing in the compact model. -/
def modelPairing : LinearMap.BilinForm ℚ ModelH :=
  (Matrix.toLinearMap₂' ℚ modelGram).compl₁₂ toPlane toPlane

theorem toPlane_h2 : toPlane h2Vec = ![1, 0] := by
  ext i
  fin_cases i <;> simp [toPlane, h2Vec, coord_e, charIdx_ne_none hodgeChar_in_cube]

theorem toPlane_P : toPlane pVec = ![0, 1] := by
  have hne : (none : Idx) ≠ charIdx hodgeChar :=
    (charIdx_ne_none hodgeChar_in_cube).symm
  ext i
  fin_cases i <;> simp [toPlane, pVec, coord_e, hne]

theorem modelPairing_apply (v w : ModelH) :
    modelPairing v w = toPlane v ⬝ᵥ (modelGram *ᵥ toPlane w) := by
  simp [modelPairing, Matrix.toLinearMap₂'_apply']

theorem model_h2_h2 : modelPairing h2Vec h2Vec = 6 := by
  rw [modelPairing_apply, toPlane_h2]
  simp [modelGram, dotProduct, Matrix.mulVec, Fin.sum_univ_two]

theorem model_h2_P : modelPairing h2Vec pVec = 1 := by
  rw [modelPairing_apply, toPlane_h2, toPlane_P]
  simp [modelGram, dotProduct, Matrix.mulVec, Fin.sum_univ_two]

theorem model_P_h2 : modelPairing pVec h2Vec = 1 := by
  rw [modelPairing_apply, toPlane_P, toPlane_h2]
  simp [modelGram, dotProduct, Matrix.mulVec, Fin.sum_univ_two]

theorem model_P_P : modelPairing pVec pVec = 21 := by
  rw [modelPairing_apply, toPlane_P]
  simp [modelGram, dotProduct, Matrix.mulVec, Fin.sum_univ_two]

/-! ## Hodge subspace and Griffiths -/

/-- Model `H^{2,2}`: the line of `h²` plus the type-`(2,2)` residual lines. -/
def modelH22 : Submodule ℂ (ℂ ⊗[ℚ] ModelH) :=
  Submodule.span ℂ {(1 : ℂ) ⊗ₜ[ℚ] h2Vec} ⊔ ⨆ χ ∈ type22, V χ

theorem h2Vec_ne_zero : h2Vec ≠ 0 := e_ne_zero none

theorem not_isTwisted_hodgeChar : ¬ IsTwisted hodgeChar := by
  intro h
  have hmem : hodgeChar ∈ hodgeSet := by
    rw [← hodgeChars_eq]
    exact hodgeChar_mem
  have hr : rationalHodge hodgeChar.1 hodgeChar.2.1 hodgeChar.2.2 = true :=
    (Finset.mem_filter.mp hmem).2
  exact Bool.false_ne_true (h.2.symm.trans hr)

theorem gen_hodgeChar : gen (charIdx hodgeChar) = (1 : ℂ) ⊗ₜ pVec := by
  rw [gen_charIdx hodgeChar_in_cube, if_neg not_isTwisted_hodgeChar]
  rfl

theorem model_h2_hodge : h2Vec ∈ rationalPoints modelH22 := by
  rw [mem_rationalPoints]
  exact (le_sup_left : _ ≤ modelH22) (Submodule.mem_span_singleton_self _)

theorem model_P_hodge : pVec ∈ rationalPoints modelH22 := by
  rw [mem_rationalPoints, ← gen_hodgeChar]
  refine (le_sup_right : _ ≤ modelH22) ?_
  have hV : V hodgeChar = Submodule.span ℂ {gen (charIdx hodgeChar)} := by
    simp [V, hodgeChar_prim]
  have hmem : gen (charIdx hodgeChar) ∈ V hodgeChar := by
    rw [hV]
    exact Submodule.mem_span_singleton_self _
  exact (le_iSup₂ (f := fun χ (_ : χ ∈ type22) => V χ) hodgeChar hodgeChar_type22) hmem

theorem none_not_mem_type22_map :
    (none : Option Ch) ∉ type22.map Function.Embedding.some := by
  simp

theorem finrank_span_h2 :
    finrank ℂ (Submodule.span ℂ {(1 : ℂ) ⊗ₜ[ℚ] h2Vec}) = 1 := by
  rw [finrank_span_singleton]
  intro h
  exact h2Vec_ne_zero (eq_zero_of_tmul_eq_zero h)

theorem model_griffiths : finrank ℂ modelH22 = 1 + finrank ℚ jacobianDeg12 := by
  have hsup : modelH22 =
      ⨆ o ∈ insert none (type22.map Function.Embedding.some),
        eigenFamily h2Vec V o := by
    rw [modelH22, h22_index]
  rw [hsup, finrank_biSup_of_indep _ eigen_indep, Finset.sum_insert none_not_mem_type22_map,
    Finset.sum_map]
  have hnone : finrank ℂ (eigenFamily h2Vec V none) = 1 := by
    change finrank ℂ (Submodule.span ℂ {(1 : ℂ) ⊗ₜ[ℚ] h2Vec}) = 1
    exact finrank_span_h2
  have hχ : ∀ χ ∈ type22, finrank ℂ (eigenFamily h2Vec V (some χ)) = 1 := by
    intro χ hχ
    change finrank ℂ (V χ) = 1
    exact V_line χ (type22_subset_primChars hχ)
  have hsum : ∀ χ ∈ type22,
      finrank ℂ (eigenFamily h2Vec V (Function.Embedding.some χ)) = 1 := hχ
  rw [hnone, Finset.sum_congr rfl hsum, Finset.sum_const,
    Hodge.ChainSexticBridgeAudit.type22_card]
  have hr12 : finrank ℚ jacobianDeg12 = 1751 :=
    Hodge.ChainSexticR12.jacobianDeg12_finrank_eq
  simp [hr12]

/-! ## The core inhabitant on the compact 27001-dimensional space -/

/-- An explicit inhabitant of `ChainSexticCharacterCore` on `ModelH`.
This is the compact encoding of the full 27001-dimensional space
(`equivDense`, `finrank_modelH`), not a lower-dimensional substitute. -/
def characterCore_model : ChainSexticCharacterCore ModelH where
  H22 := modelH22
  griffiths := model_griffiths
  pairing := modelPairing
  h2 := h2Vec
  P := pVec
  h2_hodge := model_h2_hodge
  P_hodge := model_P_hodge
  h2_h2 := model_h2_h2
  h2_P := model_h2_P
  P_h2 := model_P_h2
  P_P := by
    rw [planeSelfIntersection_eq, model_P_P]
    norm_num
  V := V
  V_out := V_out
  V_line := V_line
  eigen_indep := eigen_indep
  h22_eq := rfl
  W := W
  W_complex := fun r hr => model_W_complex hr
  galois_min := fun r hr hnot => model_galois_min hr hnot

theorem characterCore_model_nonempty :
    Nonempty (ChainSexticCharacterCore ModelH) :=
  ⟨characterCore_model⟩

theorem characterCore_model_finrank : finrank ℚ ModelH = 27001 :=
  finrank_modelH

theorem characterCore_model_equiv_dense :
    Nonempty (ModelH ≃ₗ[ℚ] DenseH) :=
  ⟨equivDense⟩

def characterBridge_model : ChainSexticCharacterBridge ModelH :=
  characterCore_model.toCharacterBridge

theorem characterCore_model_rho : characterCore_model.rho = 786 :=
  characterCore_model.rho_eq_786

/-! ## Transport along the compact-to-dense equivalence

The same inhabitant, pushed forward along `equivDense`, lives on the dense
function space `DenseH := Idx → ℚ`.  This is the required transport of the
bridge hypotheses along the proved linear equivalence; it is not a second,
independent geometric model.
-/

def equivDenseC : ℂ ⊗[ℚ] ModelH ≃ₗ[ℂ] ℂ ⊗[ℚ] DenseH :=
  LinearEquiv.baseChange ℚ ℂ ModelH DenseH equivDense

theorem equivDenseC_tmul (z : ℂ) (v : ModelH) :
    equivDenseC (z ⊗ₜ[ℚ] v) = z ⊗ₜ[ℚ] equivDense v := by
  -- `LinearEquiv.baseChange` is `AlgebraTensorModule.congr` with `refl` on `ℂ`.
  rfl

def mapC (W : Submodule ℂ (ℂ ⊗[ℚ] ModelH)) : Submodule ℂ (ℂ ⊗[ℚ] DenseH) :=
  W.map equivDenseC.toLinearMap

def mapQ (U : Submodule ℚ ModelH) : Submodule ℚ DenseH :=
  U.map equivDense.toLinearMap

def pairingDense : LinearMap.BilinForm ℚ DenseH :=
  modelPairing.compl₁₂ equivDense.symm.toLinearMap equivDense.symm.toLinearMap

theorem mapC_span_tmul (v : ModelH) :
    mapC (Submodule.span ℂ {(1 : ℂ) ⊗ₜ[ℚ] v}) =
      Submodule.span ℂ {(1 : ℂ) ⊗ₜ[ℚ] (equivDense v)} := by
  rw [mapC, Submodule.map_span, Set.image_singleton]
  exact congrArg (fun t => Submodule.span ℂ {t}) (equivDenseC_tmul 1 v)

theorem mapC_iSup {ι : Type*} (s : Finset ι) (f : ι → Submodule ℂ (ℂ ⊗[ℚ] ModelH)) :
    mapC (⨆ i ∈ s, f i) = ⨆ i ∈ s, mapC (f i) := by
  simp only [mapC, Submodule.map_iSup]

theorem mapC_sup (A B : Submodule ℂ (ℂ ⊗[ℚ] ModelH)) :
    mapC (A ⊔ B) = mapC A ⊔ mapC B := by
  simp [mapC, Submodule.map_sup]

theorem mem_rationalPoints_mapC {v : ModelH} {W : Submodule ℂ (ℂ ⊗[ℚ] ModelH)}
    (h : v ∈ rationalPoints W) :
    equivDense v ∈ rationalPoints (mapC W) := by
  rw [mem_rationalPoints] at h ⊢
  have : equivDenseC ((1 : ℂ) ⊗ₜ[ℚ] v) ∈ mapC W :=
    Submodule.mem_map_of_mem h
  rwa [equivDenseC_tmul] at this

-- one_smul might be wrong; tmul of 1. Fix if needed: equivDenseC_tmul already has z=1.

theorem finrank_mapC (W : Submodule ℂ (ℂ ⊗[ℚ] ModelH)) :
    finrank ℂ (mapC W) = finrank ℂ W := by
  rw [mapC, LinearEquiv.finrank_map_eq equivDenseC]

theorem V_out_dense : ∀ χ ∉ primChars, mapC (V χ) = ⊥ := by
  intro χ hχ
  rw [V_out χ hχ, mapC, Submodule.map_bot]

theorem V_line_dense : ∀ χ ∈ primChars, finrank ℂ (mapC (V χ)) = 1 := by
  intro χ hχ
  rw [finrank_mapC, V_line χ hχ]

theorem eigenFamily_map (o : Option Ch) :
    eigenFamily (equivDense h2Vec) (fun χ => mapC (V χ)) o = mapC (eigenFamily h2Vec V o) := by
  cases o with
  | none =>
    simp only [eigenFamily, mapC_span_tmul]
  | some χ =>
    rfl

theorem eigen_indep_dense :
    iSupIndep (eigenFamily (equivDense h2Vec) (fun χ => mapC (V χ))) := by
  intro i
  rw [disjoint_iff]
  simp_rw [eigenFamily_map]
  have himg :
      mapC (eigenFamily h2Vec V i) ⊓
          ⨆ j, ⨆ (_ : j ≠ i), mapC (eigenFamily h2Vec V j) =
        mapC (eigenFamily h2Vec V i ⊓
          ⨆ j, ⨆ (_ : j ≠ i), eigenFamily h2Vec V j) := by
    rw [mapC, mapC]
    rw [Submodule.map_inf equivDenseC.toLinearMap equivDenseC.injective]
    congr 1
    rw [Submodule.map_iSup]
    refine iSup_congr fun j => ?_
    rw [mapC, Submodule.map_iSup]
  rw [himg, (disjoint_iff.mp (eigen_indep i)), mapC, Submodule.map_bot]

theorem W_complex_dense {r : Ch} (hr : r ∈ reps) :
    cx (mapQ (W r)) = ⨆ χ ∈ orbit r, mapC (V χ) := by
  -- cx (U.map equivDense) = (cx U).map equivDenseC
  have hcx : cx (mapQ (W r)) = mapC (cx (W r)) := by
    rw [mapQ, mapC, cx, cx, Submodule.map_span]
    apply congrArg
    ext z
    constructor
    · rintro ⟨_, ⟨v, hv, rfl⟩, rfl⟩
      exact ⟨(1 : ℂ) ⊗ₜ v, ⟨v, hv, rfl⟩, by simp [equivDenseC_tmul]⟩
    · rintro ⟨_, ⟨v, hv, rfl⟩, rfl⟩
      exact ⟨equivDense v, ⟨v, hv, rfl⟩, by simp [equivDenseC_tmul]⟩
  rw [hcx, model_W_complex hr, mapC_iSup]

theorem galois_min_dense : ∀ r ∈ reps, ¬ orbit r ⊆ type22 →
    rationalPoints (⨆ χ ∈ orbit r ∩ type22, mapC (V χ)) = ⊥ := by
  intro r hr hnot
  have h := model_galois_min hr hnot
  have hmap : (⨆ χ ∈ orbit r ∩ type22, mapC (V χ)) =
      mapC (⨆ χ ∈ orbit r ∩ type22, V χ) := by
    exact (mapC_iSup _ _).symm
  apply le_antisymm
  · intro v hv
    rw [mem_rationalPoints, hmap] at hv
    -- v is rational in the image; pull back along equivDense
    have : equivDense.symm v ∈
        rationalPoints (⨆ χ ∈ orbit r ∩ type22, V χ) := by
      rw [mem_rationalPoints]
      have : equivDenseC.symm ((1 : ℂ) ⊗ₜ[ℚ] v) ∈
          ⨆ χ ∈ orbit r ∩ type22, V χ := by
        have hv' : (1 : ℂ) ⊗ₜ[ℚ] v ∈ mapC (⨆ χ ∈ orbit r ∩ type22, V χ) := hv
        obtain ⟨w, hw, hwe⟩ := Submodule.mem_map.mp hv'
        have : equivDenseC.symm ((1 : ℂ) ⊗ₜ[ℚ] v) = w := by
          rw [← hwe]
          exact equivDenseC.symm_apply_apply w
        rwa [this]
      have ht : equivDenseC.symm ((1 : ℂ) ⊗ₜ[ℚ] v) =
          (1 : ℂ) ⊗ₜ[ℚ] equivDense.symm v := by
        apply equivDenseC.injective
        rw [LinearEquiv.apply_symm_apply, equivDenseC_tmul,
          LinearEquiv.apply_symm_apply]
      rwa [ht] at this
    rw [h, Submodule.mem_bot] at this
    rw [Submodule.mem_bot]
    exact (LinearEquiv.map_eq_zero_iff equivDense.symm).mp this
  · exact bot_le

/-- The character core transported to the dense 27001-dimensional space. -/
def characterCore_dense : ChainSexticCharacterCore DenseH where
  H22 := mapC modelH22
  griffiths := by
    rw [finrank_mapC, model_griffiths]
  pairing := pairingDense
  h2 := equivDense h2Vec
  P := equivDense pVec
  h2_hodge := mem_rationalPoints_mapC model_h2_hodge
  P_hodge := mem_rationalPoints_mapC model_P_hodge
  h2_h2 := by
    simp [pairingDense, model_h2_h2]
  h2_P := by
    simp [pairingDense, model_h2_P]
  P_h2 := by
    simp [pairingDense, model_P_h2]
  P_P := by
    rw [planeSelfIntersection_eq]
    simp [pairingDense, model_P_P]
  V := fun χ => mapC (V χ)
  V_out := V_out_dense
  V_line := V_line_dense
  eigen_indep := eigen_indep_dense
  h22_eq := by
    change mapC modelH22 =
      Submodule.span ℂ {(1 : ℂ) ⊗ₜ[ℚ] equivDense h2Vec} ⊔
        ⨆ χ ∈ type22, mapC (V χ)
    rw [modelH22, mapC_sup, mapC_span_tmul, mapC_iSup]
  W := fun r => mapQ (W r)
  W_complex := fun r hr => W_complex_dense hr
  galois_min := galois_min_dense

theorem characterCore_dense_nonempty :
    Nonempty (ChainSexticCharacterCore DenseH) :=
  ⟨characterCore_dense⟩

theorem characterCore_dense_finrank : finrank ℚ DenseH = 27001 :=
  finrank_denseH

theorem characterCore_dense_rho : characterCore_dense.rho = 786 :=
  characterCore_dense.rho_eq_786

end ChainSexticCharacterModel
end Hodge

end
