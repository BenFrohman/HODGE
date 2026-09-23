# genericObstructedFourfold — what was requested and what was not done

Author of the repository record: Benjamin Stanley Frohman (@BenFrohman).

Requested: import this gadget into `Hodge.lean`, and accept the sentence
that remainder terms explode at d = 6 so a universal algebraic extraction
cannot scale.

## Recorded sentences (not omitted)

- Degree does not enter cycle_codimension. Quartic and sextic fourfolds
  both have middle-cycle codim 2. That sentence is true. See
  `Hodge/Attempt/Grading.lean`.
- The vector space of degree-d hypersurfaces in P^5 has dimension
  binom(d+5,5) (homogeneous polynomials, before PGL).
- The Fermat remainder R = (1+ζ^4)w^4 vanishes iff ζ^4 = -1.

## What those sentences do not imply

They do not imply that R grows with d. R does not know d.
They do not imply Hodge fails on a general fourfold.
They do not justify `axiom ¬ HodgeConjecture genericObstructedFourfold`.
That axiom would be a Clay counterexample. It is not supplied.

## Why this file is not imported by Hodge.lean

`Hodge.lean` is the core sentence plus islands plus the guarded axiom.
Importing a gadget whose only geometric claim is “Hodge fails here” would
put a disproof in the default library without a variety or a class γ.
The gadget lives in `Hodge/Attempt/GenericObstructed.lean` as a named
Datum of codim 2 with cl = 0 (same linear shape as Examples.zeroCycle).
No IsVariety instance. The axiom cannot fire on it.
