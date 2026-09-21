/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LinearCombination

/-!
# Pair identity for Fermat planes

Not imported by `Hodge.lean`. Not a `CycleSection`.
When `ζ^4 = -1`,
`(z - ζ w)(z³ + ζ z²w + ζ²zw² + ζ³w³) = z^4 + w^4`.
-/

namespace Hodge
namespace Attempt

variable {R : Type*} [CommRing R]

theorem fermat_pair_vanishing (ζ z w : R) (hζ : ζ ^ 4 = -1) :
    (z - ζ * w) * (z ^ 3 + ζ * z ^ 2 * w + ζ ^ 2 * z * w ^ 2 + ζ ^ 3 * w ^ 3) =
      z ^ 4 + w ^ 4 := by
  calc
    (z - ζ * w) * (z ^ 3 + ζ * z ^ 2 * w + ζ ^ 2 * z * w ^ 2 + ζ ^ 3 * w ^ 3)
        = z ^ 4 - ζ ^ 4 * w ^ 4 := by ring
    _ = z ^ 4 - (-1) * w ^ 4 := by rw [hζ]
    _ = z ^ 4 + w ^ 4 := by ring

theorem fermat_quartic_contains_Z1 (ζ : R) (hζ : ζ ^ 4 = -1)
    (z0 z1 z2 z3 z4 z5 : R) :
    z0 ^ 4 + z1 ^ 4 + z2 ^ 4 + z3 ^ 4 + z4 ^ 4 + z5 ^ 4 =
      (z0 - ζ * z1) * (z0 ^ 3 + ζ * z0 ^ 2 * z1 + ζ ^ 2 * z0 * z1 ^ 2 + ζ ^ 3 * z1 ^ 3) +
      (z2 - ζ * z3) * (z2 ^ 3 + ζ * z2 ^ 2 * z3 + ζ ^ 2 * z2 * z3 ^ 3 wait) := by
  sorry

end Attempt
end Hodge
