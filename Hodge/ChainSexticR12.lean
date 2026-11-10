/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Hodge.ChainSexticRank

/-!
# `dim_ℚ R₁₂ = 1751` for the chain sextic (kernel-checked equality)

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6.

`Hodge.ChainSexticRank.jacobianDeg12_finrank_le` proves `dim_ℚ R₁₂ ≤ 1751`: every degree-12
monomial reduces to a combination of the 1751 standard monomials (`stdTriples12`). This file
proves the reverse inequality, so the dimension is exactly 1751.

## The argument (every step is a Lean lemma below)

1. **Pair normal form** `pnf i j a b`. For one pair `(x, y) = (x_i, x_j)` the relations
   `x⁴y = 0`, `x⁵ = -6y⁵`, `y⁶ = 0` send each monomial `x^a y^b` to `0`, to itself, or to
   `-6 x^(a-5) y⁵`:
   * `b ≥ 6` gives `0`; `a ≥ 4` and `b ≥ 1` gives `0`;
   * `a ≤ 4` (and not the above) gives `x^a y^b` itself (a standard monomial);
   * `b = 0` and `5 ≤ a ≤ 8` gives `-6 x^(a-5) y⁵`; `b = 0` and `a ≥ 9` gives `0`.
2. `pnf_rel1`: `pnf (a+4) (b+1) = 0`, i.e. the normal form kills `x^a y^b · x⁴y`.
3. `pnf_rel2`: `pnf (a+5) b + 6 · pnf a (b+5) = 0`, i.e. it kills `x^a y^b · (x⁵ + 6y⁵)`.
   Case `b ≥ 1`: both terms are `0`. Case `b = 0`, `a ≤ 3`: `-6 x^a y⁵ + 6 x^a y⁵ = 0`.
   Case `b = 0`, `a ≥ 4`: `a + 5 ≥ 9` and `(a, 5)` has `a ≥ 4, 5 ≥ 1`, so both are `0`.
4. `pnf_std`: on a standard pair `(a, b) ∈ stdPairs` the normal form is `x^a y^b`.
5. `nf d` is the product of the three pair normal forms of the monomial `x^d`, and `normalForm` is the
   `ℚ`-linear map `ℚ[x0,…,x5] → ℚ[x0,…,x5]` with `normalForm (x^d) = nf d` (`Basis.constr` on the
   monomial basis; `normalForm_monomial`).
6. `normalForm_mul_pderiv`: `normalForm (c · ∂_i F) = 0` for every polynomial `c` and every `i`. By linearity in
   `c` it suffices to take `c` a monomial `r x^u`. The partials are `∂_{x_k} F = 5 x_k⁴ y_k` and
   `∂_{y_k} F = x_k⁵ + 6 y_k⁵` (`pderiv_chainSextic_low/high`); then the factor of `nf` for
   pair `k` vanishes by step 2 or step 3 and the other two factors are unchanged.
7. `normalForm_jacobianIdeal`: `normalForm` vanishes on the whole Jacobian ideal (induction on the ideal span,
   proving the stronger `∀ c, normalForm (c · p) = 0`).
8. `normalForm_std`: `normalForm` fixes every standard monomial `x^(dt t)`, `t ∈ stdTriples` (step 4).
9. `stdMonomial_linearIndependent`: if `Σ g_t · [x^(dt t)] = 0` in `R = ℚ[x]/J`, then
   `P = Σ g_t x^(dt t) ∈ J`, so `P = normalForm P = 0` (steps 7, 8). The exponents `dt t` are distinct
   (`dt_injective`), so the coefficient of `x^(dt t)` in `P` is `g_t`, hence `g_t = 0`.
   The proof works for any set of standard triples (`stdMonomial_linearIndependent_of_subset`),
   so all `25³ = 15625` standard monomials of every degree are independent
   (`stdMonomial_linearIndependent_all`); only degree 12 is used below.
10. `jacobianDeg12_eq_span`: `R₁₂` is exactly the span of the 1751 standard monomials
    (`≤` is the existing reduction, `≥` because each has degree 12: `stdMonomial_mem`).
11. `jacobianDeg12_finrank_eq : finrank ℚ jacobianDeg12 = 1751`
    (`finrank_span_eq_card` with step 9 and `stdTriples12_card`), and `jacobianDeg12_basis`.

The map `normalForm` is the Gröbner normal form for the lex-type order in which `x_k⁵ → -6 y_k⁵`. Lean does
not use Gröbner-basis theory: the only facts used are steps 2–3, proved by case analysis.

## What this does and does not say

It is a statement about the polynomial `F` and its Jacobian ring over `ℚ`. It does not
formalize cohomology, the Griffiths residue isomorphism, or any Hodge class. No `sorry`,
no `native_decide`, no new axioms.

## Non-vacuity checks

* `normalForm_x0_pow_five`: `normalForm (x0⁵) = -6 x3⁵` (the normal form is not the identity);
* `normalForm_x0_four_x3`: `normalForm (x0⁴ x3) = 0` (it kills a Jacobian relation);
* `jacobianIdeal_ne_top`: `J ≠ (1)`, so `R` is not the zero ring;
* `stdMonomial_ne_zero`: every one of the 1751 classes is nonzero;
* `nonstd_eq_neg_six`: the nonstandard class `x0⁵ x1⁷` equals `-6 x3⁵ x1⁷` in `R` (it is
  not a new basis element, so the count 1751 is not inflated by non-standard monomials).
-/

open Module MvPolynomial Hodge.ChainSexticRank

namespace Hodge
namespace ChainSexticR12


noncomputable def pnf (i j : Fin 6) (a b : ℕ) : MvPolynomial (Fin 6) ℚ :=
  if 6 ≤ b then 0 else if 4 ≤ a ∧ 1 ≤ b then 0 else if a ≤ 4 then X i ^ a * X j ^ b
  else if a ≤ 8 then -6 * (X i ^ (a - 5) * X j ^ 5) else 0

theorem pnf_rel1 (i j : Fin 6) (a b : ℕ) : pnf i j (a + 4) (b + 1) = 0 := by
  unfold pnf; split_ifs <;> first | rfl | omega

theorem pnf_rel2 (i j : Fin 6) (a b : ℕ) : pnf i j (a + 5) b + 6 * pnf i j a (b + 5) = 0 := by
  rcases Nat.eq_zero_or_pos b with rfl | hb
  · unfold pnf
    split_ifs <;> first | omega | simp
  · unfold pnf
    split_ifs <;> first | omega | simp

theorem pnf_std (i j : Fin 6) (p : ℕ × ℕ) (hp : p ∈ stdPairs) :
    pnf i j p.1 p.2 = X i ^ p.1 * X j ^ p.2 := by
  simp only [stdPairs, Finset.mem_filter, Finset.mem_product, Finset.mem_range] at hp
  unfold pnf; split_ifs <;> first | rfl | omega

noncomputable def nf (d : Fin 6 →₀ ℕ) : MvPolynomial (Fin 6) ℚ :=
  pnf 0 3 (d 0) (d 3) * pnf 1 4 (d 1) (d 4) * pnf 2 5 (d 2) (d 5)

noncomputable def normalForm : MvPolynomial (Fin 6) ℚ →ₗ[ℚ] MvPolynomial (Fin 6) ℚ :=
  (basisMonomials (Fin 6) ℚ).constr ℚ nf

theorem normalForm_monomial (d : Fin 6 →₀ ℕ) (r : ℚ) : normalForm (monomial d r) = r • nf d := by
  have : monomial d r = r • monomial d (1 : ℚ) := by rw [smul_monomial, smul_eq_mul, mul_one]
  rw [this, map_smul]
  have h := (basisMonomials (Fin 6) ℚ).constr_basis ℚ nf d
  rw [coe_basisMonomials] at h
  rw [normalForm, h]

theorem mon_mul_X_pow (u : Fin 6 →₀ ℕ) (r : ℚ) (i : Fin 6) (k : ℕ) :
    monomial u r * X i ^ k = monomial (u + Finsupp.single i k) r := by
  rw [X_pow_eq_monomial, monomial_mul, mul_one]

theorem pd_low (i j : Fin 6) (h : pderiv i chainSextic = 5 * X i ^ 4 * X j) :
    pderiv i chainSextic = (5 : ℚ) • (X i ^ 4 * X j ^ 1) := by
  rw [h, smul_eq_C_mul, pow_one, map_ofNat, mul_assoc]

theorem pd_high (i j : Fin 6) (h : pderiv j chainSextic = X i ^ 5 + 6 * X j ^ 5) :
    pderiv j chainSextic = X i ^ 5 + (6 : ℚ) • X j ^ 5 := by
  rw [h, smul_eq_C_mul, map_ofNat]

theorem g0 : pderiv 0 chainSextic = 5 * X 0 ^ 4 * X 3 := pderiv_chainSextic_low 0
theorem g3 : pderiv 3 chainSextic = X 0 ^ 5 + 6 * X 3 ^ 5 := pderiv_chainSextic_high 0

theorem g1 : pderiv 1 chainSextic = 5 * X 1 ^ 4 * X 4 := pderiv_chainSextic_low 1
theorem g4 : pderiv 4 chainSextic = X 1 ^ 5 + 6 * X 4 ^ 5 := pderiv_chainSextic_high 1
theorem g2 : pderiv 2 chainSextic = 5 * X 2 ^ 4 * X 5 := pderiv_chainSextic_low 2
theorem g5 : pderiv 5 chainSextic = X 2 ^ 5 + 6 * X 5 ^ 5 := pderiv_chainSextic_high 2

theorem normalForm_mul_low (u : Fin 6 →₀ ℕ) (r : ℚ) (i j : Fin 6)
    (h : pderiv i chainSextic = 5 * X i ^ 4 * X j)
    (hn : nf (u + Finsupp.single i 4 + Finsupp.single j 1) = 0) :
    normalForm (monomial u r * pderiv i chainSextic) = 0 := by
  rw [pd_low i j h, mul_smul_comm, ← mul_assoc, mon_mul_X_pow, mon_mul_X_pow, map_smul,
    normalForm_monomial, hn, smul_zero, smul_zero]

theorem normalForm_mul_high (u : Fin 6 →₀ ℕ) (r : ℚ) (i j : Fin 6)
    (h : pderiv j chainSextic = X i ^ 5 + 6 * X j ^ 5)
    (hn : nf (u + Finsupp.single i 5) + 6 * nf (u + Finsupp.single j 5) = 0) :
    normalForm (monomial u r * pderiv j chainSextic) = 0 := by
  rw [pd_high i j h, mul_add, mul_smul_comm, mon_mul_X_pow, mon_mul_X_pow, map_add, map_smul,
    normalForm_monomial, normalForm_monomial, smul_comm, ← smul_add, smul_eq_C_mul (nf (u + _)) (6 : ℚ),
    map_ofNat, hn, smul_zero]

theorem normalForm_mul_pderiv (c : MvPolynomial (Fin 6) ℚ) (i : Fin 6) :
    normalForm (c * pderiv i chainSextic) = 0 := by
  induction c using MvPolynomial.induction_on' with
  | monomial u r =>
    fin_cases i
    · refine normalForm_mul_low u r 0 3 g0 ?_
      simp [nf, pnf_rel1]
    · refine normalForm_mul_low u r 1 4 g1 ?_
      simp [nf, pnf_rel1]
    · refine normalForm_mul_low u r 2 5 g2 ?_
      simp [nf, pnf_rel1]
    · refine normalForm_mul_high u r 0 3 g3 ?_
      simp only [nf, Finsupp.add_apply, Finsupp.single_apply]
      simp
      linear_combination (pnf 1 4 (u 1) (u 4) * pnf 2 5 (u 2) (u 5)) * pnf_rel2 0 3 (u 0) (u 3)
    · refine normalForm_mul_high u r 1 4 g4 ?_
      simp only [nf, Finsupp.add_apply, Finsupp.single_apply]
      simp
      linear_combination (pnf 0 3 (u 0) (u 3) * pnf 2 5 (u 2) (u 5)) * pnf_rel2 1 4 (u 1) (u 4)
    · refine normalForm_mul_high u r 2 5 g5 ?_
      simp only [nf, Finsupp.add_apply, Finsupp.single_apply]
      simp
      linear_combination (pnf 0 3 (u 0) (u 3) * pnf 1 4 (u 1) (u 4)) * pnf_rel2 2 5 (u 2) (u 5)
  | add p q hp hq => rw [add_mul, map_add, hp, hq, add_zero]

theorem normalForm_jacobianIdeal {p : MvPolynomial (Fin 6) ℚ} (hp : p ∈ jacobianIdeal) : normalForm p = 0 := by
  suffices ∀ c, normalForm (c * p) = 0 by simpa using this 1
  induction hp using Submodule.span_induction with
  | mem x hx => obtain ⟨i, rfl⟩ := hx; exact fun c => normalForm_mul_pderiv c i
  | zero => intro c; simp
  | add x y _ _ hx hy => intro c; rw [mul_add, map_add, hx, hy, add_zero]
  | smul a x _ hx => intro c; rw [smul_eq_mul, ← mul_assoc]; exact hx _

abbrev Triple := (ℕ × ℕ) × (ℕ × ℕ) × (ℕ × ℕ)

noncomputable def dt (t : Triple) : Fin 6 →₀ ℕ :=
  (Finsupp.single 0 t.1.1 + Finsupp.single 3 t.1.2) +
    (Finsupp.single 1 t.2.1.1 + Finsupp.single 4 t.2.1.2) +
    (Finsupp.single 2 t.2.2.1 + Finsupp.single 5 t.2.2.2)

theorem prod_X_eq (t : Triple) :
    (X 0 ^ t.1.1 * X 3 ^ t.1.2) * (X 1 ^ t.2.1.1 * X 4 ^ t.2.1.2) *
      (X 2 ^ t.2.2.1 * X 5 ^ t.2.2.2) = (monomial (dt t) (1 : ℚ)) := by
  simp only [X_pow_eq_monomial, monomial_mul, one_mul, dt]

theorem dt_apply (t : Triple) :
    dt t 0 = t.1.1 ∧ dt t 3 = t.1.2 ∧ dt t 1 = t.2.1.1 ∧ dt t 4 = t.2.1.2 ∧
      dt t 2 = t.2.2.1 ∧ dt t 5 = t.2.2.2 := by
  simp [dt]

theorem dt_injective : Function.Injective dt := by
  intro t t' h
  obtain ⟨a0, a3, a1, a4, a2, a5⟩ := dt_apply t
  obtain ⟨b0, b3, b1, b4, b2, b5⟩ := dt_apply t'
  rw [h] at a0 a3 a1 a4 a2 a5
  obtain ⟨⟨_, _⟩, ⟨_, _⟩, ⟨_, _⟩⟩ := t
  obtain ⟨⟨_, _⟩, ⟨_, _⟩, ⟨_, _⟩⟩ := t'
  simp_all

theorem dt_degree (t : Triple) (ht : t ∈ stdTriples12) : (dt t).degree = 12 := by
  simp only [stdTriples12, Finset.mem_filter] at ht
  simp only [dt, Finsupp.degree_add, Finsupp.degree_single]
  omega

theorem stdMonomial_eq (t : Triple) :
    stdMonomial t = Ideal.Quotient.mk jacobianIdeal (monomial (dt t) (1 : ℚ)) := by
  rw [← prod_X_eq, stdMonomial]
  simp only [xbar, map_mul, map_pow]

/-- All `25³ = 15625` standard exponent triples (every degree). -/
def stdTriples : Finset Triple := stdPairs ×ˢ stdPairs ×ˢ stdPairs

theorem stdTriples_card : stdTriples.card = 15625 := by
  simp [stdTriples, Finset.card_product, stdPairs_card]

theorem stdTriples12_subset : stdTriples12 ⊆ stdTriples := fun _ ht =>
  (Finset.mem_filter.mp ht).1

theorem normalForm_std (t : Triple) (ht : t ∈ stdTriples) :
    normalForm (monomial (dt t) (1 : ℚ)) = monomial (dt t) 1 := by
  simp only [stdTriples, Finset.mem_product] at ht
  obtain ⟨h0, h1, h2⟩ := ht
  obtain ⟨a0, a3, a1, a4, a2, a5⟩ := dt_apply t
  rw [normalForm_monomial, one_smul, nf, a0, a3, a1, a4, a2, a5, pnf_std 0 3 _ h0, pnf_std 1 4 _ h1,
    pnf_std 2 5 _ h2, prod_X_eq]

/-- Any set `S` of standard triples gives linearly independent classes in `ℚ[x]/J`. -/
theorem stdMonomial_linearIndependent_of_subset (S : Finset Triple) (hS : S ⊆ stdTriples) :
    LinearIndependent ℚ (fun t : S => stdMonomial t.1) := by
  classical
  rw [linearIndependent_iff']
  intro s g hs i hi
  set P : MvPolynomial (Fin 6) ℚ := ∑ j ∈ s, g j • monomial (dt j.1) (1 : ℚ) with hP
  have hmk : Ideal.Quotient.mkₐ ℚ jacobianIdeal P = 0 := by
    rw [hP, map_sum, ← hs]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [map_smul, Ideal.Quotient.mkₐ_eq_mk, stdMonomial_eq]
  have hJ : P ∈ jacobianIdeal := by
    rw [Ideal.Quotient.mkₐ_eq_mk] at hmk
    exact Ideal.Quotient.eq_zero_iff_mem.mp hmk
  have hΦ : normalForm P = P := by
    rw [hP, map_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [map_smul, normalForm_std j.1 (hS j.2)]
  have hP0 : P = 0 := by rw [← hΦ]; exact normalForm_jacobianIdeal hJ
  have hc := congrArg (coeff (dt i.1)) hP0
  rw [hP, coeff_sum, Finset.sum_eq_single i] at hc
  · simpa using hc
  · intro j _ hji
    rw [coeff_smul, coeff_monomial, if_neg, smul_zero]
    intro h
    exact hji (Subtype.ext (dt_injective h))
  · intro h; exact absurd hi h

/-- The 1751 standard monomials of degree 12 are linearly independent in `ℚ[x]/J`. -/
theorem stdMonomial_linearIndependent :
    LinearIndependent ℚ (fun t : stdTriples12 => stdMonomial t.1) :=
  stdMonomial_linearIndependent_of_subset stdTriples12 stdTriples12_subset

/-- All 15625 standard monomials (every degree) are linearly independent in `ℚ[x]/J`. -/
theorem stdMonomial_linearIndependent_all :
    LinearIndependent ℚ (fun t : stdTriples => stdMonomial t.1) :=
  stdMonomial_linearIndependent_of_subset stdTriples subset_rfl

theorem stdMonomial_mem (t : Triple) (ht : t ∈ stdTriples12) : stdMonomial t ∈ jacobianDeg12 :=
  ⟨monomial (dt t) 1, isHomogeneous_monomial _ (dt_degree t ht), (stdMonomial_eq t).symm⟩

open Classical in
theorem jacobianDeg12_le_span : jacobianDeg12 ≤ Submodule.span ℚ
    ((stdTriples12.image stdMonomial : Finset JacobianRing) : Set JacobianRing) := by
  unfold jacobianDeg12
  rw [homogeneousSubmodule_eq_finsupp_supported, Finsupp.supported_eq_span_single,
    Submodule.map_span, Submodule.span_le]
  rintro _ ⟨_, ⟨d, hd, rfl⟩, rfl⟩
  simp only [AlgHom.toLinearMap_apply, single_eq_monomial]
  exact mk_monomial_mem d hd

theorem jacobianDeg12_eq_span :
    jacobianDeg12 = Submodule.span ℚ (Set.range fun t : stdTriples12 => stdMonomial t.1) := by
  classical
  apply le_antisymm
  · refine jacobianDeg12_le_span.trans (Submodule.span_mono ?_)
    rintro _ hx
    rw [Finset.coe_image] at hx
    obtain ⟨t, ht, rfl⟩ := hx
    exact ⟨⟨t, ht⟩, rfl⟩
  · rw [Submodule.span_le]
    rintro _ ⟨t, rfl⟩
    exact stdMonomial_mem t.1 t.2

theorem jacobianDeg12_finrank_eq : finrank ℚ jacobianDeg12 = 1751 := by
  rw [jacobianDeg12_eq_span, finrank_span_eq_card stdMonomial_linearIndependent,
    Fintype.card_coe, stdTriples12_card]

theorem le_finrank_jacobianDeg12 : 1751 ≤ finrank ℚ jacobianDeg12 :=
  jacobianDeg12_finrank_eq.ge

/-- An explicit basis of `R₁₂` indexed by the 1751 standard triples. -/
noncomputable def jacobianDeg12_basis : Basis stdTriples12 ℚ jacobianDeg12 :=
  (Basis.span stdMonomial_linearIndependent).map
    (LinearEquiv.ofEq _ _ jacobianDeg12_eq_span.symm)

theorem jacobianDeg12_basis_apply (t : stdTriples12) :
    (jacobianDeg12_basis t : JacobianRing) = stdMonomial t.1 := by
  simp [jacobianDeg12_basis, Basis.span_apply]

/-! ## Non-vacuity checks -/

theorem normalForm_x0_pow_five : normalForm (X 0 ^ 5) = -6 * X 3 ^ 5 := by
  rw [X_pow_eq_monomial, normalForm_monomial, one_smul]
  simp [nf, pnf]

theorem normalForm_x0_four_x3 : normalForm (X 0 ^ 4 * X 3) = 0 := by
  have : (X 0 ^ 4 * X 3 : MvPolynomial (Fin 6) ℚ) =
      monomial (Finsupp.single 0 4 + Finsupp.single 3 1) 1 := by
    rw [X_pow_eq_monomial, X, monomial_mul, one_mul]
  rw [this, normalForm_monomial, one_smul]
  simp [nf, pnf]

theorem jacobianIdeal_ne_top : jacobianIdeal ≠ ⊤ := by
  intro h
  have h1 : (1 : MvPolynomial (Fin 6) ℚ) ∈ jacobianIdeal := h ▸ Submodule.mem_top
  have := normalForm_jacobianIdeal h1
  rw [show (1 : MvPolynomial (Fin 6) ℚ) = monomial 0 1 from rfl, normalForm_monomial, one_smul] at this
  simp [nf, pnf] at this

theorem stdMonomial_ne_zero (t : Triple) (ht : t ∈ stdTriples12) : stdMonomial t ≠ 0 := by
  have h := LinearIndependent.ne_zero (R := ℚ) (⟨t, ht⟩ : stdTriples12)
    stdMonomial_linearIndependent
  exact h

theorem nonstd_eq_neg_six :
    xbar 0 ^ 5 * xbar 1 ^ 7 = -6 * (xbar 3 ^ 5 * xbar 1 ^ 7) := by
  have h : xbar 0 ^ 5 = -6 * xbar 3 ^ 5 := (pair_relations 0).2.1
  rw [h]
  ring

end ChainSexticR12
end Hodge
