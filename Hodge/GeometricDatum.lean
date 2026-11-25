/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/

import Hodge.Basic
import Hodge.Examples
import Hodge.Fourfold

/-!
# GeometricDatum

A refinement of `Datum` that records the minimal non-degeneracy required of a
geometric cycle class map: the existence of some cycle with nonzero class.
`zeroCycle` fails this condition and therefore cannot be a `GeometricDatum`.
The refinement does not inhabit `HodgeConjecture.general_fourfold` for an
unspecified geometric datum.
-/

namespace Hodge

variable {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]

/-- A `Datum` together with a witness that `cl` is not the zero map. -/
structure GeometricDatum (Z V N : Type*)
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]
    extends Datum Z V N where
  /-- Some algebraic cycle has nonzero cohomology class. -/
  nonvanishing_cycle : ∃ z : Z, cl z ≠ 0

namespace GeometricDatum

/-- `zeroCycle` has vanishing cycle class map, so it is not geometric. -/
theorem not_geometric_zeroCycle :
    ¬ ∃ G : GeometricDatum ℚ ℚ ℚ, G.toDatum = Examples.zeroCycle := by
  rintro ⟨G, hG⟩
  rcases G.nonvanishing_cycle with ⟨z, hz⟩
  have hcl : G.cl = Examples.zeroCycle.cl := by
    simpa using congrArg Datum.cl hG
  apply hz
  rw [hcl]
  rfl

/-- The one-dimensional hyperplane-square span is geometric. -/
def hyperplaneSquareSpan : GeometricDatum ℚ ℚ Unit where
  toDatum := {
    codim := 2
    obstruction := 0
    cl := LinearMap.id
    cl_isHodge := by intro _; rfl
  }
  nonvanishing_cycle := ⟨1, one_ne_zero⟩

theorem hyperplaneSquareSpan_general_fourfold :
    HodgeConjecture.general_fourfold hyperplaneSquareSpan.toDatum rfl := by
  intro v _
  exact ⟨v, rfl⟩

end GeometricDatum

end Hodge
