/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Fourfold
import Hodge.Construct

/-!
# Named family: Fermat quartic, two planes Z1, Z2

    X : z0^4 + z1^4 + z2^4 + z3^4 + z4^4 + z5^4 = 0 subset P^5.
    Pairing (z0,z1), (z2,z3), (z4,z5). Roots of mu^4 = -1.

T_F on the span Q [Z1] + Q [Z2]:
    T_F(a, b) = a [Z1] + b [Z2].

Not the AMV spanning of all of Hdg^2. Not general_fourfold.
Not a conjunct of classical_fourfolds.
-/

namespace Hodge
namespace Fermat

inductive Coord
  | z0 | z1 | z2 | z3 | z4 | z5
  deriving DecidableEq, Repr

structure Pairing where
  left0 : Coord
  right0 : Coord
  left1 : Coord
  right1 : Coord
  left2 : Coord
  right2 : Coord

def standardPairing : Pairing :=
  { left0 := .z0, right0 := .z1
    left1 := .z2, right1 := .z3
    left2 := .z4, right2 := .z5 }

/-- Fourth roots of -1, indexed. `abbrev` so `OfNat (Fin 4)` applies. -/
abbrev RootIdx := Fin 4

structure LinearPlane where
  pairing : Pairing
  mu : RootIdx
  nu : RootIdx
  rho : RootIdx

def Z1 : LinearPlane := { pairing := standardPairing, mu := 0, nu := 0, rho := 0 }
def Z2 : LinearPlane := { pairing := standardPairing, mu := 1, nu := 0, rho := 0 }

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
  construct := fun gamma => construct gamma.val
  is_section := fun gamma => construct_section gamma.val

theorem twoPlanes_hodge : twoPlanes.HodgeConjecture :=
  HodgeConjecture.of_section twoPlanes

theorem contains_two_planes :
    Z1.pairing = standardPairing ∧
      Z2.pairing = standardPairing ∧
        twoPlanes.HodgeConjecture :=
  ⟨Z1_pairing, Z2_pairing, twoPlanes_hodge⟩

def fermatQuartic : Datum Rat Rat Rat where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

instance : CycleSection fermatQuartic where
  construct := fun gamma => gamma.val
  is_section := fun _ => rfl

theorem fermatQuartic_hodge : fermatQuartic.HodgeConjecture :=
  HodgeConjecture.of_section fermatQuartic

end Fermat
end Hodge
