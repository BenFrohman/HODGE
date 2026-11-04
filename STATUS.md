# Status: chain sextic X = V(F) ⊂ P^5

F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6 (`Hodge/SpecialSextic.lean`), smooth
(`gradient_only_origin`). Each pair contributes y(x^5+y^5) = y·∏(x − ηy), η^5 = −1, so X
contains 6^3 = 216 planes; the 8 diagonal planes Π_abc (a,b,c ∈ {0,−1}: y = 0 or x + y = 0
per pair) are defined over Q.

## Plane intersections (`scripts/plane_intersections.py`, exact)

Planes differing in k pairs: k=0 → Π² = c₂(N) = 21 (c(N) = (1+h)³/(1+6h));
k=1 (meet in a line, excess formula) → −3 − 1 = −4; k=2 (one transverse point) → 1; k=3 → 0.
h²·h² = 6, h²·Π = 1. The 8×8 matrix of Π_abc has det 24461180928, rank 8;
⟨h², Π_abc⟩ has rank 9. All 216 planes with h²: rank 126 (primitive 125).

## Hodge classes (`scripts/hodge_rank.py`, exact)

Griffiths residues + the (Z/30)³ diagonal symmetry give a multiplicity-free character
decomposition of H⁴_prim (1, 426, 1751, 426, 1). Galois orbits under (Z/30)^* entirely of
type (2,2): dim H⁴_prim(X,Q) ∩ H^{2,2} = **785**, so ρ₂(X) = 786.

**Z (Hodge classes outside the span of h² and the 216 planes) has dimension 785 − 125 = 660.**
That is an exact count, not a proof either way: whether those 660 dimensions are algebraic
(other cycles than planes) is not decided here. The Hodge conjecture for X is not claimed.

## Classification of the 785 Hodge dimensions (`scripts/hodge_classify.py`, exact)

Pulling each eigenclass of X back along the cover X^4_30 ⇢ X (see below) gives a Fermat character α ∈ (Z/30)^6
for each of the 122 Galois orbits. For 193 of the 785 dimensions, a pair carries the trivial
character (0,0) (the residue of x^4). In those cases we classify the reduced character of length 4 or 2.
This step is a heuristic identification with a lower-dimensional Fermat piece, not a proved pullback.
The script checks that every orbit passes Shioda's Hodge test on the cover. Results:

| criterion | orbits | dim |
|---|---|---|
| D2: α splits into three pairs a+b≡0 (Shioda's decomposable / linear-cycle type [1,6]) | 77 | 425 |
| D24: one pair a+b≡0 plus a Hodge surface quadruple (Shioda–Katsura inductive structure + Lefschetz (1,1) [2]) | 45 | 360 |
| unclassified (no known cycle by these criteria) | 0 | 0 |

So every Hodge class of X, and hence all of the 660 classes not spanned by planes, corresponds to a
character that is algebraic on the Fermat cover by Shioda's classical criteria. The planes account for
only 125 of the 425 D2 dimensions. **Verdict: hit.** `docs/descent_proof.md` proves HC for X from cited theorems, the key one being HC for the degree-30 Fermat fourfold (Shioda/Aoki). The per-orbit labels are informational only. That
argument (rational-map resolution plus pushforward) is our own sketch and has not been refereed. The
193-dimension trivial-pair identification is also heuristic. No class is shown to be non-algebraic,
because no method could show that. No explicit cycles on X are written down.

## Explicit cycles (`scripts/more_planes.py`, exact)

The 540 twisted planes x_B=λx_A, y_B=μy_A, L_C=0 (μ^6=−1, λ^5μ=−1) together with the 216 coordinate planes span a primitive space of rank **425** (Gram rank 426 with h²). The 360 remaining dimensions are algebraic by the descent theorem, but no explicit cycles are known for them.

## Related results

**What is known.** Shioda's character method [1–3] expresses the primitive Hodge classes of Fermat
varieties X^n_m, and of Delsarte varieties (sums of n+2 monomials with an invertible exponent matrix),
through characters of a diagonal group. Shioda proved the Hodge conjecture (HC) for X^n_m when m ≤ 20
or m is prime [1,3]. Aoki [4,5] and Ran [6] produced further cycles, and HC is known for every
Fermat X^n_m whose degree has the form 2^a3^b5^c [4,9]. For the Fermat *sextic* fourfold X^4_6 the
primitive Hodge space has dimension 1751, and an explicit basis of algebraic classes is known: 1001 linear
cycles (planes), 720 Aoki–Shioda cycles and 30 further cycles [7, Thm 1]. So on X^4_6 the planes alone
do **not** span the Hodge classes either. Recent work extends HC to all Fermat X^n_m with m < 65 except
m = 44, 51, 52, including weighted Fermat varieties [9, Thm 1.1]. It also cites Kang [8] for HC on all
Fermat fourfolds [9, Rem. 3.9]. Note that [10] and [11] still treat some Fermat-fourfold degrees as open,
so we do not rely on [8]. Lines generate Pic of Fermat surfaces only when m ≤ 4 or gcd(m,6) = 1 [12].

**How this bears on Z = 660.** No source we found treats our X (the chain-type sextic
x0^5x3+x3^6+…) directly, and the numbers 785 and 660 are not in the literature that we know of. X is
a Delsarte hypersurface, and the monomial map (x_i, x_{i+3}) = (u_i^6/v_i, v_i^5) pulls F back to the
Fermat polynomial Σu_i^30 + Σv_i^30. That gives a dominant **rational** map X^4_30 ⇢ X (Shioda's
covering [13]). HC holds for X^4_30, since 30 = 2·3·5 [4,9]. *Our argument, sketched here and not refereed:*
1. Resolve the map by blowups along smooth centers of dimension ≤ 2 to get Ỹ → X^4_30. The blowup
   formula adds only H^2 and H^0 of those centers to H^4, and those classes are algebraic by
   Lefschetz (1,1). So HC holds for Ỹ.
2. Ỹ → X is generically finite, so f_*f^* = deg f on H^4(X). Every Hodge class on X is therefore
   algebraic.

If this argument holds, HC holds for X and the 660 classes are algebraic. They come from cycles that are
not planes (pushforwards of Aoki/Shioda-type cycles), which matches the picture on X^4_6. Explicit cycles
for the 660 and any integral statement remain **unknown**. This repository does not formalize this
argument.

## References

1. T. Shioda, *The Hodge conjecture for Fermat varieties*, Math. Ann. 245 (1979) 175–184 (Crossref
   pages; EuDML lists 175–198). https://doi.org/10.1007/BF01428804
2. T. Shioda, T. Katsura, *On Fermat varieties*, Tohoku Math. J. 31 (1979) 97–115. https://doi.org/10.2748/tmj/1178229881
3. T. Shioda, *The Hodge conjecture and the Tate conjecture for Fermat varieties*, Proc. Japan Acad. 55A (1979) 111–114. https://doi.org/10.3792/pjaa.55.111
4. N. Aoki, *On some arithmetic problems related to the Hodge cycles on the Fermat varieties*, Math. Ann. 266 (1983) 23–54; erratum 267 (1984) 572. https://doi.org/10.1007/BF01458703
5. N. Aoki, *Some new algebraic cycles on Fermat varieties*, J. Math. Soc. Japan 39 (1987) 385–396. https://doi.org/10.2969/jmsj/03930385
6. Z. Ran, *Cycles on Fermat hypersurfaces*, Compositio Math. 42 (1980) 121–142.
7. A. P. Braun, H. Fortin, D. Lopez Garcia, R. Villaflor Loyola, *More on G-flux and general Hodge cycles on the Fermat sextic*, JHEP 06 (2024) 046. https://doi.org/10.1007/JHEP06(2024)046, arXiv:2401.00470
8. S.-J. Kang, *Refined motivic dimension of some Fermat varieties*, Bull. Aust. Math. Soc. 93 (2016) 223–230. https://doi.org/10.1017/S0004972715001379
9. Miranda, Movasati, Rufino, Villaflor, *Lengths of Hodge characters in Fermat varieties*, preprint (2026). https://arxiv.org/abs/2609.27301
10. G. da Silva Jr., *Notes on the Hodge conjecture for Fermat varieties*, Experimental Results 2 (2021) e22. https://www.cambridge.org/core/journals/experimental-results/article/notes-on-the-hodge-conjecture-for-fermat-varieties/214625A5A650A760059F9C06D92A196D
11. *The Hodge conjecture for Fermat fourfolds of odd degree at most 199*, preprint (2026). https://arxiv.org/abs/2608.18134
12. A. Degtyarev, *Lines generate the Picard groups of certain Fermat surfaces*, J. Number Theory 147 (2015) 454–477. https://doi.org/10.1016/j.jnt.2014.07.020
13. T. Shioda, *An explicit algorithm for computing the Picard number of certain algebraic surfaces*, Amer. J. Math. 108 (1986) 415–432. https://doi.org/10.2307/2374678
14. H. Movasati, R. Villaflor Loyola, *Periods of linear algebraic cycles*, https://arxiv.org/abs/1705.00084; R. Villaflor Loyola, *Periods of complete intersection algebraic cycles*, Manuscripta Math. 167 (2022) 765–792, https://doi.org/10.1007/s00229-021-01290-x
15. P. A. Griffiths, *On the periods of certain rational integrals I*, Ann. of Math. 90 (1969) 460–495. https://doi.org/10.2307/1970746
