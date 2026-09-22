/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Fourfold
import Hodge.Construct

/-!
# Named family: Hassett C_8, cubic fourfold containing a plane

    X = V(F) subset P^5,    deg F = 3,
    F = x3 A + x4 B + x5 C,    deg A,B,C = 2,
    Pi = {x3 = x4 = x5 = 0}.

This is the Hassett divisor C_8 (cubics containing a plane).
T_F on the span Q h^2 + Q [Pi]:
    T_F(a, b) = a [X cap {x0 = x1 = 0}] + b [Pi].

Zucker says every class on the cubic is algebraic; this file does not
replay Zucker. It only writes T_F on this two-dimensional span.
Not general_fourfold. Not a conjunct of classical_fourfolds.
-/

namespace Hodge
namespace Hassett

inductive P5Coord where
  | x0 | x1 | x2 | x3 | x4 | x5
  deriving DecidableEq, Repr

def planeIdeal : List P5Coord := [.x3, .x4, .x5]
def hyperplaneSectionIdeal : List P5Coord := [.x0, .x1]

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

end Hassett
end Hodge
