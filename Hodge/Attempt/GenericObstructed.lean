/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Basic

/-!
# Named gadget requested as genericObstructedFourfold

A Datum with codim 2. Not a scheme. Not IsVariety.
Not imported by `Hodge.lean`.
There is no axiom `¬ HodgeConjecture` here: that would be a claimed
Clay counterexample, which has not been supplied.
-/

namespace Hodge
namespace Attempt

def genericObstructedFourfold : Datum ℚ ℚ ℚ where
  codim := 2
  obstruction := 0
  cl := 0
  cl_isHodge := by intro _; rfl

/-- Grading: a fourfold middle cycle has codim 2, independent of degree.
This field is 2 for that reason. It is not a remainder. -/
theorem genericObstructedFourfold_codim :
    genericObstructedFourfold.codim = 2 :=
  rfl

end Attempt
end Hodge
