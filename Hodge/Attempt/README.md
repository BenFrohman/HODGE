# Attempt sketches

Author: Benjamin Stanley Frohman (@BenFrohman).

These files name filtrations, type-shifts, analytic slogans, and one
easy-arrow example. They are not `CycleSection` terms on a general
fourfold and they are not Mathlib PRs.

- `MonodromyTypeShift.lean` — `N(I^{p,q}) ⊆ I^{p-1,q-1}` when `W = W(N)`.
- `AsymptoticAnalysis.lean` — `J` on `Tℝ M`, Kähler slogans.
- `Lefschetz.lean` — Hard Lefschetz / primitive decomposition slogans.
- `FermatPlanes.lean` — planes `z_{even} = ±ζ z_{odd}` on the Fermat quartic
  with `ζ^4 = -1`. Easy arrow. Membership lemmas are `sorry`.

Do not import this folder from `Hodge.lean` until a file is a theorem you
want in the default build and in CI.
