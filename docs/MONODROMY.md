# Monodromy at the locked sextic

Author: Benjamin Stanley Frohman. Copyright 2026. Apache-2.0.

A single variety does not have a monodromy group. Monodromy is a representation of the fundamental group of a family. This note computes the numerical invariants of the three groups that can be based at

```text
X = V(F) subset P^5,
F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6.
```

It does not produce a matrix of the monodromy action on the primitive lattice. That lattice has rank 2605. No basis and no vanishing-cycle matrix are in the ledger. Writing one would be a fabrication.

## Three groups, not one

| Group | Base | What is known | What is not |
|---|---|---|---|
| `Mon(U)` | space of all smooth sextics | Zariski-dense in the orthogonal group of the vanishing cohomology (Beauville, literature) | no explicit generators as integer matrices |
| `Mon(pencil)` | one Lefschetz pencil through `X` | 18750 reflections, spanning a lattice of rank 2605 | the reflections themselves |
| `Aut_diag(X)` | this fibre | finite, order 4500, fixes the visible lattice | its action on the complement of rank 2604 |

`Aut_diag(X)` is not `Mon`. A finite automorphism group of one fibre is not the monodromy of a family.

## Computed lattice numbers

Middle Betti number of a smooth sextic fourfold, Griffiths residue:

```text
b_4 = 2606.
```

Grothendieck–Lefschetz gives `H^2(X, Q) = Q h`, so the Lefschetz summand `L P^2` vanishes and

```text
rank H^4_prim = b_4 - 1 = 2605.
```

The only classes invariant under `Mon(U)` are the powers of the hyperplane class:

```text
H^4(X, Q)^{Mon(U)} = Q h^2.     rank 1.
```

Visible algebraic lattice on this special fibre, basis `(h^2, [Pi])`, with `Pi = V(x3, x4, x5)`:

```text
h^2 · h^2 = h^4 = deg(X) = 6
h^2 · [Pi] = 1
[Pi] · [Pi] = 21
```

The self-intersection is `c_2(N_{Pi/X})`. The normal sequence

```text
0 → N_{Pi/X} → O(1)^⊕3 → O(6) → 0
```

gives `c(N) = (1+h)^3 / (1+6h) = 1 - 3h + 21 h^2` on `Pi ≅ P^2`, so the degree is 21.

Gram determinant:

```text
det = 6·21 - 1² = 125 = 5^3.
```

If `[Pi]` were a rational multiple of `h^2`, the intersection `h^2 · [Pi] = 1` would force the multiple `1/6`, and then `[Pi]^2` would be `1/6`. It is 21. So `[Pi]` is not on the line `Q h^2`.

Primitive generator, orthogonal to `h^2`:

```text
β = h^2 - 6[Pi],
β · h^2 = 6 - 6 = 0,
β · β = 6 - 12 + 36·21 = 750.
```

Equivalently `π = [Pi] - h^2/6` has `π · π = 125/6`, and `β = -6π` recovers `36 · 125/6 = 750`.

```text
rank Λ_vis = 2
rank Λ_vis^⊥ inside H^4 = 2606 - 2 = 2604
```

`β` is algebraic: `β = [S] - 5[Pi]` up to the residual identity already on the ledger, and in any case `β` is an integral combination of `h^2` and `[Pi]`. It is fixed by the monodromy of the plane component and is not fixed by `Mon(U)`.

## One loop, counted

The discriminant of degree-`d` hypersurfaces of dimension `n` has degree `(d-1)^{n+1}(n+2)`. Here `n = 4`, `d = 6`:

```text
(6-1)^{5} · (4+2) = 5^5 · 6 = 3125 · 6 = 18750.
```

A generic pencil through `X` therefore meets the discriminant in 18750 nodes. Each node contributes one Picard–Lefschetz reflection in a vanishing class `δ ∈ H_4`. Middle degree 4 is even, so the intersection form is symmetric, `δ` has nonzero square, and the local monodromy is an orthogonal reflection, not a symplectic transvection. These 18750 classes span a lattice of rank 2605. They are not a basis. The reflections were not computed.

## Diagonal automorphisms, computed, and not monodromy

The affine diagonal group with `F(gx) = F(x)` has order `30^3 = 27000`, three copies of the one-block group of order 30. The scalars inside that group are the sixth roots of unity, order 6. The image in `PGL(6)` has order

```text
27000 / 6 = 4500.
```

The same count from the projective equations: 6 choices for each ratio of the three weight-6 coordinates, and 5 fifth-roots on each chain, `36 · 125 = 4500`.

Every such automorphism preserves the coordinate plane `Pi` and the hyperplane class, so it acts as the identity on `Λ_vis`. The representation on the complement of rank 2604 is not computed.

## What a matrix would require

An explicit element of `Mon` as a matrix in `O(H^4_prim, Z)` needs:

1. a basis of the primitive lattice,
2. a chosen loop,
3. the vanishing cycle of that loop in that basis,
4. the intersection numbers of that cycle with the basis.

None of the four is on disk. Beauville's density theorem names the Zariski closure of `Mon(U)`. It does not name a single matrix at `V(F)`.

## What this does not do

- It does not identify `Mon` with a finite group of order 4500, 27000, or 18750.
- It does not put `β` outside the image of `cl`. `β` is algebraic.
- It does not inhabit a Hodge-disproof triple.
- It does not use the form `Ω_0` of `OmegaZero34`. That form is alternating of type `(1,6)` on a rank-4 lattice of the `(3,4,∞)` representation. `H^4(X)` is orthogonal of rank 2606.
