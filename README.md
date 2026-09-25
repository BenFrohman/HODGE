# HODGE

**Status:** Draft (finished skeleton, not a Clay close).
**Author:** Benjamin Stanley Frohman (@BenFrohman)

Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved under the Apache License, Version 2.0.
See `LICENSE`, `NOTICE.md`, `AUTHORS.md`, and `docs/BRANCH_RULES.md`.

This repository does **not** prove the Hodge conjecture and does **not** contain a counterexample.
See `docs/TRICHOTOMY.md` and `docs/CLAY_TAG.md`.

## Derived surfaces (`Hodge/DerivedSurfaces.lean`)

Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0. No `sorry`.

Named library surfaces as objects `O_Z`. Closed numeral facts:

```lean
theorem inventory_card : inventory.length = 8
theorem residual_is_surface : residualQuintic.objectDim = 2
theorem residual_host_is_fourfold : residualQuintic.hostDim = 4
theorem residual_not_partner :
    residualQuintic.objectDim = 2 ∧ residualQuintic.objectDim ≠ 4
theorem every_listed_object_is_a_surface :
    inventory.all (fun s => s.objectDim == 2) = true
theorem every_listed_host_is_a_fourfold :
    inventory.all (fun s => s.hostDim == 4) = true
```

`S` is dimension 2 on the fourfold `V(F)`. It is not the partner `Y`.
`Y` and Term B stay named and empty in `docs/Y_AND_MISS.md`.
This file does not inhabit `general_fourfold` or ClayDisproofTerm.

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
