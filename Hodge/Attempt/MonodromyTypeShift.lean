/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Mathlib.LinearAlgebra.Basic

/-!
# Type-shift of N on a Deligne splitting — statement only

`N` is of type `(-1,-1)` on the Deligne splitting of the mixed Hodge
structure `(F, W(N))`. The theorem is not claimed for an arbitrary flag
`W` or an arbitrary splitting.

This file is bookkeeping. It is not a `CycleSection` and not a proof
of the Hodge conjecture. The proof of the type-shift is `sorry`.
-/

namespace Hodge
namespace Attempt

variable {V : Type*} [AddCommGroup V] [Module ℂ V]

structure HodgeFiltration (V : Type*) [AddCommGroup V] [Module ℂ V] where
  subspace : ℤ → Submodule ℂ V
  decreasing : ∀ p : ℤ, subspace (p + 1) ≤ subspace p

structure WeightFiltration (V : Type*) [AddCommGroup V] [Module ℂ V] where
  subspace : ℤ → Submodule ℂ V
  increasing : ∀ k : ℤ, subspace k ≤ subspace (k + 1)

structure NilpotentMonodromy (V : Type*) [AddCommGroup V] [Module ℂ V] where
  op : V →ₗ[ℂ] V
  nilpotent : ∃ k : ℕ, op ^ k = 0

/-- Weight filtration attached to a given nilpotent `N`, when it exists. -/
class IsMonodromyWeight (N : NilpotentMonodromy V)
    (W : WeightFiltration V) : Prop where
  N_shifts : ∀ k : ℤ, Submodule.map N.op (W.subspace k) ≤ W.subspace (k - 2)

structure DeligneSplitting (F : HodgeFiltration V) (W : WeightFiltration V) where
  component : ℤ → ℤ → Submodule ℂ V
  reconstruct_F :
    ∀ p : ℤ, F.subspace p = ⨆ i : ℤ, ⨆ _ : i ≥ p, ⨆ j : ℤ, component i j
  reconstruct_W :
    ∀ k : ℤ, W.subspace k = ⨆ i : ℤ, ⨆ j : ℤ, ⨆ _ : i + j ≤ k, component i j

def IsMonodromyTypeShift (N : NilpotentMonodromy V)
    {F : HodgeFiltration V} {W : WeightFiltration V}
    (I : DeligneSplitting F W) : Prop :=
  ∀ p q : ℤ, Submodule.map N.op (I.component p q) ≤ I.component (p - 1) (q - 1)

/-- Correct hypotheses: `W` is the monodromy weight filtration of *this* `N`,
and `I` is a Deligne splitting of `(F, W(N))`.
Not: every flag and every splitting. Proof omitted. -/
theorem monodromy_has_type_shift_minus_one_minus_one
    (F : HodgeFiltration V)
    (N : NilpotentMonodromy V)
    (W : WeightFiltration V)
    [IsMonodromyWeight N W]
    (I : DeligneSplitting F W) :
    IsMonodromyTypeShift N I := by
  sorry

end Attempt
end Hodge
