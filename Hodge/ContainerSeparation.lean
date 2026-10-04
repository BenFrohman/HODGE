/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/

/-!
# Claim fix: containers are not ranks

The chain sextic is

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6.

Its partials are `5 x_i^4 x_{i+3}` and `x_i^5 + 6 x_{i+3}^5`.
They are not the Fermat quintic partials `5 x_i^4`.

`gram_det_numeral` in `SpecialSextic.lean` is the arithmetic identity
`6 * 21 * 21 - 21 - 21 = 2604`. It is not a proof of an intersection matrix.
`Z` is uncomputed.
-/

namespace Hodge
namespace ContainerSeparation

theorem sextic_R6 : (426 : Nat) = 426 := by decide
theorem sextic_R12 : (1751 : Nat) = 1751 := by decide
theorem sextic_R18 : (426 : Nat) = 426 := by decide
theorem sextic_h22 : (1751 : Nat) + 1 = 1752 := by decide
theorem sextic_b4 : (1 : Nat) + 426 + 1752 + 426 + 1 = 2606 := by decide

theorem quintic_h31 : (126 : Nat) - 6 = 120 := by decide

/-- Arithmetic shadow only. Not an intersection determinant. -/
theorem gram_shadow_numeral : (6 : Nat) * 21 * 21 - 21 - 21 = 2604 := by decide

theorem two_plane_shadow_det : (6 : Nat) * 21 - 1 = 125 := by decide

theorem Z_not_container : (1751 : Nat) - 8 ≠ 1751 := by decide

def Z_status : String := "uncomputed"

theorem Z_uncomputed : Z_status = "uncomputed" := rfl

end ContainerSeparation
end Hodge
