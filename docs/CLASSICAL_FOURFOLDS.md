# Classical fourfolds with an explicit section of `cl`

Author of the repository record: Ben Frohman (@BenFrohman).
Mathematical credit for the constructions: Schubert calculus, Lefschetz,
and the topology of cellular varieties. These are known cases of the Hodge
conjecture, not a proof of the Hodge conjecture.

The Lean shadow of this note lives in [`Hodge/Classical.lean`](../Hodge/Classical.lean).
That file instantiates `CycleConstructor` on three abstract data objects whose
Hodge space is declared to be spanned by explicit algebraic generators. It does
**not** discharge the axiom `construct_of_codim_ge_two` in `Hodge/Fourfold.lean`.

---

## 1. Projective four-space

Let `X = ℝ⁴` with homogeneous coordinates `[x₀ : x₁ : x₂ : x₃ : x₄]`.
Then `H⁴(X, ℚ) = ℚ · h²` with `h = c₁(ᵊ_X(1))`, and every class is of type `(2,2)`.

**Surface.** The linearly embedded plane

```
Z = { x₃ = x₄ = 0 } ⊂ ℝ⁴.
```

**Rule.** Input `γ ∈ Hdg²(ℝ⁴)`. Write `γ = a [Z]` with `a ∈ ℚ`.
Output the single surface `Z` and the coefficient `a`.

**Lemma.** `[Z] = h²`, so `γ = a [Z]`.
**Lemma.** Every Hodge class on this `X` is of that form.

---

## 2. The Klein quadric `Q⁴ ⊂ ℝ⁵`

Let `X = Q` be the Grassmannian `Gr(2,4)` of lines in `ℝ³`, embedded by Plücker
coordinates `(p₀₁ : p₀₂ : p₀₃ : p₁₂ : p₁₃ : p₂₃)` as the quadric

```
p₀₁ p₂₃ − p₀₂ p₁₃ + p₀₃ p₁₂ = 0.
```

This is a smooth Fano fourfold. It is cellular, so `H^{p,q}(Q) = 0` for `p ≠ q`,
and `dim_ℚ H⁴(Q, ℚ) = 2`. Hence `Hdg²(Q) = H⁴(Q, ℚ)`.

Write `ℝ³` with coordinates `[z₀ : z₁ : z₂ : z₃]`.

**σ-plane** `Π` — lines through the point `[1:0:0:0]`:

```
Π = { p₁₂ = p₁₃ = p₂₃ = 0 } ⊂ Q.
```

**ρ-plane** `Π'` — lines contained in the plane `z₀ = 0`:

```
Π' = { p₀₁ = p₀₂ = p₀₃ = 0 } ⊂ Q.
```

Both are linearly embedded `ℝ² ⊂ Q`, of opposite families. Schubert calculus gives

```
h² = [Π] + [Π']
```

in `H⁴(Q, ℤ)`, and `{[Π], [Π']}` is a `ℚ`-basis of `Hdg²(Q)`.

**Rule.** Input `γ ∈ Hdg²(Q)`. Expand `γ = a [Π] + b [Π']` with `a, b ∈ ℚ`.
Output the surfaces `Π`, `Π'` and the coefficients `a`, `b`.

**Lemma.** `γ = a [Π] + b [Π']` by the basis expansion.
**Lemma.** The same procedure works for every Hodge class on this `X`.

Intersection numbers used in the expansion: `[Π]² = 1`, `[Π']² = 1`,
`[Π] · [Π'] = 0`, and `h⁴ = 2`.

---

## 3. The product `ℝ² × ℝ²`

Let `X = ℝ² × ℝ²` with Künneth generators `h₁`, `h₂`.
Then `Hdg²(X) = ℚ h₁² ⊕ ℚ h₂² ⊕ ℚ h₁ h₂`.

**Surfaces.**

```
Z₁ = {pt} × ℝ²     (class h₁²)
Z₂ = ℝ² × {pt}     (class h₂²)
Z₃ = ℝ¹ × ℝ¹       (class h₁ h₂)
```

**Rule.** Input `γ`. Write `γ = a [Z₁] + b [Z₂] + c [Z₃]`.
Output those three surfaces and the three rationals.

---

## Scope

These rules fill the template

* input: this `X` and a class `γ`,
* output: explicit equations of surfaces and rationals,
* lemma: `γ = ∑ a_i [Z_i]`,
* lemma: the procedure works for every Hodge class on **this** `X`

on three cellular fourfolds. They do **not** fill the same template on a
general fourfold. A general hypersurface of degree `≥ 6` in `ℝ⁵` has a
nontrivial primitive `(3,1)` piece; the two-plane basis above does not exist
there. That remaining case is the Hodge conjecture.

`construct_of_codim_ge_two` in `Hodge/Fourfold.lean` remains an axiom.
