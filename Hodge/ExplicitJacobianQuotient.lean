/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache 2.0 license.
Author: Frohman, Benjamin Stanley.

The actual binary Jacobian quotient of f_k=x^5*y*k+y^6 used by the section.
These results identify representatives, not basis independence or geometric
cycle classes. In particular this file does not infer nonzero quotient classes
merely from the nonzero coefficients in a representative.
-/
import Hodge.ExplicitResidueCertificates

noncomputable section

namespace Hodge.ExplicitJacobianQuotient

open MvPolynomial

abbrev Binary (K : Type*) [CommRing K] := MvPolynomial (Fin 2) K

def x {K : Type*} [CommRing K] : Binary K := X 0
def y {K : Type*} [CommRing K] : Binary K := X 1

def binarySextic {K : Type*} [CommRing K] (k : K) : Binary K := C k*x^5*y+y^6

def jacobianIdeal {K : Type*} [CommRing K] (k : K) : Ideal (Binary K) :=
  Ideal.span {pderiv 0 (binarySextic k), pderiv 1 (binarySextic k)}

abbrev Jacobian {K : Type*} [CommRing K] (k : K) := Binary K ⧸ jacobianIdeal k

def qx {K : Type*} [CommRing K] (k : K) : Jacobian k := Ideal.Quotient.mk _ x
def qy {K : Type*} [CommRing K] (k : K) : Jacobian k := Ideal.Quotient.mk _ y

def constants {K : Type*} [CommRing K] (k : K) : K →+* Jacobian k :=
  (Ideal.Quotient.mk (jacobianIdeal k)).comp C

theorem partial_x {K : Type*} [CommRing K] (k : K) :
    pderiv 0 (binarySextic k) = 5*C k*x^4*y := by
  simp [binarySextic, x, y, map_add]
  ring

theorem partial_y {K : Type*} [CommRing K] (k : K) :
    pderiv 1 (binarySextic k) = C k*x^5+6*y^5 := by
  simp [binarySextic, x, y, map_add]

theorem partial_x_class {K : Type*} [CommRing K] (k : K) :
    constants k (5*k)*qx k^4*qy k = 0 := by
  have h : pderiv 0 (binarySextic k) ∈ jacobianIdeal k :=
    Ideal.subset_span (by simp)
  have hz := (Ideal.Quotient.eq_zero_iff_mem).mpr h
  simpa [partial_x, qx, qy, constants, map_mul, map_pow, map_ofNat] using hz

theorem partial_y_class {K : Type*} [CommRing K] (k : K) :
    constants k k*qx k^5+6*qy k^5 = 0 := by
  have h : pderiv 1 (binarySextic k) ∈ jacobianIdeal k :=
    Ideal.subset_span (by simp)
  have hz := (Ideal.Quotient.eq_zero_iff_mem).mpr h
  simpa [partial_y, qx, qy, constants, map_add, map_mul, map_pow, map_ofNat] using hz

theorem constant_inverse {K : Type*} [Field K] (k a : K) (ha : a ≠ 0) :
    constants k a⁻¹*constants k a = 1 := by
  rw [← map_mul, inv_mul_cancel₀ ha, map_one]

theorem x4y_class {K : Type*} [Field K] [CharZero K] (k : K) (hk : k ≠ 0) :
    qx k^4*qy k = 0 := by
  have hn : (5 : K)*k ≠ 0 := mul_ne_zero (by norm_num) hk
  have hi := constant_inverse k (5*k) hn
  calc
    qx k^4*qy k = (constants k (5*k)⁻¹*constants k (5*k))*(qx k^4*qy k) := by
      rw [hi]; ring
    _ = constants k (5*k)⁻¹*(constants k (5*k)*qx k^4*qy k) := by ring
    _ = 0 := by rw [partial_x_class, mul_zero]

theorem y6_class {K : Type*} [Field K] [CharZero K] (k : K) (hk : k ≠ 0) :
    qy k^6 = 0 := by
  have hx := x4y_class k hk
  have hy := partial_y_class k
  have h6 : (6 : Jacobian k)*qy k^6 = 0 := by
    linear_combination qy k*hy-constants k k*qx k*hx
  have hi : constants k (6⁻¹ : K)*6 = 1 := by
    simpa only [map_ofNat] using constant_inverse k (6 : K) (by norm_num)
  calc
    qy k^6 = (constants k (6⁻¹ : K)*6)*qy k^6 := by rw [hi]; ring
    _ = constants k (6⁻¹ : K)*(6*qy k^6) := by ring
    _ = 0 := by rw [h6, mul_zero]

def sectionH {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] (k : K) : Binary K :=
  x^2+C (ExplicitCurve.sb k)*x*y+C (ExplicitCurve.sc k)*y^2

def sectionG {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] (k : K) : Binary K :=
  x^3+C (ExplicitCurve.sd k)*x^2*y+C (ExplicitCurve.se k)*x*y^2+C (ExplicitCurve.sg k)*y^3

def sectionW {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] (k : K) : Binary K :=
  pderiv 0 (sectionH k)*pderiv 1 (sectionG k)-pderiv 1 (sectionH k)*pderiv 0 (sectionG k)

theorem wronskian_polynomial {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] (k : K) :
    sectionW k = C (ExplicitResidueCertificates.w3 k)*x^3+
      C (ExplicitResidueCertificates.w2 k)*x^2*y+
      C (ExplicitResidueCertificates.w1 k)*x*y^2+
      C (ExplicitResidueCertificates.w0 k)*y^3 := by
  simpa only [sectionW, sectionH, sectionG, x, y,
    ExplicitResidueCertificates.w3, ExplicitResidueCertificates.w2,
    ExplicitResidueCertificates.w1, ExplicitResidueCertificates.w0] using
    ExplicitResidueAlgebra.binary_wronskian (ExplicitCurve.sb k) (ExplicitCurve.sc k)
      (ExplicitCurve.sd k) (ExplicitCurve.se k) (ExplicitCurve.sg k)

theorem wronskian_class {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] (k : K) :
    Ideal.Quotient.mk (jacobianIdeal k) (sectionW k) =
      constants k (ExplicitResidueCertificates.w3 k)*qx k^3+
      constants k (ExplicitResidueCertificates.w2 k)*qx k^2*qy k+
      constants k (ExplicitResidueCertificates.w1 k)*qx k*qy k^2+
      constants k (ExplicitResidueCertificates.w0 k)*qy k^3 := by
  rw [wronskian_polynomial]
  simp [constants, qx, qy, map_add, map_mul, map_pow]

theorem sectionH_class {K : Type*} [Field K] [CharZero K] [Algebra ℚ K] (k : K) :
    Ideal.Quotient.mk (jacobianIdeal k) (sectionH k) =
      qx k^2+constants k (ExplicitCurve.sb k)*qx k*qy k+
        constants k (ExplicitCurve.sc k)*qy k^2 := by
  simp [sectionH, constants, qx, qy, map_add, map_mul, map_pow]

theorem section_HW_class {K : Type*} [Field K] [CharZero K] [Algebra ℚ K]
    (k : K) (hm : k^24+66081312000*k^18-4811512860000*k^12+
      1167566400000*k^6+583200000=0) :
    Ideal.Quotient.mk (jacobianIdeal k) (sectionH k*sectionW k) =
      constants k (ExplicitResidueCertificates.u0 k)*qy k^5+
      constants k (ExplicitResidueCertificates.u1 k)*qx k*qy k^4+
      constants k (ExplicitResidueCertificates.u2 k)*qx k^2*qy k^3+
      constants k (ExplicitResidueCertificates.u3 k)*qx k^3*qy k^2 := by
  have hk := ExplicitResidueAlgebra.section_root_ne_zero k hm
  have hw : ExplicitResidueCertificates.w3 k = k := by
    unfold ExplicitResidueCertificates.w3
    linear_combination ExplicitCurve.rel_h5 k hm
  rw [map_mul, sectionH_class, wronskian_class, hw]
  simp only [ExplicitResidueCertificates.u0, ExplicitResidueCertificates.u1,
    ExplicitResidueCertificates.u2, ExplicitResidueCertificates.u3,
    map_add, map_sub, map_mul, map_ofNat]
  have hx := x4y_class k hk
  have hy := partial_y_class k
  linear_combination hy+(constants k (ExplicitResidueCertificates.w2 k)+
    constants k (ExplicitCurve.sb k)*constants k k)*hx

/-- The actual section identity in the polynomial ring, not a postulated identity. -/
theorem section_identity_polynomial {K : Type*} [Field K] [CharZero K] [Algebra ℚ K]
    (k : K) (hm : k^24+66081312000*k^18-4811512860000*k^12+
      1167566400000*k^6+583200000=0) :
    sectionG k^2-sectionH k^3 = binarySextic k := by
  have h5 := congrArg (C : K →+* Binary K) (ExplicitCurve.rel_h5 k hm)
  have h4 := congrArg (C : K →+* Binary K) (ExplicitCurve.rel_h4 k hm)
  have h3 := congrArg (C : K →+* Binary K) (ExplicitCurve.rel_h3 k hm)
  have h2 := congrArg (C : K →+* Binary K) (ExplicitCurve.rel_h2 k hm)
  have h1 := congrArg (C : K →+* Binary K) (ExplicitCurve.rel_h1 k hm)
  have h0 := congrArg (C : K →+* Binary K) (ExplicitCurve.rel_h0 k hm)
  simp only [map_add, map_sub, map_mul, map_pow, map_ofNat, map_zero] at h5 h4 h3 h2 h1 h0
  exact ExplicitCurve.section_identity (C k) (C (ExplicitCurve.sb k))
    (C (ExplicitCurve.sc k)) (C (ExplicitCurve.sd k)) (C (ExplicitCurve.se k))
    (C (ExplicitCurve.sg k)) x y h5 h4 h3 h2 h1 h0

/-- There is no common nonzero homogeneous zero of the actual H,G.
This proves the projective-common-zero exclusion needed from the tenth Python
certificate, by differentiating the section identity instead of assuming a
resultant theorem or certifying merely a renamed scalar. It does not identify
mathlib's Sylvester resultant or define projective schemes. -/
theorem section_common_zero {K : Type*} [Field K] [CharZero K] [Algebra ℚ K]
    (k : K) (hm : k^24+66081312000*k^18-4811512860000*k^12+
      1167566400000*k^6+583200000=0) (a b : K)
    (hH : eval ![a,b] (sectionH k) = 0)
    (hG : eval ![a,b] (sectionG k) = 0) : a = 0 ∧ b = 0 := by
  have identity := section_identity_polynomial k hm
  have hx : 5*k*a^4*b = 0 := by
    have hd := congrArg (fun p : Binary K => eval ![a,b] (pderiv 0 p)) identity
    simpa [pderiv_pow, partial_x, map_sub, map_mul, map_pow, hH, hG, x, y] using hd.symm
  have hy : k*a^5+6*b^5 = 0 := by
    have hd := congrArg (fun p : Binary K => eval ![a,b] (pderiv 1 p)) identity
    simpa [pderiv_pow, partial_y, map_sub, map_mul, map_pow, hH, hG, x, y] using hd.symm
  have hk := ExplicitResidueAlgebra.section_root_ne_zero k hm
  have h5k : (5 : K)*k ≠ 0 := mul_ne_zero (by norm_num) hk
  have hab : a = 0 ∨ b = 0 := by
    rcases mul_eq_zero.mp hx with ha | hb
    · exact Or.inl (pow_eq_zero ((mul_eq_zero.mp ha).resolve_left h5k))
    · exact Or.inr hb
  rcases hab with ha | hb
  · refine ⟨ha, ?_⟩
    have h6 : (6 : K)*b^5 = 0 := by simpa [ha] using hy
    exact pow_eq_zero ((mul_eq_zero.mp h6).resolve_left (by norm_num))
  · refine ⟨?_, hb⟩
    have hka : k*a^5 = 0 := by simpa [hb] using hy
    exact pow_eq_zero ((mul_eq_zero.mp hka).resolve_left hk)

end Hodge.ExplicitJacobianQuotient
