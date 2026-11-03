# Plane-span pairing (Lean)

Copyright 2026 Benjamin Stanley Frohman (@BenFrohman).
License: Apache-2.0.

File: `Hodge/PlaneSpanPairing.lean`.

Proved (`decide`):

    h²·h² = 6,  h²·[Π] = 1,  [Π]² = 21,  disc = 125
    S = h² - [Π]
    S·h² = 5,  S·[Π] = -20,  S² = 25
    β = h² - 6[Π]
    β·h² = 0,  β·[Π] = -125,  β·S = 125,  β² = 750

These numbers are the Gram form of ℔ h² + ℔ [Π] on the special sextic.
They are not a monodromy group.

Beauville / Deligne / Picard–Lefschetz remain literature in the TeX note.
`Mon_Π` and its index are not computed. The Milnor operator of
`u^5 v + v^6` is a different group.
