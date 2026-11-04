/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Mathlib

/-!
# Finite combinatorics behind the Delsarte sextic fourfold `X`

`X = V(F) ⊂ ℙ⁵`, `F = x0⁵x3 + x3⁶ + x1⁵x4 + x4⁶ + x2⁵x5 + x5⁶`.

This file re-checks in Lean the exact *finite* computations that were previously only
done in Python (`scripts/plane_intersections.py`, `scripts/hodge_rank.py`,
`scripts/hodge_classify.py`, `scripts/more_planes.py`).

**Scope (read this).** Lean verifies polynomial identities, finite enumerations and
integer linear algebra. It does **not** verify that
* the numbers `21, -4, 1, 0` are the intersection numbers of planes on `X`
  (excess intersection / Chern class computation, cited: Fulton),
* the 25 listed monomials are a basis of the Milnor algebra (Gröbner basis, Python),
* the character count equals `dim H⁴_prim(X,ℚ) ∩ H^{2,2}` (Griffiths residues and the
  Shioda character method, cited),
* the `D2`/`D24` criteria produce algebraic cycles (Shioda, Ran, Shioda–Katsura, Aoki,
  cited).
Those bridges are cited theory. All proofs here use `decide +kernel`, `ring`,
`linear_combination` or `norm_num`; no `native_decide`.
-/

namespace Hodge.SexticCombinatorics

/-! ## (a) Planes on `X` -/

/-- One pair `f(x,y) = x⁵y + y⁶`. -/
def f {R : Type*} [CommRing R] (x y : R) : R := x ^ 5 * y + y ^ 6

/-- The sextic in coordinates `(x0,x1,x2,x3,x4,x5)`. -/
def F {R : Type*} [CommRing R] (x0 x1 x2 x3 x4 x5 : R) : R :=
  f x0 x3 + f x1 x4 + f x2 x5

/-- Linear factor of a pair: `none` means `y = 0` (point `(s,0)`); `some η` means
`x = η y` (point `(η s, s)`). -/
def facPt {R : Type*} [CommRing R] : Option R → R → R × R
  | none, s => (s, 0)
  | some η, s => (η * s, s)

/-- A factor is admissible if it is `y` or `x - η y` with `η⁵ = -1`. -/
def Admissible {R : Type*} [CommRing R] : Option R → Prop
  | none => True
  | some η => η ^ 5 = -1

theorem f_facPt {R : Type*} [CommRing R] (c : Option R) (hc : Admissible c) (s : R) :
    f (facPt c s).1 (facPt c s).2 = 0 := by
  cases c with
  | none => simp [f, facPt]
  | some η =>
    simp only [f, facPt]
    have : η ^ 5 = -1 := hc
    linear_combination s ^ 6 * this

/-- Every standard plane `L₀ = L₁ = L₂ = 0` (one admissible factor per pair) lies on `X`,
over any commutative ring. Over `ℂ` there are `1 + 5 = 6` factors per pair, hence
`6³ = 216` standard planes. -/
theorem standard_plane_on_X {R : Type*} [CommRing R] (c₀ c₁ c₂ : Option R)
    (h₀ : Admissible c₀) (h₁ : Admissible c₁) (h₂ : Admissible c₂) (s₀ s₁ s₂ : R) :
    F (facPt c₀ s₀).1 (facPt c₁ s₁).1 (facPt c₂ s₂).1
      (facPt c₀ s₀).2 (facPt c₁ s₁).2 (facPt c₂ s₂).2 = 0 := by
  simp only [F, f_facPt _ h₀, f_facPt _ h₁, f_facPt _ h₂, add_zero]

/-- The factor labels per pair: `y` plus five roots of `η⁵ = -1`; `6³ = 216`. -/
theorem card_standard_labels : Fintype.card (Fin 3 → Option (Fin 5)) = 216 := by
  simp

/-- The 8 diagonal planes use only `y` or `x + y` (`η = -1`) per pair; all defined over `ℚ`. -/
theorem diagonal_plane_on_X (a b c : Bool) (s₀ s₁ s₂ : ℚ) :
    F (facPt (if a then some (-1) else none) s₀).1 (facPt (if b then some (-1) else none) s₁).1
      (facPt (if c then some (-1) else none) s₂).1 (facPt (if a then some (-1) else none) s₀).2
      (facPt (if b then some (-1) else none) s₁).2 (facPt (if c then some (-1) else none) s₂).2
      = 0 := by
  apply standard_plane_on_X <;> split <;> simp [Admissible] <;> norm_num

/-- Twisted planes: `x_B = λ x_A`, `y_B = μ y_A` with `μ⁶ = -1`, `λ⁵ μ = -1` kill `f_A + f_B`. -/
theorem twisted_pair_vanishes {R : Type*} [CommRing R] (lam mu x y : R)
    (hmu : mu ^ 6 = -1) (hlm : lam ^ 5 * mu = -1) :
    f x y + f (lam * x) (mu * y) = 0 := by
  simp only [f]
  linear_combination x ^ 5 * y * hlm + y ^ 6 * hmu


/-! ## (b) The 8×8 intersection matrix of the diagonal planes -/

/-- Number of pairs in which two diagonal planes (indexed by 3-bit labels) differ. -/
def hamming (i j : Fin 8) : ℕ :=
  ((List.range 3).filter fun b => (i.val ^^^ j.val).testBit b).length

/-- Combinatorial intersection rule: same plane `21`, line `-4`, point `1`, disjoint `0`. -/
def interVal : ℕ → ℤ
  | 0 => 21
  | 1 => -4
  | 2 => 1
  | _ => 0

def gram8 : Matrix (Fin 8) (Fin 8) ℤ := fun i j => interVal (hamming i j)

def M8 : Matrix (Fin 8) (Fin 8) ℤ :=
  !![21, -4, -4, 1, -4, 1, 1, 0;
     -4, 21, 1, -4, 1, -4, 0, 1;
     -4, 1, 21, -4, 1, 0, -4, 1;
     1, -4, -4, 21, 0, 1, 1, -4;
     -4, 1, 1, 0, 21, -4, -4, 1;
     1, -4, 0, 1, -4, 21, 1, -4;
     1, 0, -4, 1, -4, 1, 21, -4;
     0, 1, 1, -4, 1, -4, -4, 21]

theorem gram8_eq : gram8 = M8 := by
  ext i j; fin_cases i <;> fin_cases j <;> rfl

/-- Sylvester–Hadamard matrix (characters of `(ℤ/2)³`). -/
def H8 : Matrix (Fin 8) (Fin 8) ℤ := fun i j =>
  if ((List.range 3).filter fun b => (i.val &&& j.val).testBit b).length % 2 = 0 then 1 else -1

/-- Eigenvalues `12, 16, 24, 36` by character weight `0, 1, 2, 3`. -/
def eig (j : Fin 8) : ℤ :=
  match ((List.range 3).filter fun b => j.val.testBit b).length with
  | 0 => 12 | 1 => 16 | 2 => 24 | _ => 36

theorem H8_mul_self : H8 * H8 = (8 : ℤ) • (1 : Matrix (Fin 8) (Fin 8) ℤ) := by
  ext i j; revert i j; decide +kernel

theorem M8_mul_H8 : M8 * H8 = H8 * Matrix.diagonal eig := by
  ext i j; revert i j; decide +kernel

theorem det_ne_zero_of_mul_self {n : Type} [Fintype n] [DecidableEq n] {A : Matrix n n ℤ}
    (hA : A * A = (8 : ℤ) • (1 : Matrix n n ℤ)) : A.det ≠ 0 := by
  intro h
  have e := congrArg Matrix.det hA
  rw [Matrix.det_mul, h, Matrix.det_smul, Matrix.det_one] at e
  exact absurd e.symm (by simp)

theorem det_of_mul_eq {n : Type} [Fintype n] [DecidableEq n] {M H : Matrix n n ℤ} {D : n → ℤ}
    (hH : H.det ≠ 0) (h : M * H = H * Matrix.diagonal D) : M.det = ∏ j, D j := by
  have e := congrArg Matrix.det h
  rw [Matrix.det_mul, Matrix.det_mul, Matrix.det_diagonal, mul_comm H.det] at e
  exact mul_right_cancel₀ hH e

theorem det_H8_ne_zero : H8.det ≠ 0 := det_ne_zero_of_mul_self H8_mul_self

theorem prod_eig : ∏ j, eig j = 24461180928 := by decide +kernel

/-- `det = 24,461,180,928 = 12 · 16³ · 24³ · 36`. -/
theorem det_M8 : M8.det = 24461180928 :=
  (det_of_mul_eq det_H8_ne_zero M8_mul_H8).trans prod_eig

theorem det_gram8 : gram8.det = 24461180928 := by
  rw [gram8_eq]; exact det_M8

theorem rank_map_of_det_ne_zero {n : ℕ} {A : Matrix (Fin n) (Fin n) ℤ} (hA : A.det ≠ 0) :
    (A.map (Int.cast : ℤ → ℚ)).rank = n := by
  have hdet : (A.map (Int.cast : ℤ → ℚ)).det ≠ 0 := by
    rw [← Int.cast_det]; exact_mod_cast hA
  have hu : IsUnit (A.map (Int.cast : ℤ → ℚ)) :=
    (Matrix.isUnit_iff_isUnit_det _).2 (isUnit_iff_ne_zero.2 hdet)
  rw [Matrix.rank_of_isUnit _ hu, Fintype.card_fin]

/-- Rank 8 over `ℚ` (nonzero determinant). -/
theorem rank_gram8 : (gram8.map (Int.cast : ℤ → ℚ)).rank = 8 :=
  rank_map_of_det_ne_zero (by rw [det_gram8]; norm_num)




/-! ## (c) Character enumeration -/

/-- Standard monomials `x^a y^b` of the Milnor algebra of `f = x⁵y + y⁶` for the grevlex
Gröbner basis `{y⁶, x⁵ + 6y⁵, x⁴y}` (computed in Python; Lean takes this list as input). -/
def milnorBasis : List (ℕ × ℕ) :=
  [(0,0),(0,1),(0,2),(0,3),(0,4),(0,5),(1,0),(1,1),(1,2),(1,3),(1,4),(1,5),
   (2,0),(2,1),(2,2),(2,3),(2,4),(2,5),(3,0),(3,1),(3,2),(3,3),(3,4),(3,5),(4,0)]

/-- `G = ℤ/30` character of `x^a y^b`: `(a+1) - 5(b+1) mod 30`. -/
def chr (m : ℕ × ℕ) : ℕ := (m.1 + 1 + 150 - 5 * (m.2 + 1)) % 30

theorem milnorBasis_length : milnorBasis.length = 25 := by decide +kernel

/-- The character map is injective on the basis (multiplicity-free eigenspaces). -/
theorem chr_injective : (milnorBasis.map chr).Nodup := by decide +kernel

/-- Inverse of `chr` by arithmetic: the exponent `a` of the basis monomial with character `c`. -/
def aOf (c : ℕ) : ℕ := (c + 4) % 5
/-- The exponent `b` (meaningful only when `valid c`). -/
def bOf (c : ℕ) : ℕ := ((aOf c + 26 + 30 - c % 30) % 30) / 5

/-- `c` is the character of a basis monomial. -/
def valid (c : ℕ) : Bool :=
  decide (bOf c ≤ 5) && (decide (aOf c < 4) || bOf c == 0) && chr (aOf c, bOf c) == c

/-- The arithmetic inverse agrees with the basis list on all of `ℤ/30`. -/
theorem valid_iff : ∀ c < 30, (valid c = true ↔ c ∈ milnorBasis.map chr) := by decide +kernel
theorem valid_inverse : ∀ m ∈ milnorBasis, aOf (chr m) = m.1 ∧ bOf (chr m) = m.2 := by
  decide +kernel

/-- Degree of the basis monomial with character `c`. -/
def degC (c : ℕ) : ℕ := aOf c + bOf c

/-- Hodge index `q` of a primitive character triple; `99` if not primitive. -/
def qv (i j k : ℕ) : ℕ :=
  if valid i && valid j && valid k && (degC i + degC j + degC k) % 6 == 0
  then (degC i + degC j + degC k) / 6 else 99

/-- `Σ_{n < N} f n`, structural so the kernel reduces it. -/
def sumBelow : ℕ → (ℕ → ℕ) → ℕ
  | 0, _ => 0
  | n + 1, f => sumBelow n f + f n

def count3 (p : ℕ → ℕ → ℕ → Bool) : ℕ :=
  sumBelow 30 fun i => sumBelow 30 fun j => sumBelow 30 fun k => if p i j k then 1 else 0

/-- Primitive Hodge numbers `h^{4-q,q}_prim`, `q = 0..4`, and the total `2605`. -/
theorem primitive_hodge_numbers :
    count3 (fun i j k => qv i j k == 0) = 1 ∧ count3 (fun i j k => qv i j k == 1) = 426 ∧
    count3 (fun i j k => qv i j k == 2) = 1751 ∧ count3 (fun i j k => qv i j k == 3) = 426 ∧
    count3 (fun i j k => qv i j k == 4) = 1 := by decide +kernel

/-- Galois units `(ℤ/30)ˣ`. -/
def units30 : List ℕ := [1, 7, 11, 13, 17, 19, 23, 29]

theorem units30_spec : units30 = (List.range 30).filter (fun t => Nat.gcd t 30 = 1) := by
  decide +kernel

/-- Whole Galois orbit of `(i,j,k)` has type `(2,2)`: a rational primitive Hodge class. -/
def rationalHodge (i j k : ℕ) : Bool :=
  units30.all fun t => qv (t * i % 30) (t * j % 30) (t * k % 30) == 2

def code (i j k : ℕ) : ℕ := i * 900 + j * 30 + k

/-- Orbit representative: least code in its Galois orbit. -/
def isRep (i j k : ℕ) : Bool :=
  units30.all fun t => code i j k ≤ code (t * i % 30) (t * j % 30) (t * k % 30)

theorem rational_hodge_dim : count3 rationalHodge = 785 := by decide +kernel

theorem rational_hodge_orbits :
    count3 (fun i j k => rationalHodge i j k && isRep i j k) = 122 := by decide +kernel

/-- The gap to the 125-dimensional span of the 216 standard planes (rank from Python). -/
theorem gap_660 : (785 : ℕ) - 125 = 660 := by norm_num

/-! ### Classification via the Fermat cover `X⁴₃₀ → X` -/

/-- Fermat character of a pair with `X`-character `c`: `(6(a+1), -c) mod 30`. -/
def alphaPair (c : ℕ) : List ℕ := [6 * (aOf c + 1) % 30, (30 - c % 30) % 30]

def alpha (i j k : ℕ) : List ℕ := (alphaPair i ++ alphaPair j ++ alphaPair k).filter (· ≠ 0)

def hodgeTest (a : List ℕ) (n : ℕ) : Bool :=
  units30.all fun t => (a.map fun c => t * c % 30).sum == (n / 2 + 1) * 30

/-- Splits into zero-sum pairs (fuel = length bound). -/
def D2f : ℕ → List ℕ → Bool
  | _, [] => true
  | 0, _ :: _ => false
  | n + 1, a :: rest =>
    (List.range rest.length).any fun j =>
      (a + rest.getD j 0) % 30 == 0 && D2f n (rest.eraseIdx j)

def D2 (a : List ℕ) : Bool := D2f a.length a

def D24 (a : List ℕ) : Bool :=
  if a.length = 4 then hodgeTest a 2 else
  (List.range a.length).any fun i => (List.range a.length).any fun j =>
    decide (i < j) && (a.getD i 0 + a.getD j 0) % 30 == 0 &&
      hodgeTest (((List.range a.length).filter (fun k => k ≠ i ∧ k ≠ j)).map (a.getD · 0)) 2

def isD2 (i j k : ℕ) : Bool := rationalHodge i j k && D2 (alpha i j k)
def isD24 (i j k : ℕ) : Bool := rationalHodge i j k && !D2 (alpha i j k) && D24 (alpha i j k)

theorem split_425 : count3 isD2 = 425 := by decide +kernel
theorem split_360 : count3 isD24 = 360 := by decide +kernel
theorem split_orbits : count3 (fun i j k => isD2 i j k && isRep i j k) = 77 ∧
    count3 (fun i j k => isD24 i j k && isRep i j k) = 45 := by decide +kernel
theorem none_unclassified :
    count3 (fun i j k => rationalHodge i j k && !D2 (alpha i j k) && !D24 (alpha i j k)) = 0 := by
  decide +kernel

end Hodge.SexticCombinatorics
