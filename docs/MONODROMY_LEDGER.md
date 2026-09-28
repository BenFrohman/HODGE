# Monodromy notes

Author: Benjamin Stanley Frohman. Copyright 2026. Apache-2.0.

Working notes. Editable. Not a theorem. Not Term A. Not Term B.
Does not compute a subgroup of O(L_2605) as matrices.

## Rank versus group

A smooth sextic fourfold X subset P^5 has

```text
b_4 = 2606
rank H^4_prim = b_4 - 1 = 2605
```

2605 is the rank of the lattice a sextic monodromy group would act on.
It is not the group.

## Beauville — what the group is

A. Beauville, *Le groupe de monodromie des familles universelles
d'hypersurfaces et d'intersections complètes*, Lecture Notes in Math.
1194 (1986), 195–207.

Let U_{n,d} be the space of smooth degree-d hypersurfaces in P^{n+1}.
The image Γ_{n,d} of π_1(U_{n,d}) → Aut(H^n(X, Z)) on the vanishing
lattice is as large as the form allows, up to low-degree exceptions.
For even n (fourfold: n=4) and d≥4 (sextic: d=6):

```text
Mon(U) = Γ_{4,6} = O^#(L),    rank L = 2605.
```

O^# is the index-2 subgroup of the orthogonal group of the vanishing
lattice (spinor-norm / orientation). That names the group. It does not
list the Picard–Lefschetz reflections.

A generic Lefschetz pencil meets the discriminant in

```text
(n+2)(d-1)^{n+1} = 6 · 5^5 = 18750
```

nodes. Each node contributes a reflection

```text
T_δ(x) = x − (x·δ) δ,     δ·δ = 2
```

on middle homology H_4 (fibre dimension 4 ≡ 0 mod 4).
Those δ_i are not written in this repository yet.

## Deligne — what the group fixes

P. Deligne, théorème de la partie fixe (SGA 7 / Hodge II, 1971).
Monodromy invariants in a fibre of a smooth projective family are the
classes that come from a compactification of the total space. They form
a Hodge substructure.

On the full moduli of smooth sextics the only such middle classes are
powers of the hyperplane:

```text
H^4(X, Q)^{Mon(U)} = Q h^2.
```

That is variational Noether–Lefschetz for this family: a very general
sextic has no extra rational Hodge class of type (2,2).

## The two bases on this host

| Base | Group (Beauville) | Invariants (Deligne) |
|---|---|---|
| All smooth sextics U | O^#(L_2605) | Q h^2 |
| Sextics through Π | a proper subgroup Mon_Π | at least Q h^2 + Q[Π] |

Restriction of Mon_Π to the plane span is {id}.
The Gram in Hodge/PlaneSpanPairing.lean (PR #14 branch) is that fixed
2-plane, not a generating set of Mon(U).

## Inventory

| Repo / file | Object | Rank / size |
|---|---|---|
| OmegaZero34 | ⟨T_1,T_2,T_0⟩ on Z^4; unique Ω_0 of type (1,6) | 4, not 2605 |
| Hodge/PlaneSpanPairing.lean | Gram of Q h^2 + Q[Π] | 2 |
| docs/MONODROMY.md | PL / Beauville / Deligne sketch | says 2605; no matrices |
| ThreeChainJacobian | dim J(F)=15625, h^{2,2}=1752 | not Mon |
| SingularityLab / ChainAtom-u5v-v6 | Milnor of u^5 v + v^6 | μ ~ 25–30 |
| orlov-equivalence-VF | D^b(V(F)) ≃ HMF^{gr}(F) | not Mon |
| fourfold-structural-template / HODGE-DISPROOF | Term A/B schema | uninhabited |
| NS tether repos | different program | word only |

## Scope of this note

- Does not inhabit HodgeConjecture.general_fourfold.
- Does not produce a Clay counterexample triple.
- Does not write 2605×2605 matrices.
- Does not identify Ω_0 with the sextic vanishing lattice.
You can edit or delete this file.
