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

## The sentence

```text
gamma = sum_i a_i [Z_i]
```

`gamma` is a rational Hodge class of type `(k,k)`.
Each `Z_i` is a closed subvariety of codimension `k`.
Each `a_i` is rational.
On a fourfold the first open case is `k = 2`: surfaces.
Each surface is a height-2 ideal in the coordinate ring of `X`.

That identity **is** the Hodge conjecture (the reverse arrow).
The easy arrow — a subvariety gives a Hodge class — is already a theorem.

A `(2,2)`-form, `star eta = -eta`, or an eigenvalue `q^2` is a class-side
tracking parameter. It is not a surface and does not cut `I(Z_i)`.

## What is not proved

`HodgeConjecture.general_fourfold` is a `Prop`. No term. No axiom.
The missing object on a general fourfold is still the list of ideals
`I(Z_i)` and the rationals `a_i`.

There is no `axiom construct_of_codim_ge_two`.

## Locus 1 (Noether–Lefschetz)

Very general `X = V(F) subset P^5`, `deg F >= 6`:

```text
Hdg^2(X) = Q h^2
Z = X cap {L1 = L2 = 0}     two independent linear forms
I(Z) = <L1, L2>             in C[x0,...,x5] / <F>
[Z] = h^2
gamma = a [Z]
```

Degree of `Z` in that `P^3` is `deg F`. No plane, no `zeta`.
Equations: `docs/LOCUS1_LINEAR_SECTION.md`.
This constructor is length one. It is not `general_fourfold`.

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
Hodge/Fourfold.lean    open Prop + classical_fourfolds
Hodge/Classical.lean   constructions on three islands
Hodge/Construct.lean   CycleSection
Hodge/Klein.lean       named Plücker data
Hodge/Examples.lean    zeroCycle sentinel
Hodge/Frontier.lean    Lefschetz (1,1) as hypothesis
Hodge/Attempt/         sandbox, not imported by Hodge.lean
docs/PRINT_AXIOMS.md   what #print axioms lists
docs/LOCUS1_LINEAR_SECTION.md
```

## License

MIT.
