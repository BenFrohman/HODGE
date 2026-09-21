/-
Copyright (c) 2026 Ben Frohman (@BenFrohman). Released under the MIT license.
Authors: Ben Frohman (@BenFrohman)
-/
import Hodge.Known
import Hodge.Integral

/-!
# Two formal instantiations and an axiom audit

The first example is a datum on which the obstruction is zero, so every
class is Hodge and the conjecture reduces to surjectivity of `cl`.
The second example is a datum on which `cl` is zero, so the conjecture
fails.

Neither example is a fourfold. Neither example constructs surfaces from
an arbitrary Hodge class of codimension two.
-/

namespace Hodge

namespace Examples

/-- A datum whose obstruction is the zero map. Every class is a Hodge class. -/
def trivialObstruction : Datum ℚ ℚ ℚ where
  codim := 0
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro _; rfl

/-- On that datum `cl` is the identity, so the conjecture holds by inspection. -/
instance : CycleConstructor trivialObstruction :=
  ⟨fun v _ => ⟨v, rfl⟩⟩

theorem trivialObstruction_hodge : trivialObstruction.HodgeConjecture :=
  hodgeConjecture_of_constructor trivialObstruction

/-- The zero map as cycle class map, with a trivial obstruction. The Hodge
classes are everything; the algebraic classes are zero. The conjecture
fails on this datum. -/
def zeroCycle : Datum ℚ ℚ ℚ where
  codim := 2
  obstruction := 0
  cl := 0
  cl_isHodge := by intro _; rfl

theorem zeroCycle_not_hodge :
    ¬ zeroCycle.HodgeConjecture := by
  intro h
  have : (1 : ℚ) ∈ zeroCycle.hodgeClasses := by
    change LinearMap.ker (0 : ℚ →ₗ[ℚ] ℚ) 1
    simp
  have h1 := h this
  rcases h1 with ⟨z, hz⟩
  exact one_ne_zero (by simpa using hz)

end Examples

end Hodge
