/-
Copyright (c) 2026 Ben Frohman (@BenFrohman). Released under the MIT license.
Authors: Ben Frohman (@BenFrohman)
-/
import Hodge.Basic

/-!
# Integral versus rational

Hodge's conjecture is a statement over `ℚ`.  The corresponding statement over
`ℤ` — every integral `(k,k)` class is an integral combination of cycle classes —
is **false**, by Atiyah–Hirzebruch (1962), refined by Kollár and others.

This file does not formalize their counterexample.  Doing so would require
topological K-theory, the Atiyah–Hirzebruch spectral sequence, and Steenrod
operations.  What it does instead is separate the two statements *as statements*:
it exhibits a two-line model in which the rational assertion is provable and the
integral assertion is refutable.  That establishes the only thing the skeleton
can establish honestly — that no formal manipulation can derive the integral
version from the rational one, so the failure over `ℤ` is not a technicality of
the setup but a real phenomenon that had to be discovered geometrically.
-/

namespace Hodge

namespace Integral

/-- In the rational model, "divisible by two" is no condition at all. -/
theorem rational_solvable : ∀ q : ℚ, ∃ r : ℚ, 2 * r = q :=
  fun q => ⟨q / 2, by ring⟩

/-- In the integral model, it is a genuine obstruction. -/
theorem integral_unsolvable : ¬ ∃ n : ℤ, 2 * n = 1 := by
  rintro ⟨n, hn⟩
  omega

/-- **Separation.**  The rational statement holds and the integral statement
fails, in one and the same model.  Hence the integral Hodge conjecture is not a
formal consequence of the rational one, and the rational one is not weakened by
the known integral counterexamples. -/
theorem rational_does_not_imply_integral :
    (∀ q : ℚ, ∃ r : ℚ, 2 * r = q) ∧ ¬ ∃ n : ℤ, 2 * n = 1 :=
  ⟨rational_solvable, integral_unsolvable⟩

end Integral

namespace Datum

variable {Z V N : Type*} [AddCommGroup Z] [Module ℚ Z]
  [AddCommGroup V] [Module ℚ V] [AddCommGroup N] [Module ℚ N]

/-- The one implication that does hold: if a set of *integrally* constructed
cycle classes already spans the Hodge classes over `ℚ`, the rational conjecture
follows.  This is why integral information is useful even though the integral
conjecture is false — denominators are allowed on the way back. -/
theorem hodgeConjecture_of_integral_generation (D : Datum Z V N) (L : Set V)
    (hspan : D.hodgeClasses ≤ Submodule.span ℚ L)
    (hint : L ⊆ (D.algebraicClasses : Set V)) :
    D.HodgeConjecture :=
  D.hodgeConjecture_of_generators L hspan hint

end Datum

end Hodge
