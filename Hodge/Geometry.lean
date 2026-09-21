/-
Copyright (c) 2026 Benjamin Stanley Frohman.
Released under Apache-2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Hodge.Basic
import Hodge.Classical

namespace Hodge
namespace Geometry

variable {Z V N : Type*}
    [AddCommGroup Z] [Module Rat Z]
    [AddCommGroup V] [Module Rat V]
    [AddCommGroup N] [Module Rat N]

/-- Gadget standing for a variety: a name, a dimension, and one Datum. -/
structure Variety (Z V N : Type*)
    [AddCommGroup Z] [Module Rat Z]
    [AddCommGroup V] [Module Rat V]
    [AddCommGroup N] [Module Rat N] where
  name : String
  dim : Nat
  data : Datum Z V N

abbrev AlgebraicCycles (Z : Type*) := Z
abbrev Cohomology (V : Type*) := V
abbrev OffDiagonal (N : Type*) := N

def cycleClass (D : Datum Z V N) : Z →ₗ[Rat] V := D.cl
def hodgeObstruction (D : Datum Z V N) : V →ₗ[Rat] N := D.obstruction

theorem cycleClass_is_hodge (D : Datum Z V N) (z : Z) :
    D.obstruction (D.cl z) = 0 :=
  D.cl_isHodge z

def HodgeClass (X : Variety Z V N) :=
  { v : V // v ∈ X.data.hodgeClasses }

def AlgebraicCycle (X : Variety Z V N) := Z

def cl (X : Variety Z V N) (z : AlgebraicCycle X) : HodgeClass X :=
  ⟨X.data.cl z, X.data.cl_isHodge z⟩

def Variety.HodgeConjecture (X : Variety Z V N) : Prop :=
  X.data.HodgeConjecture

/-- Correct quantifier. Not `forall D, HodgeConjecture D`.
Only those gadgets marked as varieties. -/
def HodgeConjecture.forVarieties
    (IsVariety : Datum Z V N → Prop) : Prop :=
  ∀ D, IsVariety D → D.HodgeConjecture

/-- Same sentence on the Variety gadget. -/
def HodgeConjecture.onVarieties : Prop :=
  ∀ X : Variety Z V N, X.HodgeConjecture

theorem onVarieties_iff_forVarieties :
    HodgeConjecture.onVarieties (Z := Z) (V := V) (N := N) ↔
      HodgeConjecture.forVarieties (fun D => ∃ X : Variety Z V N, X.data = D) := by
  constructor
  · intro h D hD
    rcases hD with ⟨X, hX⟩
    simpa [Variety.HodgeConjecture, hX] using h X
  · intro h X
    exact h X.data ⟨X, rfl⟩

def projectiveFourSpace : Variety Rat Rat Rat where
  name := "P^4"
  dim := 4
  data := Classical.projectiveFourSpace

def kleinQuadric : Variety (Rat × Rat) (Rat × Rat) Rat where
  name := "Klein quadric Q^4"
  dim := 4
  data := Classical.kleinQuadric

def productOfPlanes : Variety (Rat × Rat × Rat) (Rat × Rat × Rat) Rat where
  name := "P^2 x P^2"
  dim := 4
  data := Classical.productOfPlanes

theorem projectiveFourSpace_hodge : projectiveFourSpace.HodgeConjecture :=
  Classical.projectiveFourSpace_hodgeConjecture

theorem kleinQuadric_hodge : kleinQuadric.HodgeConjecture :=
  Classical.kleinQuadric_hodgeConjecture

theorem productOfPlanes_hodge : productOfPlanes.HodgeConjecture :=
  Classical.productOfPlanes_hodgeConjecture

end Geometry
end Hodge
