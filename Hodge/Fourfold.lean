/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/
import Hodge.Basic
import Hodge.Classical
import Hodge.Construct

/-!
# Easy arrow, hard arrow, discharged term

Easy arrow (theorem, `Datum.cl_isHodge`):
  a subvariety Z of codimension k gives
  [Z] ∈ H^{2k}(X,Q) ∩ H^{k,k}(X).

Hard arrow (the conjecture, `Datum.HodgeConjecture`):
  every such class is a finite rational combination of subvarieties,
  γ = ∑ a_i [Z_i].

On a fourfold the first open case is k = 2: surfaces.
That identity is the statement. It is not a proof that the statement is true.

Discharged term: `HodgeConjecture.classical_fourfolds`.
Proved by `CycleSection` / `of_section` on P^4, Q^4, P^2 × P^2 only.

`HodgeConjecture.general_fourfold` is a `Prop`. No term for unspecified D.
Specializing it to P^4, Q^4, or P^2 × P^2 is not a proof for a general fourfold.
-/

namespace Hodge

variable {Z V N : Type*}
    [AddCommGroup Z] [Module Rat Z]
    [AddCommGroup V] [Module Rat V]
    [AddCommGroup N] [Module Rat N]

class IsVariety (D : Datum Z V N) : Prop

instance : IsVariety Classical.projectiveFourSpace := {}
instance : IsVariety Classical.kleinQuadric := {}
instance : IsVariety Classical.productOfPlanes := {}

def constructOfCodimGeTwo (D : Datum Z V N) (_h : 2 ≤ D.codim) : Prop :=
  ∀ v ∈ D.hodgeClasses, v ∈ D.algebraicClasses

theorem constructOfCodimGeTwo_iff (D : Datum Z V N) (h : 2 ≤ D.codim) :
    constructOfCodimGeTwo D h ↔ D.HodgeConjecture :=
  Iff.rfl

theorem HodgeConjecture.of_constructor (D : Datum Z V N)
    [CycleConstructor D] : D.HodgeConjecture :=
  hodgeConjecture_of_constructor D

theorem HodgeConjecture.of_section (D : Datum Z V N) [CycleSection D] :
    D.HodgeConjecture :=
  hodgeConjecture_of_constructor D

theorem HodgeConjecture.classical_fourfolds :
    Classical.projectiveFourSpace.HodgeConjecture ∧
      Classical.kleinQuadric.HodgeConjecture ∧
        Classical.productOfPlanes.HodgeConjecture :=
  ⟨HodgeConjecture.of_section _,
    HodgeConjecture.of_section _,
    HodgeConjecture.of_section _⟩

theorem HodgeConjecture.p4 :
    Classical.projectiveFourSpace.HodgeConjecture :=
  HodgeConjecture.classical_fourfolds.1

theorem HodgeConjecture.klein :
    Classical.kleinQuadric.HodgeConjecture :=
  HodgeConjecture.classical_fourfolds.2.1

theorem HodgeConjecture.product :
    Classical.productOfPlanes.HodgeConjecture :=
  HodgeConjecture.classical_fourfolds.2.2

/-- Open sentence. Not a clone of `classical_fourfolds`. -/
def HodgeConjecture.general_fourfold
    (D : Datum Z V N) [IsVariety D] (_h : D.codim = 2) : Prop :=
  D.HodgeConjecture

theorem HodgeConjecture.general_fourfold_iff
    (D : Datum Z V N) [IsVariety D] (h : D.codim = 2) :
    HodgeConjecture.general_fourfold D h ↔ D.HodgeConjecture :=
  Iff.rfl

/-- The open Prop, instantiated on the three islands only. -/
theorem HodgeConjecture.p4_isVariety :
    HodgeConjecture.general_fourfold
      (D := Classical.projectiveFourSpace) (by rfl) :=
  HodgeConjecture.p4

theorem HodgeConjecture.klein_isVariety :
    HodgeConjecture.general_fourfold
      (D := Classical.kleinQuadric) (by rfl) :=
  HodgeConjecture.klein

theorem HodgeConjecture.product_isVariety :
    HodgeConjecture.general_fourfold
      (D := Classical.productOfPlanes) (by rfl) :=
  HodgeConjecture.product

theorem codim_two_ge_two (D : Datum Z V N) (h : D.codim = 2) :
    2 ≤ D.codim :=
  h ▸ Nat.le_refl 2

end Hodge
