# Extra class on a special sextic fourfold: verified codimension framework

Author: Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.

Permanent record of the linear-plane count. Not a `CycleSection` on an
unnamed fourfold. Not a proof of Hodge.

`HodgeConjecture.general_fourfold` stays a `Prop`.

## Ambient dimension

Host: a hypersurface fourfold

    X = V(F) subset P^5,    deg F = 6,    dim X = 4.

Coordinates `[x0 : x1 : x2 : x3 : x4 : x5]`.

A linear subspace of dimension `k` in `P^5` is the vanishing of
`5 - k` independent linear forms.

| Object in `P^5` | Independent linear forms | Dimension |
|---|---|---|
| hyperplane `P^4` | 1 | 4 |
| `P^3` | 2 | 3 |
| linear plane `P^2` | **3** | 2 |
| line `P^1` | 4 | 1 |
| point | 5 | 0 |

## Verified count: a linear plane on `X`

A **linear plane** `Pi subset X` is a linearly embedded `P^2` contained in `X`.
In the ambient space that means three independent linear forms:

    I(Pi) = <L1, L2, L3>,    dim Pi = 5 - 3 = 2.

Containment `Pi subset X` is ideal membership `F in I(Pi)`, i.e.

    F = L1 A + L2 B + L3 C

with `deg A,B,C = 5`. That identity lives in
[BenFrohman/FermatPlanes](https://github.com/BenFrohman/FermatPlanes)
(`Membership.lean` for the quartic host; the same count for a special
non-Fermat sextic is the writing `F = x3 A + x4 B + x5 C` below).

Standard coordinate plane used as the extra-class example:

    Pi = { x3 = x4 = x5 = 0 } isomorphic to P^2,
    I(Pi) = <x3, x4, x5>.

No twelfth root is required for this plane. Do not put `zeta` in `I(Pi)`.

## Two forms are not a linear plane

Two independent linear forms cut

    V(L1, L2) isomorphic to P^3 subset P^5.

That is a linear threefold in the ambient space, not a linear plane on `X`.

`X cap P^3` is a degree-6 surface in that `P^3` when the intersection is
proper. It is **not** a linear plane. Calling that complete intersection
`Pi` is a dimension error.

One univariate factor `z - zeta w` is one form. Two such factors are two
forms. Neither count is three. The factorization therefore cannot name `Pi`.

## What `Z1 sqcup Z2` is not

On the **Fermat quartic** host, `Z1` and `Z2` are two named linear planes
(`FermatPlanes/LinearPlanes.lean`). Their disjoint union is two algebraic
cycles. Easy arrow: each `[Zi]` is Hodge because each `Zi` is algebraic.

`Z1 sqcup Z2` is **not**:

- a `CycleSection` for an arbitrary Hodge class `gamma`,
- a constructor on a general fourfold,
- a section of `cl` on `HodgeConjecture.general_fourfold`.

`CycleSection` in this repository exists only on named hosts:

- `P^4` -- `constructP4`
- `Q^4` -- `construct` (`Pi = sigma_2`, `Pi' = sigma_{1,1}`)
- `P^2 x P^2` -- `constructProduct`
- cited Fermat quartic datum -- `Hodge/Fermat.lean` (`cl = id` packaging
  the Shioda / Aljovin-Movasati-Villaflor spanning statement; coefficients
  not expanded)

## Invertibility of `1 - zeta eta` does not upgrade to Hodge

A unit in the coefficient ring (or invertibility of a remainder prefactor)
is an algebraic identity condition. It does not:

- produce three independent linear forms,
- prove a class is of type `(2,2)`,
- supply a `CycleSection`,
- discharge `HodgeConjecture.general_fourfold`.

## Univariate factorization: termination boundary

Recorded in `FermatPlanes/SexticPair.lean` for the Fermat sextic host
`sum z_i^6 = 0` in `P^5`:

    z^6 + w^6
      = (z - zeta w) * cofactor6(z,w,zeta) + (1 + zeta^6) w^6.

At `zeta^6 = -1` the remainder vanishes and **one pair** of sixth powers lies
in the principal ideal `(z - zeta w)`.

**Termination.** That identity factors one pair. It names one linear form.
It does not name `I(Pi)`. It does not glue to a surface. It does not map
to a splitting rule `s(X, gamma)`.

The same boundary for degree 4 is `FermatIdentities.lean` /
`docs/REMAINDER_CORRECTION.md`: remainder `(1 + zeta^4) w^4` tracks whether
one named pair lies on the Fermat quartic. It does not track other surfaces
on other fourfolds.

## Special non-Fermat sextic (easy arrow only)

If `F = x3 A + x4 B + x5 C` with `deg A,B,C = 5` and `X = V(F)` smooth,
then `Pi subset X` by writing. Literature intersection numbers on that host:

    [Pi] . h^2 = 1,    h^4 = 6,    [Pi]^2 = 21 != 1/6.

So `gamma := [Pi]` is not a multiple of `h^2`, and `gamma = 1 * [Pi]`. That is the
easy arrow on this one plane. It is not a constructor for every extra
`(2,2)` class on every degree >= 6 fourfold.

This host is not `sum z_i^6 = 0`. Do not mix the two sextics.

## Firewall

- Ideal membership stays in FermatPlanes.
- `CycleSection` stays on the named hosts listed above.
- `general_fourfold` stays a `Prop`.
- No axiom `construct_of_codim_ge_two`.
- Clay is open.

## 5. Global Epilogue and Mathematical Status

The local ideal membership `F in <x3, x4, x5>` verified herein represents a
structural identity on a specialized host. It does not provide an abstract
mapping mechanism for an arbitrary variety.

To bridge the foundational gap to the global conjecture, the codebase lacks
and strictly requires one of three explicit structural pieces:

* A universal `CycleSection` constructor valid for a generic `general_fourfold`.
* A certified `CycleSection` tracking an extra class on a special degree-`>= 6`
  variety written explicitly as a collection of algebraic surfaces.
* A formal counterexample pair `(X, gamma)` establishing that a specific Hodge
  class is topologically blocked from receiving an algebraic cycle representation.

Without these explicit signatures, `classical_fourfolds` functions purely as a
skeleton tracking the three classical configurations where the cycle class map
is already historically known to be onto. Grothendieck's Conjecture B remains
unimplied, and the Clay Millennium Problem remains completely open.
