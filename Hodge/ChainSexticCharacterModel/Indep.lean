/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Hodge.ChainSexticCharacterModel.Lines
import Mathlib.LinearAlgebra.TensorProduct.Basis
import Mathlib.LinearAlgebra.LinearIndependent.Lemmas

/-!
# Independence of the model eigenlines

The generators `gen o` are a triangular change of the Finsupp basis of
`ℂ ⊗ ModelH`.  In particular they are linearly independent, each residual
line is 1-dimensional, and `ℂ·h²` together with the residual lines is an
independent family.

These are linear-algebra facts about the compact 27001-dimensional model,
not geometric facts about the sextic.
-/

open Module TensorProduct Function
open Hodge.ChainSexticRank Hodge.SexticCombinatorics Hodge.ChainSexticRho
open Hodge.ChainSexticCore

noncomputable section

namespace Hodge
namespace ChainSexticCharacterModel

open Classical

/-- The complexification of the compact Finsupp basis. -/
def modelBasisC : Basis Idx ℂ (ℂ ⊗[ℚ] ModelH) :=
  modelBasis.baseChange ℂ

/-- Complex coordinate of index `i`, dual to `modelBasisC`. -/
def coeffC (i : Idx) : (ℂ ⊗[ℚ] ModelH) →ₗ[ℂ] ℂ :=
  modelBasisC.coord i

theorem coeffC_tmul (i : Idx) (z : ℂ) (v : ModelH) :
    coeffC i (z ⊗ₜ v) = coord i v • z := by
  simp [coeffC, modelBasisC, modelBasis, Basis.coord_apply, Basis.baseChange_repr_tmul, coord]

theorem coeffC_one_tmul (i : Idx) (v : ModelH) :
    coeffC i ((1 : ℂ) ⊗ₜ v) = (coord i v : ℂ) := by
  simp [coeffC_tmul]

theorem coeffC_e (i j : Idx) :
    coeffC i ((1 : ℂ) ⊗ₜ e j) = if i = j then (1 : ℂ) else 0 := by
  rw [coeffC_one_tmul, coord_e]
  split_ifs <;> simp

theorem coeffC_gen_none (i : Idx) :
    coeffC i (gen none) = if i = none then (1 : ℂ) else 0 := by
  simp [gen, coeffC_e]

theorem ofCube_twisted_slot_ne {x : Cube} (h : IsTwisted (ofCube x)) :
    charIdx (mixedSlot (ofCube x)) ≠ some x := by
  intro he
  have hχ : IsMixed (ofCube x) := isTwisted_isMixed h
  have hslot : mixedSlot (ofCube x) ∈ range30cube := mixedSlot_in_cube hχ
  have hxeq : toCube hslot = x := by
    have := (charIdx_eq_some hslot).symm.trans he
    exact Option.some.inj this
  have : mixedSlot (ofCube x) = ofCube x :=
    (ofCube_toCube hslot).symm.trans (congrArg ofCube hxeq)
  exact mixedSlot_not_type22 hχ (this.symm ▸ h.1)

theorem coeffC_gen_straight {x : Cube} (h : ¬ IsTwisted (ofCube x)) (i : Idx) :
    coeffC i (gen (some x)) = if i = some x then (1 : ℂ) else 0 := by
  simp [gen, h, coeffC_e]

theorem coeffC_gen_twisted {x : Cube} (h : IsTwisted (ofCube x)) (i : Idx) :
    coeffC i (gen (some x)) =
      if i = some x then (1 : ℂ)
      else if i = charIdx (mixedSlot (ofCube x)) then
        alpha ^ twistedRank (ofCube x)
      else 0 := by
  have hne : some x ≠ charIdx (mixedSlot (ofCube x)) :=
    fun h' => ofCube_twisted_slot_ne h h'.symm
  simp only [gen, if_pos h, map_add, map_smul, smul_eq_mul, coeffC_e]
  by_cases h1 : i = some x
  · subst h1
    simp [hne, add_zero]
  · by_cases h2 : i = charIdx (mixedSlot (ofCube x))
    · subst h2
      simp [h1, mul_one, zero_add]
    · simp [h1, h2]

/-- A slot index is the compact index of the canonical mixed-orbit complement. -/
def IsSlotIdx (i : Idx) : Prop :=
  ∃ χ, IsMixed χ ∧ i = charIdx (mixedSlot χ)

theorem not_isSlotIdx_none : ¬ IsSlotIdx none := by
  rintro ⟨χ, hχ, he⟩
  exact (charIdx_ne_none (mixedSlot_in_cube hχ) he.symm)

theorem isSlotIdx_not_twisted {x : Cube} (h : IsSlotIdx (some x)) :
    ¬ IsTwisted (ofCube x) := by
  rintro ht
  obtain ⟨χ, hχ, he⟩ := h
  have hslot : mixedSlot χ ∈ range30cube := mixedSlot_in_cube hχ
  have hxeq : toCube hslot = x := by
    have := (charIdx_eq_some hslot).symm.trans he.symm
    exact Option.some.inj this
  have : mixedSlot χ = ofCube x :=
    (ofCube_toCube hslot).symm.trans (congrArg ofCube hxeq)
  exact mixedSlot_not_type22 hχ (this.symm ▸ ht.1)

/-- Off a slot index, `gen o` is the standard basis vector at `o`. -/
theorem coeffC_gen_of_not_slot {i o : Idx} (hi : ¬ IsSlotIdx i) :
    coeffC i (gen o) = if i = o then (1 : ℂ) else 0 := by
  match o with
  | none =>
    rw [coeffC_gen_none]
  | some x =>
    by_cases ht : IsTwisted (ofCube x)
    · have hslot : IsSlotIdx (charIdx (mixedSlot (ofCube x))) :=
        ⟨ofCube x, isTwisted_isMixed ht, rfl⟩
      rw [coeffC_gen_twisted ht]
      by_cases h1 : i = some x
      · simp [h1]
      · by_cases h2 : i = charIdx (mixedSlot (ofCube x))
        · exact (hi (h2 ▸ hslot)).elim
        · simp [h1, h2]
    · rw [coeffC_gen_straight ht]

theorem coeffC_gen_sum (c : Idx →₀ ℂ) (i : Idx) :
    coeffC i (c.sum fun o a => a • gen o) =
      ∑ o ∈ c.support, c o * coeffC i (gen o) := by
  simp only [Finsupp.sum]
  rw [map_sum]
  refine Finset.sum_congr rfl fun o _ => ?_
  simp [smul_eq_mul]

theorem coeffC_gen_sum_not_slot (c : Idx →₀ ℂ) {i : Idx} (hi : ¬ IsSlotIdx i) :
    coeffC i (c.sum fun o a => a • gen o) = c i := by
  rw [coeffC_gen_sum]
  have hterm : ∀ o ∈ c.support, c o * coeffC i (gen o) = if o = i then c o else 0 := by
    intro o _
    rw [coeffC_gen_of_not_slot hi]
    by_cases h : i = o
    · simp [h]
    · simp [h, show ¬ o = i from fun n => h n.symm]
  rw [Finset.sum_congr rfl hterm]
  by_cases hin : i ∈ c.support
  · refine (Finset.sum_eq_single_of_mem i hin ?_).trans (if_pos rfl)
    intro o ho hne
    simp [hne]
  · have hi0 : c i = 0 := Finsupp.notMem_support_iff.mp hin
    refine Eq.trans (Finset.sum_eq_zero ?_) hi0.symm
    intro o ho
    have : o ≠ i := fun h => hin (h ▸ ho)
    simp [this]

theorem gen_sum_eq_zero {c : Idx →₀ ℂ}
    (h : c.sum (fun o a => a • gen o) = 0) : c = 0 := by
  ext i
  simp only [Finsupp.coe_zero, Pi.zero_apply]
  have hz : ∀ j, coeffC j (c.sum fun o a => a • gen o) = 0 := by
    intro j; simp [h]
  have hnon : ∀ j, ¬ IsSlotIdx j → c j = 0 := by
    intro j hj
    exact (coeffC_gen_sum_not_slot c hj).symm.trans (hz j)
  by_cases hs : IsSlotIdx i
  · -- After non-slot coefficients vanish, a slot generator is straight.
    have hzi := hz i
    rw [coeffC_gen_sum] at hzi
    have : ∑ o ∈ c.support, c o * coeffC i (gen o) = c i := by
      refine (Finset.sum_eq_single i ?_ ?_).trans ?_
      · intro o ho hne
        match o with
        | none =>
          have : ¬ IsSlotIdx none := not_isSlotIdx_none
          simp [hnon none this]
        | some x =>
          by_cases ht : IsTwisted (ofCube x)
          · have ho' : ¬ IsSlotIdx (some x) := fun hsi =>
              isSlotIdx_not_twisted hsi ht
            simp [hnon _ ho']
          · rw [coeffC_gen_straight ht]
            have : ¬ i = some x := hne.symm
            simp [this]
      · intro hi
        simp [Finsupp.notMem_support_iff.mp hi]
      · match i with
        | none => exact (not_isSlotIdx_none hs).elim
        | some x =>
          have hst : ¬ IsTwisted (ofCube x) := isSlotIdx_not_twisted hs
          simp [coeffC_gen_straight hst]
    exact this.symm.trans hzi
  · exact hnon i hs

theorem V_out : ∀ χ ∉ primChars, V χ = ⊥ := by
  intro χ h
  simp [V, h]

theorem gen_ne_zero (o : Idx) : gen o ≠ 0 := by
  intro h
  have hc := congrArg (coeffC o) h
  match o with
  | none =>
    simp [coeffC_gen_none] at hc
  | some x =>
    by_cases ht : IsTwisted (ofCube x)
    · simp [coeffC_gen_twisted ht] at hc
    · simp [coeffC_gen_straight ht] at hc

theorem V_line : ∀ χ ∈ primChars, finrank ℂ (V χ) = 1 := by
  intro χ hχ
  have : V χ = Submodule.span ℂ {gen (charIdx χ)} := by
    simp [V, hχ]
  rw [this, finrank_span_singleton (gen_ne_zero (charIdx χ))]

theorem gen_linearIndependent : LinearIndependent ℂ gen := by
  refine linearIndependent_iff.mpr fun c hc => ?_
  have : c.sum (fun o a => a • gen o) = 0 := by
    simpa [Finsupp.linearCombination_apply] using hc
  exact gen_sum_eq_zero this

/-- The index in `ModelH` attached to an eigenfamily label. -/
def eigenIdx : Option Ch → Idx
  | none => none
  | some χ => charIdx χ

theorem eigenIdx_inj {o o' : Option Ch}
    (ho : o = none ∨ ∃ χ, o = some χ ∧ χ ∈ primChars)
    (ho' : o' = none ∨ ∃ χ, o' = some χ ∧ χ ∈ primChars)
    (h : eigenIdx o = eigenIdx o') : o = o' := by
  cases o with
  | none =>
    cases o' with
    | none => rfl
    | some χ =>
      rcases ho' with h' | ⟨_, h1, hprim⟩
      · cases h'
      · cases h1
        exact (charIdx_ne_none (mem_primChars.mp hprim).1 h.symm).elim
  | some χ =>
    cases o' with
    | none =>
      rcases ho with h' | ⟨_, h1, hprim⟩
      · cases h'
      · cases h1
        exact (charIdx_ne_none (mem_primChars.mp hprim).1 h).elim
    | some ψ =>
      rcases ho with h' | ⟨_, h1, hχ⟩
      · cases h'
      · cases h1
        rcases ho' with h' | ⟨_, h2, hψ⟩
        · cases h'
        · cases h2
          simp only [eigenIdx] at h
          simp [charIdx_inj_on_cube (mem_primChars.mp hχ).1 (mem_primChars.mp hψ).1 h]

theorem eigenFamily_eq (o : Option Ch) :
    eigenFamily h2Vec V o =
      if o = none ∨ ∃ χ, o = some χ ∧ χ ∈ primChars then
        Submodule.span ℂ {gen (eigenIdx o)}
      else ⊥ := by
  match o with
  | none =>
    simp [eigenFamily, h2Vec, eigenIdx, gen]
  | some χ =>
    by_cases hχ : χ ∈ primChars
    · simp [eigenFamily, V, hχ, eigenIdx]
    · simp [eigenFamily, V, hχ]

theorem eigenFamily_eq_span {o : Option Ch}
    (hop : o = none ∨ ∃ χ, o = some χ ∧ χ ∈ primChars) :
    eigenFamily h2Vec V o = Submodule.span ℂ {gen (eigenIdx o)} := by
  rw [eigenFamily_eq, if_pos hop]

theorem eigenFamily_eq_bot {o : Option Ch}
    (hop : ¬ (o = none ∨ ∃ χ, o = some χ ∧ χ ∈ primChars)) :
    eigenFamily h2Vec V o = ⊥ := by
  rw [eigenFamily_eq, if_neg hop]

theorem eigenFamily_ne_bot_iff (o : Option Ch) :
    eigenFamily h2Vec V o ≠ ⊥ ↔ o = none ∨ ∃ χ, o = some χ ∧ χ ∈ primChars := by
  constructor
  · intro h
    by_contra hop
    exact h (eigenFamily_eq_bot hop)
  · intro hop
    rw [eigenFamily_eq_span hop, ne_eq, Submodule.span_singleton_eq_bot]
    exact gen_ne_zero _

/-- Independence of `ℂ·h²` and the residual eigenlines. -/
theorem eigen_indep : iSupIndep (eigenFamily h2Vec V) := by
  have hspan : iSupIndep (fun i : Idx => Submodule.span ℂ {gen i}) :=
    gen_linearIndependent.iSupIndep_span_singleton
  rw [← iSupIndep_ne_bot]
  let f : {o // eigenFamily h2Vec V o ≠ ⊥} → Idx := fun o => eigenIdx o.val
  have hf : Function.Injective f := by
    intro a b h
    refine Subtype.ext (eigenIdx_inj ?_ ?_ h)
    · exact (eigenFamily_ne_bot_iff a.val).mp a.property
    · exact (eigenFamily_ne_bot_iff b.val).mp b.property
  have hcomp := hspan.comp hf
  have heq : (fun o : {o // eigenFamily h2Vec V o ≠ ⊥} =>
      eigenFamily h2Vec V o.val) =
      (fun i => Submodule.span ℂ {gen i}) ∘ f := by
    funext o
    exact eigenFamily_eq_span ((eigenFamily_ne_bot_iff o.val).mp o.property)
  rwa [heq]

theorem twistedRank_inj {χ ψ : Ch} (hχ : IsTwisted χ) (hψ : IsTwisted ψ)
    (ho : orbit χ = orbit ψ) (hr : twistedRank χ = twistedRank ψ) : χ = ψ := by
  have hcubeχ : χ ∈ range30cube := (mem_primChars.mp (type22_subset_primChars hχ.1)).1
  have hcubeψ : ψ ∈ range30cube := (mem_primChars.mp (type22_subset_primChars hψ.1)).1
  have hle_or : code χ.1 χ.2.1 χ.2.2 ≤ code ψ.1 ψ.2.1 ψ.2.2 ∨
      code ψ.1 ψ.2.1 ψ.2.2 ≤ code χ.1 χ.2.1 χ.2.2 := le_total _ _
  have key : ∀ {a b : Ch}, IsTwisted a → IsTwisted b → orbit a = orbit b →
      code a.1 a.2.1 a.2.2 ≤ code b.1 b.2.1 b.2.2 →
      twistedRank a = twistedRank b → a = b := by
    intro a b ha hb hoab hle hrank
    have hca : a ∈ range30cube := (mem_primChars.mp (type22_subset_primChars ha.1)).1
    have hcb : b ∈ range30cube := (mem_primChars.mp (type22_subset_primChars hb.1)).1
    set Fa := (orbit a ∩ type22).filter
      (fun τ => code τ.1 τ.2.1 τ.2.2 ≤ code a.1 a.2.1 a.2.2)
    set Fb := (orbit b ∩ type22).filter
      (fun τ => code τ.1 τ.2.1 τ.2.2 ≤ code b.1 b.2.1 b.2.2)
    have hsub : Fa ⊆ Fb := by
      intro τ hτ
      have hτ' := Finset.mem_filter.mp hτ
      refine Finset.mem_filter.mpr ⟨?_, le_trans hτ'.2 hle⟩
      simpa [hoab] using hτ'.1
    by_cases heq : a = b
    · exact heq
    · have hbnot : b ∉ Fa := by
        intro hτ
        have : code b.1 b.2.1 b.2.2 ≤ code a.1 a.2.1 a.2.2 :=
          (Finset.mem_filter.mp hτ).2
        exact heq (code_inj hca hcb (le_antisymm hle this))
      have hbmem : b ∈ Fb :=
        Finset.mem_filter.mpr ⟨Finset.mem_inter.mpr ⟨self_mem_orbit hcb, hb.1⟩, le_rfl⟩
      have hss : Fa ⊂ Fb := ⟨hsub, fun hsup => hbnot (hsup hbmem)⟩
      have hlt : Fa.card < Fb.card := Finset.card_lt_card hss
      have hrank' : Fa.card = Fb.card := by
        dsimp [Fa, Fb] at *
        simpa [twistedRank] using hrank
      exact (Nat.ne_of_lt hlt hrank').elim
  rcases hle_or with hle | hle
  · exact key hχ hψ ho hle hr
  · exact (key hψ hχ ho.symm hle hr.symm).symm

theorem isTwisted_of_mem_mixed {r χ : Ch} (hr : r ∈ primChars)
    (hnot : ¬ orbit r ⊆ type22) (hχ : χ ∈ orbit r ∩ type22) : IsTwisted χ := by
  have ⟨hχo, hχ22⟩ := Finset.mem_inter.mp hχ
  have ho : orbit χ = orbit r := orbit_eq_of_mem (mem_primChars.mp hr).1 hχo
  refine ⟨hχ22, ?_⟩
  have : ¬ orbit χ ⊆ type22 := by rwa [ho]
  cases hbool : rationalHodge χ.1 χ.2.1 χ.2.2
  · rfl
  · exact (this ((orbit_subset_type22_iff χ).mpr hbool)).elim

end ChainSexticCharacterModel
end Hodge

end
