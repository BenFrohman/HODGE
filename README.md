# HODGE

**Author:** Benjamin Stanley Frohman (@BenFrohman)

Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
See `LICENSE` and `NOTICE.md`.

## Two sentences

**Claim** (no term for unspecified `D`):

```lean
def HodgeConjecture.general_fourfold D h : Prop := D.HodgeConjecture
```

**Three-host release:**

```lean
theorem HodgeConjecture.classical_fourfolds :
    HodgeConjecture.ClassicalFourfolds
```

**Longer finite release** (`Hodge/NamedFamilies.lean`):

```lean
def HodgeConjecture.NamedFourfolds : Prop :=
  ClassicalFourfolds ∧
    Fermat.twoPlanes.HodgeConjecture ∧
      SpecialSextic.planeSpan.HodgeConjecture ∧
        Hassett.planeSpan.HodgeConjecture

theorem HodgeConjecture.named_fourfolds : NamedFourfolds
```

That list is six specified hosts:

1. `P^4` — `constructP4`
2. `Q^4` — `construct`
3. `P^2 × P^2` — `constructProduct`
4. Fermat quartic, planes `Z1`, `Z2`
5. Special sextic plane span
6. Hassett `C_8` plane span

`named_fourfolds` is a bigger release than `classical_fourfolds` (3 hosts → 6 hosts).
It is not a bigger statement than Hodge: Hodge is `\u2200 D`, a list is not `\u2200`.

## License

Apache License 2.0.
