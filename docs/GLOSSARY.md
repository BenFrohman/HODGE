<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Glossary

Author: Benjamin Stanley Frohman  
Copyright © 2026 Benjamin Stanley Frohman  
License: Apache-2.0

Short definitions for the words used in this ledger. Not a proof of Hodge.

## Geometry of the host

**Fourfold.** A complex manifold of dimension 4 (real dimension 8). Here, a smooth hypersurface `X = V(F) ⊂ P^5`.

**`P^5`.** Complex projective 5-space. Homogeneous coordinates `[x0 : … : x5]`.

**Hypersurface / host.** The zero set of one homogeneous polynomial. The locked host is the degree-6 fourfold cut by `F = (x0^5 x3 + x3^6) + (x1^5 x4 + x4^6) + (x2^5 x5 + x5^6)`.

**Smooth.** `∇F` vanishes only at the origin in affine space; equivalently `X` has no singular points.

**Calabi–Yau fourfold.** `K_X ≅ O_X`. For a degree-`d` hypersurface in `P^n` this happens when `d = n+1`. Here `d=6`, `n=5`.

## Hodge package (projective)

**Hodge numbers `h^{p,q}`.** Dimensions of the pieces of complex cohomology of type `(p,q)`. For every smooth sextic fourfold they are `h^{4,0}=1`, `h^{3,1}=426`, `h^{2,2}_prim=1751`, `h^{2,2}=1752`, `b_4=2606`.

**Primitive cohomology.** The part of `H^4(X)` orthogonal to the Lefschetz operator (here: everything except the span of `h^2`).

**`h^2`.** Square of the hyperplane class. Always algebraic.

**Hodge class / `Hdg^2(X)`.** A class in `H^4(X,Q) ∩ H^{2,2}(X)`. Rational and of type `(2,2)`.

**Cycle class map `cl`.** Sends a rational combination of subvarieties to its cohomology class. Easy direction: `cl(Z)` is always Hodge. Hard direction (the conjecture): every Hodge class is `cl` of something.

**Surface / surface combination.** A codimension-2 subvariety `Z ⊂ X`, or a finite sum `∑ a_i Z_i` with `a_i ∈ Q`. That is the domain of `cl` at `k=2`.

**`[Z]`.** The cohomology class of `Z`. Hodge at `k=2` asks `γ = ∑ a_i [Z_i]`.

**Noether–Lefschetz (NL) locus.** Parameters where extra rational classes become type `(2,2)`. Hodge *numbers* stay fixed; the *rank* of `Hdg^2` over `Q` can grow.

## Jacobian / Griffiths

**Jacobian ring `R`.** `C[x0,…,x5] / (∂F/∂x0, …, ∂F/∂x5)`. For a smooth sextic, dim `R = 5^6 = 15625`.

**Hilbert series.** `H_R(t) = (1+t+t^2+t^3+t^4)^6`. Graded dimensions: `R_0=1`, `R_6=426`, `R_12=1751`, `R_18=426`, `R_24=1`.

**`R_12`.** The degree-12 piece. Griffiths: `H^{2,2}_prim(X) ≅ R_12`. A dimension, not a list of surfaces.

**Griffiths residue.** Identifies a homogeneous polynomial `P` of degree `6q` with a primitive class of type `(4-q,q)` via `Res(P Ω / F^{q+1})`.

## Affine / singularity package

**Milnor fibre `M_F`.** Nearby smooth fibre of the *function* `F : C^6 → C` inside a small ball. Homotopy equivalent to a bouquet of `μ(F)` five-spheres.

**Milnor number `μ`.** `dim C{x}/(∂F) = 15625` for this `F`. Affine length of `R`, not `b_4`.

**Chain atom `W`.** The plane-curve germ `W = u^5 v + v^6`. `μ(W)=25`, `|Aut(W)|=30`.

**Thom–Sebastiani.** `F = W ⊕ W ⊕ W` in disjoint variables. Milnor numbers multiply: `25^3 = 15625`.

**Steenbrink spectrum.** Rational numbers attached to a Jacobian basis of an isolated singularity. Determines the eigenvalues of monodromy on the Milnor fibre. Lives on the affine side.

**Monodromy `T_F`.** How vanishing cycles move as you walk around `ε=0`. Here `det(tI - T_F) = (t^6-1)^{2604}(t-1)`.

## Derived / Landau–Ginzburg

**`D^b(X)`.** Bounded derived category of coherent sheaves on `X`. Complexes of sheaves, up to quasi-isomorphism.

**Matrix factorization / `HMF^{gr}(F)`.** A pair of maps of free modules whose two composites are multiplication by `F`. Homotopy category, graded.

**Orlov equivalence.** For this Calabi–Yau host (`a = d-n-1 = 0`): `D^b(X) ≅ HMF^{gr}(F)`. Two names for one triangulated category. Not a miss class.

**FJRW correlators.** A-model numbers on moduli of spin orbicurves for a Landau–Ginzburg pair `(W,G)`. Not classes in `H^{2,2}(X)`.

## The open slots

**CycleSection.** A function `HodgeClass → Cycle` with `cl ∘ construct = id`. Exists on named hosts in this repo. Missing for an unnamed fourfold.

**Term B / miss class.** A triple `⟨X, γ_bad, p⟩` where `p` proves `cl(z) ≠ γ_bad` for every surface combination `z`. Type written. Fields 2 and 3 empty.

**`γ_bad`.** A Hodge class not in the image of `cl`. Not written.

**Miss witness `p`.** A proof `∀ z, cl z = γ → False`. Can be built from a pairing that kills every `[Z]` and not `γ`. No such pairing is written.
