/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/

import Hodge.Basic
import Hodge.NamedFamilies

namespace Hodge
namespace HodgeConjecture

/-- Clay statement at codimension 2, written out: every rational Hodge class is the class
of a cycle. Equivalent to `general_fourfold` (defined in `Hodge.Fourfold`). Open; no term
for `general_fourfold D h` itself is supplied. -/
theorem general_fourfold_iff_clay
    {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]
    (D : Datum Z V N) (h : D.codim = 2) :
    general_fourfold D h ↔ ∀ v ∈ D.hodgeClasses, ∃ z : Z, D.cl z = v :=
  ⟨fun H v hv => H hv, fun H v hv => H v hv⟩

end HodgeConjecture
end Hodge
