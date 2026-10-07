/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.SpecialSextic

namespace Hodge
namespace SpecialSextic

/-- Point of `{x0 = x1 = x2 = 0}` where `F` is `1`.
The docs asserted this plane is not on `V(F)`. This is the witness. -/
theorem head_plane_point :
    F (0 : ℚ) 0 0 1 0 0 = 1 := by
  unfold F
  ring

theorem head_plane_not_on_host :
    F (0 : ℚ) 0 0 1 0 0 ≠ 0 := by
  rw [head_plane_point]
  decide

end SpecialSextic
end Hodge
