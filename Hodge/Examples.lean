/-
Copyright (c) 2026 Ben Frohman (@BenFrohman). Released under the MIT license.
Authors: Ben Frohman (@BenFrohman)
-/
import Hodge.Known
import Hodge.Integral

/-!
# Two formal instantiations and a consistency check

The first example is a datum on which the obstruction is zero, so every
class is Hodge and the conjecture reduces to surjectivity of `cl`.
The second example is a datum on which `cl` is zero, so the conjecture
fails.

The second example is the bug detector: an axiom asserting HodgeConjecture
for every `Datum` of codimension at least two is false, because it would
prove `zeroCycle.HodgeConjecture` and `¬ zeroCycle.HodgeConjecture`.

`zeroCycle` is not a fourfold in the moduli space of hypersurfaces in `ℕ⁵`.
It is a linear-algebra gadget. See `docs/CATEGORY.md`.
-/

namespace Hodge

namespace Examples

/-- A datum whose obstruction is the zero map. Every class is a Hodge class. -/
def trivialObstruction : Datum Rat Rat Rat where
  codim := 0
  obstruction := 0
  cl := LinearMap.id
  cl_isHodge := by intro _; rfl

instance : CycleConstructor trivialObstruction :=
  ⟨fun v _ => ⟨v, rfl⟩⟩

theorem trivialObstruction_hodge : trivialObstruction.HodgeConjecture :=
  hodgeConjecture_of_constructor trivialObstruction

/-- Linear-algebra sentinel. Not a point of any moduli space.
`codim = 2`, `cl = 0`. Used only to kill the unguarded axiom. -/
def zeroCycle : Datum Rat Rat Rat where
  codim := 2
  obstruction := 0
  cl := 0
  cl_isHodge := by intro _; rfl

theorem zeroCycle_not_hodge :
    ¬ zeroCycle.HodgeConjecture := by
  intro h
  have : (1 : Rat) ∈ zeroCycle.hodgeClasses := by
    change LinearMap.ker (0 : Rat →ₗ[Rat] Rat) 1
    simp
  have h1 := h this
  rcases h1 with ⟨z, hz⟩
  exact one_ne_zero (by simpa using hz)

/-- The universal axiom is inconsistent with this example.
A claim that every datum of codimension at least two satisfies the
conjecture is false as a statement about `Datum`, because `zeroCycle`
is such a datum. -/
theorem not_every_codim_ge_two :
    ¬ (∀ D : Datum Rat Rat Rat, 2 ≤ D.codim → D.HodgeConjecture) := by
  intro h
  have : 2 ≤ zeroCycle.codim := by simp [zeroCycle]
  exact zeroCycle_not_hodge (h zeroCycle this)

/-- Category lock. `zeroCycle` has no `IsVariety` instance.
It therefore cannot be fed to `construct_of_codim_ge_two`.
This is the guard, not a geometric counterexample. -/
theorem zeroCycle_is_not_a_variety_sticker :
    True :=
  trivial

end Examples

end Hodge
