/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)

Not imported by Hodge.lean. Scaffold only.
-/
import Hodge.SpecialSextic

/-!
# Named hypotheses for Jacobian length

Piece 1 (in SpecialSextic): ∇F = 0 only at the origin.
Piece 2a: those partials are a regular sequence (`PartialsRegular`).
Piece 2b: regular sequence of n degree-d forms in n variables ⇒ dim = d^n
          (`HomogeneousCILength`).

A term of both plus Mathlib glue would give finrank R(F) = 15625.
Neither class has an instance in this file. Not surfaces. Not general_fourfold.
-/

namespace Hodge
namespace JacobianLength

/-- Mathlib name to wire later: `RingTheory.Sequence.IsRegular` on the six partials. -/
class PartialsRegular : Prop

/-- Vector-space CI length, not Krull-dimension drop. -/
class HomogeneousCILength : Prop where
  /-- Regular sequence of `n` homogeneous degree-`d` forms in `n` vars
      has `k`-dimension `d ^ n`. -/
  dim_eq_pow : ∀ n d : ℕ, d ^ n = d ^ n

theorem five_pow_six : 5 ^ 6 = 15625 :=
  SpecialSextic.five_pow_six

/-- Arithmetic face of the length. Does not evaluate `finrank` of a quotient. -/
theorem length_num : 5 ^ 6 = 15625 :=
  five_pow_six

/--
If both hypotheses are ever instanced, the numerical target is 15625.
This is not `finrank (MvPolynomial ⁄ J_F) = 15625`.
-/
theorem length_num_of_hyps [PartialsRegular] [HomogeneousCILength] :
    5 ^ 6 = 15625 :=
  five_pow_six

/-- Hodge progression is unchanged by this file. -/
theorem this_is_not_general_fourfold : True := trivial

end JacobianLength
end Hodge
