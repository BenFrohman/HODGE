# Fermat quartic as a fourth named host

Author: Benjamin Stanley Frohman (@BenFrohman).

## In core (`Hodge/Fermat.lean`)

- `Fermat.fermatQuartic` — named `Datum`, `codim = 2`
- `IsVariety` instance for **that datum only**
- `CycleSection` for **that datum only**
- theorem `Fermat.fermatQuartic_hodge`

Justification is literature, not a Lean inverse of `cl` on 142 classes:
Shioda–Ran (degree 4) and Aljovin–Movasati–Villaflor, JSC 2019.

The 960 labeled planes live in `BenFrohman/FermatPlanes`.

## Still no

- `instance [IsVariety D] : CycleSection D`
- Discharge of `HodgeConjecture.general_fourfold` for arbitrary `D`
- Import of `Hodge.Attempt` into `Hodge.lean`
