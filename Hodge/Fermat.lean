/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman).
Released under Apache-2.0 as described in LICENSE.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Fourfold
import Hodge.Construct

/-!
# Fermat quartic fourfold — named host

Host:
  X : z₀⁴ + z₁⁴ + z₂⁴ + z₃⁴ + z₄⁴ + z₅⁴ = 0 ⊂ ℝ⁵

Two named planes (pairing (0,1)(2,3)(4,5), ζ⁴ = -1):
  Z₁, Z₂ as in BenFrohman/FermatPlanes.

`T_F` on this two-plane span: (a, b) ↦ a[Z₁] + b[Z₂].
This is not the AMV spanning of all of Hdg² (rank 142).
This is not `classical_fourfolds`.
-/

namespace Hodge
namespace Fermat

/-- Linear shadow of the two named planes. -/
def twoPlaneSpan : Datum (Rat × Rat) (Rat × Rat) Rat where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

/-- T_F on the span: coefficients are the cycle. -/
def constructTwo (gamma : Rat × Rat) : Rat × Rat := gamma

theorem constructTwo_section (gamma : Rat × Rat) :
    twoPlaneSpan.cl (constructTwo gamma) = gamma :=
  rfl

instance : CycleSection twoPlaneSpan where
  construct := fun γ => constructTwo γ.val
  is_section := fun γ => constructTwo_section γ.val

theorem twoPlaneSpan_hodge : twoPlaneSpan.HodgeConjecture :=
  HodgeConjecture.of_section twoPlaneSpan

/-- One-dimensional shadow used by older files. Not the AMV lattice. -/
def fermatQuartic : Datum Rat Rat Rat where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

instance : CycleSection fermatQuartic where
  construct := fun γ => γ.val
  is_section := fun γ => rfl

theorem fermatQuartic_hodge : fermatQuartic.HodgeConjecture :=
  HodgeConjecture.of_section fermatQuartic

end Fermat
end Hodge
