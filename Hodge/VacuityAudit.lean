/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Hodge.Skeleton
import Hodge.Verify
import Hodge.NoShadow
import Hodge.Chow
import Hodge.Cubic
import Hodge.Hassett
import Hodge.Fermat
import Hodge.SpecialSextic
import Hodge.Frontier
import Hodge.Known
import Hodge.ClayTerm
import Hodge.Geometry
import Hodge.NamedFamilies
import Hodge.Islands
import Hodge.HostSplit
import Hodge.ContainerSeparation
import Hodge.SpecialSexticJacobian
import Hodge.FermatQuintic
import Hodge.JacobianLength

/-!
# Vacuity audit

Each theorem below is a *proof* that some earlier declaration of this library is
contentless: it holds for a reason that has nothing to do with the geometry its name
suggests. Nothing in earlier files is changed by this file. The honest, conditional
replacements are in `Hodge.HonestHosts`; the bridge checks for the chain sextic are in
`Hodge.ChainSexticBridgeAudit`.

Mechanisms found:

* **(a) identity shadows.** The named-host `Datum`s set `obstruction := 0` and
  `cl := LinearMap.id`. Every vector is then a "Hodge class" and every vector is
  "algebraic", so `HodgeConjecture` holds by `rfl` on any vector space. Distinct
  "varieties" are literally the same `Datum`.
* **(b) hypotheses that are the conclusion.** `CycleConstructor`, `LefschetzOneOne`,
  `HardLefschetzComplement`, `DimLeThree`, `ZuckerCubic` each have the conclusion as a
  field. Their names (dimension, hard Lefschetz, cubic) are not tied to the data.
  `Cubic.IsCubicFourfold`, `JacobianLength.PartialsRegular` have no fields and
  `JacobianLength.HomogeneousCILength` has the tautology `d ^ n = d ^ n` as its field.
* **(c) uninhabitable by construction.** `NoShadow.GeometricCycleClassDischarged` is
  equivalent to `False`.
* **(d) opaque sentences.** `Clay.RationalHodgeCodimTwo` is built from opaque constants
  with no properties, so its Lean truth value is not tied to geometry: the same sentence
  shape is true for one interpretation and false for another.
* **(e) overclaiming names.** Theorems of type `True`, numeral identities like
  `1751 = 1751`, and string inequalities have names that sound like geometry. The
  "refutations" (`onVarieties_false_on_Rat`, `not_every_codim_ge_two`,
  `ungated_codim_two_false`) refute the abstract interface on a nonsense datum, not
  the Hodge conjecture.
-/

namespace Hodge
namespace VacuityAudit

/-! ## (a) Identity shadows -/

section IdShadow

variable (V N : Type*) [AddCommGroup V] [Module ℚ V] [AddCommGroup N] [Module ℚ N]

/-- The identity shadow on an arbitrary vector space (off-diagonal space `N` arbitrary). -/
def idShadow (k : ℕ) : Datum V V N where
  codim := k
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro _; rfl

/-- `HodgeConjecture` holds for the identity shadow on *every* vector space. -/
theorem idShadow_hodge (k : ℕ) : (idShadow V N k).HodgeConjecture :=
  fun v _ => ⟨v, rfl⟩

/-- Every vector of an identity shadow is a "Hodge class". -/
theorem idShadow_hodgeClasses (k : ℕ) : (idShadow V N k).hodgeClasses = ⊤ := by
  simp [Datum.hodgeClasses, idShadow]

/-- Every vector of an identity shadow is "algebraic". -/
theorem idShadow_algebraicClasses (k : ℕ) : (idShadow V N k).algebraicClasses = ⊤ := by
  simp [Datum.algebraicClasses, idShadow]

end IdShadow

/-- E.g. a "sextic" of rank 2606 is proved Hodge by the same one-liner. -/
theorem shadow_rank_2606_hodge : (idShadow (Fin 2606 → ℚ) ℚ 2).HodgeConjecture :=
  idShadow_hodge _ _ 2

theorem p4_is_idShadow : Classical.projectiveFourSpace = idShadow ℚ ℚ 2 := rfl
theorem klein_is_idShadow : Classical.kleinQuadric = idShadow (ℚ × ℚ) ℚ 2 := rfl
theorem product_is_idShadow : Classical.productOfPlanes = idShadow (ℚ × ℚ × ℚ) ℚ 2 := rfl
theorem fermatQuartic_is_idShadow : Fermat.fermatQuartic = idShadow ℚ ℚ 2 := rfl
theorem fermatTwoPlanes_is_idShadow : Fermat.twoPlanes = idShadow (ℚ × ℚ) ℚ 2 := rfl
theorem hassett_is_idShadow : Hassett.planeSpan = idShadow (ℚ × ℚ) ℚ 2 := rfl
theorem veryGeneralCubic_is_idShadow : Cubic.veryGeneral = idShadow ℚ ℚ 2 := rfl
theorem sexticPlaneSpan_is_idShadow : SpecialSextic.planeSpan = idShadow (ℚ × ℚ) ℚ 2 := rfl
theorem sexticThreeSpan_is_idShadow :
    SpecialSextic.threeSpan = idShadow (ℚ × ℚ × ℚ) ℚ 2 := rfl
theorem k3_is_idShadow : k3Surface = idShadow ℚ ℚ 1 := rfl
theorem trivialObstruction_is_idShadow : Examples.trivialObstruction = idShadow ℚ ℚ 0 := rfl

/-- Different "varieties" are the same `Datum`: the Klein quadric, the Fermat quartic
two-plane span, the Hassett cubic and the chain sextic plane span coincide, and `P⁴`
coincides with the Fermat quartic and the very general cubic. -/
theorem distinct_hosts_are_equal :
    Classical.kleinQuadric = Fermat.twoPlanes ∧
    Classical.kleinQuadric = Hassett.planeSpan ∧
    Classical.kleinQuadric = SpecialSextic.planeSpan ∧
    Classical.projectiveFourSpace = Fermat.fermatQuartic ∧
    Classical.projectiveFourSpace = Cubic.veryGeneral ∧
    Classical.productOfPlanes = SpecialSextic.threeSpan :=
  ⟨rfl, rfl, rfl, rfl, rfl, rfl⟩

/-- `NamedFourfolds` (published name "Named (2,2) spans") is, definitionally, the statement
that four identity shadows satisfy `HodgeConjecture`. -/
theorem namedFourfolds_unfolds :
    HodgeConjecture.NamedFourfolds =
      (((idShadow ℚ ℚ 2).HodgeConjecture ∧ (idShadow (ℚ × ℚ) ℚ 2).HodgeConjecture ∧
          (idShadow (ℚ × ℚ × ℚ) ℚ 2).HodgeConjecture) ∧
        (idShadow (ℚ × ℚ) ℚ 2).HodgeConjecture ∧ (idShadow (ℚ × ℚ) ℚ 2).HodgeConjecture ∧
          (idShadow (ℚ × ℚ) ℚ 2).HodgeConjecture) :=
  rfl

/-- The `CycleSection` instances are the identity function. -/
theorem klein_section_is_id (γ : { v : ℚ × ℚ // v ∈ Classical.kleinQuadric.hodgeClasses }) :
    CycleSection.construct γ = γ.val := rfl

/-! ## (b) Hypothesis classes that are the conclusion -/

section Classes

variable {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]

theorem cycleConstructor_iff (D : Datum Z V N) :
    CycleConstructor D ↔ D.HodgeConjecture :=
  ⟨fun h => h.construct, fun h => ⟨h⟩⟩

theorem lefschetzOneOne_iff (D : Datum Z V N) :
    LefschetzOneOne D ↔ D.codim = 1 ∧ D.HodgeConjecture :=
  ⟨fun h => ⟨h.is_codim_one, h.construct⟩, fun h => ⟨h.1, h.2⟩⟩

theorem hardLefschetzComplement_iff (D : Datum Z V N) :
    HardLefschetzComplement D ↔ D.HodgeConjecture :=
  ⟨fun h => h.construct, fun h => ⟨h⟩⟩

theorem dimLeThree_iff (D : Datum Z V N) : DimLeThree D ↔ D.HodgeConjecture :=
  ⟨fun h => h.construct, fun h => ⟨h⟩⟩

theorem zuckerCubic_iff (D : Datum Z V N) : Cubic.ZuckerCubic D ↔ D.HodgeConjecture :=
  ⟨fun h => h.construct, fun h => ⟨h⟩⟩

/-- `IsCubicFourfold` has no fields: every datum is a "cubic fourfold". -/
theorem isCubicFourfold_any (D : Datum Z V N) : Cubic.IsCubicFourfold D := ⟨⟩

end Classes

/-- `DimLeThree` holds for the codimension-2 "fourfold" `P⁴` shadow: the class does not
mention dimension. -/
theorem dimLeThree_on_p4 : DimLeThree Classical.projectiveFourSpace :=
  (dimLeThree_iff _).mpr Classical.projectiveFourSpace_hodgeConjecture

/-- `ZuckerCubic` (the cubic-fourfold hypothesis) holds for the Klein quadric shadow. -/
theorem zuckerCubic_on_klein : Cubic.ZuckerCubic Classical.kleinQuadric :=
  (zuckerCubic_iff _).mpr Classical.kleinQuadric_hodgeConjecture

/-- `HardLefschetzComplement` holds on the codimension-2 shadow of `P² × P²`. -/
theorem hardLefschetz_on_product : HardLefschetzComplement Classical.productOfPlanes :=
  (hardLefschetzComplement_iff _).mpr Classical.productOfPlanes_hodgeConjecture

/-- The two Jacobian-length hypotheses are trivially satisfiable. -/
theorem partialsRegular_trivial : JacobianLength.PartialsRegular := ⟨⟩
theorem homogeneousCILength_trivial : JacobianLength.HomogeneousCILength := ⟨fun _ _ => rfl⟩

/-! ## (c) Uninhabitable by construction -/

/-- `GeometricCycleClassDischarged` is `∀ X k, True → False`, i.e. `False`. -/
theorem geometricCycleClassDischarged_iff_false :
    NoShadow.GeometricCycleClassDischarged.{0} ↔ False :=
  ⟨fun h => h PUnit 0 trivial, False.elim⟩

/-! ## (d) Opaque sentences -/

/-- The shape of `Clay.RationalHodgeCodimTwo`, with its opaque constants as parameters. -/
def ClayShape (X : Type) (Hdg A : X → Type) (f : ∀ x, A x → Hdg x) : Prop :=
  ∀ (x : X) (γ : Hdg x), ∃ z : A x, f x z = γ

theorem clay_is_shape :
    Clay.RationalHodgeCodimTwo =
      ClayShape Clay.SmoothComplexProjectiveFourfold Clay.Hdg2 Clay.AlgebraicSpan
        (fun x => @Clay.ofAlgebraic x) :=
  rfl

/-- True under one interpretation of the opaque data … -/
theorem clayShape_true : ClayShape Unit (fun _ => Unit) (fun _ => Unit) (fun _ z => z) :=
  fun _ γ => ⟨γ, rfl⟩

/-- … and false under another, with the same "Hdg²" (a nonempty type). So the Lean
sentence records no geometric information: the opaque constants have no properties. -/
theorem clayShape_false :
    ¬ ClayShape Unit (fun _ => Unit) (fun _ => Empty) (fun _ z => z.elim) := by
  intro h
  obtain ⟨z, _⟩ := h () ()
  exact z.elim

/-! ## (e) Overclaiming names -/

/-- Theorems whose type is literally `True`. -/
theorem true_typed_theorems :
    (True = True) ∧
      SpecialSextic.jacobian_lock_is_not_general_fourfold = trivial ∧
      FermatQuintic.this_is_not_general_fourfold = trivial ∧
      JacobianLength.this_is_not_general_fourfold = trivial ∧
      Examples.zeroCycle_is_not_a_variety_sticker = trivial ∧
      Cubic.no_universal_cubic_section = trivial :=
  ⟨rfl, rfl, rfl, rfl, rfl, rfl⟩

/-- "Hodge numbers" that are numeral reflexivities, not computations. -/
theorem numeral_placeholders :
    HostSplit.sextic_r12 = (rfl : (1751 : ℕ) = 1751) ∧
      HostSplit.sextic_r6 = (rfl : (426 : ℕ) = 426) ∧
      HostSplit.sextic_r18 = (rfl : (426 : ℕ) = 426) :=
  ⟨rfl, rfl, rfl⟩

/-- `JacobianLength.length_num_of_hyps` does not use its hypotheses. -/
theorem length_num_of_hyps_unconditional : (5 : ℕ) ^ 6 = 15625 :=
  @JacobianLength.length_num_of_hyps partialsRegular_trivial homogeneousCILength_trivial

/-- `ChowData` puts no condition on its map: the identity is a valid "cycle class". -/
def chowData_id : ChowData (CH := ℚ) (V := ℚ) := ⟨2, LinearMap.id⟩

theorem chowData_id_cycleClass : (chowData_id).cycleClass = LinearMap.id := rfl

/-- The datum behind the "refutations" declares every class Hodge and no class algebraic.
It is not the datum of any variety. -/
theorem zeroCycle_all_hodge : Examples.zeroCycle.hodgeClasses = ⊤ := by
  simp [Datum.hodgeClasses, Examples.zeroCycle]

theorem zeroCycle_none_algebraic : Examples.zeroCycle.algebraicClasses = ⊥ := by
  simp [Datum.algebraicClasses, Examples.zeroCycle]

/-- A `Geometry.Variety` is a label: any datum can be called `P⁴` of dimension 4. -/
theorem any_datum_labelled_P4 (D : Datum ℚ ℚ ℚ) :
    ∃ X : Geometry.Variety ℚ ℚ ℚ, X.name = "P^4" ∧ X.dim = 4 ∧ X.data = D :=
  ⟨Geometry.wrap "P^4" 4 D, rfl, rfl, rfl⟩

/-- The "variety" used to refute `onVarieties` is the zero datum labelled with dimension 4. -/
theorem zeroGadget_is_label : Geometry.zeroGadget.data = Examples.zeroCycle ∧
    Geometry.zeroGadget.dim = 4 :=
  ⟨rfl, rfl⟩

end VacuityAudit
end Hodge
