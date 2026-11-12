/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Hodge.ChainSexticCharacterCore
import Hodge.ChainSexticCharacterModel.Space
import Hodge.ChainSexticCharacterModel.Roots

/-!
# Eigenlines of the compact 27001-dimensional model

Characters of the cube are identified with `some (i,j,k) : Idx`.  The `h²`
slot is `none`.  Eigenlines of a mixed Galois orbit are twisted by powers of
`alpha`, so that a proper type-`(2,2)` part of the orbit has no rational
points.  Pure Hodge orbits and non-type-`(2,2)` characters stay on the
standard basis vectors.

These constructions live in the compact space `ModelH = Idx →₀ ℚ`, which is
linearly equivalent to the dense 27001-dimensional space (`equivDense`).
Nothing here is the cohomology of the sextic.
-/

open Module TensorProduct
open Hodge.ChainSexticRank Hodge.SexticCombinatorics Hodge.ChainSexticRho
open Hodge.ChainSexticCore

noncomputable section

namespace Hodge
namespace ChainSexticCharacterModel

open Classical

/-! ## The cube as `Fin 30 × Fin 30 × Fin 30`, identified with `Ch` on `range30cube` -/

/-- Read a cube index back as a character triple of natural numbers. -/
def ofCube (x : Cube) : Ch := (x.1.val, x.2.1.val, x.2.2.val)

theorem ofCube_mem (x : Cube) : ofCube x ∈ range30cube := by
  simp [ofCube, range30cube, Finset.mem_product, Finset.mem_range]

/-- The cube point associated to a character already known to lie in the cube. -/
def toCube {c : Ch} (hc : c ∈ range30cube) : Cube :=
  have h : c.1 < 30 ∧ c.2.1 < 30 ∧ c.2.2 < 30 := by
    simpa [range30cube, Finset.mem_product, Finset.mem_range] using hc
  ⟨⟨c.1, h.1⟩, ⟨c.2.1, h.2.1⟩, ⟨c.2.2, h.2.2⟩⟩

theorem ofCube_toCube {c : Ch} (hc : c ∈ range30cube) : ofCube (toCube hc) = c := by
  obtain ⟨i, j, k⟩ := c
  simp [ofCube, toCube]

theorem toCube_ofCube (x : Cube) : toCube (ofCube_mem x) = x := by
  ext <;> simp [ofCube, toCube]

/-- Index of a character in `ModelH`: `some (i,j,k)` on the cube, `none` off it
(the off-cube case is never used for primitive characters). -/
def charIdx (c : Ch) : Idx :=
  if h : c ∈ range30cube then some (toCube h) else none

theorem charIdx_eq_some {c : Ch} (hc : c ∈ range30cube) :
    charIdx c = some (toCube hc) :=
  dif_pos hc

theorem charIdx_ofCube (x : Cube) : charIdx (ofCube x) = some x := by
  simp [charIdx, ofCube_mem, toCube_ofCube]

theorem charIdx_eq_ofCube {c : Ch} (hc : c ∈ range30cube) :
    charIdx c = some (toCube hc) :=
  charIdx_eq_some hc

theorem charIdx_ne_none {c : Ch} (hc : c ∈ range30cube) : charIdx c ≠ none := by
  rw [charIdx_eq_some hc]; simp

theorem charIdx_inj_on_cube {c d : Ch} (hc : c ∈ range30cube) (hd : d ∈ range30cube)
    (h : charIdx c = charIdx d) : c = d := by
  rw [charIdx_eq_some hc, charIdx_eq_some hd, Option.some.injEq] at h
  rw [← ofCube_toCube hc, ← ofCube_toCube hd, h]

/-! ## Orbit combinatorics used by the twist -/

theorem units30_card : units30.toFinset.card = 8 := by decide

theorem orbit_card_le (c : Ch) : (orbit c).card ≤ 8 := by
  simpa [orbit] using (Finset.card_image_le).trans (Nat.le_of_eq units30_card)

theorem orbit_prim {χ : Ch} (hχ : χ ∈ primChars) : orbit χ ⊆ primChars := by
  obtain ⟨r, hr, hmem⟩ := mem_orbit_rep hχ
  have hrc := (mem_primChars.mp (mem_reps.mp hr).1).1
  rw [orbit_eq_of_mem hrc hmem]
  exact orbit_subset r hr

theorem orbit_subset_type22_iff (c : Ch) :
    orbit c ⊆ type22 ↔ rationalHodge c.1 c.2.1 c.2.2 = true := by
  rw [rationalHodge_iff]
  constructor
  · intro h ψ hψ
    exact (mem_type22.mp (h hψ)).2
  · intro h ψ hψ
    have hq : qv ψ.1 ψ.2.1 ψ.2.2 = 2 := h ψ hψ
    refine mem_type22.mpr ⟨mem_primChars.mpr ⟨orbit_subset_cube c hψ, ?_⟩, hq⟩
    rw [hq]; decide

/-- A primitive character whose Galois orbit is not entirely of type `(2,2)`. -/
def IsMixed (χ : Ch) : Prop :=
  χ ∈ primChars ∧ rationalHodge χ.1 χ.2.1 χ.2.2 = false

/-- A type-`(2,2)` character in a mixed orbit (these eigenlines are twisted). -/
def IsTwisted (χ : Ch) : Prop :=
  χ ∈ type22 ∧ rationalHodge χ.1 χ.2.1 χ.2.2 = false

theorem isTwisted_isMixed {χ : Ch} (h : IsTwisted χ) : IsMixed χ :=
  ⟨type22_subset_primChars h.1, h.2⟩

theorem mixed_rest_nonempty {χ : Ch} (h : IsMixed χ) : (orbit χ \ type22).Nonempty := by
  rw [Finset.nonempty_iff_ne_empty, Ne, Finset.sdiff_eq_empty_iff_subset]
  intro hs
  have := (orbit_subset_type22_iff χ).mp hs
  exact Bool.false_ne_true (h.2.symm.trans this)

/-- The unique least-`code` element of a nonempty set of cube characters. -/
def minCode (s : Finset Ch) (hs : s.Nonempty) : Ch :=
  (Finset.exists_min_image s (fun χ => code χ.1 χ.2.1 χ.2.2) hs).choose

theorem minCode_mem (s : Finset Ch) (hs : s.Nonempty) : minCode s hs ∈ s :=
  (Finset.exists_min_image s (fun χ => code χ.1 χ.2.1 χ.2.2) hs).choose_spec.1

theorem minCode_le (s : Finset Ch) (hs : s.Nonempty) :
    ∀ ψ ∈ s, code (minCode s hs).1 (minCode s hs).2.1 (minCode s hs).2.2 ≤
      code ψ.1 ψ.2.1 ψ.2.2 :=
  (Finset.exists_min_image s (fun χ => code χ.1 χ.2.1 χ.2.2) hs).choose_spec.2

theorem minCode_eq {s t : Finset Ch} (hs : s.Nonempty) (ht : t.Nonempty)
    (he : s = t) (hcube : s ⊆ range30cube) :
    minCode s hs = minCode t ht := by
  subst he
  refine code_inj (hcube (minCode_mem s hs)) (hcube (minCode_mem s ht)) ?_
  exact le_antisymm (minCode_le s hs _ (minCode_mem s ht))
    (minCode_le s ht _ (minCode_mem s hs))

/-- A canonical non-type-`(2,2)` character in a mixed orbit, depending only
on the orbit as a set (least `code`); `χ` itself otherwise. -/
def mixedSlot (χ : Ch) : Ch :=
  if h : IsMixed χ then minCode (orbit χ \ type22) (mixed_rest_nonempty h) else χ

theorem mixedSlot_mem_rest {χ : Ch} (h : IsMixed χ) :
    mixedSlot χ ∈ orbit χ \ type22 := by
  simp only [mixedSlot, dif_pos h]
  exact minCode_mem _ _

theorem mixedSlot_eq_of_orbit {χ ψ : Ch} (hχ : IsMixed χ) (hψ : IsMixed ψ)
    (ho : orbit χ = orbit ψ) : mixedSlot χ = mixedSlot ψ := by
  have hcube : orbit χ \ type22 ⊆ range30cube := by
    intro x hx
    exact orbit_subset_cube χ (Finset.mem_sdiff.mp hx).1
  simp only [mixedSlot, dif_pos hχ, dif_pos hψ]
  exact minCode_eq _ _ (by rw [ho]) hcube

theorem mixedSlot_mem_orbit {χ : Ch} (h : IsMixed χ) : mixedSlot χ ∈ orbit χ :=
  (Finset.mem_sdiff.mp (mixedSlot_mem_rest h)).1

theorem mixedSlot_not_type22 {χ : Ch} (h : IsMixed χ) : mixedSlot χ ∉ type22 :=
  (Finset.mem_sdiff.mp (mixedSlot_mem_rest h)).2

theorem mixedSlot_mem_prim {χ : Ch} (h : IsMixed χ) : mixedSlot χ ∈ primChars :=
  orbit_prim h.1 (mixedSlot_mem_orbit h)

theorem mixedSlot_in_cube {χ : Ch} (h : IsMixed χ) : mixedSlot χ ∈ range30cube :=
  (mem_primChars.mp (mixedSlot_mem_prim h)).1

/-- Rank of a type-`(2,2)` character inside its orbit, used as the exponent of `alpha`. -/
def twistedRank (χ : Ch) : ℕ :=
  ((orbit χ ∩ type22).filter
    (fun ψ => code ψ.1 ψ.2.1 ψ.2.2 ≤ code χ.1 χ.2.1 χ.2.2)).card

theorem twistedRank_pos {χ : Ch} (h : IsTwisted χ) : 0 < twistedRank χ := by
  have hcube := (mem_primChars.mp (type22_subset_primChars h.1)).1
  have hself : χ ∈ orbit χ ∩ type22 :=
    Finset.mem_inter.mpr ⟨self_mem_orbit hcube, h.1⟩
  have hle : χ ∈ (orbit χ ∩ type22).filter
      (fun ψ => code ψ.1 ψ.2.1 ψ.2.2 ≤ code χ.1 χ.2.1 χ.2.2) := by
    exact Finset.mem_filter.mpr ⟨hself, le_rfl⟩
  exact Finset.card_pos.mpr ⟨_, hle⟩

theorem twistedRank_le {χ : Ch} (h : IsTwisted χ) : twistedRank χ ≤ 7 := by
  have hO := orbit_card_le χ
  have hT := mixed_rest_nonempty (isTwisted_isMixed h)
  have hsum :
      (orbit χ ∩ type22).card + (orbit χ \ type22).card = (orbit χ).card :=
    Finset.card_inter_add_card_sdiff _ _
  have hTpos : 0 < (orbit χ \ type22).card := Finset.card_pos.mpr hT
  have hS : (orbit χ ∩ type22).card ≤ 7 := by omega
  exact (Finset.card_filter_le _ _).trans hS

theorem twistedRank_lt_eight {χ : Ch} (h : IsTwisted χ) : twistedRank χ < 8 :=
  Nat.lt_succ_of_le (twistedRank_le h)

/-! ## Generators, eigenlines, and rational pieces -/

/-- The generator of the eigenline (or of `ℂ·h²`) at index `o`. -/
def gen (o : Idx) : ℂ ⊗[ℚ] ModelH :=
  match o with
  | none => (1 : ℂ) ⊗ₜ e none
  | some x =>
    let χ := ofCube x
    if IsTwisted χ then
      (1 : ℂ) ⊗ₜ e (some x) +
        (alpha ^ twistedRank χ) • ((1 : ℂ) ⊗ₜ e (charIdx (mixedSlot χ)))
    else
      (1 : ℂ) ⊗ₜ e (some x)

/-- Residual eigenline of character `χ`, or `⊥` off `primChars`. -/
def V (χ : Ch) : Submodule ℂ (ℂ ⊗[ℚ] ModelH) :=
  if χ ∈ primChars then Submodule.span ℂ {gen (charIdx χ)} else ⊥

/-- Rational isotypic piece of the Galois orbit of `r`. -/
def W (r : Ch) : Submodule ℚ ModelH :=
  Submodule.span ℚ ((fun χ => e (charIdx χ)) '' (orbit r : Set Ch))

/-- The model class of `h²`. -/
def h2Vec : ModelH := e none

theorem hodgeChars_nonempty : hodgeChars.Nonempty := by
  have : 0 < hodgeChars.card := by rw [hodgeChars_card]; decide
  exact Finset.card_pos.mp this

/-- A fixed character in a Hodge orbit, used for the plane class `P`. -/
def hodgeChar : Ch :=
  (hodgeChars_nonempty : ∃ χ, χ ∈ hodgeChars).choose

theorem hodgeChar_mem : hodgeChar ∈ hodgeChars :=
  (hodgeChars_nonempty : ∃ χ, χ ∈ hodgeChars).choose_spec

theorem hodgeChar_prim : hodgeChar ∈ primChars :=
  hodgeChars_subset hodgeChar_mem

theorem hodgeChar_type22 : hodgeChar ∈ type22 := by
  have hmem : hodgeChar ∈ hodgeSet := by
    rw [← hodgeChars_eq]; exact hodgeChar_mem
  have hr : rationalHodge hodgeChar.1 hodgeChar.2.1 hodgeChar.2.2 = true :=
    (Finset.mem_filter.mp hmem).2
  have hcube : hodgeChar ∈ range30cube := (Finset.mem_filter.mp hmem).1
  exact (orbit_subset_type22_iff hodgeChar).mpr hr (self_mem_orbit hcube)

theorem hodgeChar_in_cube : hodgeChar ∈ range30cube :=
  (mem_primChars.mp hodgeChar_prim).1

/-- The model class of the plane.  Independent of `h²`, and a rational Hodge class. -/
def pVec : ModelH := e (charIdx hodgeChar)

end ChainSexticCharacterModel
end Hodge

end
