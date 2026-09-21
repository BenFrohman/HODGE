# Sister repositories

Author of the repository record: Benjamin Stanley Frohman (@BenFrohman).

These repos supply material that this project uses as *notes*.
They are not imported by `Hodge.lean`. They do not discharge
`HodgeConjecture.general_fourfold`.

## [BenFrohman/FermatPlanes](https://github.com/BenFrohman/FermatPlanes)

What it supplies: the remainder identity

    z^4 + w^4 = (z - ζ w)(…) + (1 + ζ^4) w^4

and the planes Z₁, Z₂ on the Fermat quartic when ζ^4 = -1.

What it does not supply: a CycleSection for a general extra class.

Copies already live in this repo under `Hodge/Attempt/` and
`docs/FERMAT_PLANES.md`. Leave them there. Do not `import Hodge.Attempt.*`
in `Hodge.lean`.

## [BenFrohman/NoetherLefschetz](https://github.com/BenFrohman/NoetherLefschetz)

What it supplies: the theorem that a very general *high-degree*
hypersurface has Hdg² = ℚ h², so the extra-class problem is empty there.

What it does not supply: Hodge on a fourfold that still has extra (2,2)
classes. Do not replace `construct_of_codim_ge_two` by “rank 1”.

## Why they stay out of Hodge.lean

Fermat is a special host. NL is a different locus. Importing either as a
module into the core library would look like a discharge of the general
fourfold sentence. That discharge is not valid.
