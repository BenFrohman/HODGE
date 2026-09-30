/-
Copyright (c) 2026 Benjamin Stanley Frohman.
Released under Apache-2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Basic
import Hodge.Classical
import Hodge.Examples

/-!
# Variety, Hodge class, algebraic cycle

Three `ℚ`-vector spaces and two `ℚ`-linear maps.

* `Z` / `AlgebraicCycles` — rational algebraic cycles of one codimension.
* `V` / `Cohomology` — stands for `H^{2k}(X, ℚ)`.
* `N` / `OffDiagonal` — stands for `⊕_{p+q=2k, p≠k} H^{p,q}(X)`.
* `cycleClass` — `cl : Z → V`.
* `hodgeObstruction` — `obstruction : V → N`.

`Variety` is a name, a dimension, and one `Datum`. It is not a scheme.
`HodgeClass` is a vector in `ker obstruction`.
`AlgebraicCycle` is a vector of `Z`.

Single copy. Not a Clay close.
-/

namespace Hodge
namespace Geometry

variable {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]

/-- Rational algebraic cycles of one fixed codimension `k`.
Geometrically: `CH^k(X) ⊗ ℚ`. Here: the caller’s space `Z`. -/
abbrev AlgebraicCycles (Z : Type*) [AddCommGroup Z] [Module ℚ Z] := Z

/-- Even rational cohomology of degree `2k`.
Geometrically: `H^{2k}(X, ℚ)`. Here: the caller’s space `V`. -/
abbrev Cohomology (V : Type*) [AddCommGroup V] [Module ℚ V] := V

/-- Off-diagonal Hodge summands of degree `2k`.
Geometrically: `⊕_{p+q=2k, p≠k} H^{p,q}(X)`. Here: the caller’s space `N`. -/
abbrev OffDiagonal (N : Type*) [AddCommGroup N] [Module ℚ N] := N

/-- Cycle class map `cl : Z → V`.
Geometrically: Poincaré dual of the fundamental class, extended `ℚ`-linearly.
Here: `Datum.cl`. -/
def cycleClass (D : Datum Z V N) : AlgebraicCycles Z →ᵢ[ℚ] Cohomology V :=
  D.cl

/-- Projection `V → N` onto the off-diagonal Hodge summands.
Kernel = Hodge classes. Here: `Datum.obstruction`. -/
def hodgeObstruction (D : Datum Z V N) : Cohomology V →ᵢ[ℚ] OffDiagonal N :=
  D.obstruction

theorem cycleClass_is_hodge (D : Datum Z V N) (z : AlgebraicCycles Z) :
    hodgeObstruction D (cycleClass D z) = 0 :=
  D.cl_isHodge z

/-- A variety as this skeleton can see it: a name, a dimension, one `Datum`.
Not a scheme. -/
structure Variety (Z V N : Type*)
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N] where
  name : String
  dim : ℕ
  data : Datum Z V N

/-- Wrap a datum as a named variety. -/
def wrap (name : String) (dim : ℕ) (D : Datum Z V N) : Variety Z V N :=
  { name := name, dim := dim, data := D }

@[simp] theorem wrap_data (name : String) (dim : ℕ) (D : Datum Z V N) :
    (wrap name dim D).data = D := rfl

theorem wrapped (name : String) (dim : ℕ) (D : Datum Z V N) :
    ∃ X : Variety Z V N, X.data = D :=
  ⟨wrap name dim D, rfl⟩

theorem every_datum_wraps (D : Datum Z V N) :
    ∃ X : Variety Z V N, X.data = D :=
  wrapped "gadget" 0 D

/-- A Hodge class: a vector of `V` in `ker obstruction`. -/
def HodgeClass (X : Variety Z V N) : Type _ :=
  { v : V // v ∈ X.data.hodgeClasses }

/-- An algebraic cycle: a vector of `Z`. -/
def AlgebraicCycle (X : Variety Z V N) : Type _ :=
  AlgebraicCycles Z

/-- Cycle class landing in Hodge classes by the easy arrow. -/
def cl (X : Variety Z V N) (z : AlgebraicCycle X) : HodgeClass X :=
  ⟨X.data.cl z, X.data.cl_isHodge z⟩

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

def projectiveFourSpace : Variety Rat Rat Rat :=
  wrap "P^4" 4 Classical.projectiveFourSpace

def kleinQuadric : Variety (Rat × Rat) (Rat × Rat) Rat :=
  wrap "Klein quadric Q^4" 4 Classical.kleinQuadric

def productOfPlanes : Variety (Rat × Rat × Rat) (Rat × Rat × Rat) Rat :=
  wrap "P^2 x P^2" 4 Classical.productOfPlanes

def zeroGadget : Variety Rat Rat Rat :=
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
