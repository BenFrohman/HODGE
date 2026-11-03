<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# The sign plane on this host

Author: Benjamin Stanley Frohman  
Copyright (c) 2026 Benjamin Stanley Frohman  
License: Apache-2.0

Host:

```
F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6
X = V(F) subset P^5
```

## Plane that is cut

```
Π_{-1} = { x0 + x3 = x1 + x4 = x2 + x5 = 0 }
I(Π_{-1}) = <x0+x3, x1+x4, x2+x5>
```

Identity, `by ring`:

```
x^5 + y^5 = (x+y)(x^4 - x^3 y + x^2 y^2 - x y^3 + y^4)
```

so

```
F = x3(x0+x3)(…) + x4(x1+x4)(…) + x5(x2+x5)(…)
  ∈ I(Π_{-1}).
```

Hence `Π_{-1} subset X`. Easy arrow: `[Π_{-1}]` is Hodge.

More generally, any `ζ` with `ζ^5 = -1` gives a plane `{x0=ζ x3, x1=ζ x4, x2=ζ x5}`. The case `ζ = -1` is the real form above.

## Plane that is not on this host

`{x0=x1=x2=0}` substitutes to `x3^6+x4^6+x5^6 ≠ 0`.

## What this does not do

Writing `I(Π_{-1})` raises `dim im(cl)` from 2 to 3 if the three classes `h^2`, `[Π]`, `[Π_{-1}]` stay independent. It does not construct `z` for an arbitrary Hodge class. `Z` uncomputed. Hodge open.
