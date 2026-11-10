/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Mathlib
import Hodge.SpecialSextic
import Hodge.Klein
import Hodge.FermatPlanes

/-!
# Kernel checks of the explicit "algebraic span" claims

The Cycle Class Map records describe explicit algebraic surfaces on named fourfolds
(Klein quadric, `P²×P²`, Hassett cubic, Fermat quartic and quintic, chain sextic) and the
intersection numbers of their classes. This file checks, in the Lean kernel, every part of
those claims that is *algebra*:

* **(a) the surfaces lie on the fourfold**: polynomial identities and ideal membership;
* **(b) the intersection data is internally consistent**: exact Gram determinants, the
  Chern-class arithmetic behind `[Π]² = d² - 3d + 3`, degree checks such as
  `h⁴ = deg X`, disjointness of planes whose pairing is claimed to be `0`;
* **(c) linear algebra**: any family of vectors whose pairings form a Gram matrix with
  nonzero determinant is linearly independent, so it spans a space of the full rank.

## What this file does NOT prove

It does not prove that the cohomology class of any surface is the vector used here, i.e.
it does not formalize the cycle class map, Poincaré duality, the self-intersection formula,
or excess intersection. Those are the hypotheses of `GramRealization` below. Mathlib has no
singular cohomology of complex projective varieties, so the step

    "the surface Z lies on X"   ⟹   "the vector used for [Z] is the cycle class of Z"

is not machine-checked. Nothing here proves that a Hodge class is algebraic, and nothing
here touches the Hodge conjecture. Kernel checks are not algebraicity certificates.
-/

namespace Hodge
namespace AlgebraicSpanChecks

open Matrix

/-! ## Part (c): Gram determinant ⟹ linear independence (pure linear algebra) -/

section Gram

variable {M : Type*} [AddCommGroup M] [Module ℚ M]

/-- The Gram matrix of a family `v` for a bilinear form `B`. -/
def gramOf {n : ℕ} (B : M →ₗ[ℚ] M →ₗ[ℚ] ℚ) (v : Fin n → M) : Matrix (Fin n) (Fin n) ℚ :=
  Matrix.of fun i j => B (v i) (v j)

/-- A family whose Gram matrix has nonzero determinant is linearly independent over `ℚ`. -/
theorem linearIndependent_of_gram_det_ne_zero {n : ℕ} (B : M →ₗ[ℚ] M →ₗ[ℚ] ℚ)
    (v : Fin n → M) (h : (gramOf B v).det ≠ 0) : LinearIndependent ℚ v := by
  rw [Fintype.linearIndependent_iff]
  intro g hg
  have hv : g ᵥ* gramOf B v = 0 := by
    funext j
    have h1 := congrArg (fun x => B x (v j)) hg
    simp only [map_sum, map_smul, LinearMap.sum_apply, LinearMap.smul_apply, smul_eq_mul,
      map_zero, LinearMap.zero_apply] at h1
    simpa [Matrix.vecMul, dotProduct, gramOf] using h1
  have h0 := Matrix.eq_zero_of_vecMul_eq_zero h hv
  intro i
  simpa using congrFun h0 i

/-- Hence the span has rank exactly `n`. -/
theorem finrank_span_of_gram_det_ne_zero {n : ℕ} (B : M →ₗ[ℚ] M →ₗ[ℚ] ℚ)
    (v : Fin n → M) (h : (gramOf B v).det ≠ 0) :
    Module.finrank ℚ (Submodule.span ℚ (Set.range v)) = n := by
  rw [finrank_span_eq_card (linearIndependent_of_gram_det_ne_zero B v h)]
  simp

/-- **The geometric bridge, as an explicit hypothesis (NOT proved here).**
`H` stands for `H⁴(X, ℚ)`, `B` for the cup-product pairing, and `cls i` for the cycle class
of the `i`-th named surface. The field `gram` says that the cup products of these classes are
the claimed intersection numbers `G i j`. Lean does not check that `cls i` is a cycle class;
that needs the cycle class map, which Mathlib does not have. -/
structure GramRealization (H : Type*) [AddCommGroup H] [Module ℚ H] {n : ℕ}
    (G : Matrix (Fin n) (Fin n) ℚ) where
  B : H →ₗ[ℚ] H →ₗ[ℚ] ℚ
  cls : Fin n → H
  gram : ∀ i j, B (cls i) (cls j) = G i j

theorem GramRealization.finrank_span {H : Type*} [AddCommGroup H] [Module ℚ H] {n : ℕ}
    {G : Matrix (Fin n) (Fin n) ℚ} (D : GramRealization H G) (hG : G.det ≠ 0) :
    Module.finrank ℚ (Submodule.span ℚ (Set.range D.cls)) = n := by
  apply finrank_span_of_gram_det_ne_zero D.B D.cls
  have : gramOf D.B D.cls = G := by
    ext i j
    simp [gramOf, D.gram]
  rw [this]
  exact hG

/-- The bilinear form `v, w ↦ v ⬝ᵥ (G *ᵥ w)` on `Fin n → ℚ`. -/
def gramForm {n : ℕ} (G : Matrix (Fin n) (Fin n) ℚ) :
    (Fin n → ℚ) →ₗ[ℚ] (Fin n → ℚ) →ₗ[ℚ] ℚ :=
  LinearMap.mk₂ ℚ (fun v w => v ⬝ᵥ (G *ᵥ w))
    (fun v v' w => by simp [add_dotProduct])
    (fun c v w => by simp [smul_dotProduct])
    (fun v w w' => by simp [Matrix.mulVec_add, dotProduct_add])
    (fun c v w => by simp [Matrix.mulVec_smul, dotProduct_smul])

/-- Non-vacuity: every Gram matrix is realized (by the standard basis of `ℚⁿ`), so the
hypothesis structure `GramRealization` is never contradictory by itself. -/
def GramRealization.model {n : ℕ} (G : Matrix (Fin n) (Fin n) ℚ) :
    GramRealization (Fin n → ℚ) G where
  B := gramForm G
  cls := fun i => Pi.single i 1
  gram := by
    intro i j
    simp [gramForm, Matrix.mulVec_single, single_dotProduct]

/-- Determinant from an `LU` certificate: `G = L U`, `L` lower and `U` upper triangular. -/
theorem det_of_LU {n : ℕ} (L U G : Matrix (Fin n) (Fin n) ℚ) (hLU : L * U = G)
    (hL : L.BlockTriangular OrderDual.toDual) (hU : U.BlockTriangular id) :
    G.det = (∏ i, L i i) * (∏ i, U i i) := by
  rw [← hLU, Matrix.det_mul, Matrix.det_of_lowerTriangular _ hL,
    Matrix.det_of_upperTriangular hU]

end Gram

/-! ## Klein quadric `Q = Gr(2,4) ⊂ P⁵` -/

namespace Klein

open Hodge.Klein

/-- The Plücker quadric is smooth: its gradient
`(p23, -p13, p12, p03, -p02, p01)` vanishes only at the origin of the affine cone. -/
theorem plucker_smooth (v : Coord → ℚ)
    (h : v .p23 = 0 ∧ -v .p13 = 0 ∧ v .p12 = 0 ∧ v .p03 = 0 ∧ -v .p02 = 0 ∧ v .p01 = 0) :
    ∀ c, v c = 0 := by
  obtain ⟨h1, h2, h3, h4, h5, h6⟩ := h
  intro c
  cases c <;> simp_all

/-- `Π = {p12=p13=p23=0}` and `Π' = {p01=p02=p03=0}` are disjoint in `P⁵`
(their equations force every Plücker coordinate to vanish). This is the geometric reason
for the claimed value `[Π]·[Π'] = 0`. -/
theorem pi_pi'_disjoint (v : Coord → ℚ)
    (h : ∀ c ∈ piIdeal, v c = 0) (h' : ∀ c ∈ pi'Ideal, v c = 0) : ∀ c, v c = 0 := by
  intro c
  rcases ideals_cover c with hc | hc
  · exact h c hc
  · exact h' c hc

/-- A codimension-two linear section `Q ∩ {p12 = 0} ∩ {p13 = 0}` is the union of the
σ-plane `Π = {p12=p13=p23=0}` and the ρ-plane `Π'' = {p01=p12=p13=0}`
(lines in `z1 = 0`): on that `P³` the quadric equation is exactly `p01 · p23`.
This is the polynomial content of `h² = [Π] + [ρ-plane]`. -/
theorem h2_section_splits (v : Coord → ℚ) (h12 : v .p12 = 0) (h13 : v .p13 = 0) :
    pluckerEval v = 0 ↔ v .p01 = 0 ∨ v .p23 = 0 := by
  simp [pluckerEval, h12, h13, mul_eq_zero]

/-- The ρ-plane `Π''` lies on `Q`. -/
theorem rhoPlane_on_quadric (v : Coord → ℚ) (h01 : v .p01 = 0) (h12 : v .p12 = 0)
    (h13 : v .p13 = 0) : pluckerEval v = 0 := by
  simp [pluckerEval, h01, h12, h13]

/-- Two ρ-planes `Π' = {p01=p02=p03=0}` and `Π''` meet in the single point where only
`p23 ≠ 0` (the line `z0 = z1 = 0`), consistent with `[Π']² = 1`. -/
theorem rhoPlanes_meet_in_point (v : Coord → ℚ)
    (h01 : v .p01 = 0) (h02 : v .p02 = 0) (h03 : v .p03 = 0)
    (h12 : v .p12 = 0) (h13 : v .p13 = 0) : ∀ c, c ≠ .p23 → v c = 0 := by
  intro c hc
  cases c <;> simp_all

/-- Gram matrix of `([Π], [Π'])`. -/
def gram : Matrix (Fin 2) (Fin 2) ℚ := !![1, 0; 0, 1]

theorem gram_det : gram.det = 1 := by
  simp [gram, Matrix.det_fin_two]

/-- With `h² = [Π] + [Π']`: `h²·h² = 2 = deg Q` and `h²·[Π] = h²·[Π'] = 1 = deg plane`. -/
theorem degree_checks :
    ![1, 1] ⬝ᵥ (gram *ᵥ ![1, 1]) = (2 : ℚ) ∧
      ![1, 1] ⬝ᵥ (gram *ᵥ ![1, 0]) = (1 : ℚ) ∧
      ![1, 1] ⬝ᵥ (gram *ᵥ ![0, 1]) = (1 : ℚ) := by
  refine ⟨?_, ?_, ?_⟩ <;>
    norm_num [gram, dotProduct, Matrix.mulVec, Fin.sum_univ_two]

end Klein

/-! ## `P² × P²` -/

namespace ProductOfPlanes

/-- Gram matrix of `(h₁², h₁h₂, h₂²)` = classes of `{pt}×P²`, `line×line`, `P²×{pt}`,
computed in `ℚ[h₁,h₂]/(h₁³,h₂³)` with `h₁²h₂² = 1`. -/
def gram : Matrix (Fin 3) (Fin 3) ℚ := !![0, 0, 1; 0, 1, 0; 1, 0, 0]

theorem gram_det : gram.det = -1 := by
  simp [gram, Matrix.det_fin_three]

/-- `h = h₁ + h₂`, `h² = h₁² + 2h₁h₂ + h₂²`, and `h⁴ = 6 = deg(Segre P²×P² ⊂ P⁸)`. -/
theorem segre_degree : ![1, 2, 1] ⬝ᵥ (gram *ᵥ ![1, 2, 1]) = (6 : ℚ) := by
  simp [gram, dotProduct, Matrix.mulVec, Fin.sum_univ_three]
  norm_num

end ProductOfPlanes

/-! ## Chern-class arithmetic for a plane in a smooth degree-`d` hypersurface `X ⊂ P⁵` -/

namespace PlaneInHypersurface

/-- `c(N_{Π/X}) = (1+h)³ / (1+dh)` mod `h³`; the inverse of `1 + dh` mod `h³`. -/
theorem inverse_mod_h3 (d h : ℤ) :
    (1 + d * h) * (1 - d * h + d ^ 2 * h ^ 2) = 1 + d ^ 3 * h ^ 3 := by ring

/-- `(1 + 3h + 3h²)(1 - dh + d²h²) = 1 + (3 - d)h + (d² - 3d + 3)h² + O(h³)`. -/
theorem chern_product (d h : ℤ) :
    (1 + 3 * h + 3 * h ^ 2) * (1 - d * h + d ^ 2 * h ^ 2) =
      1 + (3 - d) * h + (d ^ 2 - 3 * d + 3) * h ^ 2 +
        (3 * d ^ 2 - 3 * d) * h ^ 3 + 3 * d ^ 2 * h ^ 4 := by ring

/-- `c₂(N_{Π/X}) = d² - 3d + 3`. -/
def selfIx (d : ℤ) : ℤ := d ^ 2 - 3 * d + 3

theorem selfIx_values : selfIx 3 = 3 ∧ selfIx 4 = 7 ∧ selfIx 5 = 13 ∧ selfIx 6 = 21 := by
  decide

/-- Excess intersection of two planes meeting along a line `L`:
`deg (N_{Π/X}|_L) - deg N_{L/Π'} = (3 - d) - 1 = 2 - d`. -/
def lineMeetIx (d : ℤ) : ℤ := (3 - d) - 1

theorem lineMeetIx_values : lineMeetIx 3 = -1 ∧ lineMeetIx 6 = -4 := by decide

end PlaneInHypersurface

/-! ## Hassett `C₈`: cubic fourfold containing the plane `Π = {x3=x4=x5=0}` -/

namespace HassettC8

/-- Any cubic of the form `x3·A + x4·B + x5·C` lies in the ideal of `Π`. -/
theorem cubic_mem_plane {R : Type*} [CommRing R] (x3 x4 x5 A B C : R) :
    x3 * A + x4 * B + x5 * C ∈ Ideal.span ({x3, x4, x5} : Set R) := by
  refine Ideal.add_mem _ (Ideal.add_mem _ ?_ ?_) ?_
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))

/-- Gram of `(h², [Π])`: `h⁴ = 3`, `h²·Π = 1`, `Π² = c₂(N) = 3`. -/
def gram : Matrix (Fin 2) (Fin 2) ℚ := !![3, 1; 1, PlaneInHypersurface.selfIx 3]

/-- Discriminant `8`, the label of Hassett's divisor `C₈`. -/
theorem gram_det : gram.det = 8 := by
  simp [gram, Matrix.det_fin_two, PlaneInHypersurface.selfIx]
  norm_num

end HassettC8

/-! ## Fermat quartic and quintic planes -/

namespace FermatQuartic

open MvPolynomial Hodge.FermatPlanes

/-- The second plane `Z₂ = {z0 + ζ z1 = z2 - ζ z3 = z4 - ζ z5 = 0}` also lies on the
Fermat quartic (only `Z₁` was proved in `Hodge.FermatPlanes`). -/
theorem fermatQuartic_mem_surfaceZ2 (ζ : ℂ) (hζ : ζ ^ 4 = -1) :
    fermatQuartic ∈ surfaceZ2Ideal ζ := by
  have hC : (C ζ : CoordRing) ^ 4 = -1 := C_pow_four_eq_neg_one ζ hζ
  have key : fermatQuartic =
      (Xc Var.z0 + C ζ * Xc Var.z1) *
          (Xc Var.z0 ^ 3 - C ζ * Xc Var.z0 ^ 2 * Xc Var.z1 +
            (C ζ) ^ 2 * Xc Var.z0 * Xc Var.z1 ^ 2 - (C ζ) ^ 3 * Xc Var.z1 ^ 3) +
        (Xc Var.z2 - C ζ * Xc Var.z3) *
          (Xc Var.z2 ^ 3 + C ζ * Xc Var.z2 ^ 2 * Xc Var.z3 +
            (C ζ) ^ 2 * Xc Var.z2 * Xc Var.z3 ^ 2 + (C ζ) ^ 3 * Xc Var.z3 ^ 3) +
        (Xc Var.z4 - C ζ * Xc Var.z5) *
          (Xc Var.z4 ^ 3 + C ζ * Xc Var.z4 ^ 2 * Xc Var.z5 +
            (C ζ) ^ 2 * Xc Var.z4 * Xc Var.z5 ^ 2 + (C ζ) ^ 3 * Xc Var.z5 ^ 3) := by
    have e : ∀ z w : CoordRing,
        (z + C ζ * w) * (z ^ 3 - C ζ * z ^ 2 * w + (C ζ) ^ 2 * z * w ^ 2 - (C ζ) ^ 3 * w ^ 3)
          = z ^ 4 - (C ζ) ^ 4 * w ^ 4 := fun z w => by ring
    have e' : ∀ z w : CoordRing,
        (z - C ζ * w) * (z ^ 3 + C ζ * z ^ 2 * w + (C ζ) ^ 2 * z * w ^ 2 + (C ζ) ^ 3 * w ^ 3)
          = z ^ 4 - (C ζ) ^ 4 * w ^ 4 := fun z w => by ring
    rw [e, e', e', hC]
    unfold fermatQuartic
    ring
  rw [key]
  refine Ideal.add_mem _ (Ideal.add_mem _ ?_ ?_) ?_
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (Or.inl rfl))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (Or.inr (Or.inl rfl)))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (Or.inr (Or.inr rfl)))

/-- Non-vacuity of the hypothesis `ζ ^ 4 = -1`. -/
theorem exists_root : ∃ ζ : ℂ, ζ ^ 4 = -1 :=
  IsAlgClosed.exists_pow_nat_eq (-1 : ℂ) (by norm_num)

/-- So both planes exist on the actual Fermat quartic over `ℂ`. -/
theorem two_planes_exist :
    ∃ ζ : ℂ, fermatQuartic ∈ surfaceZ1Ideal ζ ∧ fermatQuartic ∈ surfaceZ2Ideal ζ := by
  obtain ⟨ζ, hζ⟩ := exists_root
  exact ⟨ζ, fermatQuartic_mem_surfaceZ1 ζ hζ, fermatQuartic_mem_surfaceZ2 ζ hζ⟩

end FermatQuartic

namespace FermatQuintic

/-- The Fermat quintic `Σ xᵢ⁵` contains the plane `{x0 = -x1, x2 = -x3, x4 = -x5}`
(over any commutative ring, since `(-1)⁵ = -1`). -/
theorem quintic_mem_plane {R : Type*} [CommRing R] (x0 x1 x2 x3 x4 x5 : R) :
    x0 ^ 5 + x1 ^ 5 + x2 ^ 5 + x3 ^ 5 + x4 ^ 5 + x5 ^ 5 ∈
      Ideal.span ({x0 + x1, x2 + x3, x4 + x5} : Set R) := by
  have key : x0 ^ 5 + x1 ^ 5 + x2 ^ 5 + x3 ^ 5 + x4 ^ 5 + x5 ^ 5 =
      (x0 + x1) * (x0 ^ 4 - x0 ^ 3 * x1 + x0 ^ 2 * x1 ^ 2 - x0 * x1 ^ 3 + x1 ^ 4) +
      (x2 + x3) * (x2 ^ 4 - x2 ^ 3 * x3 + x2 ^ 2 * x3 ^ 2 - x2 * x3 ^ 3 + x3 ^ 4) +
      (x4 + x5) * (x4 ^ 4 - x4 ^ 3 * x5 + x4 ^ 2 * x5 ^ 2 - x4 * x5 ^ 3 + x5 ^ 4) := by ring
  rw [key]
  refine Ideal.add_mem _ (Ideal.add_mem _ ?_ ?_) ?_
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (by simp))

end FermatQuintic

/-! ## The chain sextic `F = x0⁵x3 + x3⁶ + x1⁵x4 + x4⁶ + x2⁵x5 + x5⁶` -/

namespace ChainSextic

open Hodge.SpecialSextic

section Poly

variable {R : Type*} [CommRing R]

/-- Generator of one block `(head, tail)` of a diagonal plane:
`tail = 0` (choice `false`) or `head + tail = 0` (choice `true`). -/
def blockGen (b : Bool) (hd tl : R) : R := if b then hd + tl else tl

/-- Each block term `tail·(head⁵ + tail⁵)` is a multiple of either generator. -/
theorem block_term_factor (b : Bool) (hd tl : R) :
    ∃ q : R, tl * (hd ^ 5 + tl ^ 5) = blockGen b hd tl * q := by
  cases b
  · exact ⟨hd ^ 5 + tl ^ 5, by simp [blockGen]⟩
  · refine ⟨tl * (hd ^ 4 - hd ^ 3 * tl + hd ^ 2 * tl ^ 2 - hd * tl ^ 3 + tl ^ 4), ?_⟩
    simp [blockGen]
    ring

/-- Ideal of the diagonal plane indexed by `a : Fin 3 → Bool`
(blocks `(x0,x3)`, `(x1,x4)`, `(x2,x5)`). `a = false` everywhere is `Π`,
`a = true` everywhere is `Π_{-1}`. -/
def diagPlaneIdeal (a : Fin 3 → Bool) (x0 x1 x2 x3 x4 x5 : R) : Ideal R :=
  Ideal.span {blockGen (a 0) x0 x3, blockGen (a 1) x1 x4, blockGen (a 2) x2 x5}

/-- All eight diagonal planes lie on `V(F)`. -/
theorem F_mem_diagPlane (a : Fin 3 → Bool) (x0 x1 x2 x3 x4 x5 : R) :
    F x0 x1 x2 x3 x4 x5 ∈ diagPlaneIdeal a x0 x1 x2 x3 x4 x5 := by
  obtain ⟨q0, h0⟩ := block_term_factor (a 0) x0 x3
  obtain ⟨q1, h1⟩ := block_term_factor (a 1) x1 x4
  obtain ⟨q2, h2⟩ := block_term_factor (a 2) x2 x5
  rw [F_factors, h0, h1, h2]
  refine Ideal.add_mem _ (Ideal.add_mem _ ?_ ?_) ?_
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (Or.inl rfl))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (Or.inr (Or.inl rfl)))
  · exact Ideal.mul_mem_right _ _ (Ideal.subset_span (Or.inr (Or.inr rfl)))

theorem diagPlane_false (x0 x1 x2 x3 x4 x5 : R) :
    diagPlaneIdeal (fun _ => false) x0 x1 x2 x3 x4 x5 =
    planeIdeal x3 x4 x5 := rfl

theorem diagPlane_true (x0 x1 x2 x3 x4 x5 : R) :
    diagPlaneIdeal (fun _ => true) x0 x1 x2 x3 x4 x5 =
    planeIdealMinus1 x0 x1 x2 x3 x4 x5 := rfl

/-- In a block where two diagonal planes make different choices, a common point has
both coordinates of that block equal to `0`. -/
theorem block_differ (hd tl : R) (h1 : blockGen false hd tl = 0)
    (h2 : blockGen true hd tl = 0) : hd = 0 ∧ tl = 0 := by
  have h1' : tl = 0 := by simpa [blockGen] using h1
  have h2' : hd + tl = 0 := by simpa [blockGen] using h2
  rw [h1', add_zero] at h2'
  exact ⟨h2', h1'⟩

/-- `Π ∩ Π_{-1} = ∅` in `P⁵`: the six linear equations force the origin.
This is the geometric reason for the claimed value `[Π]·[Π_{-1}] = 0`. -/
theorem pi_piMinus1_disjoint (x0 x1 x2 x3 x4 x5 : R)
    (h3 : x3 = 0) (h4 : x4 = 0) (h5 : x5 = 0)
    (g0 : x0 + x3 = 0) (g1 : x1 + x4 = 0) (g2 : x2 + x5 = 0) :
    x0 = 0 ∧ x1 = 0 ∧ x2 = 0 ∧ x3 = 0 ∧ x4 = 0 ∧ x5 = 0 := by
  subst h3 h4 h5
  simp_all

/-- The `P³ = {x4 = x5 = 0}` through `Π` cuts `X` in `Π` plus the quintic surface
`S = {x4 = x5 = 0, x0⁵ + x3⁵ = 0}`; so `h² = [Π] + [S]` with `deg S = 5 = h²·[S]`. -/
theorem residual_factor (x0 x1 x2 x3 : R) :
    F x0 x1 x2 x3 0 0 = x3 * (x0 ^ 5 + x3 ^ 5) := by
  unfold F; ring

theorem residual_split [IsDomain R] (x0 x1 x2 x3 : R) :
    F x0 x1 x2 x3 0 0 = 0 ↔ x3 = 0 ∨ x0 ^ 5 + x3 ^ 5 = 0 := by
  rw [residual_factor, mul_eq_zero]

end Poly

/-! ### Coordinate linear spaces -/

/-- `F` as a function of a point of `ℤ⁶`. -/
def Fv (x : Fin 6 → ℤ) : ℤ := F (x 0) (x 1) (x 2) (x 3) (x 4) (x 5)

/-- The point with coordinate `0` on `T` and `1` elsewhere; it lies on `V(x_i : i ∈ T)`. -/
def coordPt (T : Finset (Fin 6)) : Fin 6 → ℤ := fun i => if i ∈ T then 0 else 1

/-- Of the 20 coordinate planes `V(xi, xj, xk)`, the test point is a zero of `F` exactly
for `{x3, x4, x5}`; for the other 19 it is a point of the plane where `F = ` a positive
integer, so that plane is not contained in `X` (over any field of characteristic 0). -/
theorem coordinate_planes :
    ∀ T ∈ (Finset.univ : Finset (Fin 6)).powersetCard 3,
      (Fv (coordPt T) = 0 ↔ T = {3, 4, 5}) := by
  decide

/-- No coordinate `P³ = V(xi, xj)` lies on `X`. -/
theorem no_coordinate_P3 :
    ∀ T ∈ (Finset.univ : Finset (Fin 6)).powersetCard 2, Fv (coordPt T) ≠ 0 := by
  decide

/-- Transport of a nonzero integer value to any characteristic-zero field. -/
theorem F_cast {K : Type*} [Field K] [CharZero K] (x : Fin 6 → ℤ) (h : Fv x ≠ 0) :
    F (x 0 : K) (x 1) (x 2) (x 3) (x 4) (x 5) ≠ 0 := by
  have : F (x 0 : K) (x 1) (x 2) (x 3) (x 4) (x 5) = ((Fv x : ℤ) : K) := by
    simp [Fv, F]
  rw [this]
  exact_mod_cast h

/-! ### Gram matrices -/

/-- Gram of `(h², [Π])`. -/
def gram2 : Matrix (Fin 2) (Fin 2) ℚ := !![6, 1; 1, 21]

theorem gram2_det : gram2.det = 125 := by
  simp [gram2, Matrix.det_fin_two]; norm_num

/-- Gram of `(h², [Π], [Π_{-1}])`, with `[Π]·[Π_{-1}] = 0` (disjoint planes). -/
def gram3 : Matrix (Fin 3) (Fin 3) ℚ := !![6, 1, 1; 1, 21, 0; 1, 0, 21]

/-- The actual determinant (the repository previously recorded only the numeral identity
`6·21·21 - 21 - 21 = 2604`). -/
theorem gram3_det : gram3.det = 2604 := by
  simp [gram3, Matrix.det_fin_three]; norm_num

/-- Intersection rule for the eight diagonal planes: `21` (same plane), `-4` (differ in one
block: meet in a line, `2 - d`), `1` (differ in two blocks: meet in a point), `0` (differ in
all three: disjoint). -/
def ixRule : ℕ → ℤ
  | 0 => 21
  | 1 => -4
  | 2 => 1
  | _ => 0

/-- Number of blocks where planes `i` and `j` (bits of `i, j : Fin 8`) choose differently. -/
def blockDist (i j : Fin 8) : ℕ :=
  ((List.range 3).filter fun k => i.val.testBit k != j.val.testBit k).length

def gram8Z : Matrix (Fin 8) (Fin 8) ℤ := !![21, -4, -4, 1, -4, 1, 1, 0; -4, 21, 1, -4, 1, -4, 0, 1; -4, 1, 21, -4, 1, 0, -4, 1; 1, -4, -4, 21, 0, 1, 1, -4; -4, 1, 1, 0, 21, -4, -4, 1; 1, -4, 0, 1, -4, 21, 1, -4; 1, 0, -4, 1, -4, 1, 21, -4; 0, 1, 1, -4, 1, -4, -4, 21]

/-- The literal matrix (the one printed in `scripts/plane_intersections.out`) is exactly the
rule above. -/
theorem gram8Z_rule : ∀ i j, gram8Z i j = ixRule (blockDist i j) := by decide

def gram8 : Matrix (Fin 8) (Fin 8) ℚ := !![21, (-4), (-4), 1, (-4), 1, 1, 0; (-4), 21, 1, (-4), 1, (-4), 0, 1; (-4), 1, 21, (-4), 1, 0, (-4), 1; 1, (-4), (-4), 21, 0, 1, 1, (-4); (-4), 1, 1, 0, 21, (-4), (-4), 1; 1, (-4), 0, 1, (-4), 21, 1, (-4); 1, 0, (-4), 1, (-4), 1, 21, (-4); 0, 1, 1, (-4), 1, (-4), (-4), 21]

theorem gram8_eq_cast : ∀ i j, gram8 i j = (gram8Z i j : ℚ) := by
  intro i j
  fin_cases i <;> fin_cases j <;> simp [gram8, gram8Z]

def L8 : Matrix (Fin 8) (Fin 8) ℚ := !![1, 0, 0, 0, 0, 0, 0, 0; (-4/21), 1, 0, 0, 0, 0, 0, 0; (-4/21), (1/85), 1, 0, 0, 0, 0, 0; (1/21), (-16/85), (-8/43), 1, 0, 0, 0, 0; (-4/21), (1/85), (1/86), (1/70), 1, 0, 0, 0; (1/21), (-16/85), (1/86), (1/70), (-11/59), 1, 0, 0; (1/21), (4/425), (-81/430), (1/70), (-11/59), (1/60), 1, 0; 0, (21/425), (21/430), (-13/70), (3/59), (-11/60), (-11/61), 1]
def U8 : Matrix (Fin 8) (Fin 8) ℚ := !![21, (-4), (-4), 1, (-4), 1, 1, 0; 0, (425/21), (5/21), (-80/21), (5/21), (-80/21), (4/21), 1; 0, 0, (344/17), (-64/17), (4/17), (4/17), (-324/85), (84/85); 0, 0, 0, (840/43), (12/43), (12/43), (12/43), (-156/43); 0, 0, 0, 0, (708/35), (-132/35), (-132/35), (36/35); 0, 0, 0, 0, 0, (1152/59), (96/295), (-1056/295); 0, 0, 0, 0, 0, 0, (488/25), (-88/25); 0, 0, 0, 0, 0, 0, 0, (1152/61)]

set_option maxHeartbeats 20000000 in
theorem L8_mul_U8 : L8 * U8 = gram8 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [L8, U8, gram8, Matrix.mul_apply, Fin.sum_univ_succ]

theorem L8_lower : L8.BlockTriangular OrderDual.toDual := by
  intro i j hij
  rw [OrderDual.toDual_lt_toDual] at hij
  fin_cases i <;> fin_cases j <;> simp [L8] at hij ⊢

theorem U8_upper : U8.BlockTriangular id := by
  intro i j hij
  fin_cases i <;> fin_cases j <;> simp [U8] at hij ⊢

/-- Exact determinant of the 8×8 plane Gram matrix. -/
theorem L8_diag : ∏ i, L8 i i = 1 := by
  simp [Fin.prod_univ_succ, L8]

theorem U8_diag : ∏ i, U8 i i = 24461180928 := by
  simp [Fin.prod_univ_succ, U8]
  norm_num

theorem gram8_det : gram8.det = 24461180928 := by
  rw [det_of_LU L8 U8 gram8 L8_mul_U8 L8_lower U8_upper, L8_diag, U8_diag,
    one_mul]

/-- Gram of `(h², Π_0, …, Π_7)` with `h⁴ = 6`, `h²·Π_i = 1`. -/
def gram9 : Matrix (Fin 9) (Fin 9) ℚ := !![6, 1, 1, 1, 1, 1, 1, 1, 1; 1, 21, (-4), (-4), 1, (-4), 1, 1, 0; 1, (-4), 21, 1, (-4), 1, (-4), 0, 1; 1, (-4), 1, 21, (-4), 1, 0, (-4), 1; 1, 1, (-4), (-4), 21, 0, 1, 1, (-4); 1, (-4), 1, 1, 0, 21, (-4), (-4), 1; 1, 1, (-4), 0, 1, (-4), 21, 1, (-4); 1, 1, 0, (-4), 1, (-4), 1, 21, (-4); 1, 0, 1, 1, (-4), 1, (-4), (-4), 21]

def L9 : Matrix (Fin 9) (Fin 9) ℚ := !![1, 0, 0, 0, 0, 0, 0, 0, 0; (1/6), 1, 0, 0, 0, 0, 0, 0, 0; (1/6), (-1/5), 1, 0, 0, 0, 0, 0, 0; (1/6), (-1/5), 0, 1, 0, 0, 0, 0, 0; (1/6), (1/25), (-1/5), (-1/5), 1, 0, 0, 0, 0; (1/6), (-1/5), 0, 0, 0, 1, 0, 0, 0; (1/6), (1/25), (-1/5), 0, 0, (-1/5), 1, 0, 0; (1/6), (1/25), 0, (-1/5), 0, (-1/5), 0, 1, 0; (1/6), (-1/125), (1/25), (1/25), (-1/5), (1/25), (-1/5), (-1/5), 1]
def U9 : Matrix (Fin 9) (Fin 9) ℚ := !![6, 1, 1, 1, 1, 1, 1, 1, 1; 0, (125/6), (-25/6), (-25/6), (5/6), (-25/6), (5/6), (5/6), (-1/6); 0, 0, 20, 0, (-4), 0, (-4), 0, (4/5); 0, 0, 0, 20, (-4), 0, 0, (-4), (4/5); 0, 0, 0, 0, (96/5), 0, 0, 0, (-96/25); 0, 0, 0, 0, 0, 20, (-4), (-4), (4/5); 0, 0, 0, 0, 0, 0, (96/5), 0, (-96/25); 0, 0, 0, 0, 0, 0, 0, (96/5), (-96/25); 0, 0, 0, 0, 0, 0, 0, 0, (2304/125)]

set_option maxHeartbeats 20000000 in
theorem L9_mul_U9 : L9 * U9 = gram9 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [L9, U9, gram9, Matrix.mul_apply, Fin.sum_univ_succ]

theorem L9_lower : L9.BlockTriangular OrderDual.toDual := by
  intro i j hij
  rw [OrderDual.toDual_lt_toDual] at hij
  fin_cases i <;> fin_cases j <;> simp [L9] at hij ⊢

theorem U9_upper : U9.BlockTriangular id := by
  intro i j hij
  fin_cases i <;> fin_cases j <;> simp [U9] at hij ⊢

theorem L9_diag : ∏ i, L9 i i = 1 := by
  simp [Fin.prod_univ_succ, L9]

theorem U9_diag : ∏ i, U9 i i = 130459631616 := by
  simp [Fin.prod_univ_succ, U9]
  norm_num

theorem gram9_det : gram9.det = 130459631616 := by
  rw [det_of_LU L9 U9 gram9 L9_mul_U9 L9_lower U9_upper, L9_diag, U9_diag,
    one_mul]

/-- **Conditional rank statement.** If the classes `h², [Π_0], …, [Π_7]` in `H⁴(X, ℚ)` have
the claimed cup products (hypothesis `D`, not proved here), they span a rank-9 subspace. -/
theorem rank_nine {H : Type*} [AddCommGroup H] [Module ℚ H] (D : GramRealization H gram9) :
    Module.finrank ℚ (Submodule.span ℚ (Set.range D.cls)) = 9 :=
  D.finrank_span (by rw [gram9_det]; norm_num)

theorem rank_three {H : Type*} [AddCommGroup H] [Module ℚ H] (D : GramRealization H gram3) :
    Module.finrank ℚ (Submodule.span ℚ (Set.range D.cls)) = 3 :=
  D.finrank_span (by rw [gram3_det]; norm_num)

end ChainSextic

/-! ## Conditional rank statements for the other named fourfolds -/

theorem klein_rank_two {H : Type*} [AddCommGroup H] [Module ℚ H]
    (D : GramRealization H Klein.gram) :
    Module.finrank ℚ (Submodule.span ℚ (Set.range D.cls)) = 2 :=
  D.finrank_span (by rw [Klein.gram_det]; norm_num)

theorem productOfPlanes_rank_three {H : Type*} [AddCommGroup H] [Module ℚ H]
    (D : GramRealization H ProductOfPlanes.gram) :
    Module.finrank ℚ (Submodule.span ℚ (Set.range D.cls)) = 3 :=
  D.finrank_span (by rw [ProductOfPlanes.gram_det]; norm_num)

theorem hassettC8_rank_two {H : Type*} [AddCommGroup H] [Module ℚ H]
    (D : GramRealization H HassettC8.gram) :
    Module.finrank ℚ (Submodule.span ℚ (Set.range D.cls)) = 2 :=
  D.finrank_span (by rw [HassettC8.gram_det]; norm_num)

/-- Non-vacuity: the rank-9 hypothesis is satisfiable (standard basis of `ℚ⁹`). -/
theorem rank_nine_nonvacuous :
    Module.finrank ℚ (Submodule.span ℚ (Set.range (GramRealization.model ChainSextic.gram9).cls))
      = 9 :=
  ChainSextic.rank_nine _

end AlgebraicSpanChecks
end Hodge
