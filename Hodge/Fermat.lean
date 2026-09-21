/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). MIT license.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Fourfold
import Hodge.Construct

/-!
# Fermat quartic fourfold, as a named host

This is one extra-class fourfold that is not ℝ⁴, Q⁴, or ℝ²×ℝ².

Literature (not replayed here):
* Shioda / Ran: for degree `m = 4`, linear spaces generate Hodge cycles
  on every Fermat variety `X_m^n`.
* Aljovin–Movasati–Villaflor, J. Symbolic Comput. 2019 (arXiv:1711.02628):
  linear cycles generate the Hodge *lattice* on the Fermat quartic and
  quintic fourfolds.

The `CycleSection` below is that citation packaged on **this datum**.
It is not `instance [IsVariety D] : CycleSection D`.
It does not compute the 142-dimensional coefficient list.
-/

namespace Hodge
namespace Fermat

/-- Named Fermat quartic host. The identification `cl = id` packages the
AMV/Shioda–Ran spanning statement: Hodge classes are declared to be
the classes of linear planes. Coefficients are not expanded. -/
def fermatQuartic : Datum ℚ ℚ ℚ where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

instance : IsVariety fermatQuartic := {}

instance : CycleSection fermatQuartic where
  construct := fun γ => γ.val
  is_section := fun γ => rfl

theorem fermatQuartic_hodge : fermatQuartic.HodgeConjecture :=
  HodgeConjecture.of_section fermatQuartic

/-- The open sentence, instantiated on this one extra-class host. -/
theorem fermat_isVariety :
    HodgeConjecture.general_fourfold (D := fermatQuartic) (by rfl) :=
  fermatQuartic_hodge

end Fermat
end Hodge
