# Counterexamples

Author: Benjamin Stanley Frohman (@BenFrohman).
Apache-2.0.
Copyright (c) 2026 Benjamin Stanley Frohman.

Literature survey. Not a term of `general_fourfold`.
Clay tag: open.

## Two statements

| Statement | Claim | Status |
|---|---|---|
| Rational Hodge (Clay) | Every class in \(H^{2k}(X,\mathbb{Q})\cap H^{k,k}(X)\) is a \(\mathbb{Q}\)-combination of algebraic cycles | Open. No known counterexample. |
| Integral Hodge | Same with \(\mathbb{Z}\) coefficients | False. Many counterexamples. |
| Hodge for compact Kähler manifolds | Same, but \(X\) only Kähler, not projective | False (Voisin 2002). |

The Clay problem is the rational, projective one. If \(N\alpha\) is algebraic then \(\alpha\) is algebraic over \(\mathbb{Q}\). Integral failure never disproves Clay.

## Integral failures

1. **Torsion (Atiyah–Hirzebruch 1962).** Godeaux–Serre varieties / approximations to classifying spaces. Totaro: algebraic cycles factor through complex cobordism, so classes that die in \(MU^*\otimes_{MU_*}\mathbb{Z}\) cannot be algebraic. Original examples in dimension \(\ge 7\).
2. **Infinite order, some multiple algebraic (Kollár 1990).** Very general hypersurface \(X\subset\mathbb{P}^4\) of degree 125: every curve has degree divisible by 5. An integral Hodge class of degree 1 is not a curve class; \(125\alpha\) is algebraic. Threefold. Not a rational counterexample. Hassett–Tschinkel / Totaro later produced examples over number fields.
3. **Kodaira dimension 0 threefolds (Benoist–Ottem).** Product of an Enriques surface with a very general curve of genus \(\ge 1\).
4. **Classifying-space style (Antieau, Tripathy, …).** Approximations to \(BG\) for groups of type A; integral Tate failures at all primes \(\ell\).
5. **Compact Kähler, not projective (Voisin 2002).** Outside Clay: Clay requires projective \(X\).

Voisin group \(V^n(X)=\mathrm{coker}(\mathrm{CH}^n(X)\to\mathrm{Hdg}^n(X,\mathbb{Z}))\) measures the integral gap. Rational Hodge predicts torsion. Integral Hodge predicts zero. The examples show it need not be zero.

## Not a counterexample

- `Examples.zeroCycle`: linear gadget, `codim = 2`, `cl = 0`. Not a smooth projective variety. `not_every_codim_ge_two` kills ungated `\u2200 D`, not Hodge on fourfolds.
- SSRN / OSF claims of a rational counterexample on a Fermat quintic via Abel–Jacobi. Not accepted.
- Lefschetz (1,1). Always true integrally.
- Dimension `\u2264 3`. Rational Hodge holds. Integral Hodge can still fail (Kollár).
- Cubic fourfolds and Gushel–Mukai fourfolds: integral Hodge in degree 2 holds (Voisin; later stability-condition proofs).
- Uniruled fourfolds of low degree (quartic, quintic): rational Hodge for (2,2) is known. A general sextic is open, not a counterexample.
- `named_fourfolds` / `FrohmanTwoTwoSpans`: six specified hosts, not `\u2200`.
- `SpecialSextic.planeSpan`: one locked equation on the plane NL locus, not every sextic fourfold.

## Fourfolds, (2,2), over `\u211a`

First open geometric range: middle-codimension classes that are not divisors or points.

Known as islands, not `\u2200`: `\mathbb{P}^4`, quadrics, `\mathbb{P}^2\times\mathbb{P}^2`, cubics, many Fermat fourfolds of odd degree, special / Hassett cubics, uniruled low-degree hypersurfaces.

Unknown: a general sextic fourfold, a general complete intersection of higher type, an arbitrary Calabi–Yau fourfold. No accepted paper produces a Hodge class on such an \(X\) that is proved non-algebraic over \(\mathbb{Q}\).

High-degree fourfolds are sometimes named as *candidates* because \(h^{2,2}\) is large and the Noether–Lefschetz locus is thin. A candidate is not a counterexample.

## Repo lock

`zeroCycle` is a solved negative theorem about the skeleton.
It is not a geometric counterexample and not a Clay close.
PIN stays open.
