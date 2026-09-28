# Monodromy ledger

Author: Benjamin Stanley Frohman. Copyright 2026. Apache-2.0.

Documentation lock only. Not a Lean theorem. Not Term A. Not Term B.
Does not compute a subgroup of \(O(L_{2605})\) as matrices.

## Rank versus group

A smooth sextic fourfold \(X\subset\mathbb{P}^5\) has

```text
b_4 = 2606
rank H^4_prim = b_4 - 1 = 2605
```

\(2605\) is the rank of the lattice a sextic monodromy group would act on.
It is not the group.

## Beauville — what the group is

A. Beauville, *Le groupe de monodromie des familles universelles
d'hypersurfaces et d'intersections complètes*, Lecture Notes in Math.
1194 (1986), 195–207.

Let \(U_{n,d}\) be the space of smooth degree-\(d\) hypersurfaces in
\(\mathbb{P}^{n+1}\). The image \(\Gamma_{n,d}\) of

```text
π_1(U_{n,d}) → Aut(H^n(X, ℤ))
```

on the vanishing lattice is as large as the form allows, up to low-degree
exceptions. For even \(n\) (fourfold: \(n=4\)) and \(d\ge 4\)
(sextic: \(d=6\)):

```text
Mon(U) = Γ_{4,6} = O^#(L),    rank L = 2605.
```

\(O^#\) is the index-2 subgroup of the orthogonal group of the vanishing
lattice (spinor-norm / orientation). That *names* the group. It does not
list the Picard–Lefschetz reflections.

A generic Lefschetz pencil meets the discriminant in

```text
(n+2)(d-1)^{n+1} = 6 · 5^5 = 18750
```

nodes. Each node contributes a reflection

```text
T_δ(x) = x − (x·δ) δ,     δ·δ = 2
```

on middle homology \(H_4\) (fibre dimension \(4\equiv 0\pmod{4}\)).
Those \(\delta_i\) are not written in this repository.

## Deligne — what the group fixes

P. Deligne, théorème de la partie fixe (SGA 7 / Hodge II, 1971).
Monodromy invariants in a fibre of a smooth projective family are the
classes that come from a compactification of the total space. They form
a Hodge substructure.

On the *full* moduli of smooth sextics the only such middle classes are
powers of the hyperplane:

```text
H^4(X, ℚ)^{Mon(U)} = ℚ h^2.
```

That is variational Noether–Lefschetz for this family: a very general
sextic has no extra rational Hodge class of type \((2,2)\).

## The two bases on this host

| Base | Group (Beauville) | Invariants (Deligne) |
|---|---|---|
| All smooth sextics \(U\) | \(O^#(L_{2605})\) | \(\mathbb{Q}h^2\) |
| Sextics through \(\Pi\) | a proper subgroup \(\mathrm{Mon}_\Pi\) | at least \(\mathbb{Q}h^2+\mathbb{Q}[\Pi]\) |

Restriction of \(\mathrm{Mon}_\Pi\) to the plane span is \(\{\mathrm{id}\}\).
The Gram in `Hodge/PlaneSpanPairing.lean` (PR #14 branch) is that fixed
\(2\)-plane, not a generating set of \(\mathrm{Mon}(U)\).

## Inventory: what is not \(\mathrm{Mon}\subseteq O(L_{2605})\)

| Repo / file | Object | Rank / size |
|---|---|---|
| [OmegaZero34](https://github.com/BenFrohman/OmegaZero34) | \(\langle T_1,T_2,T_0\rangle\) on \(\mathbb{Z}^4\); unique \(\Omega_0\) of type \((1,6)\) | **4, not 2605** |
| `Hodge/PlaneSpanPairing.lean` | Gram of \(\mathbb{Q}h^2+\mathbb{Q}[\Pi]\) | 2 |
| `docs/MONODROMY.md` | PL / Beauville / Deligne sketch | says 2605; no group |
| [ThreeChainJacobian](https://github.com/BenFrohman/ThreeChainJacobian) | \(\dim J(F)=15625\), \(h^{2,2}=1752\) | not Mon |
| [SingularityLab](https://github.com/BenFrohman/SingularityLab) / [ChainAtom-u5v-v6](https://github.com/BenFrohman/ChainAtom-u5v-v6) | Milnor of \(u^5v+v^6\) | \(\mu\sim 25\)–30 |
| [orlov-equivalence-VF](https://github.com/BenFrohman/orlov-equivalence-VF) | \(D^b(V(F))\simeq\mathrm{HMF}^{gr}(F)\) | not Mon |
| [fourfold-structural-template](https://github.com/BenFrohman/fourfold-structural-template) / [HODGE-DISPROOF](https://github.com/BenFrohman/HODGE-DISPROOF) | Term A/B schema | uninhabited |
| NS tether repos | different program | word only |

## What this file does not do

- Does not inhabit `HodgeConjecture.general_fourfold`.
- Does not produce a Clay counterexample triple.
- Does not write \(2605\times 2605\) matrices.
- Does not identify \(\Omega_0\) with the sextic vanishing lattice.
