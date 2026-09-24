# Local artifact tree → GitHub (BenFrohman/HODGE)

Author: Benjamin Stanley Frohman (@BenFrohman).

The live repository on GitHub is the current library. The workspace
`/home/workdir/artifacts/HODGE-lean/` is an older, smaller snapshot
(Basic, Examples, Fourfold, Frontier, Integral, Known, Quadric). It must
not replace Hodge/ on this repo.

## Already on public main

Lean modules under Hodge/ (including SpecialSextic, Classical, Construct,
Klein, Hassett, JacobianLength, Attempt/). Docs under docs/ including
F_HOST, KNOWN_BASES, DERIVED, CONSTRUCT, CORRESPONDENCES,
STANDARD_CONJECTURES, CUBIC_FOURFOLD, EXTRA_CLASS_SEXTIC,
CYCLE_CLASS_AND_CONSTRUCTOR.tex.

## On this branch / PR #2 (not yet on main)

- docs/FINDINGS.md
- docs/DERIVED_TORELLI.md
- docs/ARTIFACTS.md (this file)
- papers/ source notes copied from the local artifact tree

## Local artifacts that are dated or not source

Do not upload:
- *.aux *.log *.out *.toc
- browsed_files/ cache
- searched_images/
- HODGE-lean.zip as a replacement for Hodge/

## Local papers (workspace artifacts)

| Local file | GitHub path |
|---|---|
| frohman-hodge-source-note.tex | papers/frohman-hodge-source-note.tex |
| frohman-hodge-cycle-class-inverse.tex | papers/frohman-hodge-cycle-class-inverse.tex |
| frohman-hodge-integrated.tex | papers/frohman-hodge-integrated.tex |
| frohman-hodge-lean-audit.tex | papers/frohman-hodge-lean-audit.tex |
| frohman-hodge-quadric-constructor.tex | papers/frohman-hodge-quadric-constructor.tex |
| hodge-logconcavity-inventory.tex | papers/hodge-logconcavity-inventory.tex |
| CYCLE_CLASS_AND_CONSTRUCTOR.tex | already docs/CYCLE_CLASS_AND_CONSTRUCTOR.tex |

PDFs are build products; source tex is what belongs in git.

Merge PR #2 as BenFrohman to land FINDINGS, DERIVED_TORELLI, ARTIFACTS, and papers/ on main.
