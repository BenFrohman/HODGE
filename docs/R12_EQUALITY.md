<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# `dim_Q R_12 = 1751` for the chain sextic: the Lean proof, step by step

Author: Benjamin Stanley Frohman  
License: Apache-2.0  
Lean files: `Hodge/ChainSexticRank.lean` (upper bound, existing), `Hodge/ChainSexticR12.lean`
(lower bound and equality, new), `Hodge/ChainSexticR12Bridge.lean` (consequences, new).

## Statement

Let `F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6` in `Q[x0,…,x5]`, `J` the ideal of
its six partial derivatives, `R = Q[x]/J`, and `R_12` the image of the degree-12 homogeneous
polynomials in `R` (`jacobianDeg12`).

```lean
theorem Hodge.ChainSexticR12.jacobianDeg12_finrank_eq :
    Module.finrank ℚ Hodge.ChainSexticRank.jacobianDeg12 = 1751
```

Axioms: `propext`, `Classical.choice`, `Quot.sound`. No `sorry`, `admit`, `native_decide`, or new
axioms. This is a theorem about the Jacobian ring of `F`. It is not a theorem about cohomology:
the Griffiths isomorphism `H^{2,2}_prim(X) ≅ R_12` is cited and stays a named hypothesis.

## Notation

Write the three pairs as `(x, y) = (x0, x3), (x1, x4), (x2, x5)`. Then
`∂F/∂x = 5 x^4 y` and `∂F/∂y = x^5 + 6 y^5` in each pair. A pair monomial `x^a y^b` is
*standard* if `a ≤ 4`, `b ≤ 5` and not (`a = 4` and `b ≥ 1`); there are 25 (`stdPairs_card`).
A *standard triple* is a choice of a standard pair monomial in each pair; there are
`25^3 = 15625` (`stdTriples_card`), and 1751 of them have total degree 12
(`stdTriples12_card`, kernel `decide`).

## Upper bound (existing, `jacobianDeg12_finrank_le`)

In `R`: `x^4 y = 0` (from `5x^4y`), `x^5 = -6 y^5`, and `y^6 = 0`
(`y^6 = (1/6) y (x^5 + 6y^5) - (1/6) x (x^4 y)`). Induction on `a` (`pair_mem_span`) rewrites
every `x^a y^b` as a multiple of a standard pair monomial of the same degree, or `0`. Multiplying
the three pairs, every degree-12 monomial lies in the span of the 1751 standard monomials, so
`dim R_12 ≤ 1751`.

## Lower bound (new, `Hodge/ChainSexticR12.lean`)

1. **Pair normal form `pnf a b`.** Define
   - `pnf a b = 0` if `b ≥ 6`;
   - `pnf a b = 0` if `a ≥ 4` and `b ≥ 1`;
   - `pnf a b = x^a y^b` if (otherwise) `a ≤ 4`;
   - `pnf a b = -6 x^(a-5) y^5` if (otherwise, so `b = 0`) `5 ≤ a ≤ 8`;
   - `pnf a b = 0` if (otherwise) `a ≥ 9`.
2. **`pnf_rel1`: `pnf (a+4) (b+1) = 0`.** Since `a+4 ≥ 4` and `b+1 ≥ 1` (second clause, or the
   first if `b+1 ≥ 6`).
3. **`pnf_rel2`: `pnf (a+5) b + 6·pnf a (b+5) = 0`.**
   - If `b ≥ 1`: `pnf (a+5) b = 0` (`a+5 ≥ 4`, `b ≥ 1`) and `pnf a (b+5) = 0` (`b+5 ≥ 6`).
   - If `b = 0` and `a ≤ 3`: `pnf (a+5) 0 = -6 x^a y^5` (as `5 ≤ a+5 ≤ 8`) and
     `pnf a 5 = x^a y^5` (standard), so the sum is `-6 x^a y^5 + 6 x^a y^5 = 0`.
   - If `b = 0` and `a ≥ 4`: `pnf (a+5) 0 = 0` (`a+5 ≥ 9`) and `pnf a 5 = 0` (`a ≥ 4`, `5 ≥ 1`).
4. **`pnf_std`:** on a standard pair, `pnf a b = x^a y^b` (third clause).
5. **The map `normalForm` (`Φ`).** `nf d = pnf_0(d0,d3) · pnf_1(d1,d4) · pnf_2(d2,d5)` for an exponent vector
   `d`, and `Φ : Q[x] → Q[x]` is the unique `Q`-linear map with `Φ(x^d) = nf d`
   (`Basis.constr` on the monomial basis; `normalForm_monomial`).
6. **`normalForm_mul_pderiv`: `Φ(c · ∂_i F) = 0` for every polynomial `c`.** Both sides are additive in
   `c` (`MvPolynomial.induction_on'`), so take `c = r x^u`.
   - `i` a head variable of pair `k`: `c · ∂_iF = 5r · x^(u + 4e_x + e_y)`. In `nf`, the factor of
     pair `k` is `pnf (u_x + 4) (u_y + 1) = 0` by step 2, so `Φ = 0`.
   - `i` a tail variable of pair `k`: `c · ∂_iF = r x^(u + 5e_x) + 6r x^(u + 5e_y)`. The other two
     pair factors `P` are the same in both terms, so
     `Φ = r · P · (pnf (u_x+5) u_y + 6·pnf u_x (u_y+5)) = 0` by step 3.
7. **`normalForm_jacobianIdeal`: `normalForm` (`Φ`) vanishes on `J`.** Induction over `J = span{∂_iF}` with the stronger
   statement `∀ c, Φ(c·p) = 0`: generators by step 6; `0` trivially; sums by additivity; and
   `c·(a·p) = (c·a)·p`. Take `c = 1`.
8. **`normalForm_std`: `normalForm` (`Φ`) fixes standard monomials.** For a standard triple `t`, `nf(dt t)` is the product
   of the three `pnf` values, each the pair monomial itself by step 4, so `Φ(x^(dt t)) = x^(dt t)`.
9. **`stdMonomial_linearIndependent_of_subset`.** Let `S` be standard triples and
   `Σ_{t∈s} g_t [x^(dt t)] = 0` in `R` (`s ⊆ S` finite). Then `P = Σ g_t x^(dt t) ∈ J`. By step 7
   `Φ P = 0`, and by step 8 `Φ P = P`, so `P = 0` in `Q[x]`. The exponents `dt t` are pairwise
   distinct (`dt_injective`: read off the six coordinates), so the coefficient of `x^(dt t)` in `P`
   is exactly `g_t`. Hence `g_t = 0`. With `S = stdTriples12` this is
   `stdMonomial_linearIndependent`; with all 15625 triples it is
   `stdMonomial_linearIndependent_all` (independence in every degree).
10. **`jacobianDeg12_eq_span`.** `R_12` equals the span of the 1751 standard degree-12 monomials:
    `≤` is the upper-bound reduction (`jacobianDeg12_le_span`), and `≥` because each standard
    degree-12 monomial is the image of a homogeneous degree-12 monomial (`stdMonomial_mem`,
    `dt_degree`).
11. **`jacobianDeg12_finrank_eq`.** By step 10 and `finrank_span_eq_card` with step 9,
    `finrank R_12 = #stdTriples12 = 1751`. `jacobianDeg12_basis` is the resulting basis and
    `le_finrank_jacobianDeg12` the lower bound alone.

`normalForm` (`Φ`) is the normal form of the Gröbner basis `{x^4y, x^5 + 6y^5, y^6}` in each pair, but the Lean
proof uses no Gröbner-basis theorem: only the case analyses of steps 2–4.

## Non-vacuity checks

- `normalForm_x0_pow_five : Φ (X 0 ^ 5) = -6 * X 3 ^ 5` (the normal form is not the identity).
- `normalForm_x0_four_x3 : Φ (X 0 ^ 4 * X 3) = 0` (it kills a Jacobian relation).
- `jacobianIdeal_ne_top : jacobianIdeal ≠ ⊤` (`Φ 1 = 1 ≠ 0`, so `R` is not the zero ring).
- `stdMonomial_ne_zero`: each of the 1751 classes is nonzero.
- `nonstd_eq_neg_six : xbar 0 ^ 5 * xbar 1 ^ 7 = -6 * (xbar 3 ^ 5 * xbar 1 ^ 7)` (a nonstandard
  monomial is not a new basis element).
- `ChainSexticR12Bridge.griffiths_not_automatic`: a subspace of the wrong dimension does not
  satisfy the Griffiths field.

## Consequences (`Hodge/ChainSexticR12Bridge.lean`)

- `griffiths_iff : n = 1 + finrank ℚ jacobianDeg12 ↔ n = 1752`. The Griffiths field of
  `ChainSexticHodgeBridge` is now equivalent to `h^{2,2} = 1752`.
- `hodgeBridge_h22 : finrank ℂ D.H22 = 1752` for every `ChainSexticHodgeBridge`.
- `r_eq : ChainSexticBridgeAudit.r = 1751`, `model_rho_eq : hodgeBridge_model.rho = 1752`.
- `characterBridge_R12_obstruction_discharged`: the necessary condition
  `dim R_12 = 1751` from `characterBridge_forces_R12` holds.
- `characterBridge_griffiths_agree`: in any character bridge, `h^{2,2} = 1 + dim R_12`,
  `h^{2,2} = 1 + #type22`, and `#type22 = dim R_12 = 1751`.

## What did not change

`rho_eq_786` (`ρ_Hdg(X) = 786`) never used `dim R_12` in its proof. It is still conditional on
`ChainSexticCharacterBridge`. Its geometric fields remain named hypotheses (not axioms):
`H22`, `griffiths` (now equivalent to `h^{2,2} = 1752`), `pairing`, `h2`, `P`, `h2_hodge`,
`P_hodge`, `h2_h2`, `h2_P`, `P_h2`, `P_P`, `V`, `V_out`, `V_line`, `eigen_indep`, `h22_eq`, `W`,
`W_complex`, `hdg_split`, `orbit_simple`. No inhabitant of the character bridge is constructed.
Nothing here proves or disproves the Hodge conjecture.

## Reproduce

```
lake exe cache get
lake build
lake env lean AxiomAudit.lean   # 699 #print axioms lines, standard axioms only
python3 scripts/check_no_sorry.py
```
Toolchain `leanprover/lean4:v4.22.0`, Mathlib `v4.22.0` at
`79e94a093aff4a60fb1b1f92d9681e407124c2ca`.
