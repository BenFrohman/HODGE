# Loci (documentation only)

Author: Benjamin Stanley Frohman (@BenFrohman).

These are *names* of hosts. They are not a class `IsFermatOrClassical`
wired to `construct_of_codim_ge_two` or to CI.

- `Classical.projectiveFourSpace` — ℙ⁴
- `Classical.kleinQuadric` — Q⁴ = Gr(2,4)
- `Classical.productOfPlanes` — ℙ² × ℙ²
- Fermat quartic — sister repo BenFrohman/FermatPlanes, copies in Attempt/

CI (`.github/workflows/lean.yml`) builds `Hodge` and forbids
`import Hodge.Attempt` in `Hodge.lean`. It does not run a sentinel file.
