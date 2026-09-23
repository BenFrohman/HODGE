/-
Copyright (c) 2026 Benjamin Stanley Frohman.
Released under Apache-2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Hodge.Basic
import Hodge.Classical

/-!
# The proper construct type

`CycleConstructor.construct` is a proof that a Hodge class lies in the
image of `cl`. That is a membership witness. It does not return a cycle.

`CycleSection` is the map the membership witness comes from:

  construct : Hodge class → algebraic cycle
  is_section : cl (construct γ) = γ

Instances exist for the three classical islands. None exists for a
general fourfold.
-/

namespace Hodge

variable {Z V N : Type*}
    [AddCommGroup Z] [Module Rat Z]
    [AddCommGroup V] [Module Rat V]
    [AddCommGroup N] [Module Rat N]

/-- A section of `cl` on Hodge classes: an actual function to cycles. -/
class CycleSection (D : Datum Z V N) where
  construct : { v : V // v ∈ D.hodgeClasses } → Z
  is_section : ∀ γ, D.cl (construct γ) = γ.val

/-- A section gives the Prop-valued constructor. -/
instance (D : Datum Z V N) [CycleSection D] : CycleConstructor D where
  construct := fun v hv =>
    ⟨CycleSection.construct ⟨v, hv⟩, CycleSection.is_section ⟨v, hv⟩⟩

namespace Classical

instance : CycleSection projectiveFourSpace where
  construct := fun γ => (constructP4 γ.val).coeff
  is_section := fun γ => constructP4_section γ.val

instance : CycleSection kleinQuadric where
  construct := fun γ => construct γ.val
  is_section := fun γ => construct_recovers γ.val

instance : CycleSection productOfPlanes where
  construct := fun γ =>
    match γ.val with
    | (a, b, c) => (a, b, c)
  is_section := fun γ => by
    rcases γ with ⟨⟨a, b, c⟩, _⟩
    exact constructProduct_section a b c

theorem sections_recover :
    (∀ γ : { v : Rat // v ∈ projectiveFourSpace.hodgeClasses },
      projectiveFourSpace.cl (CycleSection.construct γ) = γ.val) ∧
    (∀ γ : { v : Rat × Rat // v ∈ kleinQuadric.hodgeClasses },
      kleinQuadric.cl (CycleSection.construct γ) = γ.val) ∧
    (∀ γ : { v : Rat × Rat × Rat // v ∈ productOfPlanes.hodgeClasses },
      productOfPlanes.cl (CycleSection.construct γ) = γ.val) :=
  ⟨CycleSection.is_section, CycleSection.is_section, CycleSection.is_section⟩

end Classical
end Hodge
