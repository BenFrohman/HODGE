# Trichotomy: Hodge, counterexample, missing instance

Author: Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.
Date: 22 September 2026.

Three different statements. Do not collapse them.

## 1. Hodge (what Clay would pay to prove)

For every smooth complex projective fourfold `X` and every Hodge class
`γ ∈ Hdg²(X)`, there exist finitely many algebraic surfaces `Z_i` on `X`
and rationals `a_i` with

    γ = ∑ a_i [Z_i].

Quantifiers: `∀ X, ∀ γ, ∃ Z_i`.

## 2. A counterexample (what Clay would pay to disprove)

One named smooth projective fourfold `X`, one named class
`γ ∈ Hdg²(X)`, and a proof that

    γ ≠ ∑ a_i [Z_i]

for every finite collection of surfaces on that `X`.

Quantifiers: `∃ X, ∃ γ, ∀ Z_i, a_i`.

## 3. What this repository has

A missing uniform construct

    instance (D : Datum) : CycleSection D

means this library does not supply a recipe for unspecified `D`.
It does not say cycles fail to exist. It is not (1) and not (2).

On the named special sextic

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6
    Π = V(x3, x4, x5)

the theorem `SpecialSexticMembership.F_mem_plane` is the **easy arrow**:
`F ∈ ⟨x3, x4, x5⟩`, so `Π ⊂ V(F)` and `[Π]` is an algebraic Hodge class.
That pair `(V(F), [Π])` is an *instance* of Hodge for one class on one host.
It cannot be a counterexample.

Relabeling that file `HC` does not turn one pair into `∀ X ∀ γ ∃ Z_i`.

## Firewall

- missing instance ≠ Hodge is false
- missing instance ≠ a counterexample
- extra-class fourfold with an explicit surface ≠ a counterexample
- `CycleSection.construct` as a global function is unwritten
- Clay status for Hodge remains **open**
