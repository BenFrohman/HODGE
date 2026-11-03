<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Named (2,2) spans

**Author:** Benjamin Stanley Frohman (@BenFrohman)  
**License:** Apache-2.0  
**Published Lean name:** `HodgeConjecture.named_fourfolds`  
**Encoding alias:** `HodgeConjecture.FrohmanTwoTwoSpans`

Published title of the proved finite list: **Named (2,2) spans**.
Do not publish this list as a personal Hodge theorem. The surfaces are
classical. Authorship of the encoding is Frohman. A personal geometric
name would belong to a uniform `\u03b3 ↦ (Z_i, a_i)` on unspecified `X`.
That map is missing. See `docs/UNIVERSAL_INSTANCE.md`.

Not Lefschetz. Lefschetz stops at \(k=1\). Not Clay.

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

Then every class \(\gamma\) in that span is algebraic:

\[
\gamma=\sum_i a_i[Z_i],\qquad
\mathrm{cl}\Bigl(\sum_i a_i[Z_i]\Bigr)=\gamma.
\]

## Explicit sections

\[
\begin{align*}
\mathbb{P}^4:&\quad ah^2\mapsto a[\mathbb{P}^2],\\
Q^4:&\quad a\sigma_2+b\sigma_{1,1}\mapsto a[\Pi]+b[\Pi'],\\
\mathbb{P}^2\times\mathbb{P}^2:&\quad
ah_1^2+bh_2^2+ch_1h_2
\mapsto a[\mathbb{P}^2\times\mathrm{pt}]
+b[\mathrm{pt}\times\mathbb{P}^2]
+c[\mathbb{P}^1\times\mathbb{P}^1],\\
\text{Fermat: }&\quad (a,b)\mapsto a[Z_1]+b[Z_2].
\end{align*}
\]

Term: `named_fourfolds`. Alias: `frohman_two_two_spans`.

---

## Open sentence

\[
\forall X^4,\ \forall\gamma\in\operatorname{Hdg}^2(X),\quad
\gamma=\sum_i a_i[Z_i].
\]

Lean: `HodgeConjecture.general_fourfold`.
Holes `?z_of` and `?cl_z_eq` stay empty.
