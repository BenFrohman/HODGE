/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
SPDX-License-Identifier: Apache-2.0
-/
import Mathlib.RingTheory.Ideal.Basic
import Mathlib.Algebra.MvPolynomial.CommRing
import Mathlib.Data.Complex.Basic
import Mathlib.Tactic.Ring

/-!
# Fermat quartic planes with ζ^4 = -1

Library term. Not a Hodge class.

`fermatQuartic` is the Fermat quartic in six variables. `surfaceZ1Ideal ζ` is the
ideal of one linear plane. Under `ζ ^ 4 = -1`, each coordinate pair factors through
that plane's generator, so the quartic lies in the ideal. The generator is the
left factor, so one `Ideal.mul_mem_right` is enough, as in `F_mem_plane`.
-/

namespace Hodge
namespace FermatPlanes

inductive Var | z0 | z1 | z2 | z3 | z4 | z5
deriving DecidableEq

abbrev CoordRing := MvPolynomial Var ℂ

open MvPolynomial

noncomputable def Xc (i : Var) : MvPolynomial Var ℂ := X i

noncomputable def fermatQuartic : CoordRing :=
  Xc Var.z0 ^ 4 + Xc Var.z1 ^ 4 + Xc Var.z2 ^ 4 +
    Xc Var.z3 ^ 4 + Xc Var.z4 ^ 4 + Xc Var.z5 ^ 4

noncomputable def surfaceZ1Ideal (ζ : ℂ) : Ideal CoordRing :=
  Ideal.span {
    Xc Var.z0 - C ζ * Xc Var.z1,
    Xc Var.z2 - C ζ * Xc Var.z3,
    Xc Var.z4 - C ζ * Xc Var.z5 }

noncomputable def surfaceZ2Ideal (ζ : ℂ) : Ideal CoordRing :=
  Ideal.span {
    Xc Var.z0 + C ζ * Xc Var.z1,
    Xc Var.z2 - C ζ * Xc Var.z3,
    Xc Var.z4 - C ζ * Xc Var.z5 }

theorem pair_with_remainder {S : Type*} [CommRing S] (z w ζ : S) :
    z ^ 4 + w ^ 4 =
      (z - ζ * w) * (z ^ 3 + ζ * z ^ 2 * w + ζ ^ 2 * z * w ^ 2 + ζ ^ 3 * w ^ 3) +
        (1 + ζ ^ 4) * w ^ 4 := by
  ring

theorem pair_vanishing {S : Type*} [CommRing S] (z w ζ : S) (hζ : ζ ^ 4 = -1) :
    z ^ 4 + w ^ 4 =
      (z - ζ * w) * (z ^ 3 + ζ * z ^ 2 * w + ζ ^ 2 * z * w ^ 2 + ζ ^ 3 * w ^ 3) := by
  calc
    z ^ 4 + w ^ 4 =
        (z - ζ * w) * (z ^ 3 + ζ * z ^ 2 * w + ζ ^ 2 * z * w ^ 2 + ζ ^ 3 * w ^ 3) +
          (1 + ζ ^ 4) * w ^ 4 := pair_with_remainder z w ζ
    _ = (z - ζ * w) * (z ^ 3 + ζ * z ^ 2 * w + ζ ^ 2 * z * w ^ 2 + ζ ^ 3 * w ^ 3) +
          (1 + (-1)) * w ^ 4 := by rw [hζ]
    _ = (z - ζ * w) * (z ^ 3 + ζ * z ^ 2 * w + ζ ^ 2 * z * w ^ 2 + ζ ^ 3 * w ^ 3) := by
        ring

/-- The constant polynomial satisfies the same relation as `ζ`. -/
theorem C_pow_four_eq_neg_one (ζ : ℂ) (hζ : ζ ^ 4 = -1) :
    (C ζ : CoordRing) ^ 4 = -1 := by
  rw [← map_pow, hζ]
  simp

/-- `+` associates left, so the three pairs are regrouped before rewriting. -/
theorem fermatQuartic_factors (ζ : ℂ) (hζ : ζ ^ 4 = -1) :
    fermatQuartic =
      (Xc Var.z0 - C ζ * Xc Var.z1) *
        (Xc Var.z0 ^ 3 + C ζ * Xc Var.z0 ^ 2 * Xc Var.z1 +
          (C ζ) ^ 2 * Xc Var.z0 * Xc Var.z1 ^ 2 + (C ζ) ^ 3 * Xc Var.z1 ^ 3) +
      (Xc Var.z2 - C ζ * Xc Var.z3) *
        (Xc Var.z2 ^ 3 + C ζ * Xc Var.z2 ^ 2 * Xc Var.z3 +
          (C ζ) ^ 2 * Xc Var.z2 * Xc Var.z3 ^ 2 + (C ζ) ^ 3 * Xc Var.z3 ^ 3) +
      (Xc Var.z4 - C ζ * Xc Var.z5) *
        (Xc Var.z4 ^ 3 + C ζ * Xc Var.z4 ^ 2 * Xc Var.z5 +
          (C ζ) ^ 2 * Xc Var.z4 * Xc Var.z5 ^ 2 + (C ζ) ^ 3 * Xc Var.z5 ^ 3) := by
  have hC := C_pow_four_eq_neg_one ζ hζ
  have h01 := pair_vanishing (Xc Var.z0) (Xc Var.z1) (C ζ) hC
  have h23 := pair_vanishing (Xc Var.z2) (Xc Var.z3) (C ζ) hC
  have h45 := pair_vanishing (Xc Var.z4) (Xc Var.z5) (C ζ) hC
  calc
    fermatQuartic =
        (Xc Var.z0 ^ 4 + Xc Var.z1 ^ 4) +
          (Xc Var.z2 ^ 4 + Xc Var.z3 ^ 4) +
          (Xc Var.z4 ^ 4 + Xc Var.z5 ^ 4) := by
      unfold fermatQuartic
      ring
    _ =
        (Xc Var.z0 - C ζ * Xc Var.z1) *
          (Xc Var.z0 ^ 3 + C ζ * Xc Var.z0 ^ 2 * Xc Var.z1 +
            (C ζ) ^ 2 * Xc Var.z0 * Xc Var.z1 ^ 2 + (C ζ) ^ 3 * Xc Var.z1 ^ 3) +
        (Xc Var.z2 - C ζ * Xc Var.z3) *
          (Xc Var.z2 ^ 3 + C ζ * Xc Var.z2 ^ 2 * Xc Var.z3 +
            (C ζ) ^ 2 * Xc Var.z2 * Xc Var.z3 ^ 2 + (C ζ) ^ 3 * Xc Var.z3 ^ 3) +
        (Xc Var.z4 - C ζ * Xc Var.z5) *
          (Xc Var.z4 ^ 3 + C ζ * Xc Var.z4 ^ 2 * Xc Var.z5 +
            (C ζ) ^ 2 * Xc Var.z4 * Xc Var.z5 ^ 2 + (C ζ) ^ 3 * Xc Var.z5 ^ 3) := by
      rw [h01, h23, h45]

/-- The Fermat quartic lies on the plane `surfaceZ1Ideal ζ` when `ζ ^ 4 = -1`.
Ideal membership, not a Hodge class. -/
theorem fermatQuartic_mem_surfaceZ1 (ζ : ℂ) (hζ : ζ ^ 4 = -1) :
    fermatQuartic ∈ surfaceZ1Ideal ζ := by
  rw [fermatQuartic_factors ζ hζ]
  refine Ideal.add_mem _ (Ideal.add_mem _ ?_ ?_) ?_
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (Or.inl rfl))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (Or.inr (Or.inl rfl)))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (Or.inr (Or.inr rfl)))

end FermatPlanes
end Hodge
