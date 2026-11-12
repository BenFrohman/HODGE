/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Hodge.ChainSexticRho

/-!
# Vacuity audit of the chain-sextic bridges

`ChainSexticRank.ChainSexticHodgeBridge` and `ChainSexticRho.ChainSexticCharacterBridge` are
hypothesis bundles. A bundle that cannot be inhabited would make `rho_bounds` and
`rho_eq_786` vacuous. This file checks that.

* `one_le_finrank_jacobianDeg12`: `R₁₂ ≠ 0`, proved from the polynomial (the monomial
  `x0³x3⁴x1³x4²` is not in the Jacobian ideal, by a monomial-ideal containment).
* `hodgeBridge_model`: an explicit inhabitant of `ChainSexticHodgeBridge`, so the hypotheses of
  `rho_bounds` are consistent. (The model is linear algebra only; it is **not** the cohomology
  of the sextic.)
* `rho_not_automatic`: for an arbitrary complex subspace in place of `H^{2,2}` the rational
  rank can be `0`, so the lower bound `2 ≤ ρ` genuinely uses the bridge fields.
* `characterBridge_forces_R12`: any `ChainSexticCharacterBridge` forces
  `finrank ℚ R₁₂ = 1751`. This file proves only `≤ 1751` (`jacobianDeg12_finrank_le`) and
  `≥ 1`. The reverse inequality (independence of the 1751 standard monomials) is proved in
  `Hodge.ChainSexticR12` (`jacobianDeg12_finrank_eq`), so this necessary condition holds; see
  `Hodge.ChainSexticR12Bridge`. This file still does not construct an inhabitant of the
  character bridge. An inhabitant is constructed in `Hodge.ChainSexticCharacterModel`; it is
  linear algebra on the compact 27001-dimensional space, not the cohomology of the sextic.
-/

open Module TensorProduct MvPolynomial
open Hodge.ChainSexticRank Hodge.SexticCombinatorics

namespace Hodge
namespace ChainSexticBridgeAudit

/-! ## `R₁₂ ≠ 0` -/

/-- Exponents generating a monomial ideal containing the Jacobian ideal. -/
def jacGens : Set (Fin 6 →₀ ℕ) :=
  {d | ∃ i : Fin 3, d = Finsupp.single (Fin.castLE (by norm_num) i) 4 +
      Finsupp.single (Fin.natAdd 3 i) 1 ∨
    d = Finsupp.single (Fin.castLE (by norm_num) i) 5 ∨ d = Finsupp.single (Fin.natAdd 3 i) 5}

/-- The monomial ideal. -/
noncomputable def monIdeal : Ideal (MvPolynomial (Fin 6) ℚ) :=
  Ideal.span ((fun s => monomial s (1 : ℚ)) '' jacGens)

theorem X_pow_mem (i : Fin 3) :
    X (Fin.castLE (by norm_num) i) ^ 4 * X (Fin.natAdd 3 i) ∈ monIdeal ∧
    X (Fin.castLE (by norm_num) i) ^ 5 ∈ monIdeal ∧
    (X (Fin.natAdd 3 i) ^ 5 : MvPolynomial (Fin 6) ℚ) ∈ monIdeal := by
  refine ⟨Ideal.subset_span ⟨_, ⟨i, Or.inl rfl⟩, ?_⟩,
    Ideal.subset_span ⟨_, ⟨i, Or.inr (Or.inl rfl)⟩, ?_⟩,
    Ideal.subset_span ⟨_, ⟨i, Or.inr (Or.inr rfl)⟩, ?_⟩⟩ <;>
  simp [X, monomial_pow, monomial_mul]

theorem jacobianIdeal_le : jacobianIdeal ≤ monIdeal := by
  rw [jacobianIdeal, Ideal.span_le]
  rintro _ ⟨j, rfl⟩
  obtain ⟨i, rfl | rfl⟩ : ∃ i : Fin 3, j = Fin.castLE (by norm_num) i ∨ j = Fin.natAdd 3 i := by
    fin_cases j
    exacts [⟨0, Or.inl rfl⟩, ⟨1, Or.inl rfl⟩, ⟨2, Or.inl rfl⟩,
      ⟨0, Or.inr rfl⟩, ⟨1, Or.inr rfl⟩, ⟨2, Or.inr rfl⟩]
  · show pderiv _ chainSextic ∈ monIdeal
    rw [pderiv_chainSextic_low, mul_assoc]
    exact Ideal.mul_mem_left _ _ (X_pow_mem i).1
  · show pderiv _ chainSextic ∈ monIdeal
    rw [pderiv_chainSextic_high]
    exact Ideal.add_mem _ (X_pow_mem i).2.1 (Ideal.mul_mem_left _ _ (X_pow_mem i).2.2)

/-- The witness exponent `x0³ x1³ x3⁴ x4²` (degree 12). -/
noncomputable def witness : Fin 6 →₀ ℕ :=
  Finsupp.single 0 3 + Finsupp.single 1 3 + Finsupp.single 3 4 + Finsupp.single 4 2

theorem witness_degree : witness.degree = 12 := by
  simp [witness, Finsupp.degree_add]

theorem witness_not_mem : monomial witness (1 : ℚ) ∉ monIdeal := by
  rw [monIdeal, mem_ideal_span_monomial_image]
  intro h
  obtain ⟨s, ⟨i, hs⟩, hle⟩ := h witness (by simp [support_monomial])
  have ev : ∀ k : Fin 6, s k ≤ witness k := fun k => hle k
  have key : ∀ i : Fin 3, witness (Fin.castLE (by norm_num) i) ≤ 3 ∧
      witness (Fin.natAdd 3 i) ≤ 4 := by
    intro i; fin_cases i <;> simp [witness]
  have hne : Fin.castLE (n := 3) (m := 6) (by norm_num) i ≠ Fin.natAdd 3 i := by
    simp [Fin.ext_iff]
  obtain ⟨k1, k2⟩ := key i
  rcases hs with rfl | rfl | rfl
  · have := ev (Fin.castLE (by norm_num) i)
    rw [Finsupp.add_apply, Finsupp.single_eq_same] at this
    rw [Finsupp.single_eq_of_ne hne.symm] at this
    omega
  · have := ev (Fin.castLE (by norm_num) i)
    rw [Finsupp.single_eq_same] at this
    omega
  · have := ev (Fin.natAdd 3 i)
    rw [Finsupp.single_eq_same] at this
    omega

/-- The image of the witness in `R₁₂` is nonzero. -/
theorem witness_class_ne_zero :
    Ideal.Quotient.mk jacobianIdeal (monomial witness (1 : ℚ)) ≠ 0 := by
  intro h
  exact witness_not_mem (jacobianIdeal_le (Ideal.Quotient.eq_zero_iff_mem.mp h))

theorem witness_class_mem :
    Ideal.Quotient.mk jacobianIdeal (monomial witness (1 : ℚ)) ∈ jacobianDeg12 :=
  ⟨monomial witness 1, (isHomogeneous_monomial _ witness_degree), rfl⟩

open Classical in
instance : FiniteDimensional ℚ jacobianDeg12 := by
  have hle : jacobianDeg12 ≤ Submodule.span ℚ
      ((stdTriples12.image stdMonomial : Finset JacobianRing) : Set JacobianRing) := by
    unfold jacobianDeg12
    rw [homogeneousSubmodule_eq_finsupp_supported, Finsupp.supported_eq_span_single,
      Submodule.map_span, Submodule.span_le]
    rintro _ ⟨_, ⟨d, hd, rfl⟩, rfl⟩
    simp only [AlgHom.toLinearMap_apply, single_eq_monomial]
    exact mk_monomial_mem d hd
  exact Submodule.finiteDimensional_of_le hle

set_option synthInstance.maxHeartbeats 400000 in
/-- **`R₁₂ ≠ 0`**, unconditionally: `1 ≤ dim_ℚ R₁₂ ≤ 1751`. -/
theorem one_le_finrank_jacobianDeg12 : 1 ≤ finrank ℚ jacobianDeg12 := by
  rw [Nat.one_le_iff_ne_zero, Ne, Submodule.finrank_eq_zero]
  intro h
  have := witness_class_mem
  rw [h, Submodule.mem_bot] at this
  exact witness_class_ne_zero this


/-! ## A model of `ChainSexticHodgeBridge` -/

/-- `r = dim_ℚ R₁₂` (`r = 1751`: `ChainSexticR12Bridge.r_eq`). -/
noncomputable abbrev r : ℕ := finrank ℚ jacobianDeg12

/-- Model space of dimension `1 + r`. -/
abbrev ModelH : Type := (Fin 2 → ℚ) × (Fin (r - 1) → ℚ)

theorem finrank_modelH : finrank ℚ ModelH = 1 + r := by
  have := one_le_finrank_jacobianDeg12
  rw [Module.finrank_prod, Module.finrank_fin_fun, Module.finrank_fin_fun]
  show 2 + (finrank ℚ jacobianDeg12 - 1) = 1 + finrank ℚ jacobianDeg12
  omega

/-- Gram matrix `[[6, 1], [1, 21]]` of `(h², [Π])`. -/
def gram : Matrix (Fin 2) (Fin 2) ℚ := !![6, 1; 1, 21]

/-- The model pairing: the Gram form on the first two coordinates. -/
noncomputable def modelPairing : LinearMap.BilinForm ℚ ModelH :=
  (Matrix.toLinearMap₂' ℚ gram).compl₁₂ (LinearMap.fst ℚ _ _) (LinearMap.fst ℚ _ _)

/-- An explicit inhabitant of the bridge: the hypotheses of `rho_bounds` are consistent.
This is linear algebra, not the cohomology of the sextic. -/
noncomputable def hodgeBridge_model : ChainSexticHodgeBridge ModelH where
  H22 := ⊤
  griffiths := by
    rw [finrank_top, Module.finrank_baseChange, finrank_modelH]
  pairing := modelPairing
  h2 := (Pi.single 0 1, 0)
  P := (Pi.single 1 1, 0)
  h2_hodge := Submodule.mem_top
  P_hodge := Submodule.mem_top
  h2_h2 := by simp [modelPairing, Matrix.toLinearMap₂'_apply', gram]
  h2_P := by simp [modelPairing, Matrix.toLinearMap₂'_apply', gram]
  P_h2 := by simp [modelPairing, Matrix.toLinearMap₂'_apply', gram]
  P_P := by
    rw [planeSelfIntersection_eq]
    simp [modelPairing, Matrix.toLinearMap₂'_apply', gram]

theorem hodgeBridge_nonempty : Nonempty (ChainSexticHodgeBridge ModelH) := ⟨hodgeBridge_model⟩

/-- In the model `ρ = 1 + r`, the top of the range: the bridge alone does not pin `ρ`. -/
theorem model_rho : hodgeBridge_model.rho = 1 + r := by
  rw [ChainSexticHodgeBridge.rho, ← finrank_modelH]
  have : rationalPoints (hodgeBridge_model.H22) = ⊤ := by
    ext v; simp [mem_rationalPoints, hodgeBridge_model]
  rw [this, finrank_top]

/-- The lower bound is not automatic: for the subspace `⊥` in place of `H^{2,2}` the rational
rank is `0`. The Gram fields of the bridge are what force `2 ≤ ρ`. -/
theorem rho_not_automatic {H : Type*} [AddCommGroup H] [Module ℚ H] [FiniteDimensional ℚ H] :
    finrank ℚ (rationalPoints (⊥ : Submodule ℂ (ℂ ⊗[ℚ] H))) = 0 := by
  have := finrank_rationalPoints_le (H := H) ⊥
  rw [finrank_bot] at this
  omega

/-! ## What the character bridge forces -/

open Hodge.ChainSexticRho

theorem count_type22 : count3 (fun i j k => qv i j k == 2) = 1751 := by decide +kernel

theorem type22_card : type22.card = 1751 := by
  have e : type22 = range30cube.filter fun c => (qv c.1 c.2.1 c.2.2 == 2) = true := by
    ext c
    simp only [type22, primChars, Finset.mem_filter, beq_iff_eq]
    constructor
    · rintro ⟨⟨h1, _⟩, h2⟩; exact ⟨h1, h2⟩
    · rintro ⟨h1, h2⟩; exact ⟨⟨h1, by omega⟩, h2⟩
  rw [e, ← count_type22, Finset.card_filter, range30cube, Finset.sum_product, count3, sumBelow_eq]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_product, sumBelow_eq]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [sumBelow_eq]

/-- Any character bridge has `h^{2,2} = 1 + #type22 = 1752`. -/
theorem characterBridge_h22 {H : Type*} [AddCommGroup H] [Module ℚ H] [FiniteDimensional ℚ H]
    (D : ChainSexticCharacterBridge H) : finrank ℂ D.H22 = 1752 := by
  classical
  have hh2 : D.h2 ≠ 0 := by
    intro h; have := D.h2_h2; rw [h] at this; simp at this
  have hline : finrank ℂ (Submodule.span ℂ {(1 : ℂ) ⊗ₜ[ℚ] D.h2}) = 1 := by
    rw [← cx_span_singleton, finrank_cx, finrank_span_singleton hh2]
  have hsup : (Submodule.span ℂ {(1 : ℂ) ⊗ₜ[ℚ] D.h2} ⊔ ⨆ χ ∈ type22, D.V χ) =
      ⨆ o ∈ insert none (type22.map Function.Embedding.some), eigenFamily D.h2 D.V o := by
    rw [Finset.iSup_insert, ← Finset.sup_eq_iSup _ (eigenFamily D.h2 D.V), Finset.sup_map,
      Finset.sup_eq_iSup]
    rfl
  have hnone : (none : Option Ch) ∉ type22.map Function.Embedding.some := by simp
  rw [D.h22_eq, hsup, finrank_biSup_of_indep _ D.eigen_indep,
    Finset.sum_insert hnone, Finset.sum_map]
  simp only [eigenFamily, Function.Embedding.some_apply]
  rw [hline, Finset.sum_congr rfl (fun χ hχ => D.V_line χ (mem_type22.mp hχ).1),
    Finset.sum_const, type22_card]
  rfl

/-- **Necessity.** A character bridge exists only if `dim_ℚ R₁₂ = 1751`. The equality is
proved in `Hodge.ChainSexticR12.jacobianDeg12_finrank_eq`, so this condition is satisfied; it is
necessary, not sufficient, for an inhabitant. -/
theorem characterBridge_forces_R12 {H : Type*} [AddCommGroup H] [Module ℚ H]
    [FiniteDimensional ℚ H] (D : ChainSexticCharacterBridge H) :
    finrank ℚ jacobianDeg12 = 1751 := by
  have h1 := characterBridge_h22 D
  have h2 := D.griffiths
  omega

end ChainSexticBridgeAudit
end Hodge
