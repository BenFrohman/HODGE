# Meaning of F (SpecialSextic)

Author: Benjamin Stanley Frohman (@BenFrohman).
This is the one fourfold in the library written as a polynomial with a proved
plane membership. Geometry of the shape is classical special NL. The named
host, the membership certificate, and planeSpan are the repo object.

## Equation

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6
      = x3 (x0^5 + x3^5) + x4 (x1^5 + x4^5) + x5 (x2^5 + x5^5)

Shape: F = x3 A + x4 B + x5 C. Simplest writing that forces a plane on a
degree-6 fourfold in P^5 — the first range where extra (2,2) classes are
interesting, and not a Schubert cell space.

    Π = {x3 = x4 = x5 = 0},    I(Π) = ⟨x3, x4, x5⟩

Certificate: Hodge.SpecialSextic.F_mem_plane / hypersurface_contains_the_plane.
Smoothness of the affine cone: gradient_only_origin / affine_cone_isolated_at_origin.

## What planeSpan is

    Q h^2 + Q [Π]

h^2 — surface every hypersurface has (linear section X ∩ P^3).
[Π] — extra class earned by putting the plane on X.
Coordinates (a, b) mean a h^2 + b [Π]. construct γ := γ. cl = id.

That is the algebraic lattice of this special member of the Noether–Lefschetz
locus of sextics. Special ⇒ extra algebraic surface, written so Lean sees
membership.

Not: full H^{2,2} of a general sextic, not a K3 lattice, not F_d, not C_d.

## Partner / moduli

None of Hassett type. h^{3,1} of a sextic fourfold is large (~426), not 1.
No Kuznetsov component ≃ D^b(S). The only partner is the NL locus of sextics
containing this plane (naive dimension 433). Formal analogue of a Hassett
divisor, not C_d and not ordinary F_d.

F lives on the plane-containing NL component of sextic fourfolds.
SpecialSextic.planeSpan is the two-class algebraic lattice on that host.

See also docs/EXTRA_CLASS_SEXTIC.md, docs/CUBIC_FOURFOLD.md, docs/KNOWN_BASES.md.
