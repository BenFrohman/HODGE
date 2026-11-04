/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Hodge.Fourfold
import Hodge.Frontier
import Hodge.SpecialSextic
import Hodge.Release
import Hodge.FermatCubicHost
import Hodge.SexticCombinatorics
import Hodge.SexticCertificates

/-!
#print axioms on the discharged theorems.
Expected on closed algebraic names: `propext`, `Quot.sound`.
No term of `Clay.RationalHodgeCodimTwo`.
No `construct_of_codim_ge_two`.
-/

#print axioms Hodge.HodgeConjecture.classical_fourfolds
#print axioms Hodge.HodgeConjecture.p4
#print axioms Hodge.HodgeConjecture.klein
#print axioms Hodge.HodgeConjecture.product
#print axioms Hodge.k3Surface_hodge
#print axioms Hodge.SpecialSextic.contains_two_planes
#print axioms Hodge.SpecialSextic.closed_membership
#print axioms Hodge.Release.contains_two_planes
#print axioms Hodge.Release.status_separation
#print axioms Hodge.FermatCubicHost.F_isHomogeneous
#print axioms Hodge.FermatCubicHost.smooth
#print axioms Hodge.FermatCubicHost.cubic_primitive_hodge
#print axioms Hodge.FermatCubicHost.sextic_primitive_hodge

-- Finite combinatorics of the Delsarte sextic (Lean checks counts/linear algebra only;
-- the identification with Hodge/cycle classes is cited theory). Expected: propext, Quot.sound, Classical.choice.
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
