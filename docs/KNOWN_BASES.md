# Known bases of Hdg^k

Author: Benjamin Stanley Frohman (@BenFrohman).
A known basis means you can name cycles Z_i that span Hdg^k(X).
This library encodes the first kind below. It does not infer a basis for a variable X.

## Always known (easy arrow + Lefschetz)

Powers of the hyperplane: h^k = [X ∩ P^{N-k}]. On a fourfold, h^2 is the class
of a linear surface section. That is one cycle, not a basis of all of Hdg^2
unless Noether–Lefschetz says extras vanish.

## Known because the variety is cellular

Schubert cycles on Grassmannians / Q^4: σ_2, σ_{1,1}.
Cells on P^4.
Künneth products h_1^2, h_2^2, h_1 h_2 on P^2 × P^2.
These are the three classical hosts.

## Known on special loci

A plane Π ⊂ X (or a rational surface, a scroll) that X contains.
Then {h^2, [Π]} spans a 2-dimensional algebraic lattice.
The special NL sextic and Hassett C_8 are this.
The full Hdg^2 may be larger; the written basis is only that span.

## Known by a theorem, not by listing equations

Zucker, Compositio 34 (1977) 199–209: every rational (2,2) class on a smooth
cubic fourfold in P^5 is algebraic. The basis exists; it is not written as
ideals in this repo except a plane on one special host.
Lefschetz (1,1): divisors on any X.
Murre (1977): Hodge for unirational fourfolds.

## Not inferred from the name “fourfold”

A general Calabi–Yau fourfold, a general type fourfold, S × S, S^{[2]},
a very general sextic (NL: extra class is 0, so only a h^2).
There is no Schubert-type list to infer.

## Repo

Encoded: cells / Schubert / h^k / a plane on a special host / divisor language.
Cited, not formalized: Zucker, Murre.
Open: a basis of Hdg^2 for a variable extra-class fourfold.
That last object is general_fourfold, still a Prop.
