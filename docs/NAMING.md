# Naming etiquette

Author: Benjamin Stanley Frohman (@BenFrohman).

Lean identifiers stay short so imports compile. Prose and module headers
use the recognized names. Do not coin a personal name for a classical object.

| Lean id | Recognized name | What it is |
|---|---|---|
| `SpecialSextic.F` | special NL sextic (plane locus); hypersurface in P^5 containing a plane | one F = x3 A + x4 B + x5 C |
| `F_mem_plane` | the plane lies on X | easy arrow γ = [Π] |
| `gradient_only_origin` | isolated singularity of the affine cone / X smooth | case split on ∇F |
| `five_pow_six` | 5^6 = 15625 | arithmetic |
| `planeSpan` | Q-span of [Π] and h^2 (coefficient shadow) | cl = id on Q² |
| `kleinQuadric` | Klein quadric Q^4 ≅ Gr(2,4) | Schubert / two rulings |
| `projectiveFourSpace` | P^4 | cells |
| `productOfPlanes` | P^2 × P^2 | product |
| `PartialsRegular` | regular sequence of partials (Mathlib IsRegular) | no instance yet |
| `HomogeneousCILength` | Macaulay / CI length d^n | no instance yet |
| `general_fourfold` | Hodge conjecture for (2,2) on a fourfold | open Prop |

Do not use in prose: Frohmanian curve, Frohman polynomial, FixedSexticHost as a theorem title, clay-freeze as a math result.

Authorship of the Lean files remains in the copyright header. That is not a new name for the geometry.
