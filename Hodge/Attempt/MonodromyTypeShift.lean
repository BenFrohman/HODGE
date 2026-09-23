/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Mathlib.LinearAlgebra.Basic

/-!
# Type-shift of N on a Deligne splitting — statement only

Hypotheses:
* `W` is a monodromy weight filtration of this `N`, centre weight `n`
  (e.g. `n = 3` on `H³(Y_t)` of a Lefschetz slice).
* `N^k : Gr^W_{n+k} → Gr^W_{n-k}` is the *induced* map, and is bijective.
* Conjugation is a conjugate-linear involution `σ`, and
  `σ(I^{p,q}) ≡ I^{q,p} (mod ⊕_{i<q, j<p} I^{i,j})`.
  The modulus indices are `i < q` and `j < p`, not `i < p` and `j < q`.

The type-shift theorem stays `sorry`. This is not a `CycleSection`.
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

/-- `W` belongs to this `N`, centred at weight `n`.
The sl₂ isomorphism `N^k : Gr_{n+k} → Gr_{n-k}` is part of the meaning of
`W(N)` and is not an independent axiom map. -/
class IsMonodromyWeight (N : NilpotentMonodromy V)
    (W : WeightFiltration V) (n : ℤ) : Prop where
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

/-- `W = W(N)` at centre weight `n`. `I` a Deligne splitting of `(F, W)`.
Not an arbitrary flag. Proof omitted. -/
theorem monodromy_has_type_shift_minus_one_minus_one
    (F : HodgeFiltration V)
    (N : NilpotentMonodromy V)
    (W : WeightFiltration V)
    (n : ℤ)
    [IsMonodromyWeight N W n]
    (I : DeligneSplitting F W) :
    IsMonodromyTypeShift N I := by
  sorry

end Attempt
end Hodge
