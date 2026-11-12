/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Hodge.ChainSexticCharacterModel.Space
import Hodge.ChainSexticCharacterModel.Roots
import Hodge.ChainSexticCharacterModel.Lines
import Hodge.ChainSexticCharacterModel.Indep
import Hodge.ChainSexticCharacterModel.GaloisMin
import Hodge.ChainSexticCharacterModel.Bridge

/-!
# Non-vacuity model of the chain-sextic character bridge

This folder constructs a linear-algebra inhabitant of
`ChainSexticCharacterCore` (and therefore of `ChainSexticCharacterBridge`)
on the compact encoding of the full 27001-dimensional space
`Option (Fin 30 × Fin 30 × Fin 30) →₀ ℚ`.

See `Space.lean` for the compact-to-dense equivalence (`equivDense`) and
the proved identity `finrank ModelH = finrank DenseH = 27001`.  See
`Roots.lean` for the degree-8 algebraic number used to twist mixed orbits,
`Indep.lean` and `GaloisMin.lean` for the eigenlines, and `Bridge.lean`
for the inhabitant of `ChainSexticCharacterCore` on `ModelH` and its
transport to `DenseH`.

This is not the cohomology of the sextic, and it is not geometric truth.
Mathlib still has no cycle class map, Hodge decomposition, Griffiths
residue map, or action of `Aut(ℂ/ℚ)` on the cohomology of a variety.
Those remain hypotheses of the bridge, inhabited here only in a
linear-algebra model.
-/
