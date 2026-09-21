# HODGE

**Author:** Benjamin Stanley Frohman (@BenFrohman)

Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
See `LICENSE` and `NOTICE.md`.

## Release

```lean
instance : CycleSection projectiveFourSpace
instance : CycleSection kleinQuadric
instance : CycleSection productOfPlanes

theorem HodgeConjecture.classical_fourfolds :
    HodgeConjecture.ClassicalFourfolds :=
  ⟨of_section _, of_section _, of_section _⟩
```

Specified X: `P^4`, `Q^4`, `P^2 × P^2`.

```lean
#print axioms Hodge.HodgeConjecture.classical_fourfolds
```

Expected: `propext`, `Quot.sound`.

An unspecified fourfold is not in this conjunction.

## License

Apache License 2.0.
