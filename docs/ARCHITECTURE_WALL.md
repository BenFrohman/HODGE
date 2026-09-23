# Architecture wall: algebraic plane vs unnamed 4-form

Author: Benjamin Stanley Frohman (@BenFrohman).

## Two objects, two sides of cl

    cl : CH^2(X)_Q → H^4(X,Q) ∩ H^{2,2}(X)

Left: algebraic cycles. Right: rational Hodge classes.

### Named plane (geometry side)

Special non-Fermat sextic, e.g.

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6

is one equation of the shape F = x3 A + x4 B + x5 C.
Then Π = V(x3,x4,x5) lies on X = V(F), and γ = [Π] is extra:
[Π]·h^2 = 1, h^4 = 6, [Π]^2 = 21 ≠ 1/6.
This is the easy arrow. See docs/EXTRA_CLASS_SEXTIC.md.

### Unnamed 4-form (class side)

A closed primitive 4-form η with ★η = -η is a real cohomology class.
It is a Hodge class in the Clay sense only if its class lies in
H^4(X,Q) ∩ H^{2,2}(X). A form over R or C is not that intersection.
Star and primitivity do not produce surfaces. No l-adic eigenvalue is attached
until X is defined over a finite field (Tate, a different conjecture).

## What NL actually says

Very general smooth X ⊂ P^5 of degree d ≥ 6:

    Hdg^2(X) = Q h^2.

There is **no** extra rational primitive Hodge class on that fibre.
h^{2,2} can still be large: most of H^{2,2} is not defined over Q.
Do not write “a non-trivial primitive (2,2) Hodge class still exists on a
very general high-degree host.” That sentence contradicts NL.

Extra rational classes live on the Hodge / NL locus (contains a plane,
Fermat, …). That locus is thin.

## What this file does not do

It does not define a Frohmanian curve. It does not prove Hodge.
general_fourfold stays a Prop.
