<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Theorem (Frohman (2,2) Spans)

**Author:** Benjamin Stanley Frohman (@BenFrohman)  
**License:** Apache-2.0  
**Lean:** `HodgeConjecture.FrohmanTwoTwoSpans`  
**Same Prop as:** `HodgeConjecture.NamedFourfolds`

This is the name of the **proved finite list**. It is not Lefschetz.
Lefschetz stops at \(k=1\). It is not Clay.

---

## Statement

Let \(X\) be one of

\[
\mathbb{P}^4,\qquad
Q^4=\mathrm{Gr}(2,4),\qquad
\mathbb{P}^2\times\mathbb{P}^2,
\]

or one of the named plane spans

\[
\mathbb{Q}[Z_1]+\mathbb{Q}[Z_2]
\text{ on the Fermat quartic},\qquad
\mathbb{Q}h^2+\mathbb{Q}[\Pi]
\text{ on the special sextic / Hassett }\mathcal{C}_8.
\]

Then every class \(\gamma\) in that span is algebraic: there exist the
named surfaces \(Z_i\) and rationals \(a_i\) with

\[
\gamma=\sum_i a_i[Z_i],\qquad
\mathrm{cl}\Bigl(\sum_i a_i[Z_i]\Bigr)=\gamma.
\]

## Explicit sections

\[
\begin{align*}
\mathbb{P}^4:&\quad
ah^2\mapsto a[\mathbb{P}^2],\\
Q^4:&\quad
a\sigma_2+b\sigma_{1,1}\mapsto a[\Pi]+b[\Pi'],\\
\mathbb{P}^2\times\mathbb{P}^2:&\quad
ah_1^2+bh_2^2+ch_1h_2
\mapsto a[\mathbb{P}^2\times\mathrm{pt}]
+b[\mathrm{pt}\times\mathbb{P}^2]
+c[\mathbb{P}^1\times\mathbb{P}^1],\\
\text{Fermat: }&\quad
(a,b)\mapsto a[Z_1]+b[Z_2].
\end{align*}
\]

## Lean term

```lean
theorem HodgeConjecture.frohman_two_two_spans :
    HodgeConjecture.FrohmanTwoTwoSpans :=
  named_fourfolds
```

Together with `Fermat.contains_two_planes`.
`#print axioms` on this conjunction is `propext` and `Quot.sound`.

The geometry of those hosts is classical. The name records the
formalization of that finite list in this repository.

---

## Open sentence (not this theorem)

\[
\forall X^4,\ \forall\gamma\in\operatorname{Hdg}^2(X),\quad
\gamma=\sum_i a_i[Z_i].
\]

Lean name of that sentence:

```lean
def HodgeConjecture.general_fourfold D h : Prop := D.HodgeConjecture
```

No term. That is the missing reverse arrow

\[
\operatorname{Hdg}^2(X)\ni\gamma\longmapsto
\sum_i a_i[Z_i]\in\mathrm{CH}^2(X)_{\mathbb{Q}}.
\]
