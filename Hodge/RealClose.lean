/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Construct
import Hodge.Fourfold

/-!
# Type of a real close at codimension 2

A real close is an inhabitant of the geometric sentence

  ∀ smooth projective fourfolds X,
  ∀ γ ∈ H⁴(X, ℚ) ∩ H^{2,2}(X),
  ∃ surfaces Z_i ⊂ X and a_i ∈ ℚ with γ = ∑ a_i [Z_i].

Lean: a `CycleSection` on a specified datum `D` with `D.codim = 2`.
This file records that *type*. It does not inhabit it for unspecified `D`.

Holes `?z_of` and `?cl_z_eq` in `docs/UNIVERSAL_INSTANCE.md` stay empty.
-/

namespace Hodge

variable {Z V N : Type*}
    [AddCommGroup Z] [Module Rat Z]
    [AddCommGroup V] [Module Rat V]
    [AddCommGroup N] [Module Rat N]

/-- Per-datum type of a section of `cl` at codimension 2.
Named hosts inhabit this via existing `CycleSection` instances.
Unspecified `D` does not. -/
structure HodgeConjecture.RealClose
    (D : Datum Z V N) (h : D.codim = 2) where
  section : CycleSection D

/-- A real-close wrapper yields the Prop `general_fourfold`. -/
theorem HodgeConjecture.of_realClose
    (D : Datum Z V N) (h : D.codim = 2)
    (s : HodgeConjecture.RealClose D h) :
    HodgeConjecture.general_fourfold D h :=
  HodgeConjecture.of_section D

/-- Package an existing island instance. Not `∀ D`. -/
def HodgeConjecture.realClose_of_section
    (D : Datum Z V N) [CycleSection D] (h : D.codim = 2) :
    HodgeConjecture.RealClose D h :=
  ⟨inferInstance⟩

/-- Fiber of `cl` over `γ`. -/
def Datum.fiber (D : Datum Z V N) (γ : V) : Type _ :=
  { z : Z // D.cl z = γ }

theorem HodgeConjecture.nonempty_fiber_iff
    (D : Datum Z V N) (γ : V) :
    Nonempty (D.fiber γ) ↔ ∃ z, D.cl z = γ :=
  ⟨fun ⟨⟨z, hz⟩⟩ => ⟨z, hz⟩, fun ⟨z, hz⟩ => ⟨⟨z, hz⟩⟩⟩

theorem HodgeConjecture.mem_algebraicClasses_iff
    (D : Datum Z V N) (γ : V) :
    γ ∈ D.algebraicClasses ↔ ∃ z, D.cl z = γ :=
  Iff.rfl

/-- Unfolding only. Not a term of `general_fourfold` for unspecified `D`. -/
theorem HodgeConjecture.iff_nonempty_fibers (D : Datum Z V N) :
    D.HodgeConjecture ↔
      ∀ γ ∈ D.hodgeClasses, Nonempty (D.fiber γ) := by
  constructor
  · intro h γ hγ
    exact (HodgeConjecture.nonempty_fiber_iff D γ).mpr (h hγ)
  · intro h γ hγ
    exact (HodgeConjecture.nonempty_fiber_iff D γ).mp (h γ hγ)

end Hodge
