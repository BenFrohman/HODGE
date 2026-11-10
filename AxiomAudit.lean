import Hodge.FermatCubicHost
import Hodge.QuinticHost
import Hodge.DeformedQuinticHost
import Hodge.DworkQuinticPsi2
import Hodge.ExplicitCurve
import Hodge.SexticCombinatorics
import Hodge.SexticCertificates
import AxiomPrint
import Hodge
import Hodge.Attempt.ClayStatement
import Hodge.Attempt.FermatIdentities
import Hodge.Attempt.FermatPlanes
import Hodge.Attempt.GenericObstructed
import Hodge.Attempt.Grading
import Hodge.Attempt.IntersectionInvariants
import Hodge.Attempt.NamedSexticMembership
import Hodge.Attempt.ParameterLocus
import Hodge.Attempt.SpecialSexticMembership
import Hodge.Basic
import Hodge.Classical
import Hodge.Clay
import Hodge.ClayStatement
import Hodge.ClayTerm
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
import Hodge.PlaneSpanPairing
import Hodge.RealClose
import Hodge.Release
import Hodge.SexticModuli
import Hodge.Skeleton
import Hodge.SpecialSextic
import Hodge.SpecialSexticJacobian
import Hodge.SpecialSexticMembership
import Hodge.Verify
import HodgeAttempt

#print axioms Hodge.Attempt.Hypersurface.mk.inj
#print axioms Hodge.Attempt.Hypersurface.mk.injEq
#print axioms Hodge.Attempt.Hypersurface.mk.sizeOf_spec
#print axioms Hodge.Attempt.IntersectionInvariants.extra_class_mismatch
#print axioms Hodge.Attempt.IntersectionInvariants.isolation_not_ambient
#print axioms Hodge.Attempt.IntersectionInvariants.planeSelfIx_six
#print axioms Hodge.Attempt.IntersectionInvariants.predicted_ambient_self
#print axioms Hodge.Attempt.NamedSextic.namedSextic_eq_plane_combination
#print axioms Hodge.Attempt.NamedSextic.namedSextic_mem_plane
#print axioms Hodge.Attempt.ParameterLocus.fermatLocus.inj
#print axioms Hodge.Attempt.ParameterLocus.fermatLocus.injEq
#print axioms Hodge.Attempt.ParameterLocus.fermatLocus.sizeOf_spec
#print axioms Hodge.Attempt.ParameterLocus.genericObstructedLocus.sizeOf_spec
#print axioms Hodge.Attempt.ParameterLocus.kleinQuadric.sizeOf_spec
#print axioms Hodge.Attempt.ParameterLocus.productOfPlanes.sizeOf_spec
#print axioms Hodge.Attempt.ParameterLocus.projectiveFourSpace.sizeOf_spec
#print axioms Hodge.Attempt.SpecialSexticMembership.F_factors
#print axioms Hodge.Attempt.SpecialSexticMembership.F_mem_plane
#print axioms Hodge.Attempt.Tagged.mk.inj
#print axioms Hodge.Attempt.Tagged.mk.injEq
#print axioms Hodge.Attempt.Tagged.mk.sizeOf_spec
#print axioms Hodge.FermatPlanes.Var.ofNat_toCtorIdx
#print axioms Hodge.FermatPlanes.Var.z0.sizeOf_spec
#print axioms Hodge.FermatPlanes.Var.z1.sizeOf_spec
#print axioms Hodge.FermatPlanes.Var.z2.sizeOf_spec
#print axioms Hodge.FermatPlanes.Var.z3.sizeOf_spec
#print axioms Hodge.FermatPlanes.Var.z4.sizeOf_spec
#print axioms Hodge.FermatPlanes.Var.z5.sizeOf_spec
#print axioms Hodge.Attempt.carriesFermatRecipe.eq_1
#print axioms Hodge.Attempt.fermat_pair_vanishing
#print axioms Hodge.Attempt.fermat_pair_with_remainder
#print axioms Hodge.Attempt.fermat_quartic_contains_Z1
#print axioms Hodge.Attempt.fourfold_complex_dim_eq_four
#print axioms Hodge.Attempt.genericObstructedFourfold_codim
#print axioms Hodge.Attempt.genericObstructedTag.eq_1
#print axioms Hodge.Attempt.generic_tag_has_no_fermat_recipe
#print axioms Hodge.Attempt.middle_cycle_codimension_is_two
#print axioms Hodge.Attempt.middle_cycle_dim_eq_two
#print axioms Hodge.FermatPlanes.pair_vanishing
#print axioms Hodge.FermatPlanes.pair_with_remainder
#print axioms Hodge.Attempt.recipe_is_not_global_constructor
#print axioms Hodge.ChowData.mk.inj
#print axioms Hodge.ChowData.mk.injEq
#print axioms Hodge.ChowData.mk.sizeOf_spec
#print axioms Hodge.Classical.P4Coord.ofNat_toCtorIdx
#print axioms Hodge.Classical.P4Coord.x0.sizeOf_spec
#print axioms Hodge.Classical.P4Coord.x1.sizeOf_spec
#print axioms Hodge.Classical.P4Coord.x2.sizeOf_spec
#print axioms Hodge.Classical.P4Coord.x3.sizeOf_spec
#print axioms Hodge.Classical.P4Coord.x4.sizeOf_spec
#print axioms Hodge.Classical.P4Cycle.mk.inj
#print axioms Hodge.Classical.P4Cycle.mk.injEq
#print axioms Hodge.Classical.P4Cycle.mk.sizeOf_spec
#print axioms Hodge.Classical.ProductCycle.mk.inj
#print axioms Hodge.Classical.ProductCycle.mk.injEq
#print axioms Hodge.Classical.ProductCycle.mk.sizeOf_spec
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
#print axioms Hodge.Classical.sections_recover
#print axioms Hodge.Clay.instNonemptyHdg2
#print axioms Hodge.Clay.of_section_is_not_uniform
#print axioms Hodge.Clay.skeleton_on_iff
#print axioms Hodge.ContainerSeparation.Z_not_container
#print axioms Hodge.ContainerSeparation.Z_bounds
#print axioms Hodge.ContainerSeparation.Z_status_eq
#print axioms Hodge.ContainerSeparation.gram_shadow_numeral
#print axioms Hodge.ContainerSeparation.quintic_h31
#print axioms Hodge.ContainerSeparation.sextic_R12
#print axioms Hodge.ContainerSeparation.sextic_R18
#print axioms Hodge.ContainerSeparation.sextic_R6
#print axioms Hodge.ContainerSeparation.sextic_b4
#print axioms Hodge.ContainerSeparation.sextic_h22
#print axioms Hodge.ContainerSeparation.two_plane_shadow_det
#print axioms Hodge.Cubic.ZuckerCubic.construct
#print axioms Hodge.Cubic.construct_h2_section
#print axioms Hodge.Cubic.hassettC8_hodge
#print axioms Hodge.Cubic.hodge_of_zucker
#print axioms Hodge.Cubic.instCycleConstructorOfZuckerCubic
#print axioms Hodge.Cubic.no_universal_cubic_section
#print axioms Hodge.Cubic.veryGeneral_hodge
#print axioms Hodge.CycleConstructor.construct
#print axioms Hodge.CycleSection.is_section
#print axioms Hodge.Datum.algebraicClasses_le_hodgeClasses
#print axioms Hodge.Datum.cl_isHodge
#print axioms Hodge.Datum.hodgeClasses.eq_1
#print axioms Hodge.Datum.hodgeConjecture_codim_blind
#print axioms Hodge.Datum.hodgeConjecture_of_generators
#print axioms Hodge.Datum.hodgeConjecture_of_integral_generation
#print axioms Hodge.Datum.mk.inj
#print axioms Hodge.Datum.mk.injEq
#print axioms Hodge.Datum.mk.sizeOf_spec
#print axioms Hodge.DerivedSurfaces.NamedDerivedSurface.mk.inj
#print axioms Hodge.DerivedSurfaces.NamedDerivedSurface.mk.injEq
#print axioms Hodge.DerivedSurfaces.NamedDerivedSurface.mk.sizeOf_spec
#print axioms Hodge.DerivedSurfaces.every_listed_host_is_a_fourfold
#print axioms Hodge.DerivedSurfaces.every_listed_object_is_a_surface
#print axioms Hodge.DerivedSurfaces.inventory_card
#print axioms Hodge.DerivedSurfaces.residual_host_is_fourfold
#print axioms Hodge.DerivedSurfaces.residual_is_surface
#print axioms Hodge.DerivedSurfaces.residual_not_partner
#print axioms Hodge.DimLeThree.construct
#print axioms Hodge.Examples.instCycleConstructorRatTrivialObstruction
#print axioms Hodge.Examples.not_every_codim_ge_two
#print axioms Hodge.Examples.trivialObstruction_hodge
#print axioms Hodge.Examples.zeroCycle.eq_1
#print axioms Hodge.Examples.zeroCycle_is_not_a_variety_sticker
#print axioms Hodge.Examples.zeroCycle_not_hodge
#print axioms Hodge.Fermat.Coord.ofNat_toCtorIdx
#print axioms Hodge.Fermat.Coord.z0.sizeOf_spec
#print axioms Hodge.Fermat.Coord.z1.sizeOf_spec
#print axioms Hodge.Fermat.Coord.z2.sizeOf_spec
#print axioms Hodge.Fermat.Coord.z3.sizeOf_spec
#print axioms Hodge.Fermat.Coord.z4.sizeOf_spec
#print axioms Hodge.Fermat.Coord.z5.sizeOf_spec
#print axioms Hodge.Fermat.LinearPlane.mk.inj
#print axioms Hodge.Fermat.LinearPlane.mk.injEq
#print axioms Hodge.Fermat.LinearPlane.mk.sizeOf_spec
#print axioms Hodge.Fermat.Pairing.mk.inj
#print axioms Hodge.Fermat.Pairing.mk.injEq
#print axioms Hodge.Fermat.Pairing.mk.sizeOf_spec
#print axioms Hodge.Fermat.Z1_pairing
#print axioms Hodge.Fermat.Z2_pairing
#print axioms Hodge.Fermat.construct_section
#print axioms Hodge.Fermat.contains_two_planes
#print axioms Hodge.Fermat.fermatQuartic_hodge
#print axioms Hodge.Fermat.twoPlanes_hodge
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
#print axioms Hodge.Geometry.Variety.hodgeConjecture_iff
#print axioms Hodge.Geometry.Variety.mk.inj
#print axioms Hodge.Geometry.Variety.mk.injEq
#print axioms Hodge.Geometry.Variety.mk.sizeOf_spec
#print axioms Hodge.Geometry.cycleClass_is_hodge
#print axioms Hodge.Geometry.every_datum_wraps
#print axioms Hodge.Geometry.kleinQuadric_hodge
#print axioms Hodge.Geometry.onVarieties_false_on_Rat
#print axioms Hodge.Geometry.productOfPlanes_hodge
#print axioms Hodge.Geometry.projectiveFourSpace_hodge
#print axioms Hodge.Geometry.wrap_data
#print axioms Hodge.Geometry.wrapped
#print axioms Hodge.Geometry.zeroGadget_not_hodge
#print axioms Hodge.HardLefschetzComplement.construct
#print axioms Hodge.Hassett.P5Coord.ofNat_toCtorIdx
#print axioms Hodge.Hassett.P5Coord.x0.sizeOf_spec
#print axioms Hodge.Hassett.P5Coord.x1.sizeOf_spec
#print axioms Hodge.Hassett.P5Coord.x2.sizeOf_spec
#print axioms Hodge.Hassett.P5Coord.x3.sizeOf_spec
#print axioms Hodge.Hassett.P5Coord.x4.sizeOf_spec
#print axioms Hodge.Hassett.P5Coord.x5.sizeOf_spec
#print axioms Hodge.Hassett.construct_section
#print axioms Hodge.Hassett.planeSpan_hodge
#print axioms Hodge.HodgeConjecture.LefschetzTwoTwo_iff
#print axioms Hodge.HodgeConjecture.RealClose.mk.inj
#print axioms Hodge.HodgeConjecture.RealClose.mk.injEq
#print axioms Hodge.HodgeConjecture.RealClose.mk.sizeOf_spec
#print axioms Hodge.HodgeConjecture.classical_fourfolds
#print axioms Hodge.HodgeConjecture.frohman_two_two_spans
#print axioms Hodge.HodgeConjecture.frohman_two_two_spans_iff
#print axioms Hodge.HodgeConjecture.general_fourfold_iff
#print axioms Hodge.HodgeConjecture.general_fourfold_iff_clay
#print axioms Hodge.HodgeConjecture.iff_nonempty_fibers
#print axioms Hodge.HodgeConjecture.klein
#print axioms Hodge.HodgeConjecture.living_skeleton
#print axioms Hodge.HodgeConjecture.mem_algebraicClasses_iff
#print axioms Hodge.HodgeConjecture.named_fourfolds
#print axioms Hodge.HodgeConjecture.nonempty_fiber_iff
#print axioms Hodge.HodgeConjecture.of_constructor
#print axioms Hodge.HodgeConjecture.of_realClose
#print axioms Hodge.HodgeConjecture.of_section
#print axioms Hodge.HodgeConjecture.p4
#print axioms Hodge.HodgeConjecture.product
#print axioms Hodge.HodgeConjecture.ungated_codim_two_false
#print axioms Hodge.HodgeConjecture.zeroCycleLift_not_hodge
#print axioms Hodge.HostSplit.Z_bounds
#print axioms Hodge.HostSplit.Z_status_eq
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
#print axioms Hodge.Integral.integral_unsolvable
#print axioms Hodge.Integral.rational_does_not_imply_integral
#print axioms Hodge.Integral.rational_solvable
#print axioms Hodge.Islands.P4Coord.ofNat_toCtorIdx
#print axioms Hodge.Islands.P4Coord.x0.sizeOf_spec
#print axioms Hodge.Islands.P4Coord.x1.sizeOf_spec
#print axioms Hodge.Islands.P4Coord.x2.sizeOf_spec
#print axioms Hodge.Islands.P4Coord.x3.sizeOf_spec
#print axioms Hodge.Islands.P4Coord.x4.sizeOf_spec
#print axioms Hodge.Islands.P4Cycle.mk.inj
#print axioms Hodge.Islands.P4Cycle.mk.injEq
#print axioms Hodge.Islands.P4Cycle.mk.sizeOf_spec
#print axioms Hodge.Islands.ProductCycle.mk.inj
#print axioms Hodge.Islands.ProductCycle.mk.injEq
#print axioms Hodge.Islands.ProductCycle.mk.sizeOf_spec
#print axioms Hodge.Islands.ProductSurface.P2TimesPt.sizeOf_spec
#print axioms Hodge.Islands.ProductSurface.lineTimesLine.sizeOf_spec
#print axioms Hodge.Islands.ProductSurface.ofNat_toCtorIdx
#print axioms Hodge.Islands.ProductSurface.ptTimesP2.sizeOf_spec
#print axioms Hodge.Islands.constructP4_coeff
#print axioms Hodge.Islands.constructP4_recovers
#print axioms Hodge.Islands.constructProduct_coeff
#print axioms Hodge.Islands.constructProduct_recovers
#print axioms Hodge.Islands.constructQ_coeff
#print axioms Hodge.Islands.constructQ_eq_initialize
#print axioms Hodge.Islands.constructQ_recovers
#print axioms Hodge.Islands.islands_construct
#print axioms Hodge.JacobianLength.HomogeneousCILength.dim_eq_pow
#print axioms Hodge.JacobianLength.five_pow_six
#print axioms Hodge.JacobianLength.length_num
#print axioms Hodge.JacobianLength.length_num_of_hyps
#print axioms Hodge.JacobianLength.this_is_not_general_fourfold
#print axioms Hodge.Klein.Coord.ofNat_toCtorIdx
#print axioms Hodge.Klein.Coord.p01.sizeOf_spec
#print axioms Hodge.Klein.Coord.p02.sizeOf_spec
#print axioms Hodge.Klein.Coord.p03.sizeOf_spec
#print axioms Hodge.Klein.Coord.p12.sizeOf_spec
#print axioms Hodge.Klein.Coord.p13.sizeOf_spec
#print axioms Hodge.Klein.Coord.p23.sizeOf_spec
#print axioms Hodge.Klein.FormalCycle.mk.inj
#print axioms Hodge.Klein.FormalCycle.mk.injEq
#print axioms Hodge.Klein.FormalCycle.mk.sizeOf_spec
#print axioms Hodge.Klein.cycleOf_coeff
#print axioms Hodge.Klein.cycleOf_construct
#print axioms Hodge.Klein.expand
#print axioms Hodge.Klein.ideals_cover
#print axioms Hodge.Klein.ideals_disjoint
#print axioms Hodge.Klein.pairing.eq_1
#print axioms Hodge.Klein.pairing_Pi
#print axioms Hodge.Klein.pairing_Pi'
#print axioms Hodge.Klein.pairing_cross
#print axioms Hodge.Klein.pi'_on_quadric
#print axioms Hodge.Klein.pi_on_quadric
#print axioms Hodge.Klein.pluckerEval.eq_1
#print axioms Hodge.LefschetzOneOne.construct
#print axioms Hodge.LefschetzOneOne.is_codim_one
#print axioms Hodge.NoShadow.fermat_certificate_is_not_chow
#print axioms Hodge.NoShadow.shadow_ne_geometric_cl
#print axioms Hodge.Release.NamedTerm.mk.inj
#print axioms Hodge.Release.NamedTerm.mk.injEq
#print axioms Hodge.Release.NamedTerm.mk.sizeOf_spec
#print axioms Hodge.Release.Status.closed.sizeOf_spec
#print axioms Hodge.Release.Status.ofNat_toCtorIdx
#print axioms Hodge.Release.Status.open.sizeOf_spec
#print axioms Hodge.Release.contains_two_planes
#print axioms Hodge.Release.inventory_uniform_count
#print axioms Hodge.Release.named_host_shadows
#print axioms Hodge.Release.only_uniformConstruct_is_flagged
#print axioms Hodge.Release.status_separation
#print axioms Hodge.SexticModuli.dim_PGL6
#print axioms Hodge.SexticModuli.eq_15625_of_eq_five_pow_six
#print axioms Hodge.SexticModuli.equation_space_dim
#print axioms Hodge.SexticModuli.fixed_plane_naive_dim
#print axioms Hodge.SexticModuli.milnor_number
#print axioms Hodge.SexticModuli.naive_git_dim
#print axioms Hodge.SexticModuli.plane_restriction_monomials
#print axioms Hodge.SexticModuli.sextic_monomials
#print axioms Hodge.SpecialSextic.F_factors
#print axioms Hodge.SpecialSextic.F_factors_minus1
#print axioms Hodge.SpecialSextic.F_mem_plane
#print axioms Hodge.SpecialSextic.F_mem_plane_minus1
#print axioms Hodge.SpecialSextic.Pi.eq_1
#print axioms Hodge.SpecialSextic.S.eq_1
#print axioms Hodge.SpecialSextic.S_eq
#print axioms Hodge.SpecialSextic.affine_cone_isolated_at_origin
#print axioms Hodge.SpecialSextic.beta.eq_1
#print axioms Hodge.SpecialSextic.beta_eq
#print axioms Hodge.SpecialSextic.closed_membership
#print axioms Hodge.SpecialSextic.constructThree_section
#print axioms Hodge.SpecialSextic.construct_section
#print axioms Hodge.SpecialSextic.contains_two_planes
#print axioms Hodge.SpecialSextic.dF_dx0_formula
#print axioms Hodge.SpecialSextic.dF_dx1_formula
#print axioms Hodge.SpecialSextic.dF_dx2_formula
#print axioms Hodge.SpecialSextic.dF_dx3_formula
#print axioms Hodge.SpecialSextic.dF_dx4_formula
#print axioms Hodge.SpecialSextic.dF_dx5_formula
#print axioms Hodge.SpecialSextic.discriminant
#print axioms Hodge.SpecialSextic.euler_homogeneous
#print axioms Hodge.SpecialSextic.five_pow_six
#print axioms Hodge.SpecialSextic.gradPair_origin
#print axioms Hodge.SpecialSextic.gradient_only_origin
#print axioms Hodge.SpecialSextic.gram_det_numeral
#print axioms Hodge.SpecialSextic.h2.eq_1
#print axioms Hodge.SpecialSextic.head_plane_not_on_host
#print axioms Hodge.SpecialSextic.head_plane_point
#print axioms Hodge.SpecialSextic.hypersurface_contains_the_plane
#print axioms Hodge.SpecialSextic.hypersurface_contains_the_sign_plane
#print axioms Hodge.SpecialSextic.jacobian_lock_is_not_general_fourfold
#print axioms Hodge.SpecialSextic.jacobian_vanishes_only_at_origin
#print axioms Hodge.SpecialSextic.pairing.eq_1
#print axioms Hodge.SpecialSextic.pairing_Pi_Pi
#print axioms Hodge.SpecialSextic.pairing_Pi_S
#print axioms Hodge.SpecialSextic.pairing_S_S
#print axioms Hodge.SpecialSextic.pairing_beta_Pi
#print axioms Hodge.SpecialSextic.pairing_beta_S
#print axioms Hodge.SpecialSextic.pairing_beta_beta
#print axioms Hodge.SpecialSextic.pairing_beta_h2
#print axioms Hodge.SpecialSextic.pairing_h2_Pi
#print axioms Hodge.SpecialSextic.pairing_h2_S
#print axioms Hodge.SpecialSextic.pairing_h2_h2
#print axioms Hodge.SpecialSextic.planeSpan_hodge
#print axioms Hodge.SpecialSextic.planeSpan_identity_shadow
#print axioms Hodge.SpecialSextic.special_NL_sextic_coefficient_shadow
#print axioms Hodge.SpecialSextic.threeSpan_hodge
#print axioms Hodge.SpecialSextic.threeSpan_identity_shadow
#print axioms Hodge.SpecialSexticMembership.F_factors
#print axioms Hodge.SpecialSexticMembership.F_factors_minus1
#print axioms Hodge.SpecialSexticMembership.F_mem_plane
#print axioms Hodge.SpecialSexticMembership.F_mem_plane_minus1
#print axioms Hodge.SpecialSexticMembership.contains_two_planes
#print axioms Hodge.chow_not_shadow_name
#print axioms Hodge.constructor_of_hodgeConjecture
#print axioms Hodge.hodgeConjecture_codim_one
#print axioms Hodge.hodgeConjecture_dim_le_three
#print axioms Hodge.hodgeConjecture_hardLefschetz
#print axioms Hodge.hodgeConjecture_of_constructor
#print axioms Hodge.instCycleConstructorOfCycleSection
#print axioms Hodge.instCycleConstructorOfDimLeThree
#print axioms Hodge.instCycleConstructorOfHardLefschetzComplement
#print axioms Hodge.instCycleConstructorOfLefschetzOneOne
#print axioms Hodge.instLefschetzOneOneRatK3Surface
#print axioms Hodge.k3Surface_codim
#print axioms Hodge.k3Surface_hodge
#print axioms Hodge.FermatCubicHost.F_isHomogeneous
#print axioms Hodge.FermatCubicHost.smooth
#print axioms Hodge.FermatCubicHost.cubic_primitive_hodge
#print axioms Hodge.FermatCubicHost.sextic_primitive_hodge
#print axioms Hodge.QuinticHost.G_isHomogeneous
#print axioms Hodge.QuinticHost.pderiv_G
#print axioms Hodge.QuinticHost.smooth
#print axioms Hodge.QuinticHost.quintic_series
#print axioms Hodge.QuinticHost.quintic_primitive_hodge
#print axioms Hodge.QuinticHost.quintic_h40_zero
#print axioms Hodge.QuinticHost.quintic_h31_ne_zero
#print axioms Hodge.DeformedQuinticHost.G_isHomogeneous
#print axioms Hodge.DeformedQuinticHost.singular_at_p
#print axioms Hodge.DeformedQuinticHost.not_smooth
#print axioms Hodge.DworkQuinticPsi2.G_isHomogeneous
#print axioms Hodge.DworkQuinticPsi2.eval_pderiv
#print axioms Hodge.DworkQuinticPsi2.smooth
#print axioms Hodge.DworkQuinticPsi2.psi_not_root
#print axioms Hodge.DworkQuinticPsi2.dwork_primitive_hodge
#print axioms Hodge.SexticCombinatorics.f_facPt
#print axioms Hodge.SexticCombinatorics.standard_plane_on_X
#print axioms Hodge.SexticCombinatorics.card_standard_labels
#print axioms Hodge.SexticCombinatorics.diagonal_plane_on_X
#print axioms Hodge.SexticCombinatorics.twisted_pair_vanishes
#print axioms Hodge.SexticCombinatorics.gram8_eq
#print axioms Hodge.SexticCombinatorics.H8_mul_self
#print axioms Hodge.SexticCombinatorics.M8_mul_H8
#print axioms Hodge.SexticCombinatorics.det_ne_zero_of_mul_self
#print axioms Hodge.SexticCombinatorics.det_of_mul_eq
#print axioms Hodge.SexticCombinatorics.det_H8_ne_zero
#print axioms Hodge.SexticCombinatorics.prod_eig
#print axioms Hodge.SexticCombinatorics.det_M8
#print axioms Hodge.SexticCombinatorics.det_gram8
#print axioms Hodge.SexticCombinatorics.rank_map_of_det_ne_zero
#print axioms Hodge.SexticCombinatorics.rank_gram8
#print axioms Hodge.SexticCombinatorics.milnorBasis_length
#print axioms Hodge.SexticCombinatorics.chr_injective
#print axioms Hodge.SexticCombinatorics.valid_iff
#print axioms Hodge.SexticCombinatorics.valid_inverse
#print axioms Hodge.SexticCombinatorics.primitive_hodge_numbers
#print axioms Hodge.SexticCombinatorics.units30_spec
#print axioms Hodge.SexticCombinatorics.rational_hodge_dim
#print axioms Hodge.SexticCombinatorics.rational_hodge_orbits
#print axioms Hodge.SexticCombinatorics.gap_660
#print axioms Hodge.SexticCombinatorics.split_425
#print axioms Hodge.SexticCombinatorics.split_360
#print axioms Hodge.SexticCombinatorics.split_orbits
#print axioms Hodge.SexticCombinatorics.none_unclassified
#print axioms Hodge.SexticCertificates.gb_in_J
#print axioms Hodge.SexticCertificates.J_in_gb
#print axioms Hodge.SexticCertificates.spoly_12
#print axioms Hodge.SexticCertificates.spoly_13
#print axioms Hodge.SexticCertificates.spoly_23
#print axioms Hodge.SexticCertificates.std_card
#print axioms Hodge.SexticCertificates.std_bounded
#print axioms Hodge.SexticCertificates.twist_action
#print axioms Hodge.SexticCertificates.mu_action
#print axioms Hodge.SexticCertificates.eta_action
#print axioms Hodge.ExplicitCurve.section_identity
#print axioms Hodge.ExplicitCurve.cone_on_X
#print axioms Hodge.ExplicitCurve.rel_h5
#print axioms Hodge.ExplicitCurve.rel_h4
#print axioms Hodge.ExplicitCurve.rel_h3
#print axioms Hodge.ExplicitCurve.rel_h2
#print axioms Hodge.ExplicitCurve.rel_h1
#print axioms Hodge.ExplicitCurve.rel_h0

#print axioms Hodge.FermatCubicHost.primHodge_of_negative_degree
#print axioms Hodge.QuinticHost.quintic_primHodge_h40_zero
#print axioms Hodge.QuinticHost.quintic_primHodge_h04_zero

#print axioms Hodge.FermatPlanes.C_pow_four_eq_neg_one
#print axioms Hodge.FermatPlanes.fermatQuartic_factors
#print axioms Hodge.FermatPlanes.fermatQuartic_mem_surfaceZ1

#print axioms Hodge.ChainSexticRank.finrank_rationalPoints_le
#print axioms Hodge.ChainSexticRank.two_le_finrank_of_gram
#print axioms Hodge.ChainSexticRank.chainSextic_isHomogeneous
#print axioms Hodge.ChainSexticRank.pderiv_chainSextic_low
#print axioms Hodge.ChainSexticRank.pderiv_chainSextic_high
#print axioms Hodge.ChainSexticRank.stdPairs_card
#print axioms Hodge.ChainSexticRank.stdTriples12_card
#print axioms Hodge.ChainSexticRank.pair_mem_span
#print axioms Hodge.ChainSexticRank.pair_relations
#print axioms Hodge.ChainSexticRank.mk_monomial_mem
#print axioms Hodge.ChainSexticRank.jacobianDeg12_finrank_le
#print axioms Hodge.ChainSexticRank.one_add_six_mul_inverse
#print axioms Hodge.ChainSexticRank.planeSelfIntersection_eq
#print axioms Hodge.ChainSexticRank.gram_det_eq
#print axioms Hodge.ChainSexticRank.rho_le_1752
#print axioms Hodge.ChainSexticRank.two_le_rho
#print axioms Hodge.ChainSexticRank.rho_bounds
