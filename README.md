# HODGE

**Status:** Draft (finished skeleton, not a Clay close).
**Author:** Benjamin Stanley Frohman (@BenFrohman)

Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved under the Apache License, Version 2.0.
See `LICENSE`, `NOTICE.md`, `AUTHORS.md`, and `docs/BRANCH_RULES.md`.

This repository does **not** prove the Hodge conjecture and does **not** contain a counterexample.
See `docs/TRICHOTOMY.md` and `docs/CLAY_TAG.md`.

## Derived surfaces

`Hodge/DerivedSurfaces.lean` names the library surfaces as objects `O_Z`.
Each listed object has `objectDim = 2` on a host of `hostDim = 4`.
The residual quintic `S` is one of those surfaces. It is not the partner `Y`.
`Y` and Term B stay in `docs/Y_AND_MISS.md` as named empty claims.

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
It is not a bigger statement than Hodge: Hodge is `∀ D`, a list is not `∀`.

`SpecialSexticMembership.F_mem_plane` is the easy arrow on one named sextic. Relabeling it does not prove Hodge and is not a counterexample.

## License

Apache License 2.0. Copyright (c) 2026 Benjamin Stanley Frohman.
