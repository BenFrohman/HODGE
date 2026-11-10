/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache 2.0 license.
Author: Frohman, Benjamin Stanley.

Degree-five independence in the actual binary Jacobian quotient. These are
coefficient annihilators of the full ideal, not an assumed quotient basis.
-/
import Hodge.ExplicitJacobianQuotient
import Mathlib.LinearAlgebra.LinearIndependent.Defs

noncomputable section
namespace Hodge.ExplicitJacobianIndependence
open MvPolynomial ExplicitJacobianQuotient

def exponent (a b : ℕ) : Fin 2 →₀ ℕ := Finsupp.single 0 a + Finsupp.single 1 b

theorem monomial_exponent {K : Type*} [CommRing K] (a b : ℕ) (c : K) :
    monomial (exponent a b) c = C c * (x : Binary K)^a * y^b := by
  simp only [exponent, x, y, X_pow_eq_monomial, C_apply, monomial_mul,
    zero_add, mul_one]

theorem partial_x_monomial {K : Type*} [CommRing K] (k : K) :
    pderiv 0 (binarySextic k) = monomial (exponent 4 1) (5*k) := by
  rw [partial_x, monomial_exponent]
  simp [map_mul, map_ofNat]

theorem partial_y_monomial {K : Type*} [CommRing K] (k : K) :
    pderiv 1 (binarySextic k) =
      monomial (exponent 5 0) k + monomial (exponent 0 5) 6 := by
  rw [partial_y, monomial_exponent, monomial_exponent]
  simp [map_ofNat]

/-- Every full-ideal element obeys four degree-five coefficient constraints.
The multipliers are arbitrary polynomials of any degree. The last functional
records the actual relation k*x^5 + 6*y^5, with its correct sign. -/
theorem jacobian_ideal_coefficient_constraints {K : Type*} [CommRing K]
    (k : K) (p : Binary K) (hp : p ∈ jacobianIdeal k) :
    coeff (exponent 1 4) p = 0 ∧ coeff (exponent 2 3) p = 0 ∧
    coeff (exponent 3 2) p = 0 ∧
    k * coeff (exponent 0 5) p - 6 * coeff (exponent 5 0) p = 0 := by
  obtain ⟨a,b,h⟩ := Ideal.mem_span_pair.mp hp
  rw [← h, partial_x_monomial, partial_y_monomial]
  simp only [mul_add, coeff_add, coeff_mul_monomial']
  norm_num [exponent, Finsupp.le_def, Fin.forall_fin_two]
  ring


/-- A four-term polynomial representative; its image is not postulated to be a basis. -/
def degreeFiveRepresentative {K : Type*} [CommRing K] (c : Fin 4 → K) : Binary K :=
  monomial (exponent 0 5) (c 0) + monomial (exponent 1 4) (c 1) +
  monomial (exponent 2 3) (c 2) + monomial (exponent 3 2) (c 3)

theorem representative_coefficient {K : Type*} [CommRing K]
    (c : Fin 4 → K) (i : Fin 4) :
    coeff (exponent i.val (5-i.val)) (degreeFiveRepresentative c) = c i := by
  fin_cases i <;>
    simp [degreeFiveRepresentative, coeff_monomial, exponent, Finsupp.ext_iff,
      Fin.forall_fin_two]

theorem representative_x5_coefficient {K : Type*} [CommRing K] (c : Fin 4 → K) :
    coeff (exponent 5 0) (degreeFiveRepresentative c) = 0 := by
  simp [degreeFiveRepresentative, coeff_monomial, exponent, Finsupp.ext_iff,
    Fin.forall_fin_two]

/-- The four-term polynomial span meets the FULL ideal only in zero. -/
theorem representative_mem_ideal_iff {K : Type*} [Field K]
    (k : K) (hk : k ≠ 0) (c : Fin 4 → K) :
    degreeFiveRepresentative c ∈ jacobianIdeal k ↔ ∀ i, c i = 0 := by
  constructor
  · intro hp
    obtain ⟨h1,h2,h3,h0⟩ := jacobian_ideal_coefficient_constraints k _ hp
    have hc0 : coeff (exponent 0 5) (degreeFiveRepresentative c) = c 0 := by
      simpa using representative_coefficient c (0 : Fin 4)
    have hc1 : coeff (exponent 1 4) (degreeFiveRepresentative c) = c 1 := by
      simpa using representative_coefficient c (1 : Fin 4)
    have hc2 : coeff (exponent 2 3) (degreeFiveRepresentative c) = c 2 := by
      simpa using representative_coefficient c (2 : Fin 4)
    have hc3 : coeff (exponent 3 2) (degreeFiveRepresentative c) = c 3 := by
      simpa using representative_coefficient c (3 : Fin 4)
    rw [hc1] at h1
    rw [hc2] at h2
    rw [hc3] at h3
    rw [hc0, representative_x5_coefficient] at h0
    have hz : c 0 = 0 := (mul_eq_zero.mp (by simpa using h0)).resolve_left hk
    intro i
    fin_cases i <;> assumption
  · intro hc
    simp [degreeFiveRepresentative, hc]

/-- The actual four degree-five monomial classes, not a basis of the entire quotient. -/
def degreeFiveClasses {K : Type*} [CommRing K] (k : K) : Fin 4 → Jacobian k :=
  ![qy k^5, qx k*qy k^4, qx k^2*qy k^3, qx k^3*qy k^2]

theorem representative_class_formula {K : Type*} [CommRing K]
    (k : K) (c : Fin 4 → K) :
    Ideal.Quotient.mk (jacobianIdeal k) (degreeFiveRepresentative c) =
      constants k (c 0)*qy k^5 + constants k (c 1)*qx k*qy k^4 +
      constants k (c 2)*qx k^2*qy k^3 + constants k (c 3)*qx k^3*qy k^2 := by
  simp [degreeFiveRepresentative, monomial_exponent, constants, qx, qy,
    map_add, map_mul, map_pow]

theorem representative_class_sum {K : Type*} [CommRing K]
    (k : K) (c : Fin 4 → K) :
    Ideal.Quotient.mk (jacobianIdeal k) (degreeFiveRepresentative c) =
      ∑ i, c i • degreeFiveClasses k i := by
  rw [representative_class_formula]
  have ha (a : K) : (algebraMap K (Jacobian k)) a = constants k a := rfl
  simp [degreeFiveClasses, Fin.sum_univ_succ, Algebra.smul_def, ha,
    add_assoc, mul_assoc]

theorem representative_class_eq_zero_iff {K : Type*} [Field K]
    (k : K) (hk : k ≠ 0) (c : Fin 4 → K) :
    Ideal.Quotient.mk (jacobianIdeal k) (degreeFiveRepresentative c) = 0 ↔
      ∀ i, c i = 0 := by
  rw [Ideal.Quotient.eq_zero_iff_mem]
  exact representative_mem_ideal_iff k hk c

/-- Genuine independence over K in K[x,y]/(5*k*x^4*y,k*x^5+6*y^5).
No basis, quotient nontriviality, or geometric realization is assumed. -/
theorem degreeFiveClasses_linearIndependent {K : Type*} [Field K]
    (k : K) (hk : k ≠ 0) : LinearIndependent K (degreeFiveClasses k) := by
  apply Fintype.linearIndependent_iff.mpr
  intro c hc
  apply (representative_class_eq_zero_iff k hk c).mp
  rw [representative_class_sum]
  exact hc

/-- Stage2 coefficient nonvanishing plus the actual Stage3 quotient identity now
prove a nonzero class, rather than just a nonzero polynomial representative. -/
theorem section_HW_class_ne_zero {K : Type*} [Field K] [CharZero K] [Algebra ℚ K]
    (k : K) (hm : k^24+66081312000*k^18-4811512860000*k^12+
      1167566400000*k^6+583200000=0) :
    Ideal.Quotient.mk (jacobianIdeal k) (sectionH k*sectionW k) ≠ 0 := by
  intro hz
  let c : Fin 4 → K := ![ExplicitResidueCertificates.u0 k,
    ExplicitResidueCertificates.u1 k, ExplicitResidueCertificates.u2 k,
    ExplicitResidueCertificates.u3 k]
  have heq : Ideal.Quotient.mk (jacobianIdeal k) (degreeFiveRepresentative c) =
      Ideal.Quotient.mk (jacobianIdeal k) (sectionH k*sectionW k) := by
    rw [representative_class_formula, section_HW_class k hm]
    rfl
  have hc := (representative_class_eq_zero_iff k
    (ExplicitResidueAlgebra.section_root_ne_zero k hm) c).mp (heq.trans hz)
  exact ExplicitResidueCertificates.u0_ne_zero k hm (hc 0)

/-- The nonzero quotient class occurs at an actual complex modulus root. -/
theorem exists_complex_nonzero_HW_class : ∃ k : ℂ,
    k^24+66081312000*k^18-4811512860000*k^12+
      1167566400000*k^6+583200000=0 ∧
    Ideal.Quotient.mk (jacobianIdeal k) (sectionH k*sectionW k) ≠ 0 := by
  obtain ⟨k, hm, _⟩ := ExplicitResidueCertificates.exists_complex_nonvanishing
  exact ⟨k, hm, section_HW_class_ne_zero k hm⟩

end Hodge.ExplicitJacobianIndependence
