/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Hodge.VacuityAudit

/-!
# Honest replacements for the identity-shadow host theorems

The earlier files fix `cl := LinearMap.id` and `obstruction := 0` and then "prove"
`HodgeConjecture`. Those files are archived on Zenodo and are left byte-identical. This file
replaces them for new work:

* The cycle class map is an **arbitrary** linear map `D.cl` of an arbitrary `Datum D`.
* The geometric input is a **named hypothesis** (`SpanBridge`): explicit cycles whose
  classes span the Hodge classes. For `P⁴`, the Klein quadric and `P² × P²` this is a
  classical theorem (cellular decomposition / Schubert basis); it is **cited, not proved**,
  because Mathlib has no cycle class map.
* The conclusion is re-proved from the hypothesis, the hypothesis is shown satisfiable,
  and the conclusion is shown to fail for a datum where the hypothesis fails, so it is not
  automatic.

For the Fermat quartic, the Hassett cubic and the chain sextic, the shadows only ever had
content "the span of the named classes consists of algebraic classes". That holds for
*every* datum (`named_span_le_algebraic`), and no statement about all Hodge classes of
those hosts is made here.

Old theorem names are kept unchanged (their modules are archived) and are tied, by kernel-checked
equations in `Hodge.HonestHosts.Legacy`, to the honestly named aliases
`*_identityShadow`. Nothing here is the Hodge conjecture.
-/

namespace Hodge
namespace HonestHosts

open VacuityAudit

section Bridge

variable {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]

/-- **Named geometric hypothesis.** `n` explicit cycles whose classes span the Hodge classes
of `D`. For a real variety this is a theorem about that variety (cited, not proved here). -/
structure SpanBridge (D : Datum Z V N) (n : ℕ) where
  cycles : Fin n → Z
  spans : D.hodgeClasses ≤ Submodule.span ℚ (Set.range fun i => D.cl (cycles i))

/-- Conditional theorem: the spanning hypothesis gives `HodgeConjecture` for `D`. -/
theorem SpanBridge.hodgeConjecture {D : Datum Z V N} {n : ℕ} (B : SpanBridge D n) :
    D.HodgeConjecture :=
  D.hodgeConjecture_of_generators _ B.spans (by
    rintro _ ⟨i, rfl⟩
    exact ⟨B.cycles i, rfl⟩)

/-- The only content of the shadows for the Fermat quartic, Hassett and the sextic: the
span of named cycle classes is algebraic. True for every datum and every list of cycles. -/
theorem named_span_le_algebraic (D : Datum Z V N) {n : ℕ} (c : Fin n → Z) :
    Submodule.span ℚ (Set.range fun i => D.cl (c i)) ≤ D.algebraicClasses := by
  rw [Submodule.span_le]
  rintro _ ⟨i, rfl⟩
  exact ⟨c i, rfl⟩

/-- Conversely the spanning hypothesis is exactly as strong as needed: `HodgeConjecture`
plus finitely many cycles spanning the algebraic classes gives a bridge. -/
def SpanBridge.ofHodge {D : Datum Z V N} {n : ℕ} (h : D.HodgeConjecture) (c : Fin n → Z)
    (hc : D.algebraicClasses ≤ Submodule.span ℚ (Set.range fun i => D.cl (c i))) :
    SpanBridge D n :=
  ⟨c, h.trans hc⟩

end Bridge

/-! ## Named hosts, conditionally -/

section Hosts

variable {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]

/-- `P⁴`: if the class of the plane `{x3 = x4 = 0}` spans `Hdg²` (classical; cited). -/
theorem p4_hodge_of_planeSpan (D : Datum Z V N) (B : SpanBridge D 1) : D.HodgeConjecture :=
  B.hodgeConjecture

/-- Klein quadric: if `[Π], [Π']` span `Hdg²` (Schubert basis of `Gr(2,4)`; cited). -/
theorem klein_hodge_of_schubertSpan (D : Datum Z V N) (B : SpanBridge D 2) :
    D.HodgeConjecture :=
  B.hodgeConjecture

/-- `P² × P²`: if the classes of `{pt} × P²`, `line × line`, `P² × {pt}` span `Hdg²`
(Künneth; cited). -/
theorem product_hodge_of_kunnethSpan (D : Datum Z V N) (B : SpanBridge D 3) :
    D.HodgeConjecture :=
  B.hodgeConjecture

end Hosts

/-! ## Non-vacuity -/

/-- The hypothesis is satisfiable (by the identity shadow, now used only as a model). -/
def kleinModelBridge : SpanBridge (idShadow (ℚ × ℚ) ℚ 2) 2 where
  cycles := ![(1, 0), (0, 1)]
  spans := by
    intro v _
    have : v = v.1 • ((1 : ℚ), (0 : ℚ)) + v.2 • ((0 : ℚ), (1 : ℚ)) := by
      ext <;> simp
    rw [this]
    refine Submodule.add_mem _ (Submodule.smul_mem _ _ (Submodule.subset_span ⟨0, rfl⟩))
      (Submodule.smul_mem _ _ (Submodule.subset_span ⟨1, rfl⟩))

/-- A datum of the same shape where the cycle class map is zero: every class is "Hodge"
but none is algebraic. -/
def zeroKlein : Datum (ℚ × ℚ) (ℚ × ℚ) ℚ where
  codim := 2
  obstruction := 0
  cl := 0
  cl_isHodge := by intro _; rfl

/-- The conclusion is not automatic: it fails on `zeroKlein` … -/
theorem zeroKlein_not_hodge : ¬ zeroKlein.HodgeConjecture := by
  intro h
  have hmem : ((1 : ℚ), (0 : ℚ)) ∈ zeroKlein.hodgeClasses := by
    simp [Datum.hodgeClasses, zeroKlein]
  obtain ⟨z, hz⟩ := h hmem
  have := congrArg Prod.fst hz
  simp [zeroKlein] at this

/-- … so no spanning bridge exists there. -/
theorem zeroKlein_no_bridge (n : ℕ) : SpanBridge zeroKlein n → False :=
  fun B => zeroKlein_not_hodge B.hodgeConjecture

/-! ## Honestly named aliases of the shadow theorems -/

theorem p4_identityShadow : Classical.projectiveFourSpace.HodgeConjecture :=
  idShadow_hodge ℚ ℚ 2
theorem klein_identityShadow : Classical.kleinQuadric.HodgeConjecture :=
  idShadow_hodge (ℚ × ℚ) ℚ 2
theorem product_identityShadow : Classical.productOfPlanes.HodgeConjecture :=
  idShadow_hodge (ℚ × ℚ × ℚ) ℚ 2
theorem fermatTwoPlanes_identityShadow : Fermat.twoPlanes.HodgeConjecture :=
  idShadow_hodge (ℚ × ℚ) ℚ 2
theorem fermatQuartic_identityShadow : Fermat.fermatQuartic.HodgeConjecture :=
  idShadow_hodge ℚ ℚ 2
theorem hassett_identityShadow : Hassett.planeSpan.HodgeConjecture :=
  idShadow_hodge (ℚ × ℚ) ℚ 2
theorem veryGeneralCubic_identityShadow : Cubic.veryGeneral.HodgeConjecture :=
  idShadow_hodge ℚ ℚ 2
theorem sexticPlaneSpan_identityShadow : SpecialSextic.planeSpan.HodgeConjecture :=
  idShadow_hodge (ℚ × ℚ) ℚ 2
theorem sexticThreeSpan_identityShadow : SpecialSextic.threeSpan.HodgeConjecture :=
  idShadow_hodge (ℚ × ℚ × ℚ) ℚ 2
theorem k3_identityShadow : k3Surface.HodgeConjecture :=
  idShadow_hodge ℚ ℚ 1
theorem trivialObstruction_identityShadow : Examples.trivialObstruction.HodgeConjecture :=
  idShadow_hodge ℚ ℚ 0
theorem namedFourfolds_identityShadows : HodgeConjecture.NamedFourfolds :=
  HodgeConjecture.named_fourfolds
/-- The "refutations" refute the abstract interface on the zero datum, not a variety. -/
theorem zeroDatum_refutes_interface :
    ¬ (∀ D : Datum ℚ ℚ ℚ, 2 ≤ D.codim → D.HodgeConjecture) :=
  Examples.not_every_codim_ge_two

/-- Honest name for `classical_islands` / `islands_construct` / `classical_fourfolds`. -/
theorem classical_identityShadows :
    Classical.projectiveFourSpace.HodgeConjecture ∧ Classical.kleinQuadric.HodgeConjecture ∧
      Classical.productOfPlanes.HodgeConjecture :=
  ⟨p4_identityShadow, klein_identityShadow, product_identityShadow⟩
theorem classicalFourfolds_identityShadows : HodgeConjecture.ClassicalFourfolds :=
  HodgeConjecture.classical_fourfolds
/-- Honest name for `Geometry.onVarieties_false_on_Rat`: the counterexample is the zero datum
wearing a `Variety` label. -/
theorem zeroDatum_refutes_labelled_interface :
    type_of% @Geometry.onVarieties_false_on_Rat :=
  @Geometry.onVarieties_false_on_Rat
/-- Honest name for `ungated_codim_two_false` (same zero datum). -/
theorem zeroDatum_refutes_codim_two_interface.{u, v, w} :
    type_of% @HodgeConjecture.ungated_codim_two_false.{u, v, w} :=
  @HodgeConjecture.ungated_codim_two_false.{u, v, w}

end HonestHosts
end Hodge

/-!
## Legacy names

Lean 4 refuses `attribute [deprecated]` on declarations from imported modules, and the
modules defining the old names are archived on Zenodo and kept byte-identical. So the old
names stay as they are; each is tied here, by a kernel-checked equation, to its honest name.
New work should use the right-hand sides.
-/

namespace Hodge.HonestHosts.Legacy

theorem legacy_1_projectiveFourSpace_hodgeConjecture : HEq @Hodge.Classical.projectiveFourSpace_hodgeConjecture @Hodge.HonestHosts.p4_identityShadow := HEq.rfl

theorem legacy_2_p4 : HEq @Hodge.HodgeConjecture.p4 @Hodge.HonestHosts.p4_identityShadow := HEq.rfl

theorem legacy_3_projectiveFourSpace_hodge : HEq @Hodge.Geometry.projectiveFourSpace_hodge @Hodge.HonestHosts.p4_identityShadow := HEq.rfl

theorem legacy_4_kleinQuadric_hodgeConjecture : HEq @Hodge.Classical.kleinQuadric_hodgeConjecture @Hodge.HonestHosts.klein_identityShadow := HEq.rfl

theorem legacy_5_klein : HEq @Hodge.HodgeConjecture.klein @Hodge.HonestHosts.klein_identityShadow := HEq.rfl

theorem legacy_6_kleinQuadric_hodge : HEq @Hodge.Geometry.kleinQuadric_hodge @Hodge.HonestHosts.klein_identityShadow := HEq.rfl

theorem legacy_7_productOfPlanes_hodgeConjecture : HEq @Hodge.Classical.productOfPlanes_hodgeConjecture @Hodge.HonestHosts.product_identityShadow := HEq.rfl

theorem legacy_8_product : HEq @Hodge.HodgeConjecture.product @Hodge.HonestHosts.product_identityShadow := HEq.rfl

theorem legacy_9_productOfPlanes_hodge : HEq @Hodge.Geometry.productOfPlanes_hodge @Hodge.HonestHosts.product_identityShadow := HEq.rfl

theorem legacy_10_twoPlanes_hodge : HEq @Hodge.Fermat.twoPlanes_hodge @Hodge.HonestHosts.fermatTwoPlanes_identityShadow := HEq.rfl

theorem legacy_11_fermatQuartic_hodge : HEq @Hodge.Fermat.fermatQuartic_hodge @Hodge.HonestHosts.fermatQuartic_identityShadow := HEq.rfl

theorem legacy_12_planeSpan_hodge : HEq @Hodge.Hassett.planeSpan_hodge @Hodge.HonestHosts.hassett_identityShadow := HEq.rfl

theorem legacy_13_hassettC8_hodge : HEq @Hodge.Cubic.hassettC8_hodge @Hodge.HonestHosts.hassett_identityShadow := HEq.rfl

theorem legacy_14_veryGeneral_hodge : HEq @Hodge.Cubic.veryGeneral_hodge @Hodge.HonestHosts.veryGeneralCubic_identityShadow := HEq.rfl

theorem legacy_15_planeSpan_hodge : HEq @Hodge.SpecialSextic.planeSpan_hodge @Hodge.HonestHosts.sexticPlaneSpan_identityShadow := HEq.rfl

theorem legacy_16_special_NL_sextic_coefficient_shadow : HEq @Hodge.SpecialSextic.special_NL_sextic_coefficient_shadow @Hodge.HonestHosts.sexticPlaneSpan_identityShadow := HEq.rfl

theorem legacy_17_threeSpan_hodge : HEq @Hodge.SpecialSextic.threeSpan_hodge @Hodge.HonestHosts.sexticThreeSpan_identityShadow := HEq.rfl

theorem legacy_18_k3Surface_hodge : HEq @Hodge.k3Surface_hodge @Hodge.HonestHosts.k3_identityShadow := HEq.rfl

theorem legacy_19_trivialObstruction_hodge : HEq @Hodge.Examples.trivialObstruction_hodge @Hodge.HonestHosts.trivialObstruction_identityShadow := HEq.rfl

theorem legacy_20_named_fourfolds : HEq @Hodge.HodgeConjecture.named_fourfolds @Hodge.HonestHosts.namedFourfolds_identityShadows := HEq.rfl

theorem legacy_21_frohman_two_two_spans : HEq @Hodge.HodgeConjecture.frohman_two_two_spans @Hodge.HonestHosts.namedFourfolds_identityShadows := HEq.rfl

theorem legacy_22_classical_fourfolds : HEq @Hodge.HodgeConjecture.classical_fourfolds @Hodge.HonestHosts.classicalFourfolds_identityShadows := HEq.rfl

theorem legacy_23_classical_islands : HEq @Hodge.Classical.classical_islands @Hodge.HonestHosts.classical_identityShadows := HEq.rfl

theorem legacy_24_islands_construct : HEq @Hodge.Islands.islands_construct @Hodge.HonestHosts.classical_identityShadows := HEq.rfl

theorem legacy_25_not_every_codim_ge_two : HEq @Hodge.Examples.not_every_codim_ge_two @Hodge.HonestHosts.zeroDatum_refutes_interface := HEq.rfl

theorem legacy_26_onVarieties_false_on_Rat : HEq @Hodge.Geometry.onVarieties_false_on_Rat @Hodge.HonestHosts.zeroDatum_refutes_labelled_interface := HEq.rfl

theorem legacy_27_ungated_codim_two_false : HEq @Hodge.HodgeConjecture.ungated_codim_two_false.{0,0,0} @Hodge.HonestHosts.zeroDatum_refutes_codim_two_interface.{0,0,0} := HEq.rfl


end Hodge.HonestHosts.Legacy
