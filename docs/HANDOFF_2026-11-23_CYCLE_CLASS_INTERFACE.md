# Handoff package for GitHub Actions and Zenodo bots

**Date:** 2026-11-23  
**Author:** Benjamin Stanley Frohman  
**Scope:** Abstract interface only. Does not complete the geometric cycle class map.

## Purpose

This document collects drafts, documents, logs, and context from the recent conversation on formalizing the geometric cycle class map (via Chow groups + Poincaré duality) so that the GitHub Actions bot and Zenodo bot can handle remaining PR/merge and publication steps. Nothing is left out that is relevant to the abstract `GeometricCycleClassData` interface.

## Current repository state (BenFrohman/HODGE)

- `Hodge/GeometricCycleClass.lean` is present on `main` (SHA of the file content as of the last fetch). It is an abstract structure:
  - Fields for rational Chow group `CH`, singular homology `H_sing`, singular cohomology `H_coh`, fundamental class `fund`, Poincaré duality `PD`, off-diagonal obstruction.
  - `cycleClassMap` defined as the composition `PD ∘ fund`.
  - Easy arrow `algebraic_le_hodge` proved from the supplied hypothesis `fund_isHodge`.
  - `HodgeConjecture` restated as the reverse inclusion.
- The file lives in namespace `Hodge.GeometricCycleClass` to avoid colliding with existing `Hodge.HodgeConjecture` results on the pure linear-algebra `Datum`.
- Compile fixes applied (OffDiagonal as a field, noncomputable, extra import). No geometric fields are inhabited. No `sorry`. Standard axioms only.
- Existing workflows (Lean, Kernel certificate, Paper, truth-gate) have run successfully on recent merges (e.g. PR #60).

## Honest-scope statement (must be preserved)

The geometric cycle class map is **not** constructed. Mathlib (pinned v4.22) does not contain Chow groups of schemes, fundamental classes of subvarieties, Poincaré duality for complex projective varieties, or the comparison with the Hodge filtration. The structure records the classical construction as an interface whose fields remain to be supplied. This is consistent with the earlier vacuity audit (HODGE PR #46) that replaced identity cycle-class maps with explicit hypotheses.

## Related prior artifacts

- Zenodo record: https://zenodo.org/records/23629480 (The Cycle Class Map, the Reverse Arrow, and a Classical Constructor on Three Fourfolds). Correction note already present for the vacuity audit.
- Companion papers listed in that record: `CYCLE_CLASS_AND_CONSTRUCTOR.pdf`, `frohman-hodge-source-note.pdf`.
- Other related Zenodo: cubic fourfold correspondence note, HODGE-DISPROOF schema.
- Existing skeleton: `Hodge/Basic.lean` (`Datum` with abstract `cl`), `Hodge/Chow.lean` (minimal `ChowData`).

## Pending items from earlier in the conversation

The following open PRs were flagged for the bot earlier (status as of last check):
- https://github.com/BenFrohman/overemployed-job-bot/pull/31
- https://github.com/BenFrohman/quadratic-residues-lean/pull/1
- https://github.com/BenFrohman/p2q-jumps-lean/pull/2

## Conversation context summary

User requested completion of the geometric body of the cycle class map given that the Lean HODGE code is a skeleton. Assessment: foundations missing; only an abstract interface is possible. Interface was written, compile-fixed, and placed. User asked to hand everything to the bots for PR/merge and Zenodo publication.

## Instructions for the bots

1. GitHub Actions bot: ensure any remaining integration of `Hodge/GeometricCycleClass.lean` is clean (already on main), run certificate/paper workflows if needed, and surface PR links in the bot chat.
2. Zenodo bot: if a new version or supplement is warranted for the abstract interface (or the correction note), prepare it with the honest-scope language above. Do not claim the geometric map has been formalized.
3. Preserve author metadata: Benjamin Stanley Frohman; no co-authored-by lines from automated tools in commit messages unless explicitly requested.

All relevant drafts and context from the chat are summarized above. The full Lean source is in the repository. No further material is required for the bots to proceed under the honest-scope rule.
