/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache 2.0 license.

Stage-one polynomial identities for the actual sextic residue construction.
This file does not define Betti/Hodge cohomology, algebraic cycles or a cycle
class map, and makes no claim to formalize the geometric residue theorem.
-/
import Hodge.ExplicitCurve

namespace Hodge.ExplicitResidueAlgebra

open Matrix

/-- Exact decomposition of the two-pair sextic, after substituting the section
identity. Here `h1,g1,h2,g2` stand for the values of the actual section polynomials. -/
theorem two_pair_decomposition {R : Type*} [CommRing R]
    (h1 g1 h2 g2 i : R) (hi : i^2 = -1) :
    (h2+h1)*(-(h2^2-h2*h1+h1^2)) + (g2+i*g1)*(g2-i*g1) =
      (g1^2-h1^3)+(g2^2-h2^3) := by
  linear_combination -(g1^2)*hi

/-- The actual split binary factorization used in the surface equations. -/
theorem split_pair_decomposition {R : Type*} [CommRing R] (u v : R) :
    (u+v)*(v*(u^4-u^3*v+u^2*v^2-u*v^3+v^4)) = u^5*v+v^6 := by
  ring

/-- Outer Jacobian determinant for `(Q,A,C,B)` in coordinates
`(H1,G1,H2,G2)`. No square-root assumption is needed for this identity. -/
theorem outer_jacobian_det {R : Type*} [CommRing R] (h1 h2 i : R) :
    Matrix.det (!![1, 0, 1, 0;
      h2-2*h1, 0, h1-2*h2, 0;
      0, i, 0, 1;
      0, -i, 0, 1] : Matrix (Fin 4) (Fin 4) R) = 6*i*(h2-h1) := by
  simp [Matrix.det_succ_row_zero, Fin.sum_univ_succ, Matrix.submatrix_apply,
    Fin.succAbove]
  ring

/-- Full four-variable determinant factor after the polynomial chain rule.
The inputs are the two section values and the eight first partial derivatives.
Linking these inputs to polynomial differentiation is a separate obligation. -/
theorem paired_jacobian_det {R : Type*} [CommRing R]
    (h1 h2 i h1x h1y g1x g1y h2x h2y g2x g2y : R) :
    Matrix.det (!![h1x, h1y, h2x, h2y;
      (h2-2*h1)*h1x, (h2-2*h1)*h1y, (h1-2*h2)*h2x, (h1-2*h2)*h2y;
      i*g1x, i*g1y, g2x, g2y;
      -i*g1x, -i*g1y, g2x, g2y] : Matrix (Fin 4) (Fin 4) R) =
      6*i*(h2-h1)*(h1x*g1y-h1y*g1x)*(h2x*g2y-h2y*g2x) := by
  simp [Matrix.det_succ_row_zero, Fin.sum_univ_succ, Matrix.submatrix_apply,
    Fin.succAbove]
  ring

/-- Every root of the actual section modulus is nonzero, in characteristic zero. -/
theorem section_root_ne_zero {K : Type*} [Field K] [CharZero K]
    (k : K)
    (hm : k^24 + 66081312000*k^18 - 4811512860000*k^12 +
      1167566400000*k^6 + 583200000 = 0) : k ≠ 0 := by
  intro hk
  subst k
  norm_num at hm

/-- One of the eight required residue coefficients: the actual `x^3` coefficient
of `det Jac(H,G)` is nonzero at every root, using the existing Lean section data.
The seven other coefficients and geometric interpretations are not asserted here. -/
theorem leading_W_ne_zero {K : Type*} [Field K] [CharZero K] [Algebra ℚ K]
    (k : K)
    (hm : k^24 + 66081312000*k^18 - 4811512860000*k^12 +
      1167566400000*k^6 + 583200000 = 0) :
    2*ExplicitCurve.sd k - 3*ExplicitCurve.sb k ≠ 0 := by
  have heq : 2*ExplicitCurve.sd k - 3*ExplicitCurve.sb k = k := by
    linear_combination ExplicitCurve.rel_h5 k hm
  rw [heq]
  exact section_root_ne_zero k hm

/-- The binary determinant is proved using actual formal polynomial derivatives,
not merely names for partial derivatives or an assumed geometric Jacobian. -/
theorem binary_wronskian {R : Type*} [CommRing R] (b c d e g : R) :
    let x : MvPolynomial (Fin 2) R := MvPolynomial.X 0
    let y : MvPolynomial (Fin 2) R := MvPolynomial.X 1
    let hp := x^2 + MvPolynomial.C b*x*y + MvPolynomial.C c*y^2
    let gp := x^3 + MvPolynomial.C d*x^2*y + MvPolynomial.C e*x*y^2 +
      MvPolynomial.C g*y^3
    MvPolynomial.pderiv 0 hp * MvPolynomial.pderiv 1 gp -
      MvPolynomial.pderiv 1 hp * MvPolynomial.pderiv 0 gp =
      MvPolynomial.C (2*d-3*b)*x^3 +
      MvPolynomial.C (4*e-b*d-6*c)*x^2*y +
      MvPolynomial.C (6*g+b*e-4*c*d)*x*y^2 +
      MvPolynomial.C (3*b*g-2*c*e)*y^3 := by
  dsimp
  simp [map_add, map_sub, map_mul, map_ofNat]
  ring

end Hodge.ExplicitResidueAlgebra
