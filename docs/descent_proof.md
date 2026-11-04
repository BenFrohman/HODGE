# Proof that every rational Hodge class on X is algebraic

X = V(F) ⊂ P^5, with F = Σ_{i=0}^{2} (x_i^5 y_i + y_i^6), where y_i := x_{i+3}. X is smooth (Lean: `Hodge/SpecialSextic.lean`).
F_30 = V(Σ u_i^30 + Σ v_i^30) ⊂ P^5 is the Fermat fourfold of degree 30.

**Theorem.** Every class in H^4(X,Q) ∩ H^{2,2} is algebraic. In other words, the Hodge conjecture holds for X.
Codimension 1 and 3 hold by Lefschetz (1,1) and hard Lefschetz, so this gives HC for X in all codimensions.

The proof is pen-and-paper and uses these cited theorems:
- (H) Hironaka's elimination of indeterminacy [Hironaka 1964, https://doi.org/10.2307/1970486].
- (B) The blowup formula [Voisin, *Hodge Theory and Complex Algebraic Geometry I*, Thm 7.31, https://doi.org/10.1017/CBO9780511615344].
- (L) Lefschetz (1,1).
- (P) Proper pushforward commutes with the cycle class map [Fulton, *Intersection Theory*, Ch. 19, https://doi.org/10.1007/978-1-4612-1700-8].
- (F) **HC for F_30.** Degrees 2^a3^b5^c are due to Shioda 1979 and Aoki 1983. We take this as stated in Miranda–Movasati–Rufino–Villaflor, arXiv:2609.27301, §1. Independently it follows from Kang's theorem that HC holds for all Fermat fourfolds [Bull. Aust. Math. Soc. 93 (2016), Cor. 3.2, as cited in arXiv:2609.27301, Rem. 3.9].
  *Caveat:* I did not read Aoki's or Kang's original proofs. (F) is used exactly as these sources state it.

## Step 1: the rational map
Put V = v_0v_1v_2 and define Φ: F_30 ⇢ X by
x_i = u_i^6 ∏_{j≠i} v_j and y_i = v_i^6 ∏_{j≠i} v_j. All components have degree 8.
Then x_i^5 y_i = u_i^30 V^6 and y_i^6 = v_i^30 V^6. So Φ^*F = V^6 · (Σu^30 + Σv^30), and Φ maps F_30 into X wherever it is defined.

**Dominance.** Take a point of X with all y_i ≠ 0. Choose v_i with v_i^5 = y_i and u_i with u_i^6 = x_i v_i. The point (u:v) lies on F_30 and maps to that point. So the image of Φ contains a dense open subset of X. Both varieties are irreducible fourfolds, so Φ is generically finite.

**Base locus.** It is contained in the base locus of the components on F_30:
- If V ≠ 0, Φ is defined.
- If exactly one v_i = 0, every component vanishes iff u_i = 0 as well.
- If two or more v_j = 0, every component vanishes.

So the base locus is S_i = F_30 ∩ {u_i = v_i = 0} (3 surfaces) together with T_{jk} = F_30 ∩ {v_j = v_k = 0} (3 surfaces). Each of these is a smooth Fermat surface of degree 30 in a P^3, and together they have codimension 2 in F_30.

## Step 2: resolution
By (H) there is a sequence F_30 = Y_0 ← Y_1 ← … ← Y_N = Ỹ of blowups along smooth irreducible centers Z_k ⊂ Y_k lying over the base locus, such that Φ∘p extends to a morphism q: Ỹ → X, where p: Ỹ → F_30 is the composite. The centers can be taken of codimension c_k ≥ 2, because blowing up a smooth divisor changes nothing. So dim Z_k ≤ 2. The map q is surjective (its image is closed and dense) and generically finite. Write d = deg q.

## Step 3: HC holds on H^4(Ỹ)
By (B), for a blowup Y' → Y along a smooth Z of codimension c:
H^4(Y') ≅ H^4(Y) ⊕ ⊕_{j=1}^{c-1} H^{4-2j}(Z)(-j).

This is an isomorphism of Hodge structures. The maps are π^* on the first summand and ι_*(ξ^{j-1} · π_E^*(–)) on the others, where E is the exceptional divisor, ξ = c_1(O_E(1)) and ι: E → Y'. These maps send algebraic classes to algebraic classes. So a Hodge class on Y' splits into Hodge components:
- On H^4(Y), it is algebraic by induction (base case: HC(F_30), from (F)).
- On H^{4-2j}(Z) with j ≥ 1, the degree is 2 or 0 because dim Z ≤ 2 (or the group is zero). Hodge classes in H^2 are algebraic by (L), and H^0 is spanned by [Z].

By induction on k, every Hodge class in H^4(Ỹ,Q) is algebraic.

## Step 4: descent
Let α be a Hodge class in H^4(X,Q). Then:
- q^*α is a Hodge class on Ỹ, so it is algebraic by Step 3.
- q_*q^*α = α ∪ q_*1 = d·α, by the projection formula.
- q_* takes algebraic classes to algebraic classes, by (P).

Hence α = (1/d) q_* q^*α is algebraic. ∎

## What this replaces
This proof covers all 785 dimensions uniformly. It does not use the per-orbit labels from `scripts/hodge_classify.py`. In particular, the heuristic reduction for the 193 dimensions with a trivial-character pair (the old "gap 2") is **no longer load-bearing**, and we do not claim it as proved.

## Explicit cycles (`scripts/more_planes.py`)
Besides the 216 coordinate planes there are 540 "twisted" planes:
x_B = λ x_A, y_B = μ y_A, L_C = 0, where μ^6 = −1, λ^5 μ = −1, A<B, and L_C is a linear factor of f_C.
The script verifies exactly, modulo Φ_60, that all of them lie in X. The exact Gram rank of ⟨h², 756 planes⟩ is 426, so the primitive span is **425**. It was 125 with the coordinate planes alone.
- 425 equals the dimension of the D2 orbits, but we do not prove that the two subspaces coincide.
- The remaining 785 − 425 = **360** dimensions are algebraic by the Theorem, but we have not exhibited explicit cycles for them.
