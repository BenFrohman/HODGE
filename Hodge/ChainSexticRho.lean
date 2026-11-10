/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Hodge.ChainSexticRank
import Hodge.SexticCombinatorics

/-!
# `ρ_Hdg(V(F)) = 786` for the chain sextic, from the character decomposition

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6,   X = V(F) ⊂ P^5.

`scripts/hodge_rank.py` claims `dim_ℚ (H⁴_prim(X,ℚ) ∩ H^{2,2}) = 785`, so `ρ_Hdg(X) = 786`.
It is an exact value, not a bound. It does not assume the Hodge conjecture and says nothing
about algebraic cycles. The argument (Griffiths residues plus the diagonal-symmetry/Galois
method of Shioda) is:

1. `G = (ℤ/30)³` acts on `X`; the residue of `x^a y^b ⋯ Ω / F^{q+1}` is a `G`-eigenvector
   whose character is `c = (a+1) − 5(b+1) mod 30` in each pair. The 2605 primitive characters
   (`primChars`) are pairwise distinct, so `H⁴_prim(X,ℂ) = ⨁ V_χ` with each `V_χ` a line of
   pure type `(4−q, q)`, where `q = qv χ`.
2. `Gal(ℚ(ζ₃₀)/ℚ) = (ℤ/30)ˣ` permutes the `V_χ` along orbits `χ ↦ tχ`. `H⁴_prim(X,ℚ)`
   splits into rational pieces `W_O`, one for each orbit, with `W_O ⊗ ℂ = ⨁_{χ∈O} V_χ`, and
   each `W_O` is a simple `ℚ[G]`-module.
3. Hence `Hdg²_prim = ⨁ { W_O : every χ ∈ O has q = 2 }`, and
   `ρ = 1 + #{χ : the whole orbit of χ has type (2,2)} = 1 + 785`.

## What is proved outright here
* `hodgeChars_card : hodgeChars.card = 785`: the union of the orbits of the Hodge orbit
  representatives. `hodgeChars_eq` identifies it with the filter `hodgeSet`, whose size is the
  existing kernel count `SexticCombinatorics.rational_hodge_dim` (122 orbits:
  `rational_hodge_orbits`). The kernel checks are `orbitCheck`, `hodgeOrbitCheck` and
  `repCheck` (`decide +kernel` over list loops, with no `native_decide`).
* `orbit_subset`: every orbit of a representative consists of primitive characters.
* `rationalHodge_iff`: the Boolean test `rationalHodge` means "every character in the orbit
  has `q = 2`".
* All of the linear algebra in steps 2–3 (`W_le_hdg_of_hodge`, `hodge_of_W_le_hdg`,
  `hdg_eq`, `cx_hdg_eq`, `finrank_cx`, `finrank_biSup_of_indep`) and the final count.

## What is a hypothesis (`ChainSexticCharacterBridge`, never an axiom)
These are the geometric and representation-theoretic facts of steps 1–2:
* `V`, `V_out`, `V_line`, `eigen_indep`: the eigenline decomposition of `H⁴(X,ℂ)`
  (Griffiths residues; multiplicity one).
* `h22_eq`: `H^{2,2} = ℂ·h² ⊕ ⨁_{q χ = 2} V_χ` (Griffiths residue type).
* `W`, `W_complex`: the rational isotypic pieces and their complexifications (Galois descent).
* `hdg_split`: `Hdg²` is the sum of its intersections with the pieces (`Hdg²` is `G`-stable,
  and the rational isotypic projectors lie in `ℚ[G]`).
* `orbit_simple`: `Hdg² ∩ W_O` is `0` or `W_O` (`W_O` is simple).

The bridge extends `ChainSexticHodgeBridge`, so `rho_bounds` (`2 ≤ ρ ≤ 1752`) and
`rho_eq_786` refer to the same `ρ`.
-/

open Module TensorProduct Hodge.ChainSexticRank Hodge.SexticCombinatorics

namespace Hodge
namespace ChainSexticRho

/-- A character triple `(c0, c1, c2) ∈ (ℤ/30)³`, stored as natural numbers `< 30`. -/
abbrev Ch := ℕ × ℕ × ℕ
def range30cube : Finset Ch := Finset.range 30 ×ˢ Finset.range 30 ×ˢ Finset.range 30
/-- The 2605 primitive characters, i.e. residues of degree `6q` (`qv ≠ 99`). -/
def primChars : Finset Ch := range30cube.filter fun c => qv c.1 c.2.1 c.2.2 ≠ 99
/-- Galois action `χ ↦ tχ`. -/
def act (t : ℕ) (c : Ch) : Ch := (t * c.1 % 30, t * c.2.1 % 30, t * c.2.2 % 30)
/-- Galois orbit under `(ℤ/30)ˣ`. -/
def orbit (c : Ch) : Finset Ch := units30.toFinset.image fun t => act t c
/-- Orbit representatives (least code in the orbit). -/
def reps : Finset Ch := primChars.filter fun c => isRep c.1 c.2.1 c.2.2 = true
/-- Representatives whose whole orbit has type `(2,2)`. -/
def hodgeReps : Finset Ch := reps.filter fun c => rationalHodge c.1 c.2.1 c.2.2 = true
/-- Characters in Hodge orbits. -/
def hodgeChars : Finset Ch := hodgeReps.biUnion orbit
/-- Primitive characters of type `(2,2)`. -/
def type22 : Finset Ch := primChars.filter fun c => qv c.1 c.2.1 c.2.2 = 2
/-- Boolean check of `p` on the whole cube `[0,30)³`, by list recursion (kernel-friendly). -/
def cubeAll (p : ℕ → ℕ → ℕ → Bool) : Bool :=
  (List.range 30).all fun i => (List.range 30).all fun j => (List.range 30).all fun k => p i j k

theorem cubeAll_spec {p : ℕ → ℕ → ℕ → Bool} (h : cubeAll p = true) :
    ∀ c ∈ range30cube, p c.1 c.2.1 c.2.2 = true := by
  rintro ⟨i, j, k⟩ hc
  simp only [range30cube, Finset.mem_product, Finset.mem_range] at hc
  simp only [cubeAll, List.all_eq_true, List.mem_range] at h
  exact h i hc.1 j hc.2.1 k hc.2.2

/-- Kernel check: orbits of primitive representatives stay primitive. -/
theorem orbitCheck : cubeAll (fun i j k => !(qv i j k != 99 && isRep i j k) ||
    units30.all fun t => qv (t * i % 30) (t * j % 30) (t * k % 30) != 99) = true := by
  decide +kernel

/-- Kernel check: the whole orbit of a Hodge representative passes `rationalHodge`. -/
theorem hodgeOrbitCheck : cubeAll (fun i j k => !(isRep i j k && rationalHodge i j k) ||
    units30.all fun t => rationalHodge (t * i % 30) (t * j % 30) (t * k % 30)) = true := by
  decide +kernel

/-- Kernel check: every character passing `rationalHodge` lies in the orbit of a Hodge representative. -/
theorem repCheck : cubeAll (fun i j k => !(rationalHodge i j k) ||
    units30.any fun t => (qv (t * i % 30) (t * j % 30) (t * k % 30) != 99 &&
      isRep (t * i % 30) (t * j % 30) (t * k % 30) &&
      rationalHodge (t * i % 30) (t * j % 30) (t * k % 30) &&
      units30.any fun s => (s * (t * i % 30) % 30 == i && s * (t * j % 30) % 30 == j &&
        s * (t * k % 30) % 30 == k))) = true := by
  decide +kernel

theorem act_mem_cube (t : ℕ) (c : Ch) : act t c ∈ range30cube := by
  simp only [act, range30cube, Finset.mem_product, Finset.mem_range]
  exact ⟨Nat.mod_lt _ (by norm_num), Nat.mod_lt _ (by norm_num), Nat.mod_lt _ (by norm_num)⟩

theorem mem_primChars {c : Ch} : c ∈ primChars ↔ c ∈ range30cube ∧ qv c.1 c.2.1 c.2.2 ≠ 99 :=
  Finset.mem_filter

theorem mem_reps {c : Ch} : c ∈ reps ↔ c ∈ primChars ∧ isRep c.1 c.2.1 c.2.2 = true :=
  Finset.mem_filter

theorem mem_orbit {c χ : Ch} : χ ∈ orbit c ↔ ∃ t ∈ units30, act t c = χ := by
  simp only [orbit, Finset.mem_image, List.mem_toFinset]

/-- Orbits of representatives consist of primitive characters. -/
theorem orbit_subset : ∀ r ∈ reps, orbit r ⊆ primChars := by
  intro r hr χ hχ
  obtain ⟨hp, hrep⟩ := mem_reps.mp hr
  obtain ⟨hcube, hq⟩ := mem_primChars.mp hp
  obtain ⟨t, ht, rfl⟩ := mem_orbit.mp hχ
  have h := cubeAll_spec orbitCheck r hcube
  have hpre : (qv r.1 r.2.1 r.2.2 != 99 && isRep r.1 r.2.1 r.2.2) = true := by
    simp [hq, hrep]
  rw [hpre] at h
  simp only [Bool.not_true, Bool.false_or, List.all_eq_true] at h
  exact mem_primChars.mpr ⟨act_mem_cube t r, by simpa using h t ht⟩

/-- The characters whose whole orbit has type `(2,2)`, as a filter of the cube. -/
def hodgeSet : Finset Ch := range30cube.filter fun c => rationalHodge c.1 c.2.1 c.2.2 = true

theorem sumBelow_eq (n : ℕ) (f : ℕ → ℕ) : sumBelow n f = ∑ i ∈ Finset.range n, f i := by
  induction n with
  | zero => rfl
  | succ n ih => rw [sumBelow, ih, Finset.sum_range_succ]

theorem hodgeSet_card : hodgeSet.card = 785 := by
  rw [← rational_hodge_dim, hodgeSet, Finset.card_filter, range30cube, Finset.sum_product,
    count3, sumBelow_eq]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_product, sumBelow_eq]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [sumBelow_eq]

theorem mem_hodgeReps {r : Ch} :
    r ∈ hodgeReps ↔ r ∈ reps ∧ rationalHodge r.1 r.2.1 r.2.2 = true :=
  Finset.mem_filter

theorem hodgeChars_eq : hodgeChars = hodgeSet := by
  ext χ
  rw [hodgeChars, Finset.mem_biUnion, hodgeSet, Finset.mem_filter]
  constructor
  · rintro ⟨r, hr, hχ⟩
    obtain ⟨hrr, hrh⟩ := mem_hodgeReps.mp hr
    obtain ⟨hp, hrep⟩ := mem_reps.mp hrr
    obtain ⟨t, ht, rfl⟩ := mem_orbit.mp hχ
    have h := cubeAll_spec hodgeOrbitCheck r (mem_primChars.mp hp).1
    have hpre : (isRep r.1 r.2.1 r.2.2 && rationalHodge r.1 r.2.1 r.2.2) = true := by
      simp [hrep, hrh]
    rw [hpre] at h
    simp only [Bool.not_true, Bool.false_or, List.all_eq_true] at h
    exact ⟨act_mem_cube t r, h t ht⟩
  · rintro ⟨hcube, hh⟩
    have h := cubeAll_spec repCheck χ hcube
    rw [hh] at h
    simp only [Bool.not_true, Bool.false_or, List.any_eq_true, Bool.and_eq_true,
      bne_iff_ne, ne_eq, beq_iff_eq] at h
    obtain ⟨t, ht, ⟨⟨hq, hrep⟩, hrh⟩, s, hs, ⟨e1, e2⟩, e3⟩ := h
    refine ⟨act t χ, ?_, ?_⟩
    · exact mem_hodgeReps.mpr ⟨mem_reps.mpr ⟨mem_primChars.mpr ⟨act_mem_cube t χ, hq⟩, hrep⟩, hrh⟩
    · refine mem_orbit.mpr ⟨s, hs, ?_⟩
      obtain ⟨i, j, k⟩ := χ
      simp only [act] at e1 e2 e3 ⊢
      rw [e1, e2, e3]

/-- Number of characters whose whole Galois orbit has type `(2,2)`: 785. -/
theorem hodgeChars_card : hodgeChars.card = 785 := by
  rw [hodgeChars_eq, hodgeSet_card]

theorem mem_type22 {c : Ch} : c ∈ type22 ↔ c ∈ primChars ∧ qv c.1 c.2.1 c.2.2 = 2 :=
  Finset.mem_filter

attribute [irreducible] primChars reps hodgeReps hodgeChars type22

theorem rationalHodge_iff (r : Ch) :
    rationalHodge r.1 r.2.1 r.2.2 = true ↔ ∀ χ ∈ orbit r, qv χ.1 χ.2.1 χ.2.2 = 2 := by
  unfold rationalHodge
  rw [List.all_eq_true]
  constructor
  · intro h χ hχ
    obtain ⟨t, ht, rfl⟩ := Finset.mem_image.mp hχ
    exact beq_iff_eq.mp (h t (List.mem_toFinset.mp ht))
  · intro h t ht
    exact beq_iff_eq.mpr (h (act t r) (Finset.mem_image.mpr ⟨t, List.mem_toFinset.mpr ht, rfl⟩))

theorem hodgeChars_subset : hodgeChars ⊆ primChars := by
  intro χ hχ
  have hχ' : χ ∈ hodgeReps.biUnion orbit := by unfold hodgeChars at hχ; exact hχ
  obtain ⟨r, hr, hχ⟩ := Finset.mem_biUnion.mp hχ'
  exact orbit_subset r (mem_hodgeReps.mp hr).1 hχ

variable {H : Type*} [AddCommGroup H] [Module ℚ H]

/-- Complexification `span_ℂ (1 ⊗ S)` of a rational subspace `S ⊆ H`. -/
noncomputable def cx (S : Submodule ℚ H) : Submodule ℂ (ℂ ⊗[ℚ] H) :=
  Submodule.span ℂ ((TensorProduct.mk ℚ ℂ H 1) '' S)

/-- `cx` is left adjoint to `rationalPoints`: `cx S ≤ W ↔ S ≤ rationalPoints W`. -/
theorem gc : GaloisConnection (cx (H := H)) rationalPoints := by
  intro S W
  constructor
  · intro h v hv
    exact h (Submodule.subset_span ⟨v, hv, rfl⟩)
  · intro h
    rw [cx, Submodule.span_le]
    rintro _ ⟨v, hv, rfl⟩
    exact h hv

/-- Complexification preserves dimension (flat base change is injective). -/
theorem finrank_cx [FiniteDimensional ℚ H] (S : Submodule ℚ H) :
    finrank ℂ (cx S) = finrank ℚ S := by
  let f : ℂ ⊗[ℚ] S →ₗ[ℂ] ℂ ⊗[ℚ] H := S.subtype.baseChange ℂ
  have hf : Function.Injective f := by
    rw [show (f : ℂ ⊗[ℚ] S → ℂ ⊗[ℚ] H) = S.subtype.lTensor ℂ from
      LinearMap.baseChange_eq_ltensor _]
    exact Module.Flat.lTensor_preserves_injective_linearMap _ Subtype.val_injective
  have hr : LinearMap.range f = cx S := by
    apply le_antisymm
    · rintro _ ⟨t, rfl⟩
      induction t using TensorProduct.induction_on with
      | zero => simp
      | tmul c v =>
        have : f (c ⊗ₜ v) = c • ((1 : ℂ) ⊗ₜ[ℚ] (v : H)) := by
          simp [f, LinearMap.baseChange_tmul, TensorProduct.smul_tmul']
        rw [this]
        exact Submodule.smul_mem _ c (Submodule.subset_span ⟨v, v.2, rfl⟩)
      | add a b ha hb => rw [map_add]; exact Submodule.add_mem _ ha hb
    · rw [cx, Submodule.span_le]
      rintro _ ⟨v, hv, rfl⟩
      exact ⟨(1 : ℂ) ⊗ₜ ⟨v, hv⟩, by simp [f]⟩
  rw [← hr, LinearMap.finrank_range_of_inj hf, Module.finrank_baseChange]

theorem cx_span_singleton (h : H) :
    cx (Submodule.span ℚ {h}) = Submodule.span ℂ {(1 : ℂ) ⊗ₜ[ℚ] h} := by
  apply le_antisymm
  · rw [gc.le_iff_le, Submodule.span_le, Set.singleton_subset_iff]
    exact Submodule.subset_span rfl
  · rw [Submodule.span_le, Set.singleton_subset_iff]
    exact Submodule.subset_span ⟨h, Submodule.mem_span_singleton_self h, rfl⟩

/-- The dimension of an independent finite supremum is the sum of the dimensions. -/
theorem finrank_biSup_of_indep {K M ι : Type*} [Field K] [AddCommGroup M] [Module K M]
    [FiniteDimensional K M] [DecidableEq ι] (E : ι → Submodule K M) (hE : iSupIndep E)
    (s : Finset ι) : finrank K ↥(⨆ i ∈ s, E i : Submodule K M) = ∑ i ∈ s, finrank K (E i) := by
  induction s using Finset.induction_on with
  | empty => simp
  | insert a s ha ih =>
    rw [Finset.sum_insert ha, ← ih]
    have hsup : (⨆ i ∈ insert a s, E i : Submodule K M) = E a ⊔ ⨆ i ∈ s, E i := by
      rw [← Finset.sup_eq_iSup, Finset.sup_insert, Finset.sup_eq_iSup]
    have hdis : Disjoint (E a) (⨆ i ∈ s, E i) := hE.disjoint_biSup (y := (s : Set ι)) ha
    rw [hsup, ← Submodule.finrank_sup_add_finrank_inf_eq, hdis.eq_bot, finrank_bot, add_zero]


/-- eigenline family: `none` is the line of `h²`, `some χ` the residue eigenline `V_χ`. -/
noncomputable def eigenFamily (h2 : H) (V : Ch → Submodule ℂ (ℂ ⊗[ℚ] H)) :
    Option Ch → Submodule ℂ (ℂ ⊗[ℚ] H)
  | none => Submodule.span ℂ {(1 : ℂ) ⊗ₜ[ℚ] h2}
  | some χ => V χ

/-- The geometric bridge for `ρ = 786`: hypotheses, not axioms. -/
structure ChainSexticCharacterBridge (H : Type*) [AddCommGroup H] [Module ℚ H]
    extends ChainSexticHodgeBridge H where
  /-- `V χ`: the `G`-eigenspace of character `χ` in `H⁴_prim(X,ℂ)` (residue eigenline). -/
  V : Ch → Submodule ℂ (ℂ ⊗[ℚ] H)
  /-- Characters outside `primChars` do not occur (indexing convention plus the residue basis). -/
  V_out : ∀ χ ∉ primChars, V χ = ⊥
  /-- Multiplicity one: each primitive character occurs in exactly one line. -/
  V_line : ∀ χ ∈ primChars, finrank ℂ (V χ) = 1
  /-- The eigenlines and `ℂ·h²` are independent (eigenspace decomposition). -/
  eigen_indep : iSupIndep (eigenFamily h2 V)
  /-- Griffiths: `H^{2,2} = ℂ·h² ⊕ ⨁_{q χ = 2} V_χ`. -/
  h22_eq : H22 = Submodule.span ℂ {(1 : ℂ) ⊗ₜ[ℚ] h2} ⊔
    ⨆ χ ∈ type22, V χ
  /-- `W r`: the rational isotypic piece of `H⁴_prim(X,ℚ)` for the Galois orbit of `r`. -/
  W : Ch → Submodule ℚ H
  /-- Galois descent: `W_O ⊗ ℂ = ⨁_{χ ∈ O} V_χ`. -/
  W_complex : ∀ r ∈ reps, cx (W r) = ⨆ χ ∈ orbit r, V χ
  /-- `Hdg²` is `G`-stable, so it splits along `ℚ·h²` and the isotypic pieces. -/
  hdg_split : rationalPoints H22 =
    Submodule.span ℚ {h2} ⊔ ⨆ r ∈ reps, (rationalPoints H22 ⊓ W r)
  /-- `W_O` is a simple `ℚ[G]`-module, so `Hdg² ∩ W_O` is `0` or `W_O`. -/
  orbit_simple : ∀ r ∈ reps, rationalPoints H22 ⊓ W r = ⊥ ∨ W r ≤ rationalPoints H22

namespace ChainSexticCharacterBridge
variable (D : ChainSexticCharacterBridge H)

theorem W_le_hdg_of_hodge {r : Ch} (hr : r ∈ reps) (hh : rationalHodge r.1 r.2.1 r.2.2 = true) :
    D.W r ≤ rationalPoints D.H22 := by
  rw [← gc.le_iff_le, D.W_complex r hr, D.h22_eq]
  refine iSup₂_le fun χ hχ => le_sup_of_le_right ?_
  have hp : χ ∈ type22 :=
    mem_type22.mpr ⟨orbit_subset r hr hχ, (rationalHodge_iff r).mp hh χ hχ⟩
  exact le_iSup₂_of_le (f := fun χ (_ : χ ∈ type22) => D.V χ) χ hp le_rfl

theorem hodge_of_W_le_hdg {r : Ch} (hr : r ∈ reps) (hW : D.W r ≤ rationalPoints D.H22) :
    rationalHodge r.1 r.2.1 r.2.2 = true := by
  rw [rationalHodge_iff]
  intro χ hχ
  by_contra hq
  have hprim := orbit_subset r hr hχ
  have h1 : D.V χ ≤ D.H22 := by
    have := gc.le_iff_le.mpr hW
    rw [D.W_complex r hr] at this
    exact le_trans (le_iSup₂_of_le (f := fun χ (_ : χ ∈ orbit r) => D.V χ) χ hχ le_rfl) this
  have h2 : D.H22 ≤ ⨆ (o : Option Ch) (_ : o ≠ some χ), eigenFamily D.h2 D.V o := by
    rw [D.h22_eq]
    refine sup_le ?_ (iSup₂_le fun c hc => ?_)
    · exact le_iSup₂_of_le (f := fun (o : Option Ch) (_ : o ≠ some χ) => eigenFamily D.h2 D.V o)
        none (by simp) le_rfl
    · have hc2 := (mem_type22.mp hc).2
      have hne : (some c : Option Ch) ≠ some χ := by
        intro h; cases h; exact hq hc2
      exact le_iSup₂_of_le (f := fun (o : Option Ch) (_ : o ≠ some χ) => eigenFamily D.h2 D.V o)
        (some c) hne le_rfl
  have hdis := D.eigen_indep (some χ)
  have hbot : D.V χ = ⊥ := by
    have : Disjoint (D.V χ) (D.V χ) := (hdis.mono_right (h1.trans h2))
    exact disjoint_self.mp this
  have := D.V_line χ hprim
  rw [hbot, finrank_bot] at this
  exact absurd this (by norm_num)

theorem hdg_eq : rationalPoints D.H22 =
    Submodule.span ℚ {D.h2} ⊔ ⨆ r ∈ hodgeReps, D.W r := by
  rw [D.hdg_split]
  congr 1
  apply le_antisymm
  · refine iSup₂_le fun r hr => ?_
    by_cases hh : rationalHodge r.1 r.2.1 r.2.2 = true
    · exact inf_le_right.trans (le_iSup₂_of_le (f := fun r (_ : r ∈ hodgeReps) => D.W r) r
        (mem_hodgeReps.mpr ⟨hr, hh⟩) le_rfl)
    · rcases D.orbit_simple r hr with h | h
      · rw [h]; exact bot_le
      · exact absurd (D.hodge_of_W_le_hdg hr h) hh
  · refine iSup₂_le fun r hr => ?_
    have hr' := mem_hodgeReps.mp hr
    have : D.W r = rationalPoints D.H22 ⊓ D.W r :=
      (inf_eq_right.mpr (D.W_le_hdg_of_hodge hr'.1 hr'.2)).symm
    rw [this]
    exact le_iSup₂_of_le (f := fun r (_ : r ∈ reps) => rationalPoints D.H22 ⊓ D.W r) r hr'.1 le_rfl

theorem cx_hdg_eq : cx (rationalPoints D.H22) =
    Submodule.span ℂ {(1 : ℂ) ⊗ₜ[ℚ] D.h2} ⊔ ⨆ χ ∈ hodgeChars, D.V χ := by
  rw [D.hdg_eq, gc.l_sup, cx_span_singleton, gc.l_iSup₂]
  congr 1
  rw [hodgeChars, Finset.iSup_biUnion]
  exact iSup_congr fun r => iSup_congr fun hr => D.W_complex r (mem_hodgeReps.mp hr).1

/-- **Main theorem**: `ρ_Hdg(X) = 786`, given the character bridge. -/
theorem rho_eq_786 [FiniteDimensional ℚ H] : D.rho = 786 := by
  classical
  have hh2 : D.h2 ≠ 0 := by
    intro h; have := D.h2_h2; rw [h] at this; simp at this
  have hline : finrank ℂ (Submodule.span ℂ {(1 : ℂ) ⊗ₜ[ℚ] D.h2}) = 1 := by
    rw [← cx_span_singleton, finrank_cx, finrank_span_singleton hh2]
  have hsup : (Submodule.span ℂ {(1 : ℂ) ⊗ₜ[ℚ] D.h2} ⊔ ⨆ χ ∈ hodgeChars, D.V χ) =
      ⨆ o ∈ insert none (hodgeChars.map Function.Embedding.some), eigenFamily D.h2 D.V o := by
    rw [Finset.iSup_insert, ← Finset.sup_eq_iSup _ (eigenFamily D.h2 D.V), Finset.sup_map,
      Finset.sup_eq_iSup]
    rfl
  have hnone : (none : Option Ch) ∉ hodgeChars.map Function.Embedding.some := by simp
  unfold ChainSexticHodgeBridge.rho
  rw [← finrank_cx, D.cx_hdg_eq, hsup, finrank_biSup_of_indep _ D.eigen_indep,
    Finset.sum_insert hnone, Finset.sum_map]
  simp only [eigenFamily, Function.Embedding.some_apply]
  rw [hline, Finset.sum_congr rfl (fun χ hχ => D.V_line χ (hodgeChars_subset hχ)),
    Finset.sum_const, hodgeChars_card]
  rfl

end ChainSexticCharacterBridge
end ChainSexticRho
end Hodge

namespace Hodge.ChainSexticRho.ChainSexticCharacterBridge

/-- The exact value agrees with the bounds of `Hodge.ChainSexticRank.rho_bounds`. -/
theorem rho_bounds_and_eq {H : Type*} [AddCommGroup H] [Module ℚ H] [FiniteDimensional ℚ H]
    (D : ChainSexticCharacterBridge H) : 2 ≤ D.rho ∧ D.rho ≤ 1752 ∧ D.rho = 786 :=
  ⟨(rho_bounds D.toChainSexticHodgeBridge).1, (rho_bounds D.toChainSexticHodgeBridge).2,
    D.rho_eq_786⟩

end Hodge.ChainSexticRho.ChainSexticCharacterBridge
