/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/

/-!
# Row 3 — rational Hodge in codimension 2, as a sentence

Existence of some surfaces. Not the Fermat recipe.
Not a theorem. Not imported by `Hodge.lean`.
The live form on the skeleton is `Datum.HodgeConjecture` in `Hodge/Basic.lean`.
-/

namespace Hodge
namespace Attempt

opaque SmoothProjectiveFourfold : Type
opaque RationalHodgeClass (X : SmoothProjectiveFourfold) : Type
opaque AlgebraicSurface (X : SmoothProjectiveFourfold) : Type

/-- Surjectivity of cl on (2,2) classes: some finite Q-combination of surfaces. -/
opaque ClayHodgeConjectureCodimTwo : SmoothProjectiveFourfold → Prop

/-- The global fourfold case of Clay. Unproved. -/
def GlobalClayFourfold : Prop :=
  ∀ X : SmoothProjectiveFourfold, ClayHodgeConjectureCodimTwo X

end Attempt
end Hodge
