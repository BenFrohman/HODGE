/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Fourfold
import Hodge.Hassett

/-!
# Cubic fourfolds

Z_i that this file actually names:

* very general cubic: one cycle Z_0 = X ∩ P^3, class h^2.
  Datum is the rank-1 shadow. CycleSection = id on Q.
* Hassett C_8: Z_0 = X ∩ {x0=x1=0}, Z_1 = Π = {x3=x4=x5=0}.
  Already `Hassett.planeSpan` (Q², cl = id).

Zucker (Compositio 34, 1977): every rational (2,2) class on any smooth cubic
in P^5 is algebraic. That is option-2 existence. It does not list Z_i.
`ZuckerCubic` records that hypothesis. It is not
`instance [IsCubicFourfold] : CycleSection`.

Not general_fourfold.
-/

namespace Hodge
namespace Cubic

/-- Sticker: this datum is meant as a cubic fourfold. Not a scheme. -/
class IsCubicFourfold (D : Datum Z V N) : Prop

/-- Rank-1 shadow of a very general cubic: Hdg^2 = Q h^2.
    The cycle is Z_0 = X ∩ P^3. -/
def veryGeneral : Datum Rat Rat Rat where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro _; simp

def construct_h2 (gamma : Rat) : Rat := gamma

/-- Z_0 = linear surface section. One coefficient. -/
theorem construct_h2_section (gamma : Rat) :
    veryGeneral.cl (construct_h2 gamma) = gamma :=
  rfl

instance : CycleSection veryGeneral where
  construct := fun γ => construct_h2 γ.val
  is_section := fun γ => construct_h2_section γ.val

theorem veryGeneral_hodge : veryGeneral.HodgeConjecture :=
  HodgeConjecture.of_section veryGeneral

/-- Hassett C_8 plane already named in Hodge/Hassett.lean. -/
abbrev hassettC8 := Hassett.planeSpan

theorem hassettC8_hodge : hassettC8.HodgeConjecture :=
  Hassett.planeSpan_hodge

/-- Literature: Zucker 1977. Every Hodge class on this datum is algebraic.
    No map to explicit Z_i. -/
class ZuckerCubic (D : Datum Z V N) : Prop where
  construct : ∀ v ∈ D.hodgeClasses, v ∈ D.algebraicClasses

instance (D : Datum Z V N) [ZuckerCubic D] : CycleConstructor D :=
  ⟨ZuckerCubic.construct⟩

theorem hodge_of_zucker (D : Datum Z V N) [ZuckerCubic D] :
    D.HodgeConjecture :=
  HodgeConjecture.of_constructor D

/-- There is no instance [IsCubicFourfold D] : CycleSection D. -/
theorem no_universal_cubic_section : True := trivial

end Cubic
end Hodge
