/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Mathlib.Tactic.Ring

/-!
# Pair identity for Fermat planes

Not imported by `Hodge.lean`. Not a `CycleSection`.
`+` associates left, so a pair rewrite needs the sum regrouped first.
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
  rw [fermat_pair_with_remainder]
  rw [hζ]
  ring

theorem fermat_quartic_contains_Z1 (z0 z1 z2 z3 z4 z5 ζ : R) (hζ : ζ ^ 4 = -1) :
    z0 ^ 4 + z1 ^ 4 + z2 ^ 4 + z3 ^ 4 + z4 ^ 4 + z5 ^ 4 =
      (z0 - ζ * z1) * (z0 ^ 3 + ζ * z0 ^ 2 * z1 + ζ ^ 2 * z0 * z1 ^ 2 + ζ ^ 3 * z1 ^ 3) +
      (z2 - ζ * z3) * (z2 ^ 3 + ζ * z2 ^ 2 * z3 + ζ ^ 2 * z2 * z3 ^ 2 + ζ ^ 3 * z3 ^ 3) +
      (z4 - ζ * z5) * (z4 ^ 3 + ζ * z4 ^ 2 * z5 + ζ ^ 2 * z4 * z5 ^ 2 + ζ ^ 3 * z5 ^ 3) := by
  have h01 := fermat_pair_vanishing z0 z1 ζ hζ
  have h23 := fermat_pair_vanishing z2 z3 ζ hζ
  have h45 := fermat_pair_vanishing z4 z5 ζ hζ
  calc
    z0 ^ 4 + z1 ^ 4 + z2 ^ 4 + z3 ^ 4 + z4 ^ 4 + z5 ^ 4 =
        (z0 ^ 4 + z1 ^ 4) + (z2 ^ 4 + z3 ^ 4) + (z4 ^ 4 + z5 ^ 4) := by ring
    _ =
        (z0 - ζ * z1) * (z0 ^ 3 + ζ * z0 ^ 2 * z1 + ζ ^ 2 * z0 * z1 ^ 2 + ζ ^ 3 * z1 ^ 3) +
        (z2 - ζ * z3) * (z2 ^ 3 + ζ * z2 ^ 2 * z3 + ζ ^ 2 * z2 * z3 ^ 2 + ζ ^ 3 * z3 ^ 3) +
        (z4 - ζ * z5) * (z4 ^ 3 + ζ * z4 ^ 2 * z5 + ζ ^ 2 * z4 * z5 ^ 2 + ζ ^ 3 * z5 ^ 3) := by
      rw [← h01, ← h23, ← h45]

end Attempt
end Hodge
