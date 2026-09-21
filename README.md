# HODGE

**Author:** Benjamin Stanley Frohman (@BenFrohman)

Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
See `LICENSE` and `NOTICE.md`.

## Release

Hodge is discharged on three specified fourfolds X.

```lean
#print axioms Hodge.HodgeConjecture.classical_fourfolds
```

| Specified X | Constructor |
|---|---|
| `P^4` | `constructP4` |
| `Q^4` | `construct` (`Pi = sigma_2`, `Pi' = sigma_{1,1}`) |
| `P^2 x P^2` | `constructProduct` |

Proof: `CycleSection`, then `of_section`.
Expected `#print axioms`: `propext`, `Quot.sound`.

Details: `docs/RELEASE.md`.

An unspecified fourfold is not in this release.

## License

Apache License 2.0.
