/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Hodge.ChainSexticR12Bridge

/-!
# Shrinking the chain-sextic character bridge

`Hodge.ChainSexticRho.ChainSexticCharacterBridge` assumes nine facts about
`X = V(x0^5x3 + x3^6 + x1^5x4 + x4^6 + x2^5x5 + x5^6) ⊂ P^5`. Two of them are not geometric
inputs at all: they are consequences of the others plus finite combinatorics.

* `hdg_split` (`Hdg²` splits along `ℚ·h²` and the rational isotypic pieces) is **proved** here
  from `h22_eq`, `eigen_indep`, `W_complex` and two kernel-checked facts about the Galois orbits
  (they cover the primitive characters and are pairwise disjoint). No hypothesis replaces it.
* `orbit_simple` (`Hdg² ∩ W_O` is `0` or `W_O`) is **proved** from one smaller statement that
  mentions only the eigenlines, not `H^{2,2}` or `Hdg²`:
  `galois_min`: for a Galois orbit `O` that is *not* entirely of type `(2,2)`, the sum
  `⊕_{χ ∈ O, q χ = 2} V_χ` contains no nonzero rational vector.
* `galois_min` is in turn **proved** (`galois_min_of_conj`) from the Galois-conjugation property
  of the eigenlines: for each `t ∈ (ℤ/30)ˣ` there is a field automorphism `σ` of `ℂ` with
  `(σ ⊗ id)(V_χ) ⊆ V_{tχ}`.

`ChainSexticCharacterCore` is the bridge with `hdg_split` and `orbit_simple` replaced by
`galois_min`. `ChainSexticCharacterCore.toCharacterBridge` rebuilds the old bridge from it, so
`rho_eq_786` holds for the smaller hypothesis set. `ChainSexticCharacterGalois` replaces
`galois_min` by the Galois-conjugation property.

Nothing here is cohomology of `X`. The remaining fields are still hypotheses; see
`docs/CHAIN_SEXTIC_BRIDGE_TABLE.md`.
-/

open Module TensorProduct
open Hodge.ChainSexticRank Hodge.SexticCombinatorics Hodge.ChainSexticRho

namespace Hodge
namespace ChainSexticCore

/-! ## 1. The Galois action on characters is a group action (arithmetic and kernel checks) -/

theorem units_mul_mem : ∀ s ∈ units30, ∀ t ∈ units30, s * t % 30 ∈ units30 := by decide

theorem units_inv : ∀ t ∈ units30, ∃ s ∈ units30, s * t % 30 = 1 := by decide

theorem one_mem_units : 1 ∈ units30 := by decide

theorem mul_mod_assoc30 (s t c : ℕ) : s * (t * c % 30) % 30 = (s * t % 30) * c % 30 := by
  have h1 : s * (t * c % 30) % 30 = s * t * c % 30 := by
    rw [Nat.mul_mod s (t * c % 30) 30, Nat.mod_mod, ← Nat.mul_mod s (t * c) 30, mul_assoc]
  have h2 : (s * t % 30) * c % 30 = s * t * c % 30 := by
    rw [Nat.mul_mod (s * t % 30) c 30, Nat.mod_mod, ← Nat.mul_mod (s * t) c 30]
  rw [h1, h2]

/-- `act s ∘ act t = act (s t mod 30)`. -/
theorem act_act (s t : ℕ) (c : Ch) : act s (act t c) = act (s * t % 30) c := by
  obtain ⟨i, j, k⟩ := c
  simp only [act, mul_mod_assoc30]

theorem act_one {c : Ch} (hc : c ∈ range30cube) : act 1 c = c := by
  obtain ⟨i, j, k⟩ := c
  simp only [range30cube, Finset.mem_product, Finset.mem_range] at hc
  simp only [act, one_mul, Nat.mod_eq_of_lt hc.1, Nat.mod_eq_of_lt hc.2.1, Nat.mod_eq_of_lt hc.2.2]

/-- `act t` is injective on the cube for a unit `t`. -/
theorem act_injOn {t : ℕ} (ht : t ∈ units30) {c d : Ch} (hc : c ∈ range30cube)
    (hd : d ∈ range30cube) (h : act t c = act t d) : c = d := by
  obtain ⟨s, -, hs⟩ := units_inv t ht
  have := congrArg (act s) h
  rwa [act_act, act_act, hs, act_one hc, act_one hd] at this

theorem orbit_subset_cube (c : Ch) : orbit c ⊆ range30cube := by
  intro χ hχ
  obtain ⟨t, -, rfl⟩ := mem_orbit.mp hχ
  exact act_mem_cube t c

theorem self_mem_orbit {c : Ch} (hc : c ∈ range30cube) : c ∈ orbit c :=
  mem_orbit.mpr ⟨1, one_mem_units, act_one hc⟩

theorem act_mem_orbit {t : ℕ} (ht : t ∈ units30) {c χ : Ch} (hχ : χ ∈ orbit c) :
    act t χ ∈ orbit c := by
  obtain ⟨s, hs, rfl⟩ := mem_orbit.mp hχ
  exact mem_orbit.mpr ⟨t * s % 30, units_mul_mem t ht s hs, (act_act t s c).symm⟩

/-- Orbits are equal as soon as they meet in the right way: `χ ∈ orbit c → orbit χ = orbit c`. -/
theorem orbit_eq_of_mem {c χ : Ch} (hc : c ∈ range30cube) (hχ : χ ∈ orbit c) :
    orbit χ = orbit c := by
  ext ψ
  constructor
  · intro hψ
    obtain ⟨s, hs, rfl⟩ := mem_orbit.mp hψ
    exact act_mem_orbit hs hχ
  · intro hψ
    obtain ⟨t, ht, rfl⟩ := mem_orbit.mp hχ
    obtain ⟨u, hu, hut⟩ := units_inv t ht
    have hback : act u (act t c) = c := by rw [act_act, hut, act_one hc]
    obtain ⟨s, hs, rfl⟩ := mem_orbit.mp hψ
    refine mem_orbit.mpr ⟨s * u % 30, units_mul_mem s hs u hu, ?_⟩
    rw [← act_act, hback]

theorem code_inj {c d : Ch} (hc : c ∈ range30cube) (hd : d ∈ range30cube)
    (h : code c.1 c.2.1 c.2.2 = code d.1 d.2.1 d.2.2) : c = d := by
  obtain ⟨i, j, k⟩ := c
  obtain ⟨i', j', k'⟩ := d
  simp only [range30cube, Finset.mem_product, Finset.mem_range] at hc hd
  simp only [code] at h
  have h1 : i = i' := by omega
  have h2 : j = j' := by omega
  have h3 : k = k' := by omega
  subst h1 h2 h3; rfl

theorem rep_le {r : Ch} (hr : r ∈ reps) {t : ℕ} (ht : t ∈ units30) :
    code r.1 r.2.1 r.2.2 ≤ code (act t r).1 (act t r).2.1 (act t r).2.2 := by
  have h := (mem_reps.mp hr).2
  unfold isRep at h
  rw [List.all_eq_true] at h
  exact of_decide_eq_true (h t ht)

/-- Orbits of distinct representatives are disjoint. -/
theorem reps_eq_of_mem_orbit {r r' χ : Ch} (hr : r ∈ reps) (hr' : r' ∈ reps)
    (h : χ ∈ orbit r) (h' : χ ∈ orbit r') : r = r' := by
  have hrc := (mem_primChars.mp (mem_reps.mp hr).1).1
  have hrc' := (mem_primChars.mp (mem_reps.mp hr').1).1
  have e : orbit r = orbit r' := (orbit_eq_of_mem hrc h).symm.trans (orbit_eq_of_mem hrc' h')
  have h1 : r' ∈ orbit r := e ▸ self_mem_orbit hrc'
  have h2 : r ∈ orbit r' := e ▸ self_mem_orbit hrc
  obtain ⟨t, ht, rfl⟩ := mem_orbit.mp h1
  obtain ⟨s, hs, hsr⟩ := mem_orbit.mp h2
  apply code_inj hrc (act_mem_cube t r)
  apply le_antisymm (rep_le hr ht)
  calc code (act t r).1 (act t r).2.1 (act t r).2.2
      ≤ code (act s (act t r)).1 (act s (act t r)).2.1 (act s (act t r)).2.2 := rep_le hr' hs
    _ = code r.1 r.2.1 r.2.2 := by rw [hsr]

/-- Kernel check: every primitive character lies in the orbit of a primitive representative. -/
theorem coverCheck : cubeAll (fun i j k => qv i j k == 99 ||
    units30.any fun t => (qv (t * i % 30) (t * j % 30) (t * k % 30) != 99 &&
      isRep (t * i % 30) (t * j % 30) (t * k % 30) &&
      units30.any fun s => (s * (t * i % 30) % 30 == i && s * (t * j % 30) % 30 == j &&
        s * (t * k % 30) % 30 == k))) = true := by
  decide +kernel

/-- The orbits of the representatives cover the primitive characters. -/
theorem mem_orbit_rep {χ : Ch} (hχ : χ ∈ primChars) : ∃ r ∈ reps, χ ∈ orbit r := by
  obtain ⟨hcube, hq⟩ := mem_primChars.mp hχ
  have h := cubeAll_spec coverCheck χ hcube
  have hq' : (qv χ.1 χ.2.1 χ.2.2 == 99) = false := by simpa using hq
  rw [hq', Bool.false_or] at h
  simp only [List.any_eq_true, Bool.and_eq_true, bne_iff_ne, ne_eq, beq_iff_eq] at h
  obtain ⟨t, ht, ⟨hq2, hrep⟩, s, hs, ⟨e1, e2⟩, e3⟩ := h
  refine ⟨act t χ, mem_reps.mpr ⟨mem_primChars.mpr ⟨act_mem_cube t χ, hq2⟩, hrep⟩,
    mem_orbit.mpr ⟨s, hs, ?_⟩⟩
  obtain ⟨i, j, k⟩ := χ
  simp only [act] at e1 e2 e3 ⊢
  rw [e1, e2, e3]

theorem primChars_subset_biUnion : primChars ⊆ reps.biUnion orbit := by
  intro χ hχ
  obtain ⟨r, hr, h⟩ := mem_orbit_rep hχ
  exact Finset.mem_biUnion.mpr ⟨r, hr, h⟩

theorem type22_subset_primChars : type22 ⊆ primChars := fun _ h => (mem_type22.mp h).1

/-! ## 2. Lattice lemmas for an independent family -/

section Lattice
variable {K M ι : Type*} [Field K] [AddCommGroup M] [Module K M] [DecidableEq ι]

theorem disjoint_biSup_of_disjoint {E : ι → Submodule K M} (hE : iSupIndep E) (t : Finset ι) :
    ∀ s : Finset ι, Disjoint s t → Disjoint (⨆ i ∈ s, E i) (⨆ i ∈ t, E i) := by
  intro s
  induction s using Finset.induction_on with
  | empty => intro _; simp
  | insert a s ha ih =>
    intro hst
    rw [Finset.disjoint_insert_left] at hst
    rw [Finset.iSup_insert]
    apply Disjoint.disjoint_sup_left_of_disjoint_sup_right (ih hst.2)
    rw [← Finset.iSup_union]
    have hx : a ∉ ((s ∪ t : Finset ι) : Set ι) := by
      simp only [Finset.coe_union, Set.mem_union, Finset.mem_coe, not_or]
      exact ⟨ha, hst.1⟩
    have := hE.disjoint_biSup hx
    simpa using this

/-- For an independent family, `(⨆_{s} E) ⊓ (⨆_{t} E) = ⨆_{s ∩ t} E`. -/
theorem biSup_inf_biSup {E : ι → Submodule K M} (hE : iSupIndep E) (s t : Finset ι) :
    (⨆ i ∈ s, E i) ⊓ (⨆ i ∈ t, E i) = ⨆ i ∈ s ∩ t, E i := by
  apply le_antisymm
  · have hs : (⨆ i ∈ s, E i) = (⨆ i ∈ s ∩ t, E i) ⊔ ⨆ i ∈ s \ t, E i := by
      rw [← Finset.iSup_union, Finset.union_comm, Finset.sdiff_union_inter]
    have hle : (⨆ i ∈ s ∩ t, E i) ≤ ⨆ i ∈ t, E i :=
      biSup_mono fun i hi => (Finset.mem_inter.mp hi).2
    rw [hs, sup_inf_assoc_of_le _ hle,
      (disjoint_biSup_of_disjoint hE t (s \ t) Finset.sdiff_disjoint).eq_bot, sup_bot_eq]
  · exact le_inf (biSup_mono fun i hi => (Finset.mem_inter.mp hi).1)
      (biSup_mono fun i hi => (Finset.mem_inter.mp hi).2)

end Lattice

/-! ## 3. Rational descent for `ℚ`-subspaces -/

section Descent
variable {H : Type*} [AddCommGroup H] [Module ℚ H]

/-- `rationalPoints (cx U) = U` for a rational subspace `U` (finite dimension). -/
theorem rationalPoints_cx [FiniteDimensional ℚ H] (U : Submodule ℚ H) :
    rationalPoints (cx U) = U := by
  have hle : U ≤ rationalPoints (cx U) := gc.le_u_l U
  have hd : finrank ℚ (rationalPoints (cx U)) ≤ finrank ℚ U := by
    rw [← finrank_cx, ← finrank_cx U]
    exact Submodule.finrank_mono (gc.l_u_le (cx U))
  exact (Submodule.eq_of_le_of_finrank_le hle hd).symm

theorem eq_zero_of_tmul_eq_zero [FiniteDimensional ℚ H] {v : H}
    (h : (1 : ℂ) ⊗ₜ[ℚ] v = 0) : v = 0 := by
  have hv : v ∈ rationalPoints (cx (⊥ : Submodule ℚ H)) := by
    rw [mem_rationalPoints, h]; exact Submodule.zero_mem _
  rw [rationalPoints_cx] at hv
  exact (Submodule.mem_bot ℚ).mp hv

theorem cx_span (T : Set H) :
    cx (Submodule.span ℚ T) = Submodule.span ℂ ((TensorProduct.mk ℚ ℂ H 1) '' T) := by
  apply le_antisymm
  · rw [gc.le_iff_le, Submodule.span_le]
    intro v hv
    exact Submodule.subset_span ⟨v, hv, rfl⟩
  · rw [Submodule.span_le]
    rintro _ ⟨v, hv, rfl⟩
    exact Submodule.subset_span ⟨v, Submodule.subset_span hv, rfl⟩

end Descent

/-! ## 4. The reduced bridge -/

section Core
variable {H : Type*} [AddCommGroup H] [Module ℚ H]

theorem biSup_map_some (h2 : H) (V : Ch → Submodule ℂ (ℂ ⊗[ℚ] H)) (s : Finset Ch) :
    (⨆ o ∈ s.map Function.Embedding.some, eigenFamily h2 V o) = ⨆ χ ∈ s, V χ := by
  rw [← Finset.sup_eq_iSup, Finset.sup_map, Finset.sup_eq_iSup]
  rfl

theorem h22_index (h2 : H) (V : Ch → Submodule ℂ (ℂ ⊗[ℚ] H)) :
    Submodule.span ℂ {(1 : ℂ) ⊗ₜ[ℚ] h2} ⊔ ⨆ χ ∈ type22, V χ =
      ⨆ o ∈ insert none (type22.map Function.Embedding.some), eigenFamily h2 V o := by
  rw [Finset.iSup_insert, biSup_map_some]
  rfl

/-- The chain-sextic character bridge with `hdg_split` and `orbit_simple` removed and replaced
by the single eigenline statement `galois_min`. Hypotheses, not axioms. -/
structure ChainSexticCharacterCore (H : Type*) [AddCommGroup H] [Module ℚ H]
    extends ChainSexticHodgeBridge H where
  /-- `V χ`: the `G`-eigenspace of character `χ` in `H⁴_prim(X,ℂ)`. -/
  V : Ch → Submodule ℂ (ℂ ⊗[ℚ] H)
  /-- Characters outside `primChars` do not occur. -/
  V_out : ∀ χ ∉ primChars, V χ = ⊥
  /-- Multiplicity one. -/
  V_line : ∀ χ ∈ primChars, finrank ℂ (V χ) = 1
  /-- The eigenlines and `ℂ·h²` are independent. -/
  eigen_indep : iSupIndep (eigenFamily h2 V)
  /-- Griffiths: `H^{2,2} = ℂ·h² ⊕ ⨁_{q χ = 2} V_χ`. -/
  h22_eq : H22 = Submodule.span ℂ {(1 : ℂ) ⊗ₜ[ℚ] h2} ⊔ ⨆ χ ∈ type22, V χ
  /-- The rational isotypic piece for the Galois orbit of `r`. -/
  W : Ch → Submodule ℚ H
  /-- Galois descent: `W_O ⊗ ℂ = ⨁_{χ ∈ O} V_χ`. -/
  W_complex : ∀ r ∈ reps, cx (W r) = ⨆ χ ∈ orbit r, V χ
  /-- For an orbit not entirely of type `(2,2)`, its type-`(2,2)` part has no rational points. -/
  galois_min : ∀ r ∈ reps, ¬ orbit r ⊆ type22 →
    rationalPoints (⨆ χ ∈ orbit r ∩ type22, V χ) = ⊥

namespace ChainSexticCharacterCore
variable (D : ChainSexticCharacterCore H)

theorem h22_eq' : D.H22 =
    ⨆ o ∈ insert none (type22.map Function.Embedding.some), eigenFamily D.h2 D.V o := by
  rw [D.h22_eq, h22_index]

theorem cx_W' {r : Ch} (hr : r ∈ reps) :
    cx (D.W r) = ⨆ o ∈ (orbit r).map Function.Embedding.some, eigenFamily D.h2 D.V o := by
  rw [D.W_complex r hr, biSup_map_some]

/-- **Proved** (was the field `orbit_simple`). -/
theorem orbit_simple {r : Ch} (hr : r ∈ reps) :
    rationalPoints D.H22 ⊓ D.W r = ⊥ ∨ D.W r ≤ rationalPoints D.H22 := by
  classical
  by_cases h : orbit r ⊆ type22
  · right
    rw [← gc.le_iff_le, D.W_complex r hr, D.h22_eq]
    refine iSup₂_le fun χ hχ => le_sup_of_le_right ?_
    exact le_iSup₂_of_le (f := fun χ (_ : χ ∈ type22) => D.V χ) χ (h hχ) le_rfl
  · left
    rw [eq_bot_iff, ← D.galois_min r hr h]
    intro v hv
    obtain ⟨hv1, hv2⟩ := Submodule.mem_inf.mp hv
    rw [mem_rationalPoints] at hv1 ⊢
    have hv2' : (1 : ℂ) ⊗ₜ[ℚ] v ∈ cx (D.W r) := Submodule.subset_span ⟨v, hv2, rfl⟩
    rw [D.cx_W' hr] at hv2'
    rw [D.h22_eq'] at hv1
    have hidx : insert none (type22.map Function.Embedding.some) ∩
        (orbit r).map Function.Embedding.some =
        (orbit r ∩ type22).map Function.Embedding.some := by
      have hnone : (none : Option Ch) ∉ (orbit r).map Function.Embedding.some := by
        simp
      rw [Finset.insert_inter_of_notMem hnone, ← Finset.map_inter, Finset.inter_comm]
    rw [← biSup_map_some, ← hidx, ← biSup_inf_biSup D.eigen_indep]
    exact Submodule.mem_inf.mpr ⟨hv1, hv2'⟩

/-- **Proved** (was the field `hdg_split`). -/
theorem hdg_split [FiniteDimensional ℚ H] : rationalPoints D.H22 =
    Submodule.span ℚ {D.h2} ⊔ ⨆ r ∈ reps, (rationalPoints D.H22 ⊓ D.W r) := by
  classical
  apply le_antisymm
  · intro v hv
    -- Step 1: `v` lies in the rational span of `h²` and the pieces `W r`.
    set U : Submodule ℚ H := Submodule.span ℚ {D.h2} ⊔ ⨆ r ∈ reps, D.W r with hU
    have hH22U : D.H22 ≤ cx U := by
      rw [hU, gc.l_sup, cx_span_singleton, gc.l_iSup₂, D.h22_eq]
      refine sup_le_sup_left ?_ _
      refine iSup₂_le fun χ hχ => ?_
      obtain ⟨r, hr, hχr⟩ := mem_orbit_rep (type22_subset_primChars hχ)
      refine le_iSup₂_of_le (f := fun r (_ : r ∈ reps) => cx (D.W r)) r hr ?_
      show D.V χ ≤ cx (D.W r)
      rw [D.W_complex r hr]
      exact le_iSup₂_of_le (f := fun χ (_ : χ ∈ orbit r) => D.V χ) χ hχr le_rfl
    have hvU : v ∈ U := by
      rw [← rationalPoints_cx U]
      exact hH22U hv
    -- Step 2: write `v = y + Σ_r μ r` with `y ∈ ℚ·h²`, `μ r ∈ W r`.
    obtain ⟨y, hy, z, hz, rfl⟩ := Submodule.mem_sup.mp hvU
    obtain ⟨μ, rfl⟩ := (Submodule.mem_iSup_finset_iff_exists_sum _ _).mp hz
    -- Step 3: each `μ r` is a Hodge class.
    have hμ : ∀ r ∈ reps, ((μ r : H)) ∈ rationalPoints D.H22 := by
      intro r hr
      set S0 := insert none (type22.map Function.Embedding.some) with hS0
      set T := ((reps.erase r).biUnion orbit).map Function.Embedding.some with hT
      have hx1 : (1 : ℂ) ⊗ₜ[ℚ] (μ r : H) ∈
          ⨆ o ∈ (orbit r).map Function.Embedding.some, eigenFamily D.h2 D.V o := by
        rw [← D.cx_W' hr]; exact Submodule.subset_span ⟨_, (μ r).2, rfl⟩
      have hx2 : (1 : ℂ) ⊗ₜ[ℚ] (μ r : H) ∈ ⨆ o ∈ S0 ∪ T, eigenFamily D.h2 D.V o := by
        have hsplit : (μ r : H) = (y + ∑ i ∈ reps, (μ i : H)) - y -
            ∑ i ∈ reps.erase r, (μ i : H) := by
          rw [← Finset.add_sum_erase _ _ hr]; abel
        rw [hsplit, TensorProduct.tmul_sub, TensorProduct.tmul_sub, TensorProduct.tmul_sum]
        have hS0le : (⨆ o ∈ S0, eigenFamily D.h2 D.V o) ≤ ⨆ o ∈ S0 ∪ T, eigenFamily D.h2 D.V o :=
          biSup_mono fun o ho => Finset.mem_union_left _ ho
        refine Submodule.sub_mem _ (Submodule.sub_mem _ ?_ ?_) (Submodule.sum_mem _ ?_)
        · apply hS0le; rw [← D.h22_eq']; exact hv
        · apply hS0le
          have hE : eigenFamily D.h2 D.V none ≤ ⨆ o ∈ S0, eigenFamily D.h2 D.V o :=
            le_iSup₂_of_le (f := fun o (_ : o ∈ S0) => eigenFamily D.h2 D.V o) none
              (Finset.mem_insert_self _ _) le_rfl
          apply hE
          obtain ⟨a, rfl⟩ := Submodule.mem_span_singleton.mp hy
          show (1 : ℂ) ⊗ₜ[ℚ] (a • D.h2) ∈ Submodule.span ℂ {(1 : ℂ) ⊗ₜ[ℚ] D.h2}
          rw [TensorProduct.tmul_smul]
          exact Submodule.smul_of_tower_mem _ a (Submodule.mem_span_singleton_self _)
        · intro i hi
          have hi' := Finset.mem_erase.mp hi
          have : (1 : ℂ) ⊗ₜ[ℚ] (μ i : H) ∈
              ⨆ o ∈ (orbit i).map Function.Embedding.some, eigenFamily D.h2 D.V o := by
            rw [← D.cx_W' hi'.2]; exact Submodule.subset_span ⟨_, (μ i).2, rfl⟩
          have hle : (⨆ o ∈ (orbit i).map Function.Embedding.some, eigenFamily D.h2 D.V o) ≤
              ⨆ o ∈ S0 ∪ T, eigenFamily D.h2 D.V o := by
            refine biSup_mono (fun o ho => ?_)
            apply Finset.mem_union_right
            obtain ⟨χ, hχ, rfl⟩ := Finset.mem_map.mp ho
            exact Finset.mem_map_of_mem _ (Finset.mem_biUnion.mpr ⟨i, hi, hχ⟩)
          exact hle this
      have hmem := Submodule.mem_inf.mpr ⟨hx1, hx2⟩
      rw [biSup_inf_biSup D.eigen_indep] at hmem
      rw [mem_rationalPoints, D.h22_eq']
      refine (biSup_mono (fun o ho => ?_) :
        (⨆ o ∈ (orbit r).map Function.Embedding.some ∩ (S0 ∪ T), eigenFamily D.h2 D.V o) ≤
          ⨆ o ∈ S0, eigenFamily D.h2 D.V o) hmem
      obtain ⟨ho1, ho2⟩ := Finset.mem_inter.mp ho
      rcases Finset.mem_union.mp ho2 with h | h
      · exact h
      · exfalso
        obtain ⟨χ, hχ, rfl⟩ := Finset.mem_map.mp ho1
        obtain ⟨ψ, hψ, hψe⟩ := Finset.mem_map.mp h
        simp only [Function.Embedding.some_apply, Option.some.injEq] at hψe
        subst hψe
        obtain ⟨i, hi, hψi⟩ := Finset.mem_biUnion.mp hψ
        have hi' := Finset.mem_erase.mp hi
        exact hi'.1 (reps_eq_of_mem_orbit hi'.2 hr hψi hχ)
    refine Submodule.add_mem_sup hy (Submodule.sum_mem _ fun r hr => ?_)
    exact le_iSup₂_of_le (f := fun r (_ : r ∈ reps) => rationalPoints D.H22 ⊓ D.W r) r hr le_rfl
      (Submodule.mem_inf.mpr ⟨hμ r hr, (μ r).2⟩)
  · refine sup_le ?_ (iSup₂_le fun r _ => inf_le_left)
    rw [Submodule.span_le, Set.singleton_subset_iff]
    exact D.h2_hodge

/-- The old bridge, rebuilt from the smaller hypothesis set. -/
def toCharacterBridge [FiniteDimensional ℚ H] : ChainSexticCharacterBridge H where
  toChainSexticHodgeBridge := D.toChainSexticHodgeBridge
  V := D.V
  V_out := D.V_out
  V_line := D.V_line
  eigen_indep := D.eigen_indep
  h22_eq := D.h22_eq
  W := D.W
  W_complex := D.W_complex
  hdg_split := D.hdg_split
  orbit_simple := fun _ hr => D.orbit_simple hr

/-- `ρ_Hdg = 786` from the smaller hypothesis set. -/
theorem rho_eq_786 [FiniteDimensional ℚ H] : D.rho = 786 :=
  D.toCharacterBridge.rho_eq_786

end ChainSexticCharacterCore
end Core

/-! ## 5. `galois_min` from Galois conjugation of the eigenlines -/

section Galois
variable {H : Type*} [AddCommGroup H] [Module ℚ H]

/-- `σ ⊗ id` on `ℂ ⊗[ℚ] H` for a field automorphism `σ` of `ℂ`. It is only `ℚ`-linear. -/
noncomputable def conjMap (σ : ℂ ≃ₐ[ℚ] ℂ) : (ℂ ⊗[ℚ] H) →ₗ[ℚ] (ℂ ⊗[ℚ] H) :=
  TensorProduct.map σ.toLinearMap LinearMap.id

/-- `σ ⊗ id` fixes the rational vectors `1 ⊗ v`. -/
theorem conjMap_one_tmul (σ : ℂ ≃ₐ[ℚ] ℂ) (v : H) :
    conjMap σ ((1 : ℂ) ⊗ₜ[ℚ] v) = (1 : ℂ) ⊗ₜ[ℚ] v := by
  simp [conjMap]

/-- If an additive map sends each `V χ` into `V (g χ)`, it sends `⨆_{χ ∈ A} V χ` into
`⨆_{χ ∈ g A} V χ` (every element of the left side is a finite sum). -/
theorem map_biSup_le (f : (ℂ ⊗[ℚ] H) →ₗ[ℚ] (ℂ ⊗[ℚ] H)) (V : Ch → Submodule ℂ (ℂ ⊗[ℚ] H))
    (g : Ch → Ch) (hf : ∀ χ, ∀ x ∈ V χ, f x ∈ V (g χ)) (A : Finset Ch) {x : ℂ ⊗[ℚ] H}
    (hx : x ∈ ⨆ χ ∈ A, V χ) : f x ∈ ⨆ χ ∈ A.image g, V χ := by
  classical
  obtain ⟨μ, rfl⟩ := (Submodule.mem_iSup_finset_iff_exists_sum _ _).mp hx
  rw [map_sum]
  refine Submodule.sum_mem _ fun χ hχ => ?_
  exact le_iSup₂_of_le (f := fun ψ (_ : ψ ∈ A.image g) => V ψ) (g χ)
    (Finset.mem_image_of_mem g hχ) le_rfl (hf χ _ (μ χ).2)

/-- `A ∩ t₁A ∩ t₂A ∩ ⋯` along a list of units. -/
def interImages (A : Finset Ch) : List ℕ → Finset Ch
  | [] => A
  | t :: L => interImages A L ∩ A.image (act t)

theorem mem_interImages (A : Finset Ch) :
    ∀ (L : List ℕ) (χ : Ch), χ ∈ interImages A L → χ ∈ A ∧ ∀ t ∈ L, χ ∈ A.image (act t)
  | [], χ, h => ⟨h, by simp⟩
  | t :: L, χ, h => by
    rw [interImages, Finset.mem_inter] at h
    obtain ⟨hA, hL⟩ := mem_interImages A L χ h.1
    refine ⟨hA, fun s hs => ?_⟩
    rcases List.mem_cons.mp hs with rfl | hs
    · exact h.2
    · exact hL s hs

/-- A proper part `A ⊊ O` of a Galois orbit is moved off itself: `⋂_t tA = ∅`. -/
theorem interImages_units_eq_empty {r : Ch} (hr : r ∈ range30cube) {A : Finset Ch}
    (hA : A ⊆ orbit r) {ψ : Ch} (hψ : ψ ∈ orbit r) (hψA : ψ ∉ A) :
    interImages A units30 = ∅ := by
  rw [Finset.eq_empty_iff_forall_notMem]
  intro χ hχ
  obtain ⟨hχA, hall⟩ := mem_interImages A units30 χ hχ
  obtain ⟨u, hu, hχe⟩ := mem_orbit.mp (hA hχA)
  obtain ⟨s, hs, rfl⟩ := mem_orbit.mp hψ
  obtain ⟨s', hs', hs's⟩ := units_inv s hs
  have ht := units_mul_mem u hu s' hs'
  obtain ⟨a, haA, ha⟩ := Finset.mem_image.mp (hall _ ht)
  have e : act (u * s' % 30) (act s r) = χ := by
    rw [← hχe, ← act_act u s', act_act s' s, hs's, act_one hr]
  have hac : a = act s r :=
    act_injOn ht (orbit_subset_cube r (hA haA)) (act_mem_cube s r) (ha.trans e.symm)
  exact hψA (hac ▸ haA)

/-- **Galois minimality.** Let `conj t` be additive maps fixing every rational vector `1 ⊗ v`
and sending `V χ` into `V (tχ)` for each unit `t`. If the `V χ` are independent, then for a
proper part `A` of a Galois orbit, `⨆_{χ ∈ A} V χ` has no nonzero rational vector. -/
theorem rationalPoints_eq_bot_of_conj [FiniteDimensional ℚ H] (V : Ch → Submodule ℂ (ℂ ⊗[ℚ] H))
    (hV : iSupIndep V) (conj : ℕ → (ℂ ⊗[ℚ] H) →ₗ[ℚ] (ℂ ⊗[ℚ] H))
    (hfix : ∀ t ∈ units30, ∀ v : H, conj t ((1 : ℂ) ⊗ₜ[ℚ] v) = (1 : ℂ) ⊗ₜ[ℚ] v)
    (hconj : ∀ t ∈ units30, ∀ χ, ∀ x ∈ V χ, conj t x ∈ V (act t χ))
    {r : Ch} (hr : r ∈ range30cube) {A : Finset Ch} (hA : A ⊆ orbit r) {ψ : Ch}
    (hψ : ψ ∈ orbit r) (hψA : ψ ∉ A) :
    rationalPoints (⨆ χ ∈ A, V χ) = ⊥ := by
  classical
  rw [eq_bot_iff]
  intro v hv
  rw [Submodule.mem_bot]
  rw [mem_rationalPoints] at hv
  have hB : ∀ L : List ℕ, (∀ t ∈ L, t ∈ units30) →
      (1 : ℂ) ⊗ₜ[ℚ] v ∈ ⨆ χ ∈ interImages A L, V χ := by
    intro L
    induction L with
    | nil => intro _; exact hv
    | cons t L ih =>
      intro hL
      have h1 := ih (fun s hs => hL s (List.mem_cons_of_mem _ hs))
      have ht : t ∈ units30 := hL t (List.mem_cons_self ..)
      have h2 : (1 : ℂ) ⊗ₜ[ℚ] v ∈ ⨆ χ ∈ A.image (act t), V χ := by
        rw [← hfix t ht v]
        exact map_biSup_le _ V _ (hconj t ht) A hv
      have h3 := Submodule.mem_inf.mpr ⟨h1, h2⟩
      rw [biSup_inf_biSup hV] at h3
      exact h3
  have h := hB units30 (fun _ ht => ht)
  rw [interImages_units_eq_empty hr hA hψ hψA] at h
  simp only [Finset.notMem_empty, iSup_false, iSup_bot, Submodule.mem_bot] at h
  exact eq_zero_of_tmul_eq_zero h

/-- The bridge with `galois_min` replaced by Galois conjugation of the eigenlines:
for each unit `t` there is `σ ∈ Aut(ℂ)` with `(σ ⊗ id)(V χ) ⊆ V (tχ)`. Hypotheses, not axioms. -/
structure ChainSexticCharacterGalois (H : Type*) [AddCommGroup H] [Module ℚ H]
    extends ChainSexticHodgeBridge H where
  V : Ch → Submodule ℂ (ℂ ⊗[ℚ] H)
  V_out : ∀ χ ∉ primChars, V χ = ⊥
  V_line : ∀ χ ∈ primChars, finrank ℂ (V χ) = 1
  eigen_indep : iSupIndep (eigenFamily h2 V)
  h22_eq : H22 = Submodule.span ℂ {(1 : ℂ) ⊗ₜ[ℚ] h2} ⊔ ⨆ χ ∈ type22, V χ
  W : Ch → Submodule ℚ H
  W_complex : ∀ r ∈ reps, cx (W r) = ⨆ χ ∈ orbit r, V χ
  /-- Galois conjugation permutes the eigenlines like the characters: `σ(V_χ) ⊆ V_{tχ}`. -/
  galois : ∀ t ∈ units30, ∃ σ : ℂ ≃ₐ[ℚ] ℂ, ∀ χ, ∀ x ∈ V χ, conjMap σ x ∈ V (act t χ)

namespace ChainSexticCharacterGalois
variable (D : ChainSexticCharacterGalois H)

/-- The chosen conjugations (`0` off the units; never used there). -/
noncomputable def conj (t : ℕ) : (ℂ ⊗[ℚ] H) →ₗ[ℚ] (ℂ ⊗[ℚ] H) := by
  classical
  exact if h : t ∈ units30 then conjMap (Classical.choose (D.galois t h)) else 0

theorem galois_min [FiniteDimensional ℚ H] : ∀ r ∈ reps, ¬ orbit r ⊆ type22 →
    rationalPoints (⨆ χ ∈ orbit r ∩ type22, D.V χ) = ⊥ := by
  classical
  intro r hr hnot
  obtain ⟨ψ, hψ, hψ22⟩ := Finset.not_subset.mp hnot
  have hV : iSupIndep D.V := D.eigen_indep.comp (Option.some_injective _)
  refine rationalPoints_eq_bot_of_conj D.V hV D.conj ?_ ?_
    (mem_primChars.mp (mem_reps.mp hr).1).1 Finset.inter_subset_left hψ
    (fun h => hψ22 (Finset.mem_inter.mp h).2)
  · intro t ht v
    simp only [conj, dif_pos ht, conjMap_one_tmul]
  · intro t ht χ x hx
    simp only [conj, dif_pos ht]
    exact Classical.choose_spec (D.galois t ht) χ x hx

/-- The reduced bridge from the Galois form. -/
def toCore [FiniteDimensional ℚ H] : ChainSexticCharacterCore H where
  toChainSexticHodgeBridge := D.toChainSexticHodgeBridge
  V := D.V
  V_out := D.V_out
  V_line := D.V_line
  eigen_indep := D.eigen_indep
  h22_eq := D.h22_eq
  W := D.W
  W_complex := D.W_complex
  galois_min := D.galois_min

/-- `ρ_Hdg = 786` from the Galois form of the bridge. -/
theorem rho_eq_786 [FiniteDimensional ℚ H] : D.rho = 786 :=
  D.toCore.rho_eq_786

end ChainSexticCharacterGalois
end Galois

end ChainSexticCore
end Hodge
