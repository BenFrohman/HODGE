# Project log — v1.0.0-guarded

Author: Benjamin Stanley Frohman. Apache-2.0.

Snapshot meaning: the Lean statement is frozen with the axiom guarded.
Clay status: open. Not a solution. Not a counterexample.

## Accepted from the last note

- Drop `global_constructor_counterexample`. That theorem would claim
  `¬ CycleConstructor X` on a variety. No such pair exists here.
- Remainder `(1+ζ⁴)w⁴` is one failed identity, not absence of all cycles.
- `Datum` keeps its three type parameters.
- `Hodge/Attempt/` stays off the default `lake build Hodge` target.

## Rejected from the last note

Do not replace `lakefile.toml` with a `lakefile.lean` whose roots are
only `Hodge.Fourfold` and `Hodge.Frontier`. That would drop Basic,
Classical, Construct, Examples, Klein, and Geometry.

Live Lake file:

    name = "HODGE"
    defaultTargets = ["Hodge"]
    mathlib rev = "v4.22.0"
    lean_lib Hodge
    lean_lib HodgeAttempt   # lake build HodgeAttempt

Default build: `lake build Hodge` from `Hodge.lean`.

## Print axioms

`#print axioms HodgeConjecture.general_fourfold` lists
`construct_of_codim_ge_two`. That is the named hypothesis, introduced
by `letI` in `of_variety_codim_ge_two`.

`Hodge/Frontier.lean` does not use that axiom.

## Git tag

    git fetch origin
    git checkout main
    git pull
    git tag -a v1.0.0-guarded -m "Guarded axiom snapshot. Clay status: OPEN."
    git push origin v1.0.0-guarded
