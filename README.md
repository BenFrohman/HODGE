# HODGE

**Author:** Benjamin Stanley Frohman (@BenFrohman)

Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
See `LICENSE` and `NOTICE.md`. Attribution to the author is required.

## What is proved

```lean
#print axioms Hodge.HodgeConjecture.classical_fourfolds
```

Three islands:

- `P^4` — `constructP4`
- `Q^4` — `construct` (`Pi = sigma_2`, `Pi' = sigma_{1,1}`)
- `P^2 x P^2` — `constructProduct`

Proof: `CycleSection`, then `HodgeConjecture.of_section`.
Expected `#print axioms`: `propext`, `Quot.sound`.

There is no Lean name `general_fourfold`.
This repository does not prove the Hodge conjecture.

## License

Apache License 2.0.
