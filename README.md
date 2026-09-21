# HODGE

**Author:** Benjamin Stanley Frohman (@BenFrohman)

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

## License

MIT.
