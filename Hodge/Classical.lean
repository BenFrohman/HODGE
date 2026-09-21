/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under the MIT license.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Basic

/-!
# Constructions on three classical fourfolds

A section of `cl` is supplied on three islands only:

* `ℙ⁴` — one plane, one coefficient;
* the Klein quadric `Q⁴` — two planes `Π`, `Π'`, two coefficients;
* `ℙ² × ℙ²` — three surfaces, three coefficients.

Each `construct` is a function from a Hodge class to those coefficients.
On these islands `cl` is the identity of the linear shadow, so the function
is a section by `rfl`. That is a construction on these three fourfolds.
It is not a construction on a general fourfold.
-/

namespace Hodge
namespace Classical

/-! ## `ℙ⁴` -/

/-- Linear plane `Z = {x₃ = x₄ = 0} ⊂ ℙ⁴`. -/
inductive P4Coord where
  | x0 | x1 | x2 | x3 | x4
  deriving DecidableEq, Repr

def p4PlaneIdeal : List P4Coord := [.x3, .x4]

structure P4Cycle where
  coeff : ℚ

def projectiveFourSpace : Datum ℚ ℚ ℚ where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

/-- Construction: `γ = a [Z]`, with `Z` the named plane. -/
def constructP4 (γ : ℚ) : P4Cycle := ⟨γ⟩

theorem constructP4_section (γ : ℚ) :
    projectiveFourSpace.cl (constructP4 γ).coeff = γ :=
  rfl

instance : CycleConstructor projectiveFourSpace :=
  ⟨fun v _ => ⟨v, rfl⟩⟩

theorem projectiveFourSpace_hodgeConjecture :
    projectiveFourSpace.HodgeConjecture :=
  hodgeConjecture_of_constructor projectiveFourSpace

/-! ## Klein quadric `Q⁴`

Planes: `Π = σ₂ = {p₁₂ = p₁₃ = p₂₃ = 0}`,
`Π' = σ_{1,1} = {p₀₁ = p₀₂ = p₀₃ = 0}`.
Construction: `γ = a[Π] + b[Π']`. -/

def kleinQuadric : Datum (ℚ × ℚ) (ℚ × ℚ) ℚ where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

/-- Construction: the pair `(a, b)` is the cycle `a Π + b Π'`. -/
def construct (γ : ℚ × ℚ) : ℚ × ℚ := γ

theorem construct_recovers (γ : ℚ × ℚ) :
    kleinQuadric.cl (construct γ) = γ :=
  rfl

theorem expansion (a b : ℚ) :
    kleinQuadric.cl (a, b) = (a, b) :=
  rfl

instance : CycleConstructor kleinQuadric :=
  ⟨fun v _ => ⟨v, rfl⟩⟩

theorem kleinQuadric_hodgeConjecture : kleinQuadric.HodgeConjecture :=
  hodgeConjecture_of_constructor kleinQuadric

/-! ## `ℙ² × ℙ²`

Surfaces: `{pt} × ℙ²`, `ℙ² × {pt}`, `ℙ¹ × ℙ¹`.
Classes: `h₁²`, `h₂²`, `h₁ h₂`. -/

structure ProductCycle where
  coeff_h1sq : ℚ
  coeff_h2sq : ℚ
  coeff_h1h2 : ℚ

def productOfPlanes : Datum (ℚ × ℚ × ℚ) (ℚ × ℚ × ℚ) ℚ where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

/-- Construction: `γ = a h₁² + b h₂² + c h₁ h₂`. -/
def constructProduct (γ : ℚ × ℚ × ℚ) : ProductCycle :=
  match γ with
  | (a, b, c) => ⟨a, b, c⟩

theorem constructProduct_section (a b c : ℚ) :
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

/-- These three constructions are sections of `cl` on three islands.
They are not a section on a general fourfold. -/
theorem constructions_are_sections :
    (∀ γ : ℚ, projectiveFourSpace.cl (constructP4 γ).coeff = γ) ∧
      (∀ γ : ℚ × ℚ, kleinQuadric.cl (construct γ) = γ) ∧
        (∀ a b c : ℚ, productOfPlanes.cl (a, b, c) = (a, b, c)) :=
  ⟨constructP4_section, construct_recovers, constructProduct_section⟩

end Classical
end Hodge
