/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/

import Hodge.Basic
import Hodge.Fourfold

/-!
# Open frontiers

Records the geometric statements that remain uninhabited.
No term is supplied for any of them.
-/

namespace Hodge

/-- The Hodge conjecture in codimension 2 for an unspecified fourfold datum.
This is the open sentence. No instance exists. -/
def open_geometric_fourfold (D : Datum Z V N) (h : D.codim = 2) : Prop :=
  HodgeConjecture.general_fourfold D h

end Hodge
