/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Mathlib.RingTheory.Ideal.Basic
import Mathlib.Data.MvPolynomial.Basic

/-!
# Fermat quartic planes with ζ^4 = -1

Easy arrow on one host. Not a `CycleSection` for every Hodge class.
Not imported by `Hodge.lean`.
-/

namespace Hodge
namespace Attempt

inductive Var | z0 | z1 | z2 | z3 | z4 | z5
deriving DecidableEq

abbrev R := MvPolynomial Var ℂ

open MvPolynomial

def fermatQuartic : R :=
  X .z0 ^ 4 + X .z1 ^ 4 + X .z2 ^ 4 + X .z3 ^ 4 + X .z4 ^ 4 + X .z5 ^ 4

def surfaceZ1Ideal (ζ : ℂ) : Ideal R :=
  Ideal.span {
    X .z0 - C ζ * X .z1,
    X .z2 - C ζ * X .z3,
    X .z4 - C ζ * X .z5 }

def surfaceZ2Ideal (ζ : ℂ) : Ideal R :=
  Ideal.span {
    X .z0 + C ζ * X .z1,
    X .z2 - C ζ * X .z3,
    X .z4 - C ζ * X .z5 }

/-- Membership: Fermat polynomial lies in each plane ideal when ζ^4 = -1.
Substitution: (ζ z)^4 + z^4 = 0. Left `sorry` as a polynomial calculation. -/
theorem fermat_mem_surfaceZ1 (ζ : ℂ) (hζ : ζ ^ 4 = -1) :
    fermatQuartic ∈ surfaceZ1Ideal ζ := by
  sorry

theorem fermat_mem_surfaceZ2 (ζ : ℂ) (hζ : ζ ^ 4 = -1) :
    fermatQuartic ∈ surfaceZ2Ideal ζ := by
  sorry

/-- Two planes and coefficients 1. No `cl` field: this is not `CycleSection`. -/
structure FermatPlaneData (ζ : ℂ) (hζ : ζ ^ 4 = -1) where
  surfaces : List (Ideal R)
  coefficients : List ℚ
  surfaces_eq : surfaces = [surfaceZ1Ideal ζ, surfaceZ2Ideal ζ]
  coefficients_eq : coefficients = [1, 1]

def fermatPlaneData (ζ : ℂ) (hζ : ζ ^ 4 = -1) : FermatPlaneData ζ hζ where
  surfaces := [surfaceZ1Ideal ζ, surfaceZ2Ideal ζ]
  coefficients := [1, 1]
  surfaces_eq := rfl
  coefficients_eq := rfl

end Attempt
end Hodge
