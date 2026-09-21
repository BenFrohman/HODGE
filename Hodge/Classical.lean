/-
Copyright (c) 2026 Ben Frohman (@BenFrohman). Released under the MIT license.
Authors: Ben Frohman (@BenFrohman)
-/
import Hodge.Basic

/-!
# Classical fourfolds where a section of `cl` is known

This file records three *islands* in which every Hodge class of codimension two
is a rational combination of explicit planes. The geometry is classical:

* `projectiveFourSpace` — `H⁴(ℝ⁴, ℚ) = ℚ · h²`, and `h²` is the class of a
  linear plane.
* `kleinQuadric` — `H⁴(Q, ℚ)` is two-dimensional, spanned by the classes of
  two planes `Π`, `Π'` of opposite families, with the incidence-free identities
  `h² = [Π] + [Π']`, `[Π]² = [Π']² = 1`, `[Π] · [Π'] = 0`.
  The rule is `γ = a[Π] + b[Π']` with `a = γ · [Π]`, `b = γ · [Π']`.
  Schubert names are an optional dictionary and are not used here.
* `productOfPlanes` — Künneth: three generators `h₁²`, `h₂²`, `h₁ h₂`.

The Lean content is the linear-algebraic shadow of those theorems:
`obstruction = 0` and `cl` the identity, hence surjective. That is the *shape*
of a known section. It is not a formalization of Grassmannians, and it does not
instantiate `CycleConstructor` for a general fourfold.

See `docs/CLASSICAL_FOURFOLDS.md` for the equations of the planes.
-/

namespace Hodge
namespace Classical

/-- Projective four-space. One-dimensional Hodge space, one algebraic generator. -/
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

/-- Klein quadric `Q⁴ ⊂ ℝ⁵`.
Two-dimensional Hodge space. Generators are the classes of two planes of
opposite families; the public identities are the sum-to-`h²` relation and
the identity intersection matrix, not a Schubert label. -/
def kleinQuadric : Datum (ℚ × ℚ) (ℚ × ℚ) ℚ where
  codim := 2
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro z; simp

/-- The two-plane rule: coefficients `(a, b)` are the cycle itself.
This is the coordinate form of `γ = (γ · [Π])[Π] + (γ · [Π'])[Π']`. -/
def construct (γ : ℚ × ℚ) : ℚ × ℚ := γ

theorem construct_recovers (γ : ℚ × ℚ) :
    kleinQuadric.cl (construct γ) = γ :=
  rfl

/-- Coordinate form of `γ = a[Π] + b[Π']`. The pair `(a, b)` does not
record which family is which. -/
theorem expansion (a b : ℚ) :
    kleinQuadric.cl (a, b) = (a, b) :=
  rfl

instance : CycleConstructor kleinQuadric :=
  ⟨fun v _ => ⟨v, rfl⟩⟩

theorem kleinQuadric_hodgeConjecture : kleinQuadric.HodgeConjecture :=
  hodgeConjecture_of_constructor kleinQuadric

/-- Product `ℝ² × ℝ²`. Three-dimensional Hodge space. -/
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
