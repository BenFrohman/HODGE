/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/

/-!
# Sextic counts in P^5

Classical arithmetic only. `milnor_number` is (d-1)^{n+1} = 5^6.
It is not `Module.rank` of a Jacobian quotient in Lean.
-/

namespace Hodge.SexticModuli

theorem sextic_monomials : Nat.choose 11 6 = 462 := by decide

theorem equation_space_dim : Nat.choose 11 6 - 1 = 461 := by decide

theorem dim_PGL6 : 6 ^ 2 - 1 = 35 := by decide

theorem naive_git_dim : Nat.choose 11 6 - 1 - (6 ^ 2 - 1) = 426 := by decide

/-- Classical Milnor number of a degree-6 hypersurface in 6 variables. -/
theorem milnor_number : 5 ^ 6 = 15625 := by decide

/-- Degree-6 forms in the three variables of Π. Vanishing is "this plane ⊂ X". -/
theorem plane_restriction_monomials : Nat.choose 8 6 = 28 := by decide

theorem fixed_plane_naive_dim : 461 - 28 = 433 := by decide

end Hodge.SexticModuli
