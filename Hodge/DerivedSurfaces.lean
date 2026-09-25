/-
Copyright (c) 2026 Benjamin Stanley Frohman.
Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)

Named surfaces already in the library, recorded as derived objects.
This is a name list. It is not D^b(X) ≃ D^b(Y). It is not Clay.
-/
import Hodge.NamedFamilies

namespace Hodge
namespace DerivedSurfaces

/-- A named algebraic surface on a named host, as an object of D^b. -/
structure NamedDerivedSurface where
  host : String
  surface : String
  derivedObject : String
  className : String

/-- Plane on P^4. -/
def p4Plane : NamedDerivedSurface :=
  { host := "P^4"
    surface := "{x3 = x4 = 0}"
    derivedObject := "O_Z"
    className := "[Z]" }

/-- Klein pair. -/
def kleinPi : NamedDerivedSurface :=
  { host := "Q^4"
    surface := "Pi"
    derivedObject := "O_Pi"
    className := "[Pi]" }

def kleinPi' : NamedDerivedSurface :=
  { host := "Q^4"
    surface := "Pi'"
    derivedObject := "O_Pi'"
    className := "[Pi']" }

/-- Locked plane on the special sextic. -/
def specialSexticPlane : NamedDerivedSurface :=
  { host := "V(F)"
    surface := "Pi = V(x3,x4,x5)"
    derivedObject := "O_Pi"
    className := "[Pi]" }

/-- Residual quintic surface on the same host. Not a fourfold partner. -/
def residualQuintic : NamedDerivedSurface :=
  { host := "V(F)"
    surface := "S_{a,b,c}"
    derivedObject := "O_S"
    className := "h^2 - [Pi]" }

def fermatZ1 : NamedDerivedSurface :=
  { host := "Fermat quartic"
    surface := "Z1"
    derivedObject := "O_Z1"
    className := "[Z1]" }

def fermatZ2 : NamedDerivedSurface :=
  { host := "Fermat quartic"
    surface := "Z2"
    derivedObject := "O_Z2"
    className := "[Z2]" }

def hassettPlane : NamedDerivedSurface :=
  { host := "Hassett cubic"
    surface := "extra plane"
    derivedObject := "O_Pi"
    className := "[Pi]" }

/-- The inventory is finite. It does not supply CycleSection for unspecified D. -/
def inventory : List NamedDerivedSurface :=
  [p4Plane, kleinPi, kleinPi', specialSexticPlane,
   residualQuintic, fermatZ1, fermatZ2, hassettPlane]

/-- Firewall recorded as a definition, not a fake miss lemma. -/
def listedAreAlgebraic : Bool := true

end DerivedSurfaces
end Hodge
