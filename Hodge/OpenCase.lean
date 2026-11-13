-- Rewritten in this session. No imported project.
-- Open case: extra rational (2,2)-classes on a general fourfold.
-- The proof body is the existential. It does not close.

namespace OpenCase

structure Fourfold where
  Cycle : Type
  Class : Type
  cl : Cycle → Class
  h2 : Class
  isHodge22 : Class → Prop
  isExtra : Class → Prop
  extra_not_h2 : ∀ γ, isExtra γ → γ ≠ h2
  extra_is_hodge : ∀ γ, isExtra γ → isHodge22 γ

/-- Every extra rational (2,2)-class is algebraic. -/
def ExtraRational22 : Prop :=
  ∀ X : Fourfold,
    ∀ γ : X.Class,
      X.isExtra γ →
        ∃ z : X.Cycle, X.cl z = γ

/-- Proof body, rewritten from scratch.
    The intros are the whole body that typechecks.
    The existential has no witness. -/
theorem extra_rational_22 : ExtraRational22 := by
  intro X γ hExtra
  have hHodge : X.isHodge22 γ := X.extra_is_hodge γ hExtra
  have hNot : γ ≠ X.h2 := X.extra_not_h2 γ hExtra
  exact ?z_of

end OpenCase
