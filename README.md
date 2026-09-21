# HODGE

**Author:** Benjamin Stanley Frohman (@BenFrohman)

## What is proved

```lean
#print axioms Hodge.HodgeConjecture.classical_fourfolds
```

That theorem is the working result. It says the Hodge sentence holds on
three islands only:

- `P^4` — `constructP4`
- `Q^4` — `construct` (`Pi = sigma_2`, `Pi' = sigma_{1,1}`)
- `P^2 x P^2` — `constructProduct`

Proof: `CycleSection` on each, then `HodgeConjecture.of_section`.
Expected `#print axioms`: `propext`, `Quot.sound`. No project axiom.

There is no Lean name `general_fourfold` in the core library.

## The sentence (documentation only)

```text
gamma = sum_i a_i [Z_i]
```

That identity is the Hodge conjecture. It is not a theorem in this repo
except on the three islands above.

## Locus 1 (Noether–Lefschetz)

Very general `X = V(F) subset P^5`, `deg F >= 6`:

```text
Hdg^2(X) = Q h^2
Z = X cap {L1 = L2 = 0}
I(Z) = <L1, L2> in C[x0,...,x5] / <F>
[Z] = h^2
gamma = a [Z]
```

Equations: `docs/LOCUS1_LINEAR_SECTION.md`.

## Easy arrow

Algebraic classes are Hodge classes (`cl_isHodge`). That is not the
conjecture.

`Examples.zeroCycle` shows the same sentence on an arbitrary `Datum` of
codimension 2 is false as linear algebra. That gadget is not a fourfold.

## Sister repos (notes, not Lean imports)

- [BenFrohman/FermatPlanes](https://github.com/BenFrohman/FermatPlanes)
- [BenFrohman/NoetherLefschetz](https://github.com/BenFrohman/NoetherLefschetz)
- [BenFrohman/CubicFourfold](https://github.com/BenFrohman/CubicFourfold)

## Layout

```
Hodge/Basic.lean       statement interface
Hodge/Fourfold.lean    classical_fourfolds
Hodge/Classical.lean   constructions on three islands
Hodge/Construct.lean   CycleSection
Hodge/Klein.lean       named Plücker data
Hodge/Examples.lean    zeroCycle sentinel
Hodge/Frontier.lean    Lefschetz (1,1) as hypothesis
Hodge/Attempt/         sandbox, not imported by Hodge.lean
docs/PRINT_AXIOMS.md
docs/LOCUS1_LINEAR_SECTION.md
```

## License

MIT.
