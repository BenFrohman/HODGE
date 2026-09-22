# Grothendieck standard conjectures

Author: Benjamin Stanley Frohman (@BenFrohman).
Survey note. Not a proof of Hodge or of any standard conjecture.
Sources: Grothendieck, Tata 1968/1969; Kleiman 1968 and Motives 1994.
See also docs/CORRESPONDENCES.md.

## Why they exist

Weil cohomology has Hard Lefschetz and Künneth. Algebraic cycles give some
classes. The standard conjectures ask that the remaining operators that exist
on cohomology also come from algebraic correspondences on X × X, and that
numerical and homological equivalence agree. Motives would then be semisimple.
Deligne proved Weil's Riemann hypothesis without them.

## The list (smooth projective X of dimension d, fixed Weil cohomology H)

A (hard Lefschetz on algebraic cycles).
  L^{d-2r} : A^r(X) → A^{d-r}(X) is an isomorphism.
  Equivalently: if L^{d-2r} γ is algebraic then γ is algebraic.

B (Lefschetz type, strong).
  The operator Λ = L^{-1} on primitives is algebraic: it is induced by a
  correspondence Z ⊂ X × X. L itself is already algebraic (cup with h).

C (Künneth type, weak Lefschetz).
  The Künneth projectors π_i ∈ H^{2d}(X × X) are algebraic.

D.
  Numerical equivalence of cycles equals homological equivalence (over Q).

Hodge standard (sometimes I).
  The pairing on primitive algebraic classes is definite, sign as in Hodge index.
  True over C (Hodge theory). Open in general in positive characteristic
  (known for surfaces; abelian fourfolds, Ancona 2020).

Usually A ⇔ B, and B ⇒ C. If Hodge standard holds, B and D are equivalent.

## Characteristic split

Over C: Hodge standard is a theorem. C is largely open.
Over finite fields: C is known (Katz–Messing, from Weil). Hodge standard is open.

Known cases of B include curves, abelian varieties (Lieberman), flag varieties,
smooth complete intersections in P^N, some hyperkähler types (Charles–Markman).
Complete intersections: Grothendieck already noted B holds there.

## Relation to Hodge

Hodge (over C) says Hodge classes on X come from Z_i ⊂ X.
B says a specific Hodge class on X × X (Λ, or the primitive projector) comes
from a correspondence. So Hodge on the product X × X, in the relevant degree,
implies B(X). Hodge on X does not automatically give Hodge on X × X.

This repo: L is geometric. Λ is the missing correspondence. general_fourfold
is Hodge on a fourfold, not B on that fourfold.

## Not in this repo as theorems

No Lean term of B, C, or D.
No claim that F or the three islands prove the standard conjectures.
