# HODGE

[![Lean certificate](https://github.com/BenFrohman/HODGE/actions/workflows/certify.yml/badge.svg)](https://github.com/BenFrohman/HODGE/actions/workflows/certify.yml)
[![Lean](https://github.com/BenFrohman/HODGE/actions/workflows/lean.yml/badge.svg)](https://github.com/BenFrohman/HODGE/actions/workflows/lean.yml)

<!-- ZENODO-PROVENANCE-HEADER -->
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.23629480.svg)](https://doi.org/10.5281/zenodo.23629480)
[![License: Apache-2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![ORCID](https://img.shields.io/badge/ORCID-0009--0006--7068--3718-brightgreen.svg)](https://orcid.org/0009-0006-7068-3718)

> **Author:** Frohman, Benjamin Stanley ([ORCID: 0009-0006-7068-3718](https://orcid.org/0009-0006-7068-3718))
> **Origin Provenance:** `2026-09-19 16:56:32 CDT (Git Initial Commit)`
> **Zenodo Archive & DOI:** [`10.5281/zenodo.23629480`](https://doi.org/10.5281/zenodo.23629480) ([Zenodo Record `23629480`](https://zenodo.org/records/23629480))
> **Primary Manuscript PDF:** [`docs/CYCLE_CLASS_AND_CONSTRUCTOR.pdf`](./docs/CYCLE_CLASS_AND_CONSTRUCTOR.pdf)
> **Copyright & License:** Copyright (c) 2026 Benjamin Stanley Frohman. Licensed under the Apache License, Version 2.0 ([`LICENSE`](./LICENSE), [`NOTICE`](./NOTICE)).
<!-- /ZENODO-PROVENANCE-HEADER -->


**Status:** Draft (finished skeleton, not a Clay close).
**Author:** Frohman, Benjamin Stanley (@BenFrohman)

Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved under the Apache License, Version 2.0.
See `LICENSE`, `NOTICE.md`, `AUTHORS.md`, and `docs/BRANCH_RULES.md`.

The Lean library does **not** yet contain a full geometric proof of the Hodge conjecture for the sextic, and the repository contains no counterexample or proof of the general Hodge conjecture. The separate classical manuscript and the incremental Lean algebra have different verification boundaries, described below.
See `docs/TRICHOTOMY.md`, `docs/CLAY_TAG.md`, `docs/CLAIM_VS_PROOF.md`, `docs/UNIVERSAL_INSTANCE.md`, and `docs/FROHMAN_SPANS.md`.

## Current sextic proof and incremental formalization

The manuscript in `paper/hodge_sextic/hodge_sextic.tex` gives a classical
explicit-cycle argument for one complex sextic fourfold, using the cited
complete-intersection residue theorem and exact support calculations. This is
not a full Lean formalization, an integral/general HC result, a claim that the
individual cycles are Q-defined, or external peer review. The conditional
Fermat-HC descent remains a separate route. Historical DOI/PDF links above
identify the existing archive/source note, not a newly submitted formalization.

The Delsarte working paper is at v1.4. The numerals (1, 426, 1751, 426, 1) recorded there are a kernel-checked Hilbert-series / character-count computation, not a Lean proof that the formalized Jacobian module `R_12` has dimension 1751. Lean proves only `1 ≤ dim R_12 ≤ 1751`; the matching lower bound is not formalized. The explicit-cycle projection step is pen-and-paper and is not Lean-formalized.

`Hodge/ExplicitResidueAlgebra.lean` proves determinant and formal-derivative
identities. `Hodge/ExplicitResidueCertificates.lean` proves exact rational
polynomial reduction/Bezout identities and actual section-coefficient
nonvanishing under the original modulus-root hypothesis. These modules do not
supply the missing geometric cycle-class, Betti/Hodge, or residue-theorem bridge.
See `docs/FULL_FORMALIZATION_STAGE1.md` for the dependency inventory.

`Hodge/ExplicitJacobianQuotient.lean` additionally identifies the actual `W`
and `H*W` representatives modulo the partial derivatives of `k*x^5*y+y^6`.
It proves that the actual section `H,G` have no common homogeneous zero except
the origin, by differentiating the checked section identity. This does not yet
prove a monomial basis, nonzero quotient classes, or the geometric comparison.
See `docs/FULL_FORMALIZATION_STAGE3.md` for exact statements and limitations.

### Reproduce

Use the toolchain pinned by `lean-toolchain` (Lean 4.22.0) and the exact
`lake-manifest.json` dependency revisions; do not replace them with latest.
After installing Lean's standard `elan` toolchain manager:

```sh
lake exe cache get
lake build
python3 scripts/check_no_sorry.py
lake build Hodge.ExplicitResidueAlgebra Hodge.ExplicitResidueCertificates Hodge.ExplicitJacobianQuotient
python3 scripts/check_residue_axioms.py
```

The incremental modules are explicit build targets, not silently included in
an older release-root audit. For the separate exact Python certificate and
reproducible Lean witness generation (Python 3.12 or newer):

```sh
python3 -m venv .venv
. .venv/bin/activate
python3 -m pip install sympy==1.14.0
python3 scripts/explicit_projection_certificate.py
python3 scripts/generate_residue_certificates.py
# Regeneration should leave the generated Lean file unchanged.
git diff --exit-code -- Hodge/ExplicitResidueCertificates.lean
lake build Hodge.ExplicitResidueCertificates
```

SymPy generates candidate witnesses; Lean checks the polynomial identities.
Python success or a clean axiom audit does not by itself formalize geometry.
See `CONTRIBUTING.md`, `SECURITY.md`, `LICENSE`, and `NOTICE.md` for review,
reporting, license, and third-party provenance boundaries.

## Vacuity audit (2026-11-10)

The identity-shadow theorems in the earlier ledger are true for a trivial reason. Each named
host (`P⁴`, Klein quadric, `P²×P²`, Fermat quartic, Hassett cubic, very general cubic, chain
sextic spans, K3) is the datum `cl := LinearMap.id`, `obstruction := 0`, so every vector
counts as both "Hodge" and "algebraic". `named_fourfolds` and the `*_hodgeConjecture` theorems
are therefore statements about identity maps, not about varieties. The audit proves this and
the other vacuities in Lean. It also adds honest, conditional replacements, with a named
spanning hypothesis that is cited, not proved. See `docs/VACUITY_AUDIT.md`. Earlier files are
unchanged because Zenodo records snapshot them; old names are tied to the new names in
`Hodge.HonestHosts.Legacy`. Several declarations are `True`-typed or numeral placeholders, so
the earlier "no `True` gadget" sentence below is inaccurate. Nothing here proves the Hodge
conjecture.

## Earlier abstract-interface ledger

Abstract-interface theorem name: **Named (2,2) spans** (not a geometric HC theorem).
Lean: `HodgeConjecture.named_fourfolds`.
`FrohmanTwoTwoSpans` is an encoding alias of the same finite list.
Not Lefschetz. Lefschetz stops at `k = 1`.

Released terms:

- `HodgeConjecture.named_fourfolds`
- `HodgeConjecture.frohman_two_two_spans` (same term)
- `Fermat.contains_two_planes`

Not released: a term of `HodgeConjecture.general_fourfold` for unspecified `D`.
That `def` is the name of the open sentence

```text
∀ X⁴, ∀ γ ∈ Hdg²(X),  γ = ∑ a_i [Z_i].
```

The holes `?z_of` and `?cl_z_eq` in `docs/UNIVERSAL_INSTANCE.md` stay empty.
No axiom, `sorry`, or `True` gadget.

Live construction details: `docs/CYCLESECTION_BODIES.md`.
Named-span pairing: `docs/HODGE_RIEMANN.md`, `docs/GRAM_VALUES.md`.
`#print axioms` on `named_fourfolds`: `propext`, `Quot.sound` (`docs/PRINT_AXIOMS.md`).

## Derived surfaces (`Hodge/DerivedSurfaces.lean`)

Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0. No `sorry`.

Named library surfaces as objects `O_Z`. Closed numeral facts:

```lean
theorem inventory_card : inventory.length = 8
theorem residual_is_surface : residualQuintic.objectDim = 2
theorem residual_host_is_fourfold : residualQuintic.hostDim = 4
theorem residual_not_partner :
    residualQuintic.objectDim = 2 ∧ residualQuintic.objectDim ≠ 4
theorem every_listed_object_is_a_surface :
    inventory.all (fun s => s.objectDim == 2) = true
theorem every_listed_host_is_a_fourfold :
    inventory.all (fun s => s.hostDim == 4) = true
```

`S` is dimension 2 on the fourfold `V(F)`. It is not the partner `Y`.
`Y` and Term B stay named and empty in `docs/Y_AND_MISS.md`.
This file does not inhabit `general_fourfold` or ClayDisproofTerm.

## Two sentences

**Claim** (no term for unspecified `D`):

```lean
def HodgeConjecture.general_fourfold (D) (_h : D.codim = 2) : Prop :=
  ∀ v ∈ D.hodgeClasses, ∃ z : Z, D.cl z = v
```

**Three-host release:**

```lean
theorem HodgeConjecture.classical_fourfolds :
    HodgeConjecture.ClassicalFourfolds
```

**Longer finite release** (`Hodge/NamedFamilies.lean`):

```lean
def HodgeConjecture.NamedFourfolds : Prop :=
  ClassicalFourfolds ∧
    Fermat.twoPlanes.HodgeConjecture ∧
      SpecialSextic.planeSpan.HodgeConjecture ∧
        Hassett.planeSpan.HodgeConjecture

theorem HodgeConjecture.named_fourfolds : NamedFourfolds
```

That list is six specified hosts:

1. `P^4` — `constructP4`
2. `Q^4` — `construct`
3. `P^2 × P^2` — `constructProduct`
4. Fermat quartic, planes `Z1`, `Z2`
5. Special sextic plane span
6. Hassett `C_8` plane span

`named_fourfolds` is a bigger release than `classical_fourfolds` (3 hosts → 6 hosts).
It is not a bigger statement than Hodge: Hodge is `∀ D`, a list is not `∀`.

`contains_two_planes` is the easy arrow on `V(F)`: `Π, Π_{-1} ⊂ V(F)`.
It is not the reverse arrow on every class of `V(F)`.

## License

Apache License 2.0. Copyright (c) 2026 Benjamin Stanley Frohman.
