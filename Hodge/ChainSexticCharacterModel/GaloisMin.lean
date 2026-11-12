/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Hodge.ChainSexticCharacterModel.Indep
import Mathlib.LinearAlgebra.DFinsupp

/-!
# Galois minimality and descent in the compact model

A mixed Galois orbit's type-`(2,2)` eigenlines are twisted by distinct
powers of `alpha`.  A rational vector in that partial sum would give a
linear dependence among `1, α, …, α^7`, which is impossible.  Hence the
partial sum has no nonzero rational points.

The rational isotypic piece `W r` complexifies to the sum of the
eigenlines of the orbit of `r`.

These are linear-algebra facts about the model, not a geometric Galois
action on the cohomology of the sextic.
-/

open Module TensorProduct
open Hodge.ChainSexticRank Hodge.SexticCombinatorics Hodge.ChainSexticRho
open Hodge.ChainSexticCore

noncomputable section

namespace Hodge
namespace ChainSexticCharacterModel

open Classical

set_option maxHeartbeats 800000
set_option synthInstance.maxHeartbeats 200000

theorem rat_smul_complex (x : ℚ) (z : ℂ) : x • z = (x : ℂ) * z := by
  -- `ℚ` acts on `ℂ` through the algebra map, which is the coercion.
  simp [Algebra.smul_def]

theorem rationalPoints_bot :
    rationalPoints (⊥ : Submodule ℂ (ℂ ⊗[ℚ] ModelH)) = ⊥ := by
  ext v
  simp only [Submodule.mem_bot, mem_rationalPoints]
  constructor
  · intro h
    exact eq_zero_of_tmul_eq_zero h
  · intro h
    rw [h, TensorProduct.tmul_zero]

theorem mixedSlot_eq_rep {r χ : Ch} (hr : IsMixed r) (hχ : χ ∈ orbit r) :
    IsMixed χ ∧ mixedSlot χ = mixedSlot r := by
  have hrprim := hr.1
  have hχprim : χ ∈ primChars := orbit_prim hrprim hχ
  have ho : orbit χ = orbit r :=
    orbit_eq_of_mem (mem_primChars.mp hrprim).1 hχ
  have hmix : IsMixed χ := by
    refine ⟨hχprim, ?_⟩
    have : ¬ orbit χ ⊆ type22 := by
      rw [ho, orbit_subset_type22_iff]
      intro ht
      exact Bool.false_ne_true (hr.2.symm.trans ht)
    cases hbool : rationalHodge χ.1 χ.2.1 χ.2.2
    · rfl
    · exact (this ((orbit_subset_type22_iff χ).mpr hbool)).elim
  exact ⟨hmix, mixedSlot_eq_of_orbit hmix hr ho⟩

theorem not_isSlotIdx_type22 {χ : Ch} (hχ : χ ∈ type22) :
    ¬ IsSlotIdx (charIdx χ) := by
  rintro ⟨ψ, hψ, he⟩
  have hcube : χ ∈ range30cube :=
    (mem_primChars.mp (type22_subset_primChars hχ)).1
  have hslot : mixedSlot ψ ∈ range30cube := mixedSlot_in_cube hψ
  have : mixedSlot ψ = χ := charIdx_inj_on_cube hslot hcube he.symm
  exact mixedSlot_not_type22 hψ (this ▸ hχ)

theorem gen_charIdx {χ : Ch} (hχ : χ ∈ range30cube) :
    gen (charIdx χ) =
      if IsTwisted χ then
        (1 : ℂ) ⊗ₜ e (charIdx χ) +
          (alpha ^ twistedRank χ) • ((1 : ℂ) ⊗ₜ e (charIdx (mixedSlot χ)))
      else
        (1 : ℂ) ⊗ₜ e (charIdx χ) := by
  rw [charIdx_eq_some hχ]
  dsimp only [gen]
  rw [ofCube_toCube hχ]

theorem biSup_span_singleton {ι : Type*} (s : Finset ι) (f : ι → ℂ ⊗[ℚ] ModelH) :
    (⨆ i ∈ s, Submodule.span ℂ {f i}) = Submodule.span ℂ (f '' (s : Set ι)) := by
  induction s using Finset.induction_on with
  | empty =>
    simp
  | insert a s ha ih =>
    rw [Finset.iSup_insert, Finset.coe_insert, Set.image_insert_eq, ih]
    exact (Submodule.span_insert _ _).symm


/-- Reindex a combination `∑ q_χ α^{rank χ}` by the exponent in `Fin 8`.
The rank is an abstract function so this proof never unfolds `twistedRank`. -/
theorem sum_filter_by_nat {S : Finset Ch} (rank : Ch → ℕ) (q : Ch → ℚ)
    (hbound : ∀ χ ∈ S, rank χ < 8) :
    ∑ k : Fin 8,
        (∑ χ ∈ S, if rank χ = (k : ℕ) then q χ else (0 : ℚ)) •
          alpha ^ (k : ℕ) =
      ∑ χ ∈ S, q χ • alpha ^ rank χ := by
  have hstep :
      ∑ k : Fin 8,
          (∑ χ ∈ S, if rank χ = (k : ℕ) then q χ else (0 : ℚ)) •
            alpha ^ (k : ℕ) =
        ∑ k : Fin 8, ∑ χ ∈ S,
          (if rank χ = (k : ℕ) then q χ else (0 : ℚ)) •
            alpha ^ (k : ℕ) := by
    refine Finset.sum_congr rfl fun k _ => ?_
    exact Finset.sum_smul
      (s := S)
      (f := fun χ => if rank χ = (k : ℕ) then q χ else (0 : ℚ))
      (x := alpha ^ (k : ℕ))
  rw [hstep, Finset.sum_comm]
  refine Finset.sum_congr rfl fun χ hχ => ?_
  let n : ℕ := rank χ
  have hrk : n < 8 := hbound χ hχ
  let kχ : Fin 8 := ⟨n, hrk⟩
  have hkval : (kχ : ℕ) = n := rfl
  -- The goal still mentions `rank χ`; replace it by `n` with a definitional unfold of the let.
  change ∑ k : Fin 8,
      (if n = (k : ℕ) then q χ else (0 : ℚ)) • alpha ^ (k : ℕ) =
    q χ • alpha ^ n
  refine (Finset.sum_eq_single kχ ?_ ?_).trans ?_
  · intro k _ hk
    have hne : n ≠ (k : ℕ) := by
      intro he
      exact hk (Fin.val_injective (he.symm.trans hkval.symm))
    rw [if_neg hne]
    exact zero_smul ℚ (alpha ^ (k : ℕ))
  · intro hk
    exact (hk (Finset.mem_univ kχ)).elim
  · rw [hkval, if_pos rfl]

theorem sum_twisted_by_rank {S : Finset Ch} (q : Ch → ℚ)
    (htw : ∀ χ ∈ S, IsTwisted χ) :
    ∑ k : Fin 8,
        (∑ χ ∈ S, if twistedRank χ = (k : ℕ) then q χ else 0) •
          alpha ^ (k : ℕ) =
      ∑ χ ∈ S, q χ • alpha ^ twistedRank χ :=
  sum_filter_by_nat (rank := twistedRank) q fun χ hχ =>
    twistedRank_lt_eight (htw χ hχ)

theorem sum_if_zero_pow (qS : ℚ) :
    ∑ k : Fin 8, (if (k : ℕ) = 0 then -qS else 0) • alpha ^ (k : ℕ) =
      (-qS) • (1 : ℂ) := by
  refine (Finset.sum_eq_single (0 : Fin 8) ?_ ?_).trans ?_
  · intro k _ hk
    have : (k : ℕ) ≠ 0 := fun hkval => hk (Fin.ext hkval)
    rw [if_neg this, zero_smul]
  · intro hk
    exact (hk (Finset.mem_univ (0 : Fin 8))).elim
  · have hz : ((0 : Fin 8) : ℕ) = 0 := rfl
    rw [hz, if_pos rfl, pow_zero]

/-- For a mixed orbit, the type-`(2,2)` part of the eigenline sum has no
rational points. -/
theorem model_galois_min {r : Ch} (hr : r ∈ reps)
    (hnot : ¬ orbit r ⊆ type22) :
    rationalPoints (⨆ χ ∈ orbit r ∩ type22, V χ) = ⊥ := by
  set S := orbit r ∩ type22
  by_cases hS : S = ∅
  · rw [hS]
    simp [rationalPoints_bot]
  have hrprim : r ∈ primChars := (mem_reps.mp hr).1
  have hrmix : IsMixed r := by
    refine ⟨hrprim, ?_⟩
    cases hbool : rationalHodge r.1 r.2.1 r.2.2
    · rfl
    · exact (hnot ((orbit_subset_type22_iff r).mpr hbool)).elim
  have htw : ∀ χ ∈ S, IsTwisted χ := fun χ hχ =>
    isTwisted_of_mem_mixed hrprim hnot hχ
  have hV : (⨆ χ ∈ S, V χ) =
      ⨆ χ ∈ S, Submodule.span ℂ {gen (charIdx χ)} := by
    refine iSup_congr fun χ => iSup_congr fun hχ => ?_
    have hprim : χ ∈ primChars :=
      type22_subset_primChars (Finset.mem_inter.mp hχ).2
    simp [V, hprim]
  have huniq : ∀ {χ ψ : Ch}, χ ∈ S → ψ ∈ S →
      twistedRank χ = twistedRank ψ → χ = ψ := by
    intro χ ψ hχ hψ hrank
    have hoχ : orbit χ = orbit r :=
      orbit_eq_of_mem (mem_primChars.mp hrprim).1 (Finset.mem_inter.mp hχ).1
    have hoψ : orbit ψ = orbit r :=
      orbit_eq_of_mem (mem_primChars.mp hrprim).1 (Finset.mem_inter.mp hψ).1
    exact twistedRank_inj (htw χ hχ) (htw ψ hψ) (hoχ.trans hoψ.symm) hrank
  apply le_antisymm
  · intro v hv
    rw [mem_rationalPoints] at hv
    rw [hV] at hv
    obtain ⟨μ, hμ⟩ :=
      (Submodule.mem_iSup_finset_iff_exists_sum
        (fun χ => Submodule.span ℂ {gen (charIdx χ)}) ((1 : ℂ) ⊗ₜ[ℚ] v)).mp hv
    let a : Ch → ℂ := fun χ =>
      (Submodule.mem_span_singleton.mp (μ χ).2).choose
    have ha : ∀ χ, (μ χ : ℂ ⊗[ℚ] ModelH) = a χ • gen (charIdx χ) :=
      fun χ => (Submodule.mem_span_singleton.mp (μ χ).2).choose_spec.symm
    have hsum : ∑ χ ∈ S, a χ • gen (charIdx χ) = (1 : ℂ) ⊗ₜ[ℚ] v := by
      rw [← hμ]
      refine Finset.sum_congr rfl fun χ _ => (ha χ).symm
    have haQ : ∀ χ ∈ S, a χ = (coord (charIdx χ) v : ℂ) := by
      intro χ hχ
      have hi : ¬ IsSlotIdx (charIdx χ) :=
        not_isSlotIdx_type22 (Finset.mem_inter.mp hχ).2
      have hcoeff : coeffC (charIdx χ) ((1 : ℂ) ⊗ₜ[ℚ] v) =
          ∑ ψ ∈ S, a ψ * coeffC (charIdx χ) (gen (charIdx ψ)) := by
        rw [← hsum, map_sum]
        refine Finset.sum_congr rfl fun ψ _ => ?_
        simp [smul_eq_mul]
      have hterm : ∀ ψ ∈ S,
          a ψ * coeffC (charIdx χ) (gen (charIdx ψ)) =
            if ψ = χ then a χ else 0 := by
        intro ψ hψ
        rw [coeffC_gen_of_not_slot hi]
        by_cases hidx : charIdx χ = charIdx ψ
        · have hχcube : χ ∈ range30cube :=
            (mem_primChars.mp (type22_subset_primChars
              (Finset.mem_inter.mp hχ).2)).1
          have hψcube : ψ ∈ range30cube :=
            (mem_primChars.mp (type22_subset_primChars
              (Finset.mem_inter.mp hψ).2)).1
          have heq : ψ = χ :=
            charIdx_inj_on_cube hψcube hχcube hidx.symm
          simp [heq]
        · have hne : ψ ≠ χ := fun h => hidx (congrArg charIdx h).symm
          simp [hidx, hne]
      have hcoeff' : coeffC (charIdx χ) ((1 : ℂ) ⊗ₜ[ℚ] v) = a χ := by
        rw [hcoeff, Finset.sum_congr rfl hterm]
        refine (Finset.sum_eq_single_of_mem χ hχ ?_).trans (if_pos rfl)
        intro ψ _ hne
        exact if_neg hne
      rw [coeffC_one_tmul] at hcoeff'
      exact hcoeff'.symm
    let q : Ch → ℚ := fun χ => coord (charIdx χ) v
    let qS : ℚ := coord (charIdx (mixedSlot r)) v
    have hslotC : coeffC (charIdx (mixedSlot r)) ((1 : ℂ) ⊗ₜ[ℚ] v) = (qS : ℂ) :=
      coeffC_one_tmul _ _
    have hslotSum :
        coeffC (charIdx (mixedSlot r)) ((1 : ℂ) ⊗ₜ[ℚ] v) =
          ∑ χ ∈ S, a χ * alpha ^ twistedRank χ := by
      rw [← hsum, map_sum]
      refine Finset.sum_congr rfl fun χ hχ => ?_
      -- `coeffC` is linear, so the scalar comes out as a product.
      have hmul : coeffC (charIdx (mixedSlot r)) (a χ • gen (charIdx χ)) =
          a χ * coeffC (charIdx (mixedSlot r)) (gen (charIdx χ)) := by
        simp [smul_eq_mul]
      rw [hmul]
      have ht := htw χ hχ
      have hcube : χ ∈ range30cube :=
        (mem_primChars.mp (type22_subset_primChars ht.1)).1
      have hx : charIdx χ = some (toCube hcube) := charIdx_eq_some hcube
      have hof : ofCube (toCube hcube) = χ := ofCube_toCube hcube
      have ht' : IsTwisted (ofCube (toCube hcube)) := by rwa [hof]
      rw [hx, coeffC_gen_twisted ht']
      have hne : charIdx (mixedSlot r) ≠ some (toCube hcube) := by
        intro he
        have : mixedSlot r = χ := by
          have hslot : mixedSlot r ∈ range30cube := mixedSlot_in_cube hrmix
          have := (charIdx_eq_some hslot).symm.trans he
          exact (ofCube_toCube hslot).symm.trans
            ((congrArg ofCube (Option.some.inj this)).trans hof)
        exact mixedSlot_not_type22 hrmix
          (this.symm ▸ (Finset.mem_inter.mp hχ).2)
      have hslots : mixedSlot χ = mixedSlot r :=
        (mixedSlot_eq_rep hrmix (Finset.mem_inter.mp hχ).1).2
      rw [if_neg hne]
      have hslotidx :
          charIdx (mixedSlot r) =
            charIdx (mixedSlot (ofCube (toCube hcube))) := by
        rw [hof, hslots]
      rw [if_pos hslotidx, hof]
    have hcomb : ∑ χ ∈ S, q χ • alpha ^ twistedRank χ + (-qS) • (1 : ℂ) = 0 := by
      have hcast : ∑ χ ∈ S, q χ • alpha ^ twistedRank χ =
          ∑ χ ∈ S, a χ * alpha ^ twistedRank χ := by
        refine Finset.sum_congr rfl fun χ hχ => ?_
        rw [rat_smul_complex, haQ χ hχ]
      rw [hcast, rat_smul_complex, mul_one, ← hslotSum, hslotC, Rat.cast_neg,
        add_neg_cancel]
    let d : Fin 8 → ℚ := fun k =>
      (∑ χ ∈ S, if twistedRank χ = (k : ℕ) then q χ else 0) +
        if (k : ℕ) = 0 then -qS else 0
    have hd : ∑ k : Fin 8, d k • alpha ^ (k : ℕ) = 0 := by
      have hsplit :
          ∑ k : Fin 8, d k • alpha ^ (k : ℕ) =
            (∑ k : Fin 8,
              (∑ χ ∈ S, if twistedRank χ = (k : ℕ) then q χ else 0) •
                alpha ^ (k : ℕ)) +
            ∑ k : Fin 8,
              (if (k : ℕ) = 0 then -qS else 0) • alpha ^ (k : ℕ) := by
        simp only [d, add_smul, Finset.sum_add_distrib]
      have hinter := sum_twisted_by_rank (S := S) q htw
      have hzero := sum_if_zero_pow qS
      rw [hsplit, hinter, hzero, hcomb]
    have hd0 : ∀ k, d k = 0 := alpha_pow_eq_zero hd
    have hqS : qS = 0 := by
      have h := hd0 0
      have hsum0 : (∑ χ ∈ S, if twistedRank χ = 0 then q χ else 0) = 0 := by
        refine Finset.sum_eq_zero fun χ hχ => ?_
        have hne : twistedRank χ ≠ 0 := (twistedRank_pos (htw χ hχ)).ne'
        exact if_neg hne
      have heq : d 0 =
          (∑ χ ∈ S, if twistedRank χ = (0 : ℕ) then q χ else 0) + (-qS) := rfl
      rw [heq, hsum0, zero_add] at h
      exact neg_eq_zero.mp h
    have hq : ∀ χ ∈ S, q χ = 0 := by
      intro χ hχ
      have hrk : twistedRank χ < 8 := twistedRank_lt_eight (htw χ hχ)
      have h := hd0 ⟨twistedRank χ, hrk⟩
      have hsumχ :
          (∑ ψ ∈ S,
            if twistedRank ψ = twistedRank χ then q ψ else 0) = q χ := by
        refine (Finset.sum_eq_single χ ?_ ?_).trans (if_pos rfl)
        · intro ψ hψ hne
          have : twistedRank ψ ≠ twistedRank χ := fun he => hne (huniq hψ hχ he)
          exact if_neg this
        · exact fun hnot => (hnot hχ).elim
      have hpos : twistedRank χ ≠ 0 := (twistedRank_pos (htw χ hχ)).ne'
      have hkval : ((⟨twistedRank χ, hrk⟩ : Fin 8) : ℕ) = twistedRank χ := rfl
      have hif : (if ((⟨twistedRank χ, hrk⟩ : Fin 8) : ℕ) = 0 then -qS else 0) = 0 :=
        if_neg hpos
      have heq : d ⟨twistedRank χ, hrk⟩ =
          (∑ ψ ∈ S, if twistedRank ψ = twistedRank χ then q ψ else 0) + 0 := by
        change (∑ ψ ∈ S,
            if twistedRank ψ = ((⟨twistedRank χ, hrk⟩ : Fin 8) : ℕ)
              then q ψ else 0) +
            (if ((⟨twistedRank χ, hrk⟩ : Fin 8) : ℕ) = 0 then -qS else 0) =
          (∑ ψ ∈ S, if twistedRank ψ = twistedRank χ then q ψ else 0) + 0
        rw [hkval, hif]
      rw [heq, hsumχ, add_zero] at h
      exact h
    have : (1 : ℂ) ⊗ₜ[ℚ] v = 0 := by
      rw [← hsum]
      refine Finset.sum_eq_zero fun χ hχ => ?_
      have ha0 : a χ = 0 := by
        have : q χ = 0 := hq χ hχ
        rw [haQ χ hχ]
        change (q χ : ℂ) = 0
        rw [this, Rat.cast_zero]
      rw [ha0, zero_smul]
    have hv0 : v = 0 := eq_zero_of_tmul_eq_zero this
    rwa [Submodule.mem_bot]
  · exact bot_le

theorem gen_mem_span_e {r χ : Ch} (hr : r ∈ primChars) (hχ : χ ∈ orbit r) :
    gen (charIdx χ) ∈
      Submodule.span ℂ
        ((TensorProduct.mk ℚ ℂ ModelH 1) ''
          ((fun ψ => e (charIdx ψ)) '' (orbit r : Set Ch))) := by
  have hcube : χ ∈ range30cube :=
    (mem_primChars.mp (orbit_prim hr hχ)).1
  have hself :
      (1 : ℂ) ⊗ₜ e (charIdx χ) ∈
        Submodule.span ℂ
          ((TensorProduct.mk ℚ ℂ ModelH 1) ''
            ((fun ψ => e (charIdx ψ)) '' (orbit r : Set Ch))) :=
    Submodule.subset_span ⟨e (charIdx χ), ⟨χ, hχ, rfl⟩, rfl⟩
  rw [gen_charIdx hcube]
  split_ifs with ht
  · have hslot : mixedSlot χ ∈ orbit r := by
      have ho : orbit χ = orbit r :=
        orbit_eq_of_mem (mem_primChars.mp hr).1 hχ
      rw [← ho]
      exact mixedSlot_mem_orbit (isTwisted_isMixed ht)
    have hslotT :
        (1 : ℂ) ⊗ₜ e (charIdx (mixedSlot χ)) ∈
          Submodule.span ℂ
            ((TensorProduct.mk ℚ ℂ ModelH 1) ''
              ((fun ψ => e (charIdx ψ)) '' (orbit r : Set Ch))) :=
      Submodule.subset_span ⟨e (charIdx (mixedSlot χ)), ⟨mixedSlot χ, hslot, rfl⟩, rfl⟩
    exact Submodule.add_mem _ hself (Submodule.smul_mem _ _ hslotT)
  · exact hself

theorem one_tmul_e_mem_span_gen {r χ : Ch} (hr : r ∈ primChars)
    (hχ : χ ∈ orbit r) :
    (1 : ℂ) ⊗ₜ e (charIdx χ) ∈
      Submodule.span ℂ ((fun ψ => gen (charIdx ψ)) '' (orbit r : Set Ch)) := by
  have hcube : χ ∈ range30cube :=
    (mem_primChars.mp (orbit_prim hr hχ)).1
  by_cases ht : IsTwisted χ
  · have hgen : gen (charIdx χ) ∈
        Submodule.span ℂ ((fun ψ => gen (charIdx ψ)) '' (orbit r : Set Ch)) :=
      Submodule.subset_span ⟨χ, hχ, rfl⟩
    have ho : orbit χ = orbit r :=
      orbit_eq_of_mem (mem_primChars.mp hr).1 hχ
    have hmix : IsMixed χ := isTwisted_isMixed ht
    have hslot : mixedSlot χ ∈ orbit r := by
      rw [← ho]
      exact mixedSlot_mem_orbit hmix
    have hslotN : ¬ IsTwisted (mixedSlot χ) := by
      intro ht'
      exact mixedSlot_not_type22 hmix ht'.1
    have hslotG : gen (charIdx (mixedSlot χ)) =
        (1 : ℂ) ⊗ₜ e (charIdx (mixedSlot χ)) := by
      rw [gen_charIdx (mixedSlot_in_cube hmix), if_neg hslotN]
    have hslotMem : (1 : ℂ) ⊗ₜ e (charIdx (mixedSlot χ)) ∈
        Submodule.span ℂ ((fun ψ => gen (charIdx ψ)) '' (orbit r : Set Ch)) := by
      rw [← hslotG]
      exact Submodule.subset_span ⟨mixedSlot χ, hslot, rfl⟩
    have hgenEq : gen (charIdx χ) =
        (1 : ℂ) ⊗ₜ e (charIdx χ) +
          (alpha ^ twistedRank χ) • ((1 : ℂ) ⊗ₜ e (charIdx (mixedSlot χ))) := by
      rw [gen_charIdx hcube, if_pos ht]
    have : (1 : ℂ) ⊗ₜ e (charIdx χ) =
        gen (charIdx χ) -
          (alpha ^ twistedRank χ) • ((1 : ℂ) ⊗ₜ e (charIdx (mixedSlot χ))) := by
      rw [hgenEq]
      abel
    rw [this]
    exact Submodule.sub_mem _ hgen (Submodule.smul_mem _ _ hslotMem)
  · have : gen (charIdx χ) = (1 : ℂ) ⊗ₜ e (charIdx χ) := by
      rw [gen_charIdx hcube, if_neg ht]
    rw [← this]
    exact Submodule.subset_span ⟨χ, hχ, rfl⟩

/-- Galois descent in the model: the complexification of `W r` is the
sum of the residual lines of the orbit. -/
theorem model_W_complex {r : Ch} (hr : r ∈ reps) :
    cx (W r) = ⨆ χ ∈ orbit r, V χ := by
  have hrprim : r ∈ primChars := (mem_reps.mp hr).1
  have horbit : orbit r ⊆ primChars := orbit_prim hrprim
  have hV : (⨆ χ ∈ orbit r, V χ) =
      ⨆ χ ∈ orbit r, Submodule.span ℂ {gen (charIdx χ)} := by
    refine iSup_congr fun χ => iSup_congr fun hχ => ?_
    simp [V, horbit hχ]
  rw [W, cx_span, hV, biSup_span_singleton]
  apply le_antisymm
  · rw [Submodule.span_le]
    rintro _ ⟨v, ⟨χ, hχ, rfl⟩, rfl⟩
    exact one_tmul_e_mem_span_gen hrprim hχ
  · rw [Submodule.span_le]
    rintro _ ⟨χ, hχ, rfl⟩
    exact gen_mem_span_e hrprim hχ

end ChainSexticCharacterModel
end Hodge

end
