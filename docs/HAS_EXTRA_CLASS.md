# The geometric predicate

**Author:** Benjamin Stanley Frohman  
**Copyright:** © 2026 Benjamin Stanley Frohman  
**License:** Apache-2.0

`ExtraClass` is the geometric predicate

\[
\mathrm{Hdg}^2(X)\;\text{larger than}\;\mathbb{Q}\,h^2.
\]

That is a field of the host, not a tautology.

```lean
structure Hypersurface where
  degree : Nat
  isVeryGeneral : Prop
  hasExtraClass : Prop

def ExtraClass (X : Hypersurface) : Prop :=
  X.hasExtraClass
```

`hasExtraClass : Prop` is the honest encoding. It is not
`degree = 0 ∧ degree ≠ 0`. That dummy is deleted on
`NoetherLefschetz` branch `prop-not-axiom`.

A term of `VanishingOfExtraClasses` would force `hasExtraClass = False`
for every very general host of degree ≥ 3. That term is Beauville + Deligne.
It is not in this file.
