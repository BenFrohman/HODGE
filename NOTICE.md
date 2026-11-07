# NOTICE

Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman).

This repository is licensed under the Apache License, Version 2.0.
See `LICENSE` for the actual redistribution and notice conditions; this
provenance note adds no license terms. Third-party work remains under its
respective copyright and license.

The current Lean encoding does not fully formalize the geometric sextic Hodge
argument. The separate classical manuscript uses external theorems; neither
this note nor the algebra certificates establish general or integral HC.

## Author of this repository

Frohman, Benjamin Stanley (@BenFrohman) is credited for this repository's original
Lean encoding and documentation. Existing third-party credits/notices are
preserved; this is not a claim of ownership of dependencies or cited mathematics.

## Software this encoding stands on

- [Lean 4](https://github.com/leanprover/lean4) (leanprover)
- [Mathlib4](https://github.com/leanprover-community/mathlib4) (leanprover-community),
  pinned here to v4.22.0

Reuse of Mathlib is under Mathlib's own Apache-2.0 terms. That library is not
this author's work.

## Mathematics this encoding records (not claimed as new theorems)

- W. V. D. Hodge — the Hodge conjecture
- S. Lefschetz — Lefschetz (1,1) and the classical Lefschetz theorems
- H. Schubert — Schubert calculus on Grassmannians, including Gr(2,4)
- F. Klein — the Klein quadric
- M. Noether, S. Lefschetz, and later Hodge-theoretic proofs — Noether–Lefschetz
- S. Zucker (1977) — Hodge for cubic fourfolds
- J. Murre — unirational fourfolds
- C. Voisin — Hodge theory and the integral Hodge conjecture
- E. Cattani, P. Deligne, A. Kaplan — algebraicity of Hodge loci
- P. Griffiths, J. Carlson, M. Green, P. Griffiths, J. Harris — infinitesimal variation / NL
- Clay Mathematics Institute — Millennium problem statement

Naming those results here is citation, not coauthorship and not a claim that
those authors endorse this repository.

## Incremental residue work: provenance and dependency boundaries

The polynomial witness generator uses SymPy 1.14.0. Its installed distribution
has BSD-style terms and additional third-party notices (including Diofant,
multipledispatch, PyDy and latex2sympy components). Its mpmath dependency has
BSD-style terms. These dependencies are installed separately, not vendored by
this change; retaining the repository's Apache-2.0 license does not relicense
them. Redistributing dependency code/binaries requires preserving their own
applicable notices and terms; this document is not a replacement for those files.

The residue argument cites R. Villaflor Loyola, *Periods of complete intersection
algebraic cycles*, Theorem 1.1, doi:10.1007/s00229-021-01290-x, and Griffiths'
Jacobian-ring/Hodge theory. Citation records provenance; it does not claim
coauthorship, endorsement, novelty, or that those geometric theorems have been
formalized in the incremental Lean modules.

The two tracked source-note PDFs have corresponding TeX sources. This bounded
review does not establish complete clearance of every historical artifact,
embedded font, quotation, transitive dependency, or external linked archive.
No existing license, third-party notice, PDF or historical citation identifier
was replaced or relicensed. Any ownership/license ambiguity needs owner review
before redistributing material beyond the rights already established.
