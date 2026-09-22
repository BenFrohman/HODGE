# Derived categories (literature note)

Author: Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.

Not a `CycleSection`. Not imported by `Hodge.lean`. Not Tate. Not Clay.

## Object

For a smooth projective `X`, `D^b(X) = D^b(Coh X)` is the bounded derived
category of coherent sheaves. Objects are complexes with coherent cohomology,
up to quasi-isomorphism. Morphisms remember `Ext`.

Bondal–Orlov: if `K_X` or `-K_X` is ample, `X` is reconstructed from `D^b(X)`.

An exact equivalence `D^b(X) ≃ D^b(Y)` is Fourier–Mukai: a kernel
`E ∈ D^b(X × Y)`. If that kernel is a single subvariety `Z ⊂ X × Y`, it is
an algebraic correspondence. That is Hodge on the **product**, the same reverse
arrow as `general_fourfold` for the datum of `X × Y`.

`P^2 × P^2` is already a named host in this repo. A general product is not.

## What this is not

`D^b` does not replace `cl`. A derived kernel does not write `I(Z_i)` from an
arbitrary Hodge class on an unnamed fourfold.
