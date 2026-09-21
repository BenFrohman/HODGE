# Architectural Wall: classical_fourfolds is not general_fourfold

Author: Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.

**Status:** architecture locked. Not a Clay proof. Not Conjecture B.

## 1. Executive summary

`HodgeConjecture.classical_fourfolds` and `HodgeConjecture.general_fourfold`
are not the same instance. They do not inhabit the same type slot.

Inferring a constructor for an unnamed fourfold from the three-island
theorem is blocked. The Lean kernel does not unify those names.

## 2. Live types (Hodge/Fourfold.lean)

### A. `classical_fourfolds`

A **theorem**, not a definition:

```lean
theorem HodgeConjecture.classical_fourfolds :
    Classical.projectiveFourSpace.HodgeConjecture ∧
      Classical.kleinQuadric.HodgeConjecture ∧
        Classical.productOfPlanes.HodgeConjecture
```

That is the conjunction

```text
HC(P^4) ∧ HC(Q^4) ∧ HC(P^2 × P^2).
```

Proof: `of_section` on each, from `CycleSection`. What is `rfl` is only
`CycleSection.is_section`, because those three data have `cl = id`.
`#print axioms` lists `propext` and `Quot.sound`.

Those hosts have algebraic bases (linear sections / Schubert cells).
The Lean file is the linear shadow of that fact.

### B. `general_fourfold`

A **definition** of a `Prop`, parameterized by a datum:

```lean
def HodgeConjecture.general_fourfold
    (D : Datum Z V N) [IsVariety D] (_h : D.codim = 2) : Prop :=
  D.HodgeConjecture
```

It is not a single `∀` theorem over every fourfold in P^5. `IsVariety` is
an empty marker. Specializing to P^4 is `p4_isVariety`. That is one named
`D`. It is not a term for an unspecified fourfold.

The missing object is still

```text
s : (X, γ) ↦ (Z_i, a_i)
```

with `γ = ∑ a_i [Z_i]`, or a pair `(X, γ)` outside `im(cl)`.

Do not call this `Prop` "non-computable." It is uninhabited off the named
hosts. Computability is the wrong word.

## 3. Domain separation

| Metric | Named islands | Unspecified `D` |
|---|---|---|
| Lean name | `classical_fourfolds` | `general_fourfold D h` |
| Kind | theorem (conjunction) | `def … : Prop` |
| Hosts | P^4, Q^4, P^2 × P^2 | any `Datum` with `[IsVariety]` and `codim = 2` |
| `CycleSection` | yes | no, unless `D` is one of the named hosts |
| Proof | `of_section` | no term |
| Clay | not this | first open geometric case |

A naming inductive `FourfoldHost` with constructors `P4_Space` and
`GeneralHypersurface F d` can record the same wall as constructor
inequality. That inequality is tautological (`nomatch`). It is not Hodge.
It does not belong in `Hodge.lean`. If encoded, it stays in `Hodge/Attempt`.

`IsSmoothProjective` that returns `True` on every constructor does not
encode smoothness.

## 4. Firewall policy

1. `SexticPair.lean` and FermatPlanes stay on their hosts. Univariate
   factorization stops at one linear form. A plane in P^5 is three forms.
2. `Z1 ⊔ Z2` is two planes on the Fermat *quartic*. Not a `CycleSection`.
3. Invertibility of `1 - zeta eta` does not upgrade those objects to Hodge.
4. `CycleSection` stays on P^4, Q^4, P^2 × P^2, and the cited Fermat quartic
   datum in `Hodge/Fermat.lean`.
5. `general_fourfold` stays a `Prop`. No axiom `construct_of_codim_ge_two`.
6. Grothendieck Conjecture B is unimplied. Clay is open.
