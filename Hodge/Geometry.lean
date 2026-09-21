/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Hodge.Basic
import Hodge.Classical

/-!
# Variety, Hodge class, algebraic cycle

Three `\u211a`-vector spaces and two `\u211a`-linear maps.

* `Z` / `AlgebraicCycles` — rational algebraic cycles of one codimension.
* `V` / `Cohomology` — stands for `H^{2k}(X, \u211a)`.
* `N` / `OffDiagonal` — stands for `\u2295_{p+q=2k, p\u2260k} H^{p,q}(X)`.
* `cycleClass` — `cl : Z \u2192 V`.
* `hodgeObstruction` — `obstruction : V \u2192 N`.

`Variety` is a name, a dimension, and one `Datum`. It is not a scheme.
`HodgeClass` is a vector in `ker obstruction`.
`AlgebraicCycle` is a vector of `Z`.
-/

namespace Hodge
namespace Geometry

variable {Z V N : Type*}
    [AddCommGroup Z] [Module \u211a Z]
    [AddCommGroup V] [Module \u211a V]
    [AddCommGroup N] [Module \u211a N]

/-- Rational algebraic cycles of one fixed codimension `k`.
Geometrically: `CH^k(X) \u2297 \u211a`. Here: the caller\u2019s space `Z`. -/
abbrev AlgebraicCycles (Z : Type*) [AddCommGroup Z] [Module \u211a Z] := Z

/-- Even rational cohomology of degree `2k`.
Geometrically: `H^{2k}(X, \u211a)`. Here: the caller\u2019s space `V`. -/
abbrev Cohomology (V : Type*) [AddCommGroup V] [Module \u211a V] := V

/-- Off-diagonal Hodge summands of degree `2k`.
Geometrically: `\u2295_{p+q=2k, p\u2260k} H^{p,q}(X)`. Here: the caller\u2019s space `N`. -/
abbrev OffDiagonal (N : Type*) [AddCommGroup N] [Module \u211a N] := N

/-- Cycle class map `cl : Z \u2192 V`.
Geometrically: Poincar\u00e9 dual of the fundamental class, extended `\u211a`-linearly.
Here: `Datum.cl`. -/
def cycleClass (D : Datum Z V N) : AlgebraicCycles Z \u2192\u1d62[\u211a] Cohomology V :=
  D.cl

/-- Projection `V \u2192 N` onto the off-diagonal Hodge summands.
Kernel = Hodge classes. Here: `Datum.obstruction`. -/
def hodgeObstruction (D : Datum Z V N) : Cohomology V \u2192\u1d62[\u211a] OffDiagonal N :=
  D.obstruction

theorem cycleClass_is_hodge (D : Datum Z V N) (z : AlgebraicCycles Z) :
    hodgeObstruction D (cycleClass D z) = 0 :=
  D.cl_isHodge z

/-- A variety as this skeleton can see it: a name, a dimension, one `Datum`.
Not a scheme. -/
structure Variety (Z V N : Type*)
    [AddCommGroup Z] [Module \u211a Z]
    [AddCommGroup V] [Module \u211a V]
    [AddCommGroup N] [Module \u211a N] where
  name : String
  dim : \u2115
  data : Datum Z V N

/-- A Hodge class: a vector of `V` in `ker obstruction`. -/
def HodgeClass (X : Variety Z V N) : Type _ :=
  { v : V // v \u2208 X.data.hodgeClasses }

/-- An algebraic cycle: a vector of `Z`. -/
def AlgebraicCycle (X : Variety Z V N) : Type _ :=
  AlgebraicCycles Z

/-- Cycle class landing in Hodge classes by the easy arrow. -/
def cl (X : Variety Z V N) (z : AlgebraicCycle X) : HodgeClass X :=
  \u27e8X.data.cl z, X.data.cl_isHodge z\u27e9

def Variety.HodgeConjecture (X : Variety Z V N) : Prop :=
  X.data.HodgeConjecture

theorem Variety.hodgeConjecture_iff (X : Variety Z V N) :
    X.HodgeConjecture \u2194 \u2200 v \u2208 X.data.hodgeClasses, v \u2208 X.data.algebraicClasses :=
  Iff.rfl

def projectiveFourSpace : Variety \u211a \u211a \u211a where
  name := "P^4"
  dim := 4
  data := Classical.projectiveFourSpace

def kleinQuadric : Variety (\u211a \u00d7 \u211a) (\u211a \u00d7 \u211a) \u211a where
  name := "Klein quadric Q^4"
  dim := 4
  data := Classical.kleinQuadric

def productOfPlanes : Variety (\u211a \u00d7 \u211a \u00d7 \u211a) (\u211a \u00d7 \u211a \u00d7 \u211a) \u211a where
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
