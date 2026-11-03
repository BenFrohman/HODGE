<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Jacobian generators of the chain sextic

**Author:** Benjamin Stanley Frohman (@BenFrohman)
**License:** Apache-2.0
**Clay tag:** `clay-statement-open`
**Host file:** `Hodge/SpecialSextic.lean`

This note names the six partial derivatives of

```text
F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6.
```

It does not inhabit `HodgeConjecture.general_fourfold`.
It does not pick a residue in `R(F)_12`.
It does not compute ledger `Z`.

## The six generators

```text
∂F/∂x0 = 5 x0^4 x3
∂F/∂x1 = 5 x1^4 x4
∂F/∂x2 = 5 x2^4 x5
∂F/∂x3 = x0^5 + 6 x3^5
∂F/∂x4 = x1^5 + 6 x4^5
∂F/∂x5 = x2^5 + 6 x5^5
```

These are the classical partials. They are already the six hypotheses of
`gradient_only_origin` and `affine_cone_isolated_at_origin` in
`Hodge/SpecialSextic.lean`. Naming them as `dF_dx0, …, dF_dx5` is a lock,
not a new geometric theorem.

## What this proves (Field 1)

Over an integral domain with `5 ≠ 0` and `6 ≠ 0`, if all six generators
vanish then every coordinate is zero. That is the affine cone of `V(F)`
isolated at the origin. A singular point of the projective hypersurface
`X = V(F) ⊂ P^5` would be a nonzero point of that cone. Hence `X` is
smooth as a projective hypersurface in this algebraic encoding.

Euler check (degree 6):

```text
∑_{i=0}^5 x_i ∂_i F = 6 F.
```

This identity is the ring-level certificate that the six named functions
are the partials of `F`. It is not Hodge.

## What this does not prove

- Not `HodgeConjecture.general_fourfold`. That remains a `Prop` with no term.
- Not `SmoothComplexProj` as a Mathlib scheme. The sister-repo record
  `VF` is a label `⟨"V(F)", 4, equation string⟩`.
- Not `finrank R(F) = 15625`. `Hodge/JacobianLength.lean` records the
  arithmetic `5^6 = 15625` and leaves `PartialsRegular` and
  `HomogeneousCILength` uninstanced.
- Not a Griffiths residue. No element of `R(F)_12` is selected.
- Not ledger `Z`. The rational cokernel
  `dim_Q (Hdg^2(V(F)) / (im(cl) ∩ Hdg^2))` stays uncomputed.
- Not `ClayDisproofTerm`. Miss field empty.

## Reduction rules inside `R(F)` (dictionary only)

The first three generators say that any monomial containing `x0^4 x3`,
`x1^4 x4`, or `x2^4 x5` is zero in the Jacobian ring. The last three say
`x0^5 ≡ -6 x3^5`, and cyclic. Those are rewriting rules. They do not
produce a period matrix and they do not assign a numeral to `Z`.

## Coefficient ring

Clay uses `Q`. Integral Hodge uses `Z` and is a different sentence.
Ledger letter `Z` is the uncomputed rational cokernel, not the integers.

Clay status: **open**.
