import Hodge.ExplicitJacobianQuotient
/-
Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Author: Frohman, Benjamin Stanley.
Incremental algebra audit, not an audit of unimplemented geometric foundations.
-/
import Hodge.ExplicitResidueAlgebra
import Hodge.ExplicitResidueCertificates

#print axioms Hodge.ExplicitResidueAlgebra.two_pair_decomposition
#print axioms Hodge.ExplicitResidueAlgebra.split_pair_decomposition
#print axioms Hodge.ExplicitResidueAlgebra.outer_jacobian_det
#print axioms Hodge.ExplicitResidueAlgebra.paired_jacobian_det
#print axioms Hodge.ExplicitResidueAlgebra.section_root_ne_zero
#print axioms Hodge.ExplicitResidueAlgebra.leading_W_ne_zero
#print axioms Hodge.ExplicitResidueAlgebra.binary_wronskian
#print axioms Hodge.ExplicitResidueCertificates.eval_bPoly
#print axioms Hodge.ExplicitResidueCertificates.eval_cPoly
#print axioms Hodge.ExplicitResidueCertificates.eval_dPoly
#print axioms Hodge.ExplicitResidueCertificates.eval_ePoly
#print axioms Hodge.ExplicitResidueCertificates.eval_gPoly
#print axioms Hodge.ExplicitResidueCertificates.eval_w0
#print axioms Hodge.ExplicitResidueCertificates.eval_w1
#print axioms Hodge.ExplicitResidueCertificates.eval_w2
#print axioms Hodge.ExplicitResidueCertificates.eval_w3
#print axioms Hodge.ExplicitResidueCertificates.eval_u0
#print axioms Hodge.ExplicitResidueCertificates.eval_u1
#print axioms Hodge.ExplicitResidueCertificates.eval_u2
#print axioms Hodge.ExplicitResidueCertificates.eval_u3
#print axioms Hodge.ExplicitResidueCertificates.eval_disc
#print axioms Hodge.ExplicitResidueCertificates.w0_reduction
#print axioms Hodge.ExplicitResidueCertificates.w0_bezout
#print axioms Hodge.ExplicitResidueCertificates.w1_reduction
#print axioms Hodge.ExplicitResidueCertificates.w1_bezout
#print axioms Hodge.ExplicitResidueCertificates.w2_reduction
#print axioms Hodge.ExplicitResidueCertificates.w2_bezout
#print axioms Hodge.ExplicitResidueCertificates.w3_reduction
#print axioms Hodge.ExplicitResidueCertificates.w3_bezout
#print axioms Hodge.ExplicitResidueCertificates.u0_reduction
#print axioms Hodge.ExplicitResidueCertificates.u0_bezout
#print axioms Hodge.ExplicitResidueCertificates.u1_reduction
#print axioms Hodge.ExplicitResidueCertificates.u1_bezout
#print axioms Hodge.ExplicitResidueCertificates.u2_reduction
#print axioms Hodge.ExplicitResidueCertificates.u2_bezout
#print axioms Hodge.ExplicitResidueCertificates.u3_reduction
#print axioms Hodge.ExplicitResidueCertificates.u3_bezout
#print axioms Hodge.ExplicitResidueCertificates.disc_reduction
#print axioms Hodge.ExplicitResidueCertificates.disc_bezout
#print axioms Hodge.ExplicitResidueCertificates.eval_ne_zero_of_certificate
#print axioms Hodge.ExplicitResidueCertificates.w0_ne_zero
#print axioms Hodge.ExplicitResidueCertificates.w1_ne_zero
#print axioms Hodge.ExplicitResidueCertificates.w2_ne_zero
#print axioms Hodge.ExplicitResidueCertificates.w3_ne_zero
#print axioms Hodge.ExplicitResidueCertificates.u0_ne_zero
#print axioms Hodge.ExplicitResidueCertificates.u1_ne_zero
#print axioms Hodge.ExplicitResidueCertificates.u2_ne_zero
#print axioms Hodge.ExplicitResidueCertificates.u3_ne_zero
#print axioms Hodge.ExplicitResidueCertificates.disc_ne_zero
#print axioms Hodge.ExplicitResidueCertificates.modulus_degree
#print axioms Hodge.ExplicitResidueCertificates.exists_complex_root
#print axioms Hodge.ExplicitResidueCertificates.exists_complex_nonvanishing

#print axioms Hodge.ExplicitJacobianQuotient.partial_x
#print axioms Hodge.ExplicitJacobianQuotient.partial_y
#print axioms Hodge.ExplicitJacobianQuotient.partial_x_class
#print axioms Hodge.ExplicitJacobianQuotient.partial_y_class
#print axioms Hodge.ExplicitJacobianQuotient.constant_inverse
#print axioms Hodge.ExplicitJacobianQuotient.x4y_class
#print axioms Hodge.ExplicitJacobianQuotient.y6_class
#print axioms Hodge.ExplicitJacobianQuotient.wronskian_polynomial
#print axioms Hodge.ExplicitJacobianQuotient.wronskian_class
#print axioms Hodge.ExplicitJacobianQuotient.sectionH_class
#print axioms Hodge.ExplicitJacobianQuotient.section_HW_class
#print axioms Hodge.ExplicitJacobianQuotient.section_identity_polynomial
#print axioms Hodge.ExplicitJacobianQuotient.section_common_zero
