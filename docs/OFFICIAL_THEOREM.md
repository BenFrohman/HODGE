<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Official theorem (closed)

**Author:** Benjamin Stanley Frohman (@BenFrohman)  
**Copyright:** (c) 2026 Benjamin Stanley Frohman  
**License:** Apache-2.0  
**Repo:** https://github.com/BenFrohman/HODGE (public, `main`)

This page closes the theorem the files prove. It does not close Clay.

---

## Theorem (Frohman). Two planes on a named sextic fourfold

Let

```
F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6
Π      = V(x3, x4, x5)
Π_{-1}  = V(x0+x3, x1+x4, x2+x5)
```
in `P^5`. Then, in every commutative ring,

```
F ∈ I(Π)     and     F ∈ I(Π_{-1}).
```

So both planes lie on the fourfold `X = V(F)`.

**Lean name:** `Hodge.SpecialSextic.contains_two_planes`  
**Proof:** `ring` factorizations `F_factors` and `F_factors_minus1`, then ideal membership. No `sorry`. No axiom.

**Also closed on this host**

- `CycleSection` on the coordinate span `ℚ h² + ℚ[Π]` (`planeSpan_hodge`)
- `CycleSection` on the three classical hosts `ℙ^4`, `Q^4`, `ℙ² × ℙ²`, and on the Fermat / Hassett named spans (`named_fourfolds`)

---

## What this applies to

It applies to **this equation** and to **those named hosts**.  
It applies to the *easy arrow*: a subvariety gives a Hodge class. Here the subvarieties are written as height-2 ideals.

It applies as one explicit point of the *plane-containing* Noether–Lefschetz locus of sextic fourfolds in `ℙ^5`.

---

## Why it is larger than the two-line membership

The membership is a ring identity. The larger fact it sits inside is shelf (B), not Clay.

Baldi–Klingler–Ullmo, Invent. Math. 235 (2023), Corollary 1.6 (cited, not coauthored): for fourfolds of degree `≥ 6`, the primitive VHS has level `≥ 3`, the typical Hodge locus is empty, and every positive-dimensional Hodge component is atypical and algebraic. Plane-containing sextics are the standard example that the expected-codimension count is not sharp.

This `F` is a concrete equation on that locus, with two planes written down. That is more than “a polynomial is in an ideal”: it is a named geometric point of an atypical Hodge component whose existence BKU already guarantees in the large, and whose expected-codimension failure Griffiths already flagged. The Lean file supplies the equations.

A very general sextic still has only `ℚ h²` (monodromy / Deligne, `d ≥ 3`). This `F` is not very general. That is the point of shelf (B).

---

## What it does not close

- Clay: `∀ X, ∀ γ ∈ H⁴(X,ℚ) ∩ H^{2,2}(X), γ = ∑ a_i [Z_i]`.
- BKU Corollary 1.6 itself (already proved by Baldi–Klingler–Ullmo).
- Hodge on the whole group `H⁴(V(F), ℚ)` (`dim = 2606`). `planeSpan` is `ℚ²`, not that group.
- Shelf (A): Atiyah–Hirzebruch torsion and Kollár degree. Those are integral failures, not a rational counterexample, and not “Hodge proved over `ℚ`.”

Bluntly: the official closed theorem of this repository is the two-plane membership plus `CycleSection` on the named list. The larger surrounding theorem is BKU’s description of the atypical locus. The Clay sentence stays open.
