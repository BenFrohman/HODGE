/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Construct

/-!
# One named family: special sextic containing a linear plane

    X = V(F) subset P^5,    F = x3 A + x4 B + x5 C,    deg A,B,C = 5.
    Pi = {x3 = x4 = x5 = 0}.

T_F on the two-dimensional span Q h^2 + Q [Pi]:

    T_F (a, b) = a [X cap {x0 = x1 = 0}] + b [Pi].

This is not every Hodge class on this X. This is not general_fourfold.
Not a conjunct of classical_fourfolds.
-/

namespace Hodge
namespace SpecialSextic

inductive P5Coord where
  | x0 | x1 | x2 | x3 | x4 | x5
  deriving DecidableEq, Repr

/-- I(Pi) = <x3, x4, x5>. -/
def planeIdeal : List P5Coord := [.x3, .x4, .x5]

/-- Linear section surface representing h^2: X cap {x0 = x1 = 0}. -/
def hyperplaneSectionIdeal : List P5Coord := [.x0, .x1]

/-- Linear shadow of the span Q h^2 + Q [Pi]. -/
def planeSpan : Datum (Rat × Rat) (Rat × Rat) Rat where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

def construct (gamma : Rat × Rat) : Rat × Rat := gamma

theorem construct_section (gamma : Rat × Rat) :
    planeSpan.cl (construct gamma) = gamma :=
  rfl

instance : CycleSection planeSpan where
  construct := fun γ => construct γ.val
  is_section := fun γ => construct_section γ.val

theorem planeSpan_hodge : planeSpan.HodgeConjecture :=
  HodgeConjecture.of_section planeSpan

end SpecialSextic
end Hodge
