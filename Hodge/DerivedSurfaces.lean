/-
Copyright (c) 2026 Benjamin Stanley Frohman.
Released under Apache License 2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)

Named surfaces as derived objects O_Z. Sorry-free. No axiom.
S is a surface (dim 2) on a fourfold (dim 4). That is not a partner Y.
This file does not construct Y and does not inhabit Term B.
-/

namespace Hodge
namespace DerivedSurfaces

/-- A named algebraic surface on a named host. -/
structure NamedDerivedSurface where
  host : String
  hostDim : Nat
  surface : String
  objectDim : Nat
  derivedObject : String
  className : String
  deriving Repr, DecidableEq

def p4Plane : NamedDerivedSurface where
  host := "P^4"
  hostDim := 4
  surface := "{x3 = x4 = 0}"
  objectDim := 2
  derivedObject := "O_Z"
  className := "[Z]"

def kleinPi : NamedDerivedSurface where
  host := "Q^4"
  hostDim := 4
  surface := "Pi"
  objectDim := 2
  derivedObject := "O_Pi"
  className := "[Pi]"

def kleinPi' : NamedDerivedSurface where
  host := "Q^4"
  hostDim := 4
  surface := "Pi'"
  objectDim := 2
  derivedObject := "O_Pi'"
  className := "[Pi']"

def specialSexticPlane : NamedDerivedSurface where
  host := "V(F)"
  hostDim := 4
  surface := "Pi = V(x3,x4,x5)"
  objectDim := 2
  derivedObject := "O_Pi"
  className := "[Pi]"

/-- Residual quintic on V(F). Surface, not fourfold partner. -/
def residualQuintic : NamedDerivedSurface where
  host := "V(F)"
  hostDim := 4
  surface := "S_{a,b,c}"
  objectDim := 2
  derivedObject := "O_S"
  className := "h^2 - [Pi]"

def fermatZ1 : NamedDerivedSurface where
  host := "Fermat quartic"
  hostDim := 4
  surface := "Z1"
  objectDim := 2
  derivedObject := "O_Z1"
  className := "[Z1]"

def fermatZ2 : NamedDerivedSurface where
  host := "Fermat quartic"
  hostDim := 4
  surface := "Z2"
  objectDim := 2
  derivedObject := "O_Z2"
  className := "[Z2]"

def hassettPlane : NamedDerivedSurface where
  host := "Hassett cubic"
  hostDim := 4
  surface := "extra plane"
  objectDim := 2
  derivedObject := "O_Pi"
  className := "[Pi]"

def inventory : List NamedDerivedSurface :=
  [p4Plane, kleinPi, kleinPi', specialSexticPlane,
   residualQuintic, fermatZ1, fermatZ2, hassettPlane]

theorem inventory_card : inventory.length = 8 := rfl

theorem residual_is_surface : residualQuintic.objectDim = 2 := rfl

theorem residual_host_is_fourfold : residualQuintic.hostDim = 4 := rfl

/-- S sits on X; S is not a fourfold. Partner Y would have dim 4. -/
theorem residual_not_partner :
    residualQuintic.objectDim = 2 ∧ residualQuintic.objectDim ≠ 4 := by
  decide

theorem every_listed_object_is_a_surface :
    inventory.all (fun s => s.objectDim == 2) = true := rfl

theorem every_listed_host_is_a_fourfold :
    inventory.all (fun s => s.hostDim == 4) = true := rfl

end DerivedSurfaces
end Hodge
