/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Mathlib.RingTheory.Polynomial.Eisenstein.Criterion
import Mathlib.RingTheory.Polynomial.GaussLemma
import Mathlib.Analysis.Complex.Polynomial.Basic
import Mathlib.RingTheory.PowerBasis
import Mathlib.FieldTheory.Minpoly.Field
import Mathlib.Data.Nat.Prime.Int

/-!
# An algebraic number of degree 8

An eighth root of two in `ℂ`, with minimal polynomial `X^8 - 2` over `ℚ`
(Eisenstein at `2`, then Gauss's lemma).  The powers `1, α, …, α^7` are
linearly independent over `ℚ`.  This is used to twist mixed-orbit eigenlines
so that a proper subset of an orbit has no rational points.

This is field arithmetic, not geometry.
-/

open Polynomial Ideal PowerBasis

noncomputable section

namespace Hodge
namespace ChainSexticCharacterModel

/-- The monic integer polynomial `X^8 - 2`. -/
def poly8Z : ℤ[X] := X ^ 8 - C 2

theorem poly8Z_monic : poly8Z.Monic :=
  monic_X_pow_sub_C 2 (by decide : (8 : ℕ) ≠ 0)

theorem poly8Z_irreducible : Irreducible poly8Z := by
  have hP : (span {(2 : ℤ)}).IsPrime :=
    (span_singleton_prime (by decide : (2 : ℤ) ≠ 0)).mpr Int.prime_two
  refine irreducible_of_eisenstein_criterion hP ?lead ?mem ?deg ?trail poly8Z_monic.isPrimitive
  · rw [poly8Z, leadingCoeff_X_pow_sub_C (by decide : 0 < 8), mem_span_singleton]
    decide
  · intro n hn
    rw [poly8Z, degree_X_pow_sub_C (by decide : 0 < 8)] at hn
    norm_cast at hn
    rw [mem_span_singleton, poly8Z, coeff_sub, coeff_X_pow, coeff_C]
    interval_cases n <;> decide
  · rw [poly8Z, degree_X_pow_sub_C (by decide : 0 < 8)]
    decide
  · rw [poly8Z, coeff_sub, coeff_X_pow, coeff_C, span_singleton_pow, mem_span_singleton]
    decide

/-- `X^8 - 2` is irreducible over `ℚ`. -/
theorem poly8_irreducible : Irreducible (X ^ 8 - C (2 : ℚ) : ℚ[X]) := by
  have hmap : (X ^ 8 - C (2 : ℚ) : ℚ[X]) = poly8Z.map (Int.castRingHom ℚ) := by
    simp [poly8Z, Polynomial.map_sub, Polynomial.map_pow, map_X, map_ofNat]
  rw [hmap]
  exact (IsPrimitive.Int.irreducible_iff_irreducible_map_cast poly8Z_monic.isPrimitive).mp
    poly8Z_irreducible

theorem exists_eighth_root_two : ∃ α : ℂ, α ^ 8 = 2 := by
  have hdeg : ((X : ℂ[X]) ^ 8 - C 2).degree ≠ 0 := by
    rw [degree_X_pow_sub_C (by decide : 0 < 8)]
    decide
  obtain ⟨α, hα⟩ := IsAlgClosed.exists_root ((X : ℂ[X]) ^ 8 - C 2) hdeg
  refine ⟨α, ?_⟩
  simpa [IsRoot, eval_sub, eval_pow, eval_X, eval_C, sub_eq_zero] using hα

/-- A chosen eighth root of two in `ℂ`. -/
noncomputable def alpha : ℂ := Classical.choose exists_eighth_root_two

theorem alpha_pow_eight : alpha ^ 8 = 2 :=
  Classical.choose_spec exists_eighth_root_two

theorem aeval_poly8 : (aeval alpha) (X ^ 8 - C (2 : ℚ)) = 0 := by
  simp [aeval_def, eval₂_sub, eval₂_pow, eval₂_X, alpha_pow_eight, map_ofNat]

theorem minpoly_alpha : minpoly ℚ alpha = X ^ 8 - C 2 :=
  (minpoly.eq_of_irreducible_of_monic poly8_irreducible aeval_poly8
    (monic_X_pow_sub_C (2 : ℚ) (by decide : (8 : ℕ) ≠ 0))).symm

theorem minpoly_alpha_natDegree : (minpoly ℚ alpha).natDegree = 8 := by
  rw [minpoly_alpha, natDegree_X_pow_sub_C]

/-- The powers `1, α, …, α^7` are linearly independent over `ℚ`. -/
theorem alpha_pow_independent :
    LinearIndependent ℚ (fun i : Fin 8 => alpha ^ (i : ℕ)) := by
  have h := linearIndependent_pow (K := ℚ) (S := ℂ) alpha
  rwa [minpoly_alpha_natDegree] at h

/-- A linear combination of `{1, α, …, α^7}` that vanishes has zero coefficients. -/
theorem alpha_pow_eq_zero {c : Fin 8 → ℚ}
    (h : ∑ i : Fin 8, c i • alpha ^ (i : ℕ) = 0) : ∀ i, c i = 0 :=
  Fintype.linearIndependent_iff.mp alpha_pow_independent c h

end ChainSexticCharacterModel
end Hodge

end
