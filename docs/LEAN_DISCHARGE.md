# What Lean 4 actually counts as discharge

Author: Benjamin Stanley Frohman (@BenFrohman).
Source: Lean 4 reference — Validating proofs / Axioms / Lake.

This is a note in the repository. It is not a proof of Hodge.

## Finished theorem

A `theorem` is finished when its body is a term of that `Prop`.

```lean
#print axioms Hodge.HodgeConjecture.general_fourfold
```

- `sorryAx` — a hole remains. Not finished.
- `construct_of_codim_ge_two` — the theorem depends on the guarded axiom.
  Correct relative to that hypothesis. Not a construction of surfaces.
- Only `propext`, `Quot.sound`, `Classical.choice` — standard Lean logic.
  That is what a discharge without the project axiom would look like.

## Lake targets

From Lake: `defaultTargets` is what `lake build` compiles.
Each `[[lean_lib]]` is a separate target.

```bash
lake build              # Hodge (default)
lake build Hodge        # same
lake build HodgeAttempt # sandbox only
```

Building HodgeAttempt does not change the axiom list of
`HodgeConjecture.general_fourfold`.

`Hodge.lean` must not contain `import Hodge.Attempt`.
