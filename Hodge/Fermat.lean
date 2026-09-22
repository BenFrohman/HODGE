/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Fourfold
import Hodge.Construct

/-!
# Named family: Fermat quartic, two planes Z1, Z2

    X : z0^4 + z1^4 + z2^4 + z3^4 + z4^4 + z5^4 = 0 subset P^5.
    Pairing (z0,z1), (z2,z3), (z4,z5). Roots of μ^4 = -1.

T_F on the span Q [Z1] + Q [Z2]:
    T_F(a, b) = a [Z1] + b [Z2].

Not the AMV spanning of all of Hdg^2. Not general_fourfold.
Not a conjunct of classical_fourfolds.
-/

namespace Hodge
namespace Fermat

inductive Coord | z0 | z1 | z2 | z3 | z4 | z5
  deriving DecidableEq, Repr

structure Pairing where
  left0 : Coord; right0 : Coord
  left1 : Coord; right1 : Coord
  left2 : Coord; right2 : Coord

def standardPairing : Pairing :=
  { left0 := .z0, right0 := .z1
    left1 := .z2, right1 := .z3
    left2 := .z4, right2 := .z5 }

def RootIdx := Fin 4

structure LinearPlane where
  pairing : Pairing
  μ : RootIdx
  ν : RootIdx
  ρ : RootIdx

def Z1 : LinearPlane := { pairing := standardPairing, μ := 0, ν := 0, ρ := 0 }
def Z2 : LinearPlane := { pairing := standardPairing, μ := 1, ν := 0, ρ := 0 }

theorem Z1_pairing : Z1.pairing = standardPairing := rfl
theorem Z2_pairing : Z2.pairing = standardPairing := rfl

/-- Linear shadow of Q [Z1] + Q [Z2]. -/
def twoPlanes : Datum (Rat × Rat) (Rat × Rat) Rat where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

def construct (gamma : Rat × Rat) : Rat × Rat := gamma

theorem construct_section (gamma : Rat × Rat) :
    twoPlanes.cl (construct gamma) = gamma :=
  rfl

instance : CycleSection twoPlanes where
  construct := fun γ => construct γ.val
  is_section := fun γ => construct_section γ.val

theorem twoPlanes_hodge : twoPlanes.HodgeConjecture :=
  HodgeConjecture.of_section twoPlanes

/-- Literature packaging of the full AMV span: cl = id on Q.
Coefficients not expanded. Separate from twoPlanes. -/
def fermatQuartic : Datum Rat Rat Rat where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

instance : CycleSection fermatQuartic where
  construct := fun γ => γ.val
  is_section := fun γ => rfl

theorem fermatQuartic_hodge : fermatQuartic.HodgeConjecture :=
  HodgeConjecture.of_section fermatQuartic

end Fermat
end Hodge
