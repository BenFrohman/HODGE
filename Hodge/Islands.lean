/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Classical
import Hodge.Klein

/-!
# Constructions on the three classical islands

These are explicit maps from a Hodge class on one named fourfold to a
formal cycle supported on named surfaces. They are the Lean form of the
section of `cl` already written in `docs/CLASSICAL_FOURFOLDS.md`.

They are not a constructor for a general fourfold. They do not prove
`[Π]² = 1` in a Chow ring.
-/

namespace Hodge
namespace Islands

/-! ## `P^4`

Surface: the linearly embedded plane `Z = {x₃ = x₄ = 0}`.
Rule: `γ = a [Z]`.
-/

inductive P4Coord where
  | x0 | x1 | x2 | x3 | x4
  deriving DecidableEq, Repr

/-- Linear generators of the ideal of the plane `Z ⊂ P^4`. -/
def planeIdeal : List P4Coord := [.x3, .x4]

/-- Formal cycle `a [Z]` on `P^4`. -/
structure P4Cycle where
  coeff : ℚ

/-- Construction: the coefficient *is* the class, because `Hdg²(P^4) = ℚ h²`. -/
def constructP4 (gamma : ℚ) : P4Cycle := ⟨gamma⟩

theorem constructP4_coeff (a : ℚ) : (constructP4 a).coeff = a := rfl

theorem constructP4_recovers (a : ℚ) :
    Classical.projectiveFourSpace.cl (constructP4 a).coeff = a :=
  rfl

/-! ## Klein quadric `Q^4`

Surfaces: `Π = {p₁₂ = p₁₃ = p₂₃ = 0}` and `Π' = {p₀₁ = p₀₂ = p₀₃ = 0}`.
Rule: `γ = a [Π] + b [Π']` with `a = γ · [Π]`, `b = γ · [Π']`.
The named geometry lives in `Hodge.Klein`.
-/

def constructQ (gamma : ℚ × ℚ) : Klein.FormalCycle :=
  Klein.initialize (Classical.construct gamma)

theorem constructQ_eq_initialize (gamma : ℚ × ℚ) :
    constructQ gamma = Klein.initialize gamma :=
  rfl

theorem constructQ_coeff (a b : ℚ) :
    (constructQ (a, b)).coeffPi = a ∧ (constructQ (a, b)).coeffPi' = b :=
  Klein.initialize_coeff a b

theorem constructQ_recovers (gamma : ℚ × ℚ) :
    Classical.kleinQuadric.cl (Classical.construct gamma) = gamma :=
  Classical.construct_recovers gamma

/-! ## `P² × P²`

Surfaces:
* `Z₁ = {pt} × P²` (class `h₁²`)
* `Z₂ = P² × {pt}` (class `h₂²`)
* `Z₃ = P¹ × P¹` (class `h₁ h₂`)

Rule: `γ = a [Z₁] + b [Z₂] + c [Z₃]`.
-/

inductive ProductSurface where
  | ptTimesP2
  | P2TimesPt
  | lineTimesLine
  deriving DecidableEq, Repr

structure ProductCycle where
  coeffZ1 : ℚ
  coeffZ2 : ℚ
  coeffZ3 : ℚ

def constructProduct : ℚ × ℚ × ℚ → ProductCycle
  | (a, b, c) => ⟨a, b, c⟩

theorem constructProduct_coeff (a b c : ℚ) :
    (constructProduct (a, b, c)).coeffZ1 = a ∧
      (constructProduct (a, b, c)).coeffZ2 = b ∧
        (constructProduct (a, b, c)).coeffZ3 = c :=
  ⟨rfl, rfl, rfl⟩

theorem constructProduct_recovers (a b c : ℚ) :
    Classical.productOfPlanes.cl (a, b, c) = (a, b, c) :=
  rfl

/-- The three islands supply constructions *on those fourfolds*.
This conjunction is not a constructor for a general fourfold. -/
theorem islands_construct :
    Classical.projectiveFourSpace.HodgeConjecture ∧
      Classical.kleinQuadric.HodgeConjecture ∧
        Classical.productOfPlanes.HodgeConjecture :=
  Classical.classical_islands

end Islands
end Hodge
