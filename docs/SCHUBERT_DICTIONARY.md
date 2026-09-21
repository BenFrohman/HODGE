# The dictionary that does not move

The proper labels are the incidence conditions, not the nicknames.

On `Gr(2,4)`, points are lines in `P^3`. Schubert classes of codimension two
are named by how the line is constrained:

- `σ_2` = lines through a fixed point `p ∈ P^3`
- `σ_{1,1}` = lines contained in a fixed plane `P ⊂ P^3`

Pieri is then forced: `σ_1^2 = σ_2 + σ_{1,1}`.

The two vanishing loci match those conditions on the nose.

- `Π = {p_{12}=p_{13}=p_{23}=0}`. The remaining free coordinates are
  `p_{01}, p_{02}, p_{03}`. Those are the lines through `[1:0:0:0]`.
  That is `σ_2`.
- `Π' = {p_{01}=p_{02}=p_{03}=0}`. The remaining free coordinates are
  `p_{12}, p_{13}, p_{23}`. Those are the lines in the plane `z_0=0`.
  That is `σ_{1,1}`.

So `Π = σ_2` and `Π' = σ_{1,1}` is the proper assignment. Do not swap them.

## Why the swap keeps appearing

The two classes are easy to interchange because they are interchangeable in
cheap ways, and none of those ways is the definition.

**Duality.** Point ↔ plane in `P^3` is a linear duality. It interchanges
"through a point" with "in a plane," hence interchanges `σ_2` with
`σ_{1,1}`. If someone dualizes the ambient `P^3` and keeps the same symbols,
the labels flip. The geometry is isomorphic; the names are not.

**A naming collision.** One family was called a σ-plane (star: lines through
a point) and the other a ρ-plane (ruled: lines in a plane). Schubert calculus
independently uses the letter σ for every class. Mapping "the σ-plane" to
"σ_{1,1}" is a pun, not an identity.

**The intersection form cannot tell them apart.** On `Q^4`,

```
[Π]·[Π] = [Π']·[Π'] = 1,    [Π]·[Π'] = 0,    h^2 = [Π]+[Π'].
```

Those identities are symmetric in `Π` and `Π'`. Coefficients
`a = γ·[Π]`, `b = γ·[Π']` still work after a swap. The linear algebra of
the Lean datum is therefore blind to the labels. Only the incidence conditions
distinguish them.

**Index conventions.** Some authors index Schubert varieties by strictly
increasing pairs `1 ≤ a1 < a2 ≤ 4` rather than by partitions in a `2×2` box.
On `Gr(2,4)` the conversion is

```
λ_i = (n-k) + i - a_i
```

which sends

```
(1,4)  →  (2,0)  = σ_2
(2,3)  →  (1,1)  = σ_{1,1}
```

The same pairs written 0-based (`0 ≤ b1 < b2 ≤ 3`) are `(0,3)` and `(1,2)`.
Getting that line backwards, mixing a 0-based pair with a 1-based pair, or
converting with `λ_i = a_i - i` instead of `λ_i = (n-k)+i-a_i`, swaps the two
middle classes again. It is another naming map, not another identity.

## How to check, every time

Ignore the letter in front of "plane." Ask one question: what does a general
line in this `P^2 ⊂ Q` do in `P^3`?

- If every such line passes through a fixed point, the class is `σ_2`.
- If every such line lies in a fixed plane, the class is `σ_{1,1}`.

That test is the definition. On this quadric the test says `Π = σ_2` and
`Π' = σ_{1,1}`. Leave them there.
