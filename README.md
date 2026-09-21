# HODGE

**Author:** Benjamin Stanley Frohman (@BenFrohman)

## What is proved

```lean
#print axioms Hodge.HodgeConjecture.classical_fourfolds
```

That theorem is the working result. It says the Hodge sentence holds on
three islands only:

- `ℝ^4` — `constructP4`
- `Q^4` — `construct` (`Π = σ₂`, `Π' = σ_{1,1}`)
- `ℝ² × ℝ²` — `constructProduct`

Proof: `CycleSection` on each, then `HodgeConjecture.of_section`.
Expected `#print axioms`: `propext`, `Quot.sound`. No project axiom.

## What is not proved

`HodgeConjecture.general_fourfold` is a `Prop`. No term. No axiom.
The missing object on a general fourfold is still
`γ = ∑ a_i [Z_i]`.

There is no `axiom construct_of_codim_ge_two`.

## Easy arrow

Algebraic classes are Hodge classes (`cl_isHodge`). That is not the
conjecture.

`Examples.zeroCycle` shows the same sentence on an arbitrary `Datum` of
codimension 2 is false as linear algebra. That gadget is not a fourfold.

## Sister repos (notes, not Lean imports)

- [BenFrohman/FermatPlanes](https://github.com/BenFrohman/FermatPlanes)
- [BenFrohman/NoetherLefschetz](https://github.com/BenFrohman/NoetherLefschetz)

## Layout

```
Hodge/Basic.lean       statement interface
Hodge/Fourfold.lean    open Prop + classical_fourfolds
Hodge/Classical.lean   constructions on three islands
Hodge/Construct.lean   CycleSection
Hodge/Klein.lean       named Plücker data
Hodge/Examples.lean    zeroCycle sentinel
Hodge/Frontier.lean    Lefschetz (1,1) as hypothesis
Hodge/Attempt/         sandbox, not imported by Hodge.lean
docs/PRINT_AXIOMS.md   what #print axioms lists
```

## License

MIT.
