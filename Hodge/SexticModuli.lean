/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/

/-!
# Sextic counts in P^5

Author: Benjamin Stanley Frohman (@BenFrohman).
`milnor_number` is finished arithmetic. It does not compute `finrank` of a
Jacobian quotient.
-/

namespace Hodge.SexticModuli

theorem sextic_monomials : Nat.choose 11 6 = 462 := by decide

theorem equation_space_dim : Nat.choose 11 6 - 1 = 461 := by decide

theorem dim_PGL6 : 6 ^ 2 - 1 = 35 := by decide

theorem naive_git_dim : Nat.choose 11 6 - 1 - (6 ^ 2 - 1) = 426 := by decide

theorem milnor_number : 5 ^ 6 = 15625 := by decide

/-- If a later algebra proof gives `finrank = 5 ^ 6`, this rewrites the numeral. -/
theorem eq_15625_of_eq_five_pow_six {n : Nat} (h : n = 5 ^ 6) : n = 15625 :=
  h.trans milnor_number

theorem plane_restriction_monomials : Nat.choose 8 6 = 28 := by decide

theorem fixed_plane_naive_dim : 461 - 28 = 433 := by decide

end Hodge.SexticModuli
