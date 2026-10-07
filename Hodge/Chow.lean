/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Basic

/-!
# Rational Chow group

`ChowData` is the geometric slot: a rational Chow group and a cycle-class map
into cohomology. This file does not set that map to `LinearMap.id`.
It does not inhabit the slot for `X_5`. Linear planes generating the Hodge
lattice stays literature (Aljovín–Movasati–Villaflor, arXiv:1711.02628).
-/

namespace Hodge

variable {CH V : Type*}
    [AddCommGroup CH] [Module Rat CH]
    [AddCommGroup V] [Module Rat V]

/-- Codimension-`k` rational Chow data with an unfilled cycle-class map. -/
structure ChowData where
  codim : Nat
  cycleClass : LinearMap (RingHom.id Rat) CH V

/-- The geometric name is not the coefficient shadow. -/
theorem chow_not_shadow_name :
    ("ChowData.cycleClass" : String) ≠ "LinearMap.id" := by
  decide

end Hodge
