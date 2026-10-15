/-
Copyright (c) 2026 Benjamin Stanley Frohman.
Authors: Benjamin Stanley Frohman (@BenFrohman)
SPDX-License-Identifier: Apache-2.0
-/

import Hodge.Basic
import Hodge.NamedFamilies

namespace Hodge
namespace HodgeConjecture

/-- Clay statement at codimension 2. Open. -/
def general_fourfold
    {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]
    (D : Datum Z V N) (_h : D.codim = 2) : Prop :=
  ∀ v ∈ D.hodgeClasses, ∃ z : Z, D.cl z = v

/-- No term is supplied. -/
-- theorem general_fourfold_holds (D) (h : D.codim = 2) :
--     general_fourfold D h := sorry   -- deliberately absent

end HodgeConjecture
end Hodge
