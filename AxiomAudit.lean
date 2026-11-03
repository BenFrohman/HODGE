-- Axiom audit: prints the axioms of every theorem/lemma in the project.
-- CI fails unless each depends only on propext, Classical.choice, Quot.sound (or none).
import Hodge
import Hodge.Basic
import Hodge.Classical
import Hodge.ClayStatement
import Hodge.Construct
import Hodge.DerivedSurfaces
import Hodge.Examples
import Hodge.Fermat
import Hodge.FermatQuintic
import Hodge.Fourfold
import Hodge.Frontier
import Hodge.Geometry
import Hodge.Hassett
import Hodge.HeadPlane
import Hodge.HostSplit
import Hodge.Integral
import Hodge.Klein
import Hodge.Known
import Hodge.NamedFamilies
import Hodge.SexticModuli
import Hodge.SpecialSextic
import Hodge.SpecialSexticJacobian
import Hodge.SpecialSexticMembership
import Hodge.Verify

#print axioms Hodge.CycleConstructor.construct
#print axioms Hodge.Datum.algebraicClasses_le_hodgeClasses
#print axioms Hodge.Datum.cl_isHodge
#print axioms Hodge.Datum.hodgeConjecture_codim_blind
#print axioms Hodge.Datum.hodgeConjecture_of_generators
#print axioms Hodge.constructor_of_hodgeConjecture
#print axioms Hodge.hodgeConjecture_of_constructor
#print axioms Hodge.Classical.P4Coord.ofNat_toCtorIdx
#print axioms Hodge.Classical.classical_islands
#print axioms Hodge.Classical.constructP4_coeff
#print axioms Hodge.Classical.constructP4_discharged
#print axioms Hodge.Classical.constructP4_section
#print axioms Hodge.Classical.constructProduct_section
#print axioms Hodge.Classical.construct_recovers
#print axioms Hodge.Classical.constructions_are_sections
#print axioms Hodge.Classical.expansion
#print axioms Hodge.Classical.instCycleConstructorProdRatKleinQuadric
#print axioms Hodge.Classical.instCycleConstructorProdRatProductOfPlanes
#print axioms Hodge.Classical.instCycleConstructorRatProjectiveFourSpace
#print axioms Hodge.Classical.kleinQuadric_hodgeConjecture
#print axioms Hodge.Classical.productOfPlanes_hodgeConjecture
#print axioms Hodge.Classical.projectiveFourSpace_hodgeConjecture
#print axioms Hodge.HodgeConjecture.general_fourfold_iff_clay
#print axioms Hodge.Classical.sections_recover
#print axioms Hodge.CycleSection.is_section
#print axioms Hodge.instCycleConstructorOfCycleSection
#print axioms Hodge.DerivedSurfaces.every_listed_host_is_a_fourfold
#print axioms Hodge.DerivedSurfaces.every_listed_object_is_a_surface
#print axioms Hodge.DerivedSurfaces.inventory_card
#print axioms Hodge.DerivedSurfaces.residual_host_is_fourfold
#print axioms Hodge.DerivedSurfaces.residual_is_surface
#print axioms Hodge.DerivedSurfaces.residual_not_partner
#print axioms Hodge.Examples.instCycleConstructorRatTrivialObstruction
#print axioms Hodge.Examples.not_every_codim_ge_two
#print axioms Hodge.Examples.trivialObstruction_hodge
#print axioms Hodge.Examples.zeroCycle_is_not_a_variety_sticker
#print axioms Hodge.Examples.zeroCycle_not_hodge
#print axioms Hodge.FermatQuintic.F5_eq_G
#print axioms Hodge.FermatQuintic.G_not_euler_degree5
#print axioms Hodge.FermatQuintic.X_5_name_ne_T_F
#print axioms Hodge.FermatQuintic.affine_cone_isolated_at_origin
#print axioms Hodge.FermatQuintic.b4_numeral
#print axioms Hodge.FermatQuintic.canonical_degree
#print axioms Hodge.FermatQuintic.euler_homogeneous
#print axioms Hodge.FermatQuintic.h22_full_numeral
#print axioms Hodge.FermatQuintic.h31_numeral
#print axioms Hodge.FermatQuintic.h40_numeral
#print axioms Hodge.FermatQuintic.jacobian_certificate
#print axioms Hodge.FermatQuintic.this_is_not_general_fourfold
#print axioms Hodge.Fermat.Coord.ofNat_toCtorIdx
#print axioms Hodge.Fermat.Z1_pairing
#print axioms Hodge.Fermat.Z2_pairing
#print axioms Hodge.Fermat.construct_section
#print axioms Hodge.Fermat.contains_two_planes
#print axioms Hodge.Fermat.fermatQuartic_hodge
#print axioms Hodge.Fermat.twoPlanes_hodge
#print axioms Hodge.HodgeConjecture.LefschetzTwoTwo_iff
#print axioms Hodge.HodgeConjecture.classical_fourfolds
#print axioms Hodge.HodgeConjecture.general_fourfold_iff
#print axioms Hodge.HodgeConjecture.klein
#print axioms Hodge.HodgeConjecture.of_constructor
#print axioms Hodge.HodgeConjecture.of_section
#print axioms Hodge.HodgeConjecture.p4
#print axioms Hodge.HodgeConjecture.product
#print axioms Hodge.LefschetzOneOne.construct
#print axioms Hodge.LefschetzOneOne.is_codim_one
#print axioms Hodge.hodgeConjecture_codim_one
#print axioms Hodge.instCycleConstructorOfLefschetzOneOne
#print axioms Hodge.instLefschetzOneOneRatK3Surface
#print axioms Hodge.k3Surface_codim
#print axioms Hodge.k3Surface_hodge
#print axioms Hodge.Geometry.Variety.hodgeConjecture_iff
#print axioms Hodge.Geometry.cycleClass_is_hodge
#print axioms Hodge.Geometry.every_datum_wraps
#print axioms Hodge.Geometry.kleinQuadric_hodge
#print axioms Hodge.Geometry.onVarieties_false_on_Rat
#print axioms Hodge.Geometry.productOfPlanes_hodge
#print axioms Hodge.Geometry.projectiveFourSpace_hodge
#print axioms Hodge.Geometry.wrap_data
#print axioms Hodge.Geometry.wrapped
#print axioms Hodge.Geometry.zeroGadget_not_hodge
#print axioms Hodge.Hassett.P5Coord.ofNat_toCtorIdx
#print axioms Hodge.Hassett.construct_section
#print axioms Hodge.Hassett.planeSpan_hodge
#print axioms Hodge.SpecialSextic.head_plane_not_on_host
#print axioms Hodge.SpecialSextic.head_plane_point
#print axioms Hodge.HostSplit.Z_uncomputed
#print axioms Hodge.HostSplit.containers_differ
#print axioms Hodge.HostSplit.quintic_b4
#print axioms Hodge.HostSplit.quintic_h22
#print axioms Hodge.HostSplit.quintic_h31
#print axioms Hodge.HostSplit.sextic_b4
#print axioms Hodge.HostSplit.sextic_h22
#print axioms Hodge.HostSplit.sextic_length
#print axioms Hodge.HostSplit.sextic_r12
#print axioms Hodge.HostSplit.sextic_r18
#print axioms Hodge.HostSplit.sextic_r6
#print axioms Hodge.Datum.hodgeConjecture_of_integral_generation
#print axioms Hodge.Integral.integral_unsolvable
#print axioms Hodge.Integral.rational_does_not_imply_integral
#print axioms Hodge.Integral.rational_solvable
#print axioms Hodge.Klein.Coord.ofNat_toCtorIdx
#print axioms Hodge.Klein.cycleOf_coeff
#print axioms Hodge.Klein.cycleOf_construct
#print axioms Hodge.Klein.ideals_cover
#print axioms Hodge.Klein.ideals_disjoint
#print axioms Hodge.Klein.pi'_on_quadric
#print axioms Hodge.Klein.pi_on_quadric
#print axioms Hodge.DimLeThree.construct
#print axioms Hodge.HardLefschetzComplement.construct
#print axioms Hodge.hodgeConjecture_dim_le_three
#print axioms Hodge.hodgeConjecture_hardLefschetz
#print axioms Hodge.instCycleConstructorOfDimLeThree
#print axioms Hodge.instCycleConstructorOfHardLefschetzComplement
#print axioms Hodge.HodgeConjecture.frohman_two_two_spans
#print axioms Hodge.HodgeConjecture.frohman_two_two_spans_iff
#print axioms Hodge.HodgeConjecture.named_fourfolds
#print axioms Hodge.SexticModuli.dim_PGL6
#print axioms Hodge.SexticModuli.eq_15625_of_eq_five_pow_six
#print axioms Hodge.SexticModuli.equation_space_dim
#print axioms Hodge.SexticModuli.fixed_plane_naive_dim
#print axioms Hodge.SexticModuli.milnor_number
#print axioms Hodge.SexticModuli.naive_git_dim
#print axioms Hodge.SexticModuli.plane_restriction_monomials
#print axioms Hodge.SexticModuli.sextic_monomials
#print axioms Hodge.SpecialSextic.dF_dx0_formula
#print axioms Hodge.SpecialSextic.dF_dx1_formula
#print axioms Hodge.SpecialSextic.dF_dx2_formula
#print axioms Hodge.SpecialSextic.dF_dx3_formula
#print axioms Hodge.SpecialSextic.dF_dx4_formula
#print axioms Hodge.SpecialSextic.dF_dx5_formula
#print axioms Hodge.SpecialSextic.euler_homogeneous
#print axioms Hodge.SpecialSextic.jacobian_lock_is_not_general_fourfold
#print axioms Hodge.SpecialSextic.jacobian_vanishes_only_at_origin
#print axioms Hodge.SpecialSexticMembership.F_factors
#print axioms Hodge.SpecialSexticMembership.F_factors_minus1
#print axioms Hodge.SpecialSexticMembership.F_mem_plane
#print axioms Hodge.SpecialSexticMembership.F_mem_plane_minus1
#print axioms Hodge.SpecialSexticMembership.contains_two_planes
#print axioms Hodge.SpecialSextic.F_factors
#print axioms Hodge.SpecialSextic.F_factors_minus1
#print axioms Hodge.SpecialSextic.F_mem_plane
#print axioms Hodge.SpecialSextic.F_mem_plane_minus1
#print axioms Hodge.SpecialSextic.affine_cone_isolated_at_origin
#print axioms Hodge.SpecialSextic.constructThree_section
#print axioms Hodge.SpecialSextic.construct_section
#print axioms Hodge.SpecialSextic.contains_two_planes
#print axioms Hodge.SpecialSextic.five_pow_six
#print axioms Hodge.SpecialSextic.gradPair_origin
#print axioms Hodge.SpecialSextic.gradient_only_origin
#print axioms Hodge.SpecialSextic.gram_det_numeral
#print axioms Hodge.SpecialSextic.hypersurface_contains_the_plane
#print axioms Hodge.SpecialSextic.hypersurface_contains_the_sign_plane
#print axioms Hodge.SpecialSextic.planeSpan_hodge
#print axioms Hodge.SpecialSextic.special_NL_sextic_coefficient_shadow
#print axioms Hodge.SpecialSextic.threeSpan_hodge
