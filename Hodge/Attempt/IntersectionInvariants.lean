/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)

Numerical isolation of [Pi] from Q · h^2 on a special sextic fourfold in P^5.
Not a Chow-ring theorem. Not a CycleSection. Not general_fourfold.
Not imported by Hodge.lean.
-/
import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum

/-!
# Intersection arithmetic for a linear plane on a degree-d fourfold

Geometric input, recorded as comments, not as Lean geometry:

* `h^4 = d` on a degree-`d` hypersurface fourfold in `P^5`.
* `[Pi] · h^2 = 1` for a linear plane `Pi ≅ P^2`.
* `[Pi]^2 = d^2 - 3d + 3` from the normal-bundle sequence
  `0 → N_{Pi/X} → O(1)^{\oplus 3} → O(d)|_Pi → 0`.

At `d = 6` that polynomial is `21`. If `[Pi] = c · h^2` then
`c = 1/6` from the restriction and the predicted self-intersection is
`1/6`. The integers `21` and `1/6` are not equal.
-/

namespace Hodge.Attempt

/-- Integer polynomial `d^2 - 3d + 3`. Evaluation only. -/
def planeSelfIntersection (d : ℤ) : ℤ :=
  d ^ 2 - 3 * d + 3

theorem planeSelfIntersection_sextic :
    planeSelfIntersection 6 = 21 := by
  decide

/-- Ambient prediction: `(1/6)^2 * 6 = 1/6`. -/
theorem ambient_selfIntersection_prediction :
    ((1 / 6 : ℚ) * (1 / 6)) * 6 = 1 / 6 := by
  norm_num

/-- Isolation: `21 ≠ 1/6`. -/
theorem extra_class_not_ambient_multiple :
    (21 : ℚ) ≠ 1 / 6 := by
  norm_num

/-- Combined: no rational `c` satisfies both ambient identities at these numbers. -/
theorem no_rational_ambient_coefficient :
    ¬ ∃ c : ℚ, c * 6 = 1 ∧ c * c * 6 = 21 := by
  rintro ⟨c, h1, h2⟩
  have hc : c = 1 / 6 := by
    have : c * 6 - 1 = 0 := by linear_combination h1
    have : (c - 1 / 6) * 6 = 0 := by
      linear_combination this
    have h6 : (6 : ℚ) ≠ 0 := by norm_num
    exact eq_of_sub_eq_zero (eq_zero_of_mul_eq_zero_right this h6?)
```