/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
-/

/-!
# Coefficient space of sextics in P^5

Degree-6 forms in 6 variables: C(11,6) = 462.
Space of equations: P^461.
PGL(6) has dimension 6^2 - 1 = 35.
Naive orbit-space count: 461 - 35 = 426.
Stabilizers exist; this is not a scheme-dimension theorem.
These counts hold for every sextic. They do not inhabit general_fourfold.
-/

namespace Hodge.SexticModuli

theorem sextic_monomials : Nat.choose 11 6 = 462 := by decide

theorem equation_space_dim : Nat.choose 11 6 - 1 = 461 := by decide

theorem dim_PGL6 : 6 ^ 2 - 1 = 35 := by decide

theorem naive_GIT_dim : 461 - 35 = 426 := by decide

end Hodge.SexticModuli
