# Architectural wall

Author: Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.

`classical_fourfolds` and `general_fourfold` are not the same instance.
This note records that disconnect. It is not a proof of Hodge.

## Live names

```lean
theorem HodgeConjecture.classical_fourfolds :
    Classical.projectiveFourSpace.HodgeConjecture ∧
      Classical.kleinQuadric.HodgeConjecture ∧
        Classical.productOfPlanes.HodgeConjecture
```

Proof: `of_section` on each. `CycleSection.is_section` is `rfl` because
those three data have `cl = id`. The conjunction itself is not proved by
one `rfl`.

```lean
def HodgeConjecture.general_fourfold
    (D : Datum Z V N) [IsVariety D] (_h : D.codim = 2) : Prop :=
  D.HodgeConjecture
```

A family of propositions. No term for an unspecified `D`.
Specializing to `P^4` is `p4_isVariety`. That is one named host.

## What definitional equality is allowed to see

| Object | What it is |
|---|---|
| `classical_fourfolds` | Theorem. Finite conjunction of three named data. |
| `p4`, `klein`, `product` | Projections of that conjunction. |
| `general_fourfold D h` | `Prop`. Same sentence as `D.HodgeConjecture`. |
| `IsVariety` | Empty marker class. Not a scheme. |
| `CycleSection` | Exists on `P^4`, `Q^4`, `P^2 x P^2`, cited Fermat quartic datum. |

No unification of those three data with an unnamed hypersurface in `P^5`.

## Sketch only: an inductive tag (not imported by Hodge.lean)

A constructor tag can name the split. It does not replace `Datum`.
It does not encode smoothness. `P4_Space ≠ GeneralHypersurface F d` is
constructor inequality. It is not Hodge.

```lean
inductive FourfoldHost
  | P4_Space
  | Q4_Quadric
  | P2_ProjProd
  | GeneralHypersurface (deg : Nat)
```

Ambient of a hypersurface fourfold is `P^5` (six homogeneous coordinates).
Ambient of `P^4` is `P^4`. Those are different spaces. Two linear forms
in `P^5` cut a `P^3`, not a linear plane. A linear plane on `X subset P^5`
is three independent linear forms.

Do not import this inductive into `Hodge.lean`.

## What is not claimed

- `classical_fourfolds` is not proved by theorem-level `rfl`.
- `general_fourfold` is not a Lean `∀` over every smooth projective fourfold.
- `general_fourfold` is not “non-computable.” It is a `Prop` with no general term.
- Constructor inequality is not Grothendieck B.
- `Z1 ⊔ Z2` is two planes on the Fermat quartic. Not a `CycleSection`.
- Clay is open.

## Firewall

1. `SexticPair.lean` / FermatPlanes stay on named Fermat hosts in `P^5`.
2. `CycleSection` stays on the named hosts listed above.
3. `general_fourfold` stays a `Prop`.
4. No axiom `construct_of_codim_ge_two`.
