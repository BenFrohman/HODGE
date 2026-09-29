<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# On disk (public)

Repository: https://github.com/BenFrohman/HODGE  
Visibility: **public**. Branch: `main`.  
Author: Benjamin Stanley Frohman (@BenFrohman). Apache-2.0.

Clay Hodge remains the uninhabited sentence
`∀ X, ∀ γ ∈ H⁴(X,ℚ) ∩ H^{2,2}(X), γ = ∑ a_i [Z_i]`.
This page lists what is actually compiled. It is not that sentence.

## CycleSection on named hosts

| Host | File | Theorem / instance |
|---|---|---|
| `ℙ⁴` | [Hodge/Classical.lean](https://github.com/BenFrohman/HODGE/blob/main/Hodge/Classical.lean) | `constructP4`, `CycleSection` |
| `Q⁴` | [Hodge/Classical.lean](https://github.com/BenFrohman/HODGE/blob/main/Hodge/Classical.lean) | `construct`, `CycleSection` |
| `ℙ² × ℙ²` | [Hodge/Classical.lean](https://github.com/BenFrohman/HODGE/blob/main/Hodge/Classical.lean) | `constructProduct`, `CycleSection` |
| Fermat two-planes | [Hodge/Fermat.lean](https://github.com/BenFrohman/HODGE/blob/main/Hodge/Fermat.lean) | `twoPlanes_hodge` |
| Special sextic span | [Hodge/SpecialSextic.lean](https://github.com/BenFrohman/HODGE/blob/main/Hodge/SpecialSextic.lean) | `planeSpan_hodge` |
| Hassett `C₈` span | [Hodge/Hassett.lean](https://github.com/BenFrohman/HODGE/blob/main/Hodge/Hassett.lean) | `planeSpan_hodge` |
| Finite conjunction | [Hodge/NamedFamilies.lean](https://github.com/BenFrohman/HODGE/blob/main/Hodge/NamedFamilies.lean) | `named_fourfolds` |

## Two memberships on this `F`

    F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6

| Theorem | Ideal | File |
|---|---|---|
| `F_mem_plane` | `I(Π) = ⟨x3, x4, x5⟩` | [Hodge/SpecialSextic.lean](https://github.com/BenFrohman/HODGE/blob/main/Hodge/SpecialSextic.lean) |
| `F_mem_plane_minus1` | `I(Π_{-1}) = ⟨x0+x3, x1+x4, x2+x5⟩` | same file |

Also mirrored in [Hodge/SpecialSexticMembership.lean](https://github.com/BenFrohman/HODGE/blob/main/Hodge/SpecialSexticMembership.lean) (`F_mem_plane` only).

## Hodge on the tiny model

`planeSpan : Datum (ℚ × ℚ) (ℚ × ℚ) ℚ` with `cl = LinearMap.id`.
Theorem: `planeSpan_hodge`. That is `ℚh² + ℚ[Π]` as coordinates. It does not mention `H⁴(V(F), ℚ)` (`dim = 2606`).

## Citation, not coauthorship

BKU Invent. Math. 2023 Cor. 1.6 is cited in [docs/BKU_ATYPICAL.md](https://github.com/BenFrohman/HODGE/blob/main/docs/BKU_ATYPICAL.md).
Frohman is not a coauthor of that paper. This `F` is one named point on the atypical plane-sextic locus.
