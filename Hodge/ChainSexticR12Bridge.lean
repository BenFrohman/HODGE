/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Hodge.ChainSexticBridgeAudit
import Hodge.ChainSexticR12

/-!
# Consequences of `dim_ℚ R₁₂ = 1751` for the chain-sextic bridges

`Hodge.ChainSexticR12.jacobianDeg12_finrank_eq` proves `finrank ℚ jacobianDeg12 = 1751`.
This file records what that changes, and what it does not.

* `griffiths_iff`: the Griffiths field `finrank ℂ H22 = 1 + finrank ℚ R₁₂` of
  `ChainSexticHodgeBridge` is now equivalent to the plain statement `h^{2,2} = 1752`.
* `hodgeBridge_h22`: every `ChainSexticHodgeBridge` has `finrank ℂ H22 = 1752`.
* `r_eq` and `model_rho_eq`: in the linear-algebra model of `ChainSexticBridgeAudit`,
  `r = 1751` and `ρ = 1752` exactly.
* `characterBridge_R12_obstruction_discharged`: `ChainSexticBridgeAudit.characterBridge_forces_R12`
  showed that a character bridge can exist only if `dim R₁₂ = 1751`. That condition is now a
  theorem, so it is no longer an obstruction to `ChainSexticCharacterBridge`.
* `characterBridge_griffiths_agree`: in any character bridge the two computations of
  `h^{2,2}` agree: `1 + dim R₁₂` (Griffiths field) and `1 + #type22` (eigenline fields) are
  both `1752`, and `#type22 = dim R₁₂ = 1751`.

## What remains a hypothesis

`rho_eq_786` never used `dim R₁₂` in its proof; it uses the eigenline fields. The equality removes
the one known necessary condition that was unproved. This file does **not** construct an
inhabitant of `ChainSexticCharacterBridge`. A linear-algebra inhabitant (not the cohomology
of the sextic) is constructed in `Hodge.ChainSexticCharacterModel`. The geometric fields remain
named hypotheses (never Lean axioms):
* from `ChainSexticHodgeBridge`: `H22`, `griffiths` (now equivalent to `h^{2,2} = 1752`),
  `pairing`, `h2`, `P`, `h2_hodge`, `P_hodge`, `h2_h2`, `h2_P`, `P_h2`, `P_P`;
* from `ChainSexticCharacterBridge`: `V`, `V_out`, `V_line`, `eigen_indep`, `h22_eq`, `W`,
  `W_complex`, `hdg_split`, `orbit_simple`.
So `ρ_Hdg(X) = 786` is still conditional on the character bridge.
-/

open Module TensorProduct
open Hodge.ChainSexticRank Hodge.ChainSexticRho Hodge.ChainSexticBridgeAudit Hodge.ChainSexticR12

namespace Hodge
namespace ChainSexticR12Bridge

/-- The Griffiths field is now equivalent to `h^{2,2} = 1752`. -/
theorem griffiths_iff (n : ℕ) : n = 1 + finrank ℚ jacobianDeg12 ↔ n = 1752 := by
  rw [jacobianDeg12_finrank_eq]

/-- Every `ChainSexticHodgeBridge` has `h^{2,2} = 1752`. -/
theorem hodgeBridge_h22 {H : Type*} [AddCommGroup H] [Module ℚ H]
    (D : ChainSexticHodgeBridge H) : finrank ℂ D.H22 = 1752 :=
  (griffiths_iff _).mp D.griffiths

/-- The model dimension `r` of `ChainSexticBridgeAudit` is exactly 1751. -/
theorem r_eq : ChainSexticBridgeAudit.r = 1751 := jacobianDeg12_finrank_eq

/-- In the linear-algebra model, `ρ = 1752` exactly (the top of `2 ≤ ρ ≤ 1752`). -/
theorem model_rho_eq : hodgeBridge_model.rho = 1752 := by
  rw [model_rho, r_eq]

/-- The necessary condition `dim R₁₂ = 1751` forced by any character bridge
(`characterBridge_forces_R12`) is a theorem. -/
theorem characterBridge_R12_obstruction_discharged : finrank ℚ jacobianDeg12 = 1751 :=
  jacobianDeg12_finrank_eq

/-- In a character bridge, `#type22 = dim R₁₂` and both computations of `h^{2,2}` give 1752. -/
theorem characterBridge_griffiths_agree {H : Type*} [AddCommGroup H] [Module ℚ H]
    [FiniteDimensional ℚ H] (D : ChainSexticCharacterBridge H) :
    finrank ℂ D.H22 = 1 + finrank ℚ jacobianDeg12 ∧ finrank ℂ D.H22 = 1 + type22.card ∧
      type22.card = finrank ℚ jacobianDeg12 := by
  have h1 := characterBridge_h22 D
  rw [type22_card, jacobianDeg12_finrank_eq]
  omega

/-- Non-vacuity: the Griffiths field is not automatic. A subspace of the wrong dimension
(here `⊥`, of dimension `0`) does not satisfy it. -/
theorem griffiths_not_automatic {H : Type*} [AddCommGroup H] [Module ℚ H] :
    finrank ℂ (⊥ : Submodule ℂ (ℂ ⊗[ℚ] H)) ≠ 1 + finrank ℚ jacobianDeg12 := by
  rw [finrank_bot, jacobianDeg12_finrank_eq]; norm_num

end ChainSexticR12Bridge
end Hodge
