/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman).
Released under Apache-2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Known
import Hodge.Integral

namespace Hodge

namespace Examples

def trivialObstruction : Datum Rat Rat Rat where
  codim := 0
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro _; rfl

instance : CycleConstructor trivialObstruction :=
  ⟨fun v _ => ⟨v, rfl⟩⟩

theorem trivialObstruction_hodge : trivialObstruction.HodgeConjecture :=
  hodgeConjecture_of_constructor trivialObstruction

def zeroCycle : Datum Rat Rat Rat where
  codim := 2
  obstruction := 0
  cl := 0
  cl_isHodge := by intro _; rfl

theorem zeroCycle_not_hodge :
    ¬ zeroCycle.HodgeConjecture := by
  intro h
  have hone : (1 : Rat) ∈ zeroCycle.hodgeClasses := by
    rw [Datum.hodgeClasses]
    simp [zeroCycle]
  rcases h hone with ⟨z, hz⟩
  have : (0 : Rat) = 1 := by simpa [zeroCycle] using hz
  exact one_ne_zero this.symm

theorem not_every_codim_ge_two :
    ¬ (∀ D : Datum Rat Rat Rat, 2 ≤ D.codim → D.HodgeConjecture) := by
  intro h
  have : 2 ≤ zeroCycle.codim := by simp [zeroCycle]
  exact zeroCycle_not_hodge (h zeroCycle this)

theorem zeroCycle_is_not_a_variety_sticker : True := trivial

end Examples

end Hodge
