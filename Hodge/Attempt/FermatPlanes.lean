/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)
SPDX-License-Identifier: Apache-2.0
-/
import Mathlib.RingTheory.Ideal.Basic
import Mathlib.Algebra.MvPolynomial.Basic
import Mathlib.Data.Complex.Basic
import Mathlib.Tactic.Ring

/-!
# Fermat quartic planes with ζ^4 = -1

Easy arrow on one host. Not imported by `Hodge.lean`.
Constructors are `Var.z0`, not dotted `.z0`, so the expected type is explicit.
-/

namespace Hodge
namespace Attempt

inductive Var | z0 | z1 | z2 | z3 | z4 | z5
deriving DecidableEq

abbrev CoordRing := MvPolynomial Var ℂ

open MvPolynomial

noncomputable def fermatQuartic : CoordRing :=
  X Var.z0 ^ 4 + X Var.z1 ^ 4 + X Var.z2 ^ 4 +
    X Var.z3 ^ 4 + X Var.z4 ^ 4 + X Var.z5 ^ 4

noncomputable def surfaceZ1Ideal (ζ : ℂ) : Ideal CoordRing :=
  Ideal.span {
    X Var.z0 - C ζ * X Var.z1,
    X Var.z2 - C ζ * X Var.z3,
    X Var.z4 - C ζ * X Var.z5 }

noncomputable def surfaceZ2Ideal (ζ : ℂ) : Ideal CoordRing :=
  Ideal.span {
    X Var.z0 + C ζ * X Var.z1,
    X Var.z2 - C ζ * X Var.z3,
    X Var.z4 - C ζ * X Var.z5 }

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

end Attempt
end Hodge
