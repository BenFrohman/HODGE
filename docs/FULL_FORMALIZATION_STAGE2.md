# Incremental residue formalization: exact nonvanishing certificates

Copyright (c) 2026 Benjamin Stanley Frohman. Apache-2.0.
Author: Frohman, Benjamin Stanley.

This stage adds genuine polynomial identities and section-root consequences.
It does not formalize the geometry, prove the full Hodge theorem in Lean,
claim peer review/novelty, or submit/release anything.

## Exact statement semantics

Let K be a characteristic-zero field with its Q-algebra structure. Let k satisfy
exactly the original section-root hypothesis

`k^24+66081312000 k^18-4811512860000 k^12+1167566400000 k^6+583200000=0`.

Write b,c,d,e,g for the actual existing Lean definitions
`ExplicitCurve.sb k`, `sc k`, `sd k`, `se k`, `sg k`, not arbitrary coefficients.
The new final theorems prove that all nine following quantities are nonzero:

```
w0 = 3bg-2ce
w1 = 6g+be-4cd
w2 = 4e-bd-6c
w3 = 2d-3b
u0 = cw0-6
u1 = bw0+cw1
u2 = w0+bw1+cw2
u3 = w1+bw2+ck
disc = b^2-4c.
```

Each `*_ne_zero` theorem assumes only the field/Q-algebra structure and the
actual modulus-root equation. No desired coefficient nonvanishing, numerical
root approximation, irreducibility, geometry, Python-check success, or abstract
Hodge datum is an assumption.

## What Lean actually checks

`Hodge/ExplicitResidueCertificates.lean` defines actual polynomials in Q[X]:
the section modulus, all five section coefficient polynomials, each raw
coefficient polynomial P, and explicit sparse polynomials R,Q,A,B satisfying

`P = R+Q*m` and `A*R+B*m = 1`.

These are polynomial equalities proved in Lean, using polynomial
extensionality over the infinite field Q and exact ring normalization. They
are not data read from a trusted external process at theorem-checking time.
Evaluation lemmas prove that the polynomial section coefficients evaluate to
the existing Lean `sb,sc,sd,se,sg`, and that the nine raw expressions evaluate
to the actual scalar formulas above. Evaluating the two certified identities
at any section root proves the desired nonvanishing. Thus the reduced
polynomial R is not silently substituted for the actual coefficient P.

The module also proves the modulus has degree 24, that an actual complex root
exists using mathlib's algebraic closedness of C, and that all nine quantities
are simultaneously nonzero at such a root. This makes explicit that the
universal root statements are not merely assertions over a field with no roots.

`scripts/generate_residue_certificates.py` computes candidate rational
coefficients with SymPy. It is reproducible generation tooling, not part of
the proof trust base. The generated Lean identities and their consequences
must still typecheck in the pinned Lean/mathlib version. No native-decision
shortcut, admitted proof or new axiom is introduced.

## Boundaries still outstanding

- The tenth Python certificate concerns the H/G resultant. This stage does
  not claim a Lean proof of that actual resultant or common-projective-zero
  consequence. The pinned mathlib resultant is defined through a Sylvester
  determinant; its basic file explicitly lists further resultant theory as TODO.
- The U formulas have been proved nonzero as actual section expressions.
  Their identification with coefficients in the actual Jacobian quotient still
  needs a Lean quotient-reduction/basis theorem. Stage one's formal derivative
  and determinant identities are useful but do not discharge this obligation.
- Actual complete-intersection ideal regularity, reducedness and saturation,
  the geometric residue-cycle theorem, Betti/Hodge comparison, geometric group
  action, and rational geometric spanning remain the larger obligations.
- The initial seven stage-one lemmas and existing mathematical sources remain
  intact. No arbitrary structures were relabeled as the geometry of X.

## Reproduce and audit

```
python3 scripts/generate_residue_certificates.py
lake build Hodge.ExplicitResidueAlgebra Hodge.ExplicitResidueCertificates
python3 scripts/check_residue_axioms.py
python3 scripts/check_no_sorry.py
```

`ResidueAxiomAudit.lean` enumerates every theorem in both incremental modules;
the checker requires complete coverage and only the standard axiom dependencies
`propext`, `Classical.choice`, `Quot.sound`. These are explicit build/audit
targets, not a claim that an older root audit covers unimported files.

## Narrow repository-care review

The original `LICENSE` (Apache-2.0), existing citation archive identifiers,
third-party copyright notices and bundled PDFs are preserved. Existing
`CITATION.cff` already uses the correct family/given names and author email;
its historical version/date/DOI are not relabeled as a new release.
README scope/reproduction, AUTHORS, NOTICE/NOTICE.md, CONTRIBUTING and SECURITY
are synchronized with the actual boundaries of this incremental work.
SECURITY reuses the already published author contact from CITATION/NOTICE;
no address, service, response guarantee or private-reporting feature is invented.

Inspected mathlib's Apache-2.0 license and installed SymPy/mpmath license files.
Those separately installed dependencies retain their own notices/terms;
SymPy's distribution also includes additional third-party notices. No copied
dependency code or vendored binary is added. The two tracked PDFs have matching
TeX sources, but this is not a complete rights/embedded-font/transitive-dependency
clearance audit. No concrete license conflict was found in the limited inspected
material; any future ambiguity needs owner review, not invented relicensing.

## Completed checks in this bounded stage

- Explicit incremental module build: 7085 targets, passed.
- Complete incremental audit: 52 theorem declarations, including the original
  seven, all with standard axioms only; passed.
- Degree 24 and actual complex-root/nonvanishing existence: kernel-checked.
- Byte-for-byte witness regeneration: passed.
- Existing exact projection Python certificate: passed unchanged.
- Python syntax checks, repository no-sorry scan, and whitespace checks: passed.
- LICENSE, CITATION.cff and stage-one Lean source compared byte-for-byte with
  the prior commit: unchanged.
- Mathematical proof checking uses no native-decision shortcut. Ordinary
  `decide +kernel` discharges only closed numerical bounds in the degree proof.
- Audit/build evidence is retained in
  `/workspace/hodge-formal-stage2-evidence-20261106/`.
