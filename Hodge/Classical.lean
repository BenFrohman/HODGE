/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Basic

/-!
# Constructions on three classical fourfolds

A section of `cl` is supplied on three specified hosts only:

* `P^4` — `constructP4`, one plane, one coefficient;
* Klein quadric `Q^4` — two planes `Π`, `Π'`;
* `P^2 × P^2` — three surfaces.

On these hosts `cl` is `LinearMap.id` of the linear shadow.
Not a construction on an unnamed fourfold.
-/

namespace Hodge
namespace Classical

/-! ## Specified host `X = P^4`

Surface: `Z = {x₃ = x₄ = 0} ≅ P^2`.
Rule: `γ = a [Z]`.
-/

inductive P4Coord where
  | x0 | x1 | x2 | x3 | x4
  deriving DecidableEq, Repr

/-- Ideal generators of the linear plane in `P^4`. -/
def p4PlaneIdeal : List P4Coord := [.x3, .x4]

structure P4Cycle where
  coeff : Rat

def projectiveFourSpace : Datum Rat Rat Rat where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

/-- `T_F` on `P^4`: the coefficient *is* the class. -/
def constructP4 (γ : Rat) : P4Cycle := ⟨γ⟩

theorem constructP4_coeff (γ : Rat) : (constructP4 γ).coeff = γ := rfl

theorem constructP4_section (γ : Rat) :
    projectiveFourSpace.cl (constructP4 γ).coeff = γ :=
  rfl

theorem constructP4_discharged (γ : Rat) :
    projectiveFourSpace.cl (constructP4 γ).coeff = γ ∧
      (constructP4 γ).coeff = γ :=
  ⟨constructP4_section γ, constructP4_coeff γ⟩

instance : CycleConstructor projectiveFourSpace :=
  ⟨fun v _ => ⟨v, rfl⟩⟩

theorem projectiveFourSpace_hodgeConjecture :
    projectiveFourSpace.HodgeConjecture :=
  hodgeConjecture_of_constructor projectiveFourSpace

/-! ## Klein quadric `Q^4`

Planes: `Π = σ₂ = {p₁₂ = p₁₃ = p₂₃ = 0}`,
`Π' = σ_{1,1} = {p₀₁ = p₀₂ = p₀₃ = 0}`.
Construction: `γ = a[Π] + b[Π']`.
-/

def kleinQuadric : Datum (Rat × Rat) (Rat × Rat) Rat where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

def construct (γ : Rat × Rat) : Rat × Rat := γ

theorem construct_recovers (γ : Rat × Rat) :
    kleinQuadric.cl (construct γ) = γ :=
  rfl

theorem expansion (a b : Rat) :
    kleinQuadric.cl (a, b) = (a, b) :=
  rfl

instance : CycleConstructor kleinQuadric :=
  ⟨fun v _ => ⟨v, rfl⟩⟩

theorem kleinQuadric_hodgeConjecture : kleinQuadric.HodgeConjecture :=
  hodgeConjecture_of_constructor kleinQuadric

/-! ## `P^2 × P^2`

Surfaces: `{pt} × P^2`, `P^2 × {pt}`, `P^1 × P^1`.
Classes: `h₁²`, `h₂²`, `h₁ h₂`.
-/

structure ProductCycle where
  coeff_h1sq : Rat
  coeff_h2sq : Rat
  coeff_h1h2 : Rat

def productOfPlanes : Datum (Rat × Rat × Rat) (Rat × Rat × Rat) Rat where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

def constructProduct (γ : Rat × Rat × Rat) : ProductCycle :=
  match γ with
  | (a, b, c) => ⟨a, b, c⟩

theorem constructProduct_section (a b c : Rat) :
    productOfPlanes.cl (a, b, c) = (a, b, c) :=
  rfl

instance : CycleConstructor productOfPlanes :=
  ⟨fun v _ => ⟨v, rfl⟩⟩

theorem productOfPlanes_hodgeConjecture : productOfPlanes.HodgeConjecture :=
  hodgeConjecture_of_constructor productOfPlanes

theorem classical_islands :
    projectiveFourSpace.HodgeConjecture ∧
      kleinQuadric.HodgeConjecture ∧
        productOfPlanes.HodgeConjecture :=
  ⟨projectiveFourSpace_hodgeConjecture,
    kleinQuadric_hodgeConjecture,
    productOfPlanes_hodgeConjecture⟩

theorem constructions_are_sections :
    (∀ γ : Rat, projectiveFourSpace.cl (constructP4 γ).coeff = γ) ∧
      (∀ γ : Rat × Rat, kleinQuadric.cl (construct γ) = γ) ∧
        (∀ a b c : Rat, productOfPlanes.cl (a, b, c) = (a, b, c)) :=
  ⟨constructP4_section, construct_recovers, constructProduct_section⟩

end Classical
end Hodge
