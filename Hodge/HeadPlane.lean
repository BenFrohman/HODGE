/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)

Point witness for the named sextic. Not a Hodge class.
-/
import Hodge.SpecialSextic

namespace Hodge
namespace HeadPlane

open SpecialSextic

/-- `1 ^ 6 = 1`, so `(0,0,0,1,0,0)` is not the origin of the cone. -/
theorem head_plane_point : F (0 : ℚ) 0 0 1 0 0 = 1 := by
  unfold F
  ring

end HeadPlane
end Hodge
