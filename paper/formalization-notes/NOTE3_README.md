<!-- Copyright (c) 2026 Benjamin Stanley Frohman. Licensed under Apache-2.0. -->
# Stage 3 formalization note (REVIEW DRAFT)

Author metadata: **Frohman, Benjamin Stanley**
Email: frohmanbenjamin@gmail.com
ORCID: https://orcid.org/0009-0006-7068-3718
License: Apache-2.0 (preserve repository `LICENSE`/`NOTICE`; no relicense)

**Status:** REVIEW DRAFT. No DOI assigned. No Zenodo write performed here.
Companion to Stage 1–2 algebraic notes under `paper/formalization-notes/`.
Does **not** overwrite Stage 1/2 `README.md` or `PROVENANCE.json`.

## Source

- Mathematical pin: `e56be3d0e848c2098f1d9057dccec324f34bae7f` (unchanged)
- Verified merge tip: `9289b3c6ae3f2f3ef616493737c113a09c255330` (PR #38)
- Module: `Hodge/ExplicitJacobianQuotient.lean`
- PR: https://github.com/BenFrohman/HODGE/pull/38
- Local evidence: `/workspace/hodge-stage3-evidence-20261106/`
  (`PASS: 65 incremental theorem declarations; standard axioms only`)

## Post-merge CI (America/Chicago)

All six Lean / Lean certificate / Paper runs for merges #37 and #38 PASS.
Certificate audits: PR37 PASS 52; PR38 PASS 65 (~18:48 America/Chicago).
Paper CI does **not** build these formalization notes.
See `NOTE3_PROVENANCE.json` for run URLs.

## Artifacts

| File | Role |
|------|------|
| `note3-jacobian-quotient-stage3.tex` / `.pdf` | 13 Jacobian-quotient / common-zero theorems |
| `references.bib` | Shared bibliography (unchanged vs Stage 1/2) |
| `NOTE3_PROVENANCE.json` | Note3 hashes + pins (separate from Stage 1/2 `PROVENANCE.json`) |
| `NOTE3_README.md` | This file |

## Scope

**Proved:** 13 theorems in `Hodge.ExplicitJacobianQuotient` (partials, quotient
relations, Wronskian/HW representatives, $G^2-H^3=f_k$, common-zero exclusion).
Combined audit with Stages 1–2: **65** declarations.

**Not proved:** Sylvester resultant identification; basis independence /
quotient dimension / nonzero classes from coefficients alone; schemes;
geometric Hodge/residue/cycle-class/descent.

## Independent review corrections applied

1. Theorem Wronskian polynomial identity uses $C(w_i)$ / unbarred scalar
   coefficients in $K[x,y]$; bars retained only on the quotient image.
2. Provenance filename is `NOTE3_PROVENANCE.json` (avoids Stage 1/2 collision).
3. Empty independent typecheck log is not treated as axiom evidence; dedicated
   audit logs are cited separately (exit status alone may support typecheck).

## Rebuild

```sh
cd paper/formalization-notes
tectonic note3-jacobian-quotient-stage3.tex
```

## Queued (not started)

Clay actual spatial-bridge paper remains queued pending independent review;
this packaging does not start it.
