# HODGE

**Author:** Benjamin Stanley Frohman (@BenFrohman)

## Center: the open problem

Let `X` be a general fourfold and let `γ ∈ Hdg²(X)` be arbitrary. The missing
object is a finite collection of surfaces `Z_i ⊂ X` and rationals `a_i ∈ ℚ`
such that

```
γ = ∑ a_i [Z_i].
```

That equality is the Hodge conjecture in its first open case. Writing the
`Z_i` down from `γ` would be a section of `cl`. That section is not in this
repository. There is no general Hodge proof here.

Lean records the sentence as a proposition, not as a theorem:

```lean
def constructOfCodimGeTwo (D : Datum Z V N) (_h : 2 ≤ D.codim) : Prop :=
  ∀ v ∈ D.hodgeClasses, v ∈ D.algebraicClasses
```

A restored axiom `construct_of_codim_ge_two` exists only under the flag
`IsVariety`. That is a hypothesis. It is not a construction of the surfaces.

## What is proved here

- The easy arrow: algebraic classes are Hodge classes (`cl_isHodge`).
- A section of `cl` on three classical fourfolds only:
  `ℙ⁴`, `Q⁴ = Gr(2,4)`, and `ℙ² × ℙ²` (`Hodge/Classical.lean`).
- On `Q⁴`, the section is `γ = (γ · [Π])[Π] + (γ · [Π'])[Π']`
  with `Π = σ₂` and `Π' = σ_{1,1}`.
- `Examples.zeroCycle` shows that the same sentence on an arbitrary `Datum`
  of codimension 2 is false as linear algebra.

## What is not proved here

- The Hodge conjecture.
- A rule `γ ↦ (Z_i, a_i)` on a general fourfold.
- A Chow ring of `Gr(2,4)` in which `[Π]² = 1` is a theorem.

## Sister repos (notes, not Lean imports)

These are **not** imported by `Hodge.lean`. They do not supply the missing
general constructor.

- [BenFrohman/FermatPlanes](https://github.com/BenFrohman/FermatPlanes) — easy arrow on the Fermat quartic; remainder identity `(1+ζ^4)w^4`.
- [BenFrohman/NoetherLefschetz](https://github.com/BenFrohman/NoetherLefschetz) — very general high-degree hosts have no extra Hodge class.

Copies of the Fermat Lean sit under `Hodge/Attempt/` for reading only.

## Side notes (not the center)

- `docs/NAMING.md` — dictionary for the two planes on `Q⁴`
- `docs/CLASSICAL_FOURFOLDS.md` — constructor identities on the three islands
- `docs/FERMAT_PLANES.md` — remainder identity; Fermat is a special host
- `docs/EXTRA_CLASS_SEXTIC.md` — special sextic containing a plane
- `docs/STATUS.md` — what is complete and what is not
- `docs/CLOSING_RECORD.md` — inventory of constructors that exist

## Layout

```
Hodge/Basic.lean       statement interface
Hodge/Fourfold.lean    open case, guarded axiom, IsVariety
Hodge/Classical.lean   constructions on three islands
Hodge/Klein.lean       named Plücker data
Hodge/Examples.lean    zeroCycle counter-model
Hodge/Frontier.lean    Lefschetz (1,1) as hypothesis
Hodge/Known.lean       scoreboard of known cases
Hodge/Integral.lean    rational vs integral
Hodge/Attempt/         sandboxed sketches, not imported
docs/                  dictionaries and status
```

## License

MIT.
