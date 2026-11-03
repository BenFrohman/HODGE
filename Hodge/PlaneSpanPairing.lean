/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.SpecialSextic

/-!
# Intersection form on ℔ h² + ℔ [Π]

Coordinates: `(a, b)` means `a h² + b [Π]`.
Gram matrix from the special sextic (`h⁴ = 6`, `h² · [Π] = 1`, `[Π]² = 21`):

    ⟨(a,b), (a',b')⟩ = 6 a a' + a b' + a' b + 21 b b'

This is bilinear algebra on the named span. It is not
`CH²(V(F))`, not `Mon`, not `Mon_Π`, and not a list of
2605 × 2605 matrices.
-/

namespace Hodge
namespace SpecialSextic

/-- Gram form of the plane span. -/
def pairing : ℚ × ℚ → ℚ × ℚ → ℚ
  | (a, b), (a', b') => 6 * a * a' + a * b' + a' * b + 21 * b * b'

def h2 : ℚ × ℚ := (1, 0)
def Pi : ℚ × ℚ := (0, 1)
/-- Residual class `h² - [Π]` on this span. -/
def S : ℚ × ℚ := (1, -1)
/-- Primitive direction orthogonal to `h²`: `h² - 6[Π]`. -/
def beta : ℚ × ℚ := (1, -6)

theorem pairing_h2_h2 : pairing h2 h2 = 6 := by decide
theorem pairing_h2_Pi : pairing h2 Pi = 1 := by decide
theorem pairing_Pi_Pi : pairing Pi Pi = 21 := by decide

theorem discriminant : pairing h2 h2 * pairing Pi Pi - pairing h2 Pi ^ 2 = 125 := by
  decide

theorem pairing_h2_S : pairing h2 S = 5 := by decide
theorem pairing_Pi_S : pairing Pi S = -20 := by decide
theorem pairing_S_S : pairing S S = 25 := by decide

theorem pairing_beta_h2 : pairing beta h2 = 0 := by decide
theorem pairing_beta_Pi : pairing beta Pi = -125 := by decide
theorem pairing_beta_S : pairing beta S = 125 := by decide
theorem pairing_beta_beta : pairing beta beta = 750 := by decide

theorem S_eq : S = (h2.1 - Pi.1, h2.2 - Pi.2) := rfl
theorem beta_eq : beta = (h2.1 - 6 * Pi.1, h2.2 - 6 * Pi.2) := by decide

end SpecialSextic
end Hodge
