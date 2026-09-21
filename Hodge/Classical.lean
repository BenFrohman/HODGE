/-
Copyright (c) 2026 Ben Frohman (@BenFrohman). Released under the MIT license.
Authors: Ben Frohman (@BenFrohman)
-/
import Hodge.Basic

/-
# Classical fourfolds where a section of `cl` is known

This file records two *islands* in which every Hodge class of codimension two
is a rational combination of explicit planes. The geometry is classical:

* `ℝ⁴` — Lefschetz / projective space: `H⁴(ℝ⁴, ℚ) = ℚ · h²`, and `h²` is
  the class of a linear plane.
* the Klein quadric `Q⁴ ≈ Gr(2,4)` — Schubert calculus: `H⁴(Q, ℚ)` is spanned
  by the two families of planes.

The Lean content is the linear-algebraic shadow of those theorems:
`obstruction = 0` and `cl` surjective. That is the *shape* of a known section.
It is not a formalization of Grassmannians, and it does not instantiate
`CycleConstructor` for a general fourfold.

See `docs/CLASSICAL_FOURFOLDS.md` for the equations of the planes.
-/

namespace Hodge
namespace Classical

/-
## Projective four-space

Model: one-dimensional Hodge space, one algebraic generator.
Geometrically `V = H⁴(ℝ⁴, ℚ) = ℚ · h²` and `Z = ℚ · [plane]`.
-/
def projectiveFourSpace : Datum ℚ ℚ ℚ where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

instance : CycleConstructor projectiveFourSpace :=
  ⟨fun v _ => ⟨v, rfl⟩⟩

theorem projectiveFourSpace_hodgeConjecture :
    projectiveFourSpace.HodgeConjecture :=
  hodgeConjecture_of_constructor projectiveFourSpace

/-
## Klein quadric / Grassmannian `Gr(2,4)`

Model: two-dimensional Hodge space, two algebraic generators
`[Π]` and `[Π']`, the classes of the two families of planes.
Geometrically `Hdg²(Q) = ℚ[Π] ⊕ ℚ[Π']` and `h² = [Π] + [Π']`.
-/
def kleinQuadric : Datum (ℚ × ℚ) (ℚ × ℚ) ℚ where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

instance : CycleConstructor kleinQuadric :=
  ⟨fun v _ => ⟨v, rfl⟩⟩

theorem kleinQuadric_hodgeConjecture : kleinQuadric.HodgeConjecture :=
  hodgeConjecture_of_constructor kleinQuadric

/-
## Product `ℝ² × ℝ²`

Model: three-dimensional Hodge space spanned by `h₁²`, `h₂²`, and `h₁ h₂`,
the classes of `{pt} × ℝ²`, `ℝ² × {pt}`, and `ℝ¹ × ℝ¹`.
-/
def productOfPlanes : Datum (ℚ × ℚ × ℚ) (ℚ × ℚ × ℚ) ℚ where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

instance : CycleConstructor productOfPlanes :=
  ⟨fun v _ => ⟨v, rfl⟩⟩

theorem productOfPlanes_hodgeConjecture : productOfPlanes.HodgeConjecture :=
  hodgeConjecture_of_constructor productOfPlanes

/-- All three classical islands satisfy the conjecture *as data*.
This is not evidence for a general fourfold. -/
theorem classical_islands :
    projectiveFourSpace.HodgeConjecture ∧
      kleinQuadric.HodgeConjecture ∧
        productOfPlanes.HodgeConjecture :=
  ⟨projectiveFourSpace_hodgeConjecture,
    kleinQuadric_hodgeConjecture,
    productOfPlanes_hodgeConjecture⟩

end Classical
end Hodge
