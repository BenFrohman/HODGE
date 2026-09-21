/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). MIT license.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Classical

/-!
# Numerical pairing on the Klein shadow

On `Rat × Rat` we record the matrix of Identity B:
`[Π]² = [Π']² = 1`, `[Π]·[Π'] = 0`.
This is a bilinear form on coefficients, not CH(Gr(2,4)).
-/

namespace Hodge
namespace Klein

def pairing : (ℚ × ℚ) → (ℚ × ℚ) → ℚ
  | (a, b), (a', b') => a * a' + b * b'

theorem pairing_Pi : pairing (1, 0) (1, 0) = 1 := by decide
theorem pairing_Pi' : pairing (0, 1) (0, 1) = 1 := by decide
theorem pairing_cross : pairing (1, 0) (0, 1) = 0 := by decide

/-- Reconstruction in the orthogonal ruling basis. -/
theorem expand (a b : ℚ) :
    (a, b) = (pairing (a, b) (1, 0), pairing (a, b) (0, 1)) := by
  simp [pairing]

end Klein
end Hodge
