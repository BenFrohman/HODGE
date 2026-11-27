/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/

import Mathlib.LinearAlgebra.Dimension.Finrank
import Mathlib.LinearAlgebra.RankNullity
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Hodge.Basic
import Hodge.Fourfold

/-!
# SexticFourfoldDatum

Refines `Datum` with a symmetric pairing and a hyperplane square cycle
whose self-intersection is 6. The non-vanishing of the hyperplane class is
derived from the pairing. The orthogonal decomposition
`V = ℚ·ω ⊕ ω⊥` is proved, and
`HodgeConjecture.general_fourfold` is shown to be equivalent to the numerical
condition that the primitive algebraic image has rank 1751.

This file records pure module theory on an abstract datum. It does not
construct a cycle from an arbitrary primitive Hodge class, and it does not
inhabit the geometric inclusion for an unspecified fourfold.
-/

namespace Hodge

variable {Z V N : Type*}
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]

structure SexticFourfoldDatum (Z V N : Type*)
    [AddCommGroup Z] [Module ℚ Z]
    [AddCommGroup V] [Module ℚ V]
    [AddCommGroup N] [Module ℚ N]
    extends Datum Z V N where
  pairing : V →ₑ[ℚ] V →ₑ[ℚ] ℚ
  pairing_symm : ∀ u v, pairing u v = pairing v u
  hSq : Z
  hSq_self_intersection : pairing (cl hSq) (cl hSq) = 6

namespace SexticFourfoldDatum

def omega (S : SexticFourfoldDatum Z V N) : V := S.cl S.hSq

theorem omega_ne_zero (S : SexticFourfoldDatum Z V N) : S.omega ≠ 0 := by
  intro h0
  have h := S.hSq_self_intersection
  unfold omega at h0
  rw [h0, map_zero, LinearMap.zero_apply] at h
  norm_num at h

def ambientLine (S : SexticFourfoldDatum Z V N) : Submodule ℚ V :=
  Submodule.span ℚ {S.omega}

def primSubmodule (S : SexticFourfoldDatum Z V N) : Submodule ℚ V where
  carrier := {v : V | S.pairing S.omega v = 0}
  zero_mem' := by simp
  add_mem' {u v} hu hv := by simp [hu, hv]
  smul_mem' c {v} hv := by simp [hv]

theorem ambientLine_le_algebraicClasses (S : SexticFourfoldDatum Z V N) :
    S.ambientLine ≤ S.algebraicClasses := by
  rw [Submodule.span_singleton_le_iff_mem]
  exact ⟨S.hSq, rfl⟩

theorem algebraicClasses_le_hodgeClasses (S : SexticFourfoldDatum Z V N) :
    S.algebraicClasses ≤ S.hodgeClasses := by
  rintro v ⟨z, rfl⟩
  exact S.cl_isHodge z

theorem ambientLine_le_hodgeClasses (S : SexticFourfoldDatum Z V N) :
    S.ambientLine ≤ S.hodgeClasses :=
  le_trans S.ambientLine_le_algebraicClasses S.algebraicClasses_le_hodgeClasses

theorem ambientLine_isCompl_primSubmodule (S : SexticFourfoldDatum Z V N) :
    IsCompl S.ambientLine S.primSubmodule := by
  rw [isCompl_iff]
  constructor
  · rw [disjoint_iff, eq_bot_iff]
    rintro v ⟨hv_line, hv_prim⟩
    rw [Submodule.mem_span_singleton] at hv_line
    rcases hv_line with ⟨c, rfl⟩
    have hp : S.pairing S.omega (c • S.omega) = 0 := hv_prim
    rw [map_smul, smul_eq_mul, S.hSq_self_intersection] at hp
    have hc : c = 0 := by linarith
    simp [hc]
  · rw [codisjoint_iff, eq_top_iff]
    intro v _
    let c : ℚ := S.pairing S.omega v / 6
    have hv_eq : v = c • S.omega + (v - c • S.omega) := by abel
    rw [hv_eq]
    refine Submodule.add_mem_sup (Submodule.mem_span_singleton.mpr ⟨c, rfl⟩) ?_
    show S.pairing S.omega (v - c • S.omega) = 0
    rw [map_sub, map_smul, smul_eq_mul, S.hSq_self_intersection]
    dsimp [c]
    ring

theorem finrank_ambientLine (S : SexticFourfoldDatum Z V N) :
    Module.finrank ℚ S.ambientLine = 1 :=
  finrank_span_singleton S.omega_ne_zero

theorem algebraicClasses_eq_sup_prim (S : SexticFourfoldDatum Z V N) :
    S.algebraicClasses = S.ambientLine ⊔ (S.algebraicClasses ⊓ S.primSubmodule) := by
  apply le_antisymm
  · intro v hv
    let c : ℚ := S.pairing S.omega v / 6
    have hc_mem : c • S.omega ∈ S.ambientLine :=
      Submodule.mem_span_singleton.mpr ⟨c, rfl⟩
    have hp_mem : v - c • S.omega ∈ S.algebraicClasses ⊓ S.primSubmodule := by
      refine ⟨Submodule.sub_mem _ hv (S.ambientLine_le_algebraicClasses hc_mem), ?_⟩
      show S.pairing S.omega (v - c • S.omega) = 0
      rw [map_sub, map_smul, smul_eq_mul, S.hSq_self_intersection]
      dsimp [c]
      ring
    have hv_eq : v = c • S.omega + (v - c • S.omega) := by abel
    rw [hv_eq]
    exact Submodule.add_mem_sup hc_mem hp_mem
  · exact sup_le S.ambientLine_le_algebraicClasses inf_le_left

theorem general_fourfold_iff_prim_cycle_rank_1751
    [FiniteDimensional ℚ V]
    (S : SexticFourfoldDatum Z V N)
    (h : S.codim = 2)
    (hb4 : Module.finrank ℚ V = 2606)
    (hobs : Module.finrank ℚ (LinearMap.range S.obstruction) = 854) :
    HodgeConjecture.general_fourfold S.toDatum h ↔
      Module.finrank ℚ (↑(S.algebraicClasses ⊓ S.primSubmodule)) = 1751 := by
  have hle : S.algebraicClasses ≤ S.hodgeClasses := S.algebraicClasses_le_hodgeClasses
  have hrn : Module.finrank ℚ (LinearMap.range S.obstruction) +
      Module.finrank ℚ S.hodgeClasses = Module.finrank ℚ V :=
    LinearMap.finrank_range_add_finrank_ker S.obstruction
  have hdisj : Disjoint S.ambientLine (S.algebraicClasses ⊓ S.primSubmodule) :=
    Disjoint.mono_right inf_le_right S.ambientLine_isCompl_primSubmodule.disjoint
  have hdim_alg :
      Module.finrank ℚ S.algebraicClasses =
        1 + Module.finrank ℚ (↑(S.algebraicClasses ⊓ S.primSubmodule)) := by
    conv_lhs => rw [S.algebraicClasses_eq_sup_prim]
    have hsup := Submodule.finrank_sup_add_finrank_inf_eq
      S.ambientLine (S.algebraicClasses ⊓ S.primSubmodule)
    rw [hdisj.eq_bot, finrank_bot, add_zero, S.finrank_ambientLine] at hsup
    exact hsup.symm
  unfold HodgeConjecture.general_fourfold HodgeConjecture
  constructor
  · intro hsub
    have heq : S.algebraicClasses = S.hodgeClasses := le_antisymm hle hsub
    have hdim_eq : Module.finrank ℚ S.algebraicClasses = Module.finrank ℚ S.hodgeClasses :=
      congrArg (Module.finrank ℚ) heq
    omega
  · intro hprim
    have hdim_eq : Module.finrank ℚ S.algebraicClasses = Module.finrank ℚ S.hodgeClasses := by
      omega
    exact le_of_eq (Submodule.eq_of_le_of_finrank_eq hle hdim_eq).symm

end SexticFourfoldDatum

end Hodge
