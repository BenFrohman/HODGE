/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/

/-!
# Coefficient space of sextics in P^5

Degree-6 forms in 6 variables: C(11,6) = 462.
Space of equations: P^461.
PGL(6) has dimension 6^2 - 1 = 35.
Naive orbit-space dimension: 461 - 35 = 426 (stabilizers exist).

Milnor number formula for an isolated degree-6 singularity in 6 variables:
  μ = (d-1)^{n+1} = 5^6 = 15625.
This is the expected dimension of the Jacobian algebra. It is not a
computed `Module.rank` of a Lean quotient ring.

Fixed plane `Π = V(x3,x4,x5)`: degree-6 forms in the remaining 3 variables
have C(8,6)=28 coefficients. Those must vanish for `Π ⊂ X`.
These counts hold as arithmetic. They do not inhabit general_fourfold.
-/

namespace Hodge.SexticModuli

theorem sextic_monomials : Nat.choose 11 6 = 462 := by decide

theorem equation_space_dim : Nat.choose 11 6 - 1 = 461 := by decide

theorem dim_PGL6 : 6 ^ 2 - 1 = 35 := by decide

theorem naive_git_dim : Nat.choose 11 6 - 1 - (6 ^ 2 - 1) = 426 := by decide

/-- Classical Milnor formula (d-1)^{n+1} for d=6 in 6 variables. -/
theorem milnor_formula_5_pow_6 : 5 ^ 6 = 15625 := by decide

/-- Degree-6 monomials in 3 variables: forms vanishing on this fixed plane. -/
theorem forbidden_on_fixed_plane : Nat.choose 8 6 = 28 := by decide

theorem fixed_plane_locus_dim : Nat.choose 11 6 - 1 - Nat.choose 8 6 = 433 := by decide

end Hodge.SexticModuli
