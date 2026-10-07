/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Construct
import Hodge.FermatQuintic

/-!
# No shadow discharge

The proved named sections set `cl = LinearMap.id` and `construct γ = γ.val`.
That is a coefficient shadow, not `cl_X : CH^k(X)_Q → H^{2k}(X, Q)`.

This file does not inhabit the geometric cycle-class map.
-/

namespace Hodge
namespace NoShadow

/-- Coefficient encoding used by the named islands. Not Chow. -/
def shadow_name : String := "LinearMap.id"

/-- Geometric cycle-class map. Not constructed in this repository. -/
def geometric_cl_name : String := "CH^k(X)_Q → H^{2k}(X,Q)"

theorem shadow_ne_geometric_cl : shadow_name ≠ geometric_cl_name := by
  decide

/-- The missing discharge. No inhabitant is supplied. -/
def GeometricCycleClassDischarged : Prop :=
  ∀ (X : Type) (k : Nat), True → False

/-- Fermat certificate stays the cone theorem, not a cycle-class section. -/
theorem fermat_certificate_is_not_chow
    {R : Type} [CommRing R] [IsDomain R] (h5 : (5 : R) ≠ 0) :
    shadow_name ≠ geometric_cl_name :=
  shadow_ne_geometric_cl

end NoShadow
end Hodge
