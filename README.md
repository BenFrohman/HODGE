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

## Side notes (not the center)

These are secondary documents, not a proof of the conjecture.

- `docs/NAMING.md` — dictionary for the two planes on `Q⁴`
- `docs/CLASSICAL_FOURFOLDS.md` — constructor identities on the three islands
- `docs/AMPLITUHEDRON.md` — positive Grassmannians; not a renaming of `Π`, `Π'`
- `docs/STATUS.md` — what is complete and what is not
- `docs/FOURFOLD_CLAIM.md` — the guarded axiom

A log-concavity inventory citing Huh, Adiprasito–Huh–Katz, Brändén–Huh, and
others is a separate exposition. Those theorems are theirs. They are not a
Hodge proof.

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
docs/                  dictionaries and status
```

## License

MIT.
