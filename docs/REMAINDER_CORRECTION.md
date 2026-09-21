# Correction: what the remainder does and does not do

Author: Benjamin Stanley Frohman (@BenFrohman).

## The identity (unchanged)

For any commutative ring and any ζ,

    z^4 + w^4
      = (z - ζ w)(z^3 + ζ z^2 w + ζ^2 z w^2 + ζ^3 w^3)
        + (1 + ζ^4) w^4.

Call R = (1 + ζ^4) w^4 the remainder.

## What is true

- R is a polynomial identity term. It is not a cohomology class and not
  a period.
- R = 0 if and only if ζ^4 = -1 or w = 0. So the *specific* linear plane
  z = ζ w (and the two companion pairs) lies on the Fermat quartic
  ∑ z_i^4 = 0 precisely at those roots.
- If you change ζ off that locus, *those* planes leave *that* host.
- That is the scope of the identity in `FermatIdentities.lean`.

## What was overclaimed (“remainder explosion”)

The following sentences are **not** theorems of R:

- R becomes large on a dense open of the moduli space of fourfolds.
- R is an obstruction class in primitive cohomology.
- At degree d = 6 the same remainder “explodes” and blocks every constructor.
- Therefore no CycleSection can exist on a general fourfold.
- Therefore Hodge is unprovable, disproved, or independent of ZFC.

R does not know about moduli of hypersurfaces, Hodge loci, or colon ideals.
A special sextic containing a plane uses F = x_3 A + x_4 B + x_5 C, which
has no ζ and no R.

## Corrected one-line

The remainder tracks whether one named family of linear planes lies on the
Fermat quartic. It does not track whether some other surfaces exist for some
other Hodge class on some other fourfold.
