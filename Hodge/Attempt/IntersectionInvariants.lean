/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)

Arithmetic of the extra-class isolation on a linear plane in a degree-6
hypersurface fourfold in P^5. Not a Chow ring. Not a CycleSection.
Not imported by Hodge.lean. `HodgeConjecture.general_fourfold` stays a Prop.
-/
import Mathlib.Data.Rat.Init
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

/-!
# Intersection arithmetic (numbers only)

Geometry recorded in `docs/EXTRA_CLASS_SEXTIC.md` §6:

    h^4 = 6,    [Pi] · h^2 = 1,    [Pi]^2 = d^2 - 3d + 3.

The last identity is c2 of the normal sequence
`0 → N_{Pi/X} → O(1)^3 → O(d) → 0` on `Pi ≅ P^2`.
That sequence is **not** a theorem in this file.

This file proves only:
* the integer evaluation at `d = 6` is 21;
* if `[Pi] = (1/6) h^2` then the predicted self-intersection is `1/6`;
* `21 ≠ 1/6`.
-/

namespace Hodge.Attempt.IntersectionInvariants

/-- Chern-arithmetic formula, as an integer polynomial. -/
def planeSelfIx (d : Int) : Int := d ^ 2 - 3 * d + 3

@[simp] theorem planeSelfIx_six : planeSelfIx 6 = 21 := by
  decide

theorem predicted_ambient_self :
    ((1 : Rat) / 6) ^ 2 * 6 = 1 / 6 := by
  norm_num

theorem extra_class_mismatch : (21 : Rat) ≠ (1 : Rat) / 6 := by
  norm_num

/-- Isolation: the two numbers that would have to agree if `[Pi] = c h^2`. -/
theorem isolation_not_ambient :
    planeSelfIx 6 ≠ 1 := by
  decide

end Hodge.Attempt.IntersectionInvariants
