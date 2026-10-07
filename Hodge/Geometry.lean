/-
Copyright (c) 2026 Benjamin Stanley Frohman.
Released under Apache-2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Hodge.Basic
import Hodge.Classical
import Hodge.Examples

/-!
# Variety, Hodge class, algebraic cycle

One copy. `Variety` is a name, a dimension, and one `Datum`. It is not a scheme.
-/

namespace Hodge
namespace Geometry

variable {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]

abbrev AlgebraicCycles (Z : Type*) [AddCommGroup Z] [Module ℚ Z] := Z
abbrev Cohomology (V : Type*) [AddCommGroup V] [Module ℚ V] := V
abbrev OffDiagonal (N : Type*) [AddCommGroup N] [Module ℚ N] := N

def cycleClass (D : Datum Z V N) : LinearMap (RingHom.id ℚ) Z V := D.cl
def hodgeObstruction (D : Datum Z V N) : LinearMap (RingHom.id ℚ) V N := D.obstruction

theorem cycleClass_is_hodge (D : Datum Z V N) (z : Z) :
    D.obstruction (D.cl z) = 0 :=
  D.cl_isHodge z

structure Variety (Z V N : Type*)
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N] where
  name : String
  dim : Nat
  data : Datum Z V N

def wrap (name : String) (dim : Nat) (D : Datum Z V N) : Variety Z V N :=
  { name := name, dim := dim, data := D }

@[simp] theorem wrap_data (name : String) (dim : Nat) (D : Datum Z V N) :
    (wrap name dim D).data = D := rfl

theorem wrapped (name : String) (dim : Nat) (D : Datum Z V N) :
    Exists fun X : Variety Z V N => X.data = D :=
  Exists.intro (wrap name dim D) rfl

theorem every_datum_wraps (D : Datum Z V N) :
    Exists fun X : Variety Z V N => X.data = D :=
  wrapped "gadget" 0 D

def HodgeClass (X : Variety Z V N) :=
  Subtype fun v : V => v ∈ X.data.hodgeClasses

def AlgebraicCycle (X : Variety Z V N) := Z

def cl (X : Variety Z V N) (z : AlgebraicCycle X) : HodgeClass X :=
  Subtype.mk (X.data.cl z) (X.data.cl_isHodge z)

def Variety.HodgeConjecture (X : Variety Z V N) : Prop :=
  X.data.HodgeConjecture

theorem Variety.hodgeConjecture_iff (X : Variety Z V N) :
    X.HodgeConjecture ↔ ∀ v ∈ X.data.hodgeClasses, v ∈ X.data.algebraicClasses :=
  Iff.rfl

def HodgeConjecture.forVarieties
    (IsVariety : Datum Z V N → Prop) : Prop :=
  ∀ D, IsVariety D → D.HodgeConjecture

def HodgeConjecture.onVarieties : Prop :=
  ∀ X : Variety Z V N, X.HodgeConjecture

def projectiveFourSpace : Variety ℚ ℚ ℚ :=
  wrap "P^4" 4 Classical.projectiveFourSpace

def kleinQuadric : Variety (ℚ × ℚ) (ℚ × ℚ) ℚ :=
  wrap "Klein quadric Q^4" 4 Classical.kleinQuadric

def productOfPlanes : Variety (ℚ × ℚ × ℚ) (ℚ × ℚ × ℚ) ℚ :=
  wrap "P^2 x P^2" 4 Classical.productOfPlanes

def zeroGadget : Variety ℚ ℚ ℚ :=
  wrap "zeroCycle" 4 Examples.zeroCycle

theorem projectiveFourSpace_hodge : projectiveFourSpace.HodgeConjecture :=
  Classical.projectiveFourSpace_hodgeConjecture

theorem kleinQuadric_hodge : kleinQuadric.HodgeConjecture :=
  Classical.kleinQuadric_hodgeConjecture

theorem productOfPlanes_hodge : productOfPlanes.HodgeConjecture :=
  Classical.productOfPlanes_hodgeConjecture

theorem zeroGadget_not_hodge : ¬ zeroGadget.HodgeConjecture :=
  Examples.zeroCycle_not_hodge

theorem onVarieties_false_on_Rat :
    ¬ HodgeConjecture.onVarieties (Z := Rat) (V := Rat) (N := Rat) := by
  intro h
  exact zeroGadget_not_hodge (h zeroGadget)

end Geometry
end Hodge
