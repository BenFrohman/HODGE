/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Mathlib.Tactic.Ring

/-!
# Pair identity for Fermat planes

Not imported by `Hodge.lean`. Not a `CycleSection`.
-/

namespace Hodge
namespace Attempt

variable {R : Type*} [CommRing R]

/-- Remainder form: does not assume ζ^4 = -1. -/
theorem fermat_pair_with_remainder (z w ζ : R) :
    z ^ 4 + w ^ 4 =
      (z - ζ * w) * (z ^ 3 + ζ * z ^ 2 * w + ζ ^ 2 * z * w ^ 2 + ζ ^ 3 * w ^ 3) +
        (1 + ζ ^ 4) * w ^ 4 := by
  ring

theorem fermat_pair_vanishing (z w ζ : R) (hζ : ζ ^ 4 = -1) :
    (z - ζ * w) * (z ^ 3 + ζ * z ^ 2 * w + ζ ^ 2 * z * w ^ 2 + ζ ^ 3 * w ^ 3) =
      z ^ 4 + w ^ 4 := by
  have h := fermat_pair_with_remainder z w ζ
  simp [hζ] at h
  linarith

theorem fermat_quartic_contains_Z1 (z0 z1 z2 z3 z4 z5 ζ : R) (hζ : ζ ^ 4 = -1) :
    z0 ^ 4 + z1 ^ 4 + z2 ^ 4 + z3 ^ 4 + z4 ^ 4 + z5 ^ 4 =
      (z0 - ζ * z1) * (z0 ^ 3 + ζ * z0 ^ 2 * z1 + ζ ^ 2 * z0 * z1 ^ 2 + ζ ^ 3 * z1 ^ 3) +
      (z2 - ζ * z3) * (z2 ^ 3 + ζ * z2 ^ 2 * z3 + ζ ^ 2 * z2 * z3 ^ 2 + ζ ^ 3 * z3 ^ 3) +
      (z4 - ζ * z5) * (z4 ^ 3 + ζ * z4 ^ 2 * z5 + ζ ^ 2 * z4 * z5 ^ 2 + ζ ^ 3 * z5 ^ 3) := by
  simp [fermat_pair_vanishing z0 z1 ζ hζ, fermat_pair_vanishing z2 z3 ζ hζ,
    fermat_pair_vanishing z4 z5 ζ hζ]

end Attempt
end Hodge
