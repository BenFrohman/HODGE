# TRUTH GATE — the GOD gate. Read this first.

Author: Benjamin Stanley Frohman. This file is the root instruction for every person and every
automated agent (every bot) that touches this repository. Load it before any other file.

**Only truth and honest, kernel-proved theorems pass this gate. Nothing from this repository is
published, released, deposited on Zenodo, cited or claimed unless the `truth-gate` check is green
on the exact commit being cited.** That is why it is the GOD gate: it sits above every other
check, and no other green check can stand in for it.

## The issue this gate fixes

A paper states its claim in English. Lean can only prove `formal_claim ↔ paper_claim` once
`paper_claim` is itself written in Lean. If `paper_claim` were simply *defined to be*
`formal_claim` (or an alias of it, or something that unfolds to it), the theorem
`intended_correspondence` would be `Iff.rfl`: it would be empty and prove nothing about the
paper. A green certificate could then "certify" a statement different from the one the paper
makes (drift), whether by accident or by an injected instruction.

## The fix rule (binding, permanent)

1. `paper_claim` is an **independent Lean transcription of the paper's exact claim**, written in
   the paper's own terms, with every hypothesis the paper states. The verbatim English quote,
   the paper path, its sha256 and the section are recorded in the doc comment of
   `Semantics.lean` **and** in this file (below).
2. `paper_claim` must **not** be defined as, reference, or trivially alias `formal_claim`.
3. `intended_correspondence : formal_claim ↔ paper_claim` must have a **substantive proof**. It
   may not be `Iff.rfl`, `rfl`, `exact Iff.rfl` or similar, and it may not use the main theorem
   (it is a statement-level equivalence, not "both sides happen to be provable").
4. `formal_claim` is exactly the statement of the repository's main theorem, and
   `paper_claim_holds` is the main theorem transported across the correspondence.
5. Only `propext`, `Classical.choice` and `Quot.sound`. No `sorry`, `admit`, `native_decide` or
   new `axiom` anywhere outside the draft directories in `TRUTH_GATE.lock`.
6. If the paper's English claim cannot be faithfully transcribed, or is not what Lean proves,
   the gate stays **red** and the mismatch is reported. Never patch over it: never weaken
   `paper_claim`, drop a hypothesis, or redefine it to match the formal side. If the
   formalization drifted, rewrite the formalization so it transports across the lock again.
7. Open problems stay hypotheses. No Millennium Prize problem is claimed solved; the gate only
   ensures the certificate proves precisely the locked claim and nothing else.
8. The locked region of `Semantics.lean`, the quote and `TRUTH_GATE.lock` change only with the
   author's explicit sign-off, as a PR that says "new lock" in its title.
9. Commits are authored by Benjamin Stanley Frohman only, with no AI co-author trailers. No
   force-push and no history rewriting.

## What `scripts/verify-lock.sh` checks mechanically

* `lake build` succeeds, with no `sorry` warning outside the draft directories;
* no `sorry` / `admit` / `native_decide` / `axiom` token outside the draft directories
  (comments and strings excluded);
* `Semantics.lean` has `PAPER_PATH`, `PAPER_SHA256`, `PAPER_SECTION` and a verbatim
  `PAPER_QUOTE`; the hash matches the paper file and the quote occurs in it; this file carries
  the same path, hash and quote;
* the lock region hash matches `TRUTH_GATE.lock`;
* `paper_claim`'s body does not mention `formal_claim`; the correspondence is not proved by
  `Iff.rfl`/`rfl`;
* in Lean: the bodies of `formal_claim` and `paper_claim` differ, the two are not
  definitionally equal, the correspondence proof does not reach the main theorem, the main
  theorem's statement is `formal_claim`, `paper_claim_holds` goes through the correspondence,
  and `#print axioms` shows only the three standard axioms.

What it cannot check: whether the transcription is the right reading of the English. That
reading is fixed once, in writing, below and in `Semantics.lean`, and is the author's sign-off.

## Running the gate locally

```
lake exe cache get
bash scripts/verify-lock.sh
```

Reports are written to `truth-gate-report/`.

## The locked claim of this repository

* Paper: `paper/hodge_sextic/hodge_sextic.tex`
* sha256: `8442be3d0a1972445477219a1a5ec344e3c71e2daf34ad9015f179824c458bad`
* Section: Section "The Jacobian module R_12 has dimension 1751" (sec:r12), Theorem thm:r12 in full (dimension AND basis), with the definition of standard monomials in sec:r12 and F from Section "The variety"
* Main theorem(s): `Hodge.ChainSexticR12.jacobianDeg12_finrank_eq`, `Hodge.ChainSexticRank.stdTriples12_card`, `Hodge.ChainSexticR12.stdMonomial_linearIndependent`, `Hodge.ChainSexticR12.jacobianDeg12_eq_span`
* Lock file: `TRUTH_GATE.lock`; semantics: `Hodge/Semantics.lean`

Verbatim quote:

```
Write $y_i=x_{i+3}$ and $f(x,y)=x^5y+y^6=y(x^5+y^5)$, so $F=f(x_0,y_0)+f(x_1,y_1)+f(x_2,y_2)$.

Let $J\subset\Q[x_0,\dots,x_5]$ be the ideal generated by the six partial derivatives
of $F$, $R=\Q[x]/J$, and $R_{12}\subset R$ the image of the homogeneous polynomials of
degree $12$ (\texttt{jacobianDeg12}). Write the pairs as $(x,y)=(x_k,x_{k+3})$, $k=0,1,2$.

A pair monomial $x^ay^b$ is \emph{standard} if $a\le4$, $b\le5$, and not ($a=4$ and
$b\ge1$); there are $25$. A standard triple is a choice of one standard pair monomial
per pair ($25^3=15625$ of them); exactly $1751$ have total degree $12$

\begin{theorem}[\textbf{Lean}, \texttt{jacobianDeg12\_finrank\_eq}]\label{thm:r12}
$\dim_{\Q}R_{12}=1751$, and the classes of the $1751$ standard monomials of degree $12$
form a basis of $R_{12}$ (\texttt{jacobianDeg12\_basis}).
```

```lean
def formal_claim : Prop :=
  Module.finrank ℚ Hodge.ChainSexticRank.jacobianDeg12 = 1751 ∧
    Hodge.ChainSexticRank.stdTriples12.card = 1751 ∧
    LinearIndependent ℚ
      (fun t : Hodge.ChainSexticRank.stdTriples12 => Hodge.ChainSexticRank.stdMonomial t.1) ∧
    Hodge.ChainSexticRank.jacobianDeg12 = Submodule.span ℚ
      (Set.range fun t : Hodge.ChainSexticRank.stdTriples12 =>
        Hodge.ChainSexticRank.stdMonomial t.1)

def paper_claim : Prop :=
  Module.finrank ℚ pR12 = 1751 ∧
    pStd12.ncard = 1751 ∧
    LinearIndependent ℚ (fun d : pStd12 => Ideal.Quotient.mk pJ (monomial (d : Fin 6 →₀ ℕ) (1 : ℚ))) ∧
    Submodule.span ℚ (Set.range fun d : pStd12 =>
      Ideal.Quotient.mk pJ (monomial (d : Fin 6 →₀ ℕ) (1 : ℚ))) = pR12
```

See the doc comment of `Hodge/Semantics.lean` for the fixed reading of the paper's terms, the scope and the non-vacuity witness.

## Re-audit (2026-11-16): the earlier lock was NOT certifying (superseded by the re-lock below)

Status at the re-audit: **REOPENED. The gate was red on purpose.** `TRUTH_GATE.lock` carries `"certifying": false`, and
`scripts/truth_gate_check.py` fails while it does. Nothing was deleted: `Semantics.lean`, the quotes,
the hashes and the history are unchanged.

Rule applied (Benjamin Stanley Frohman, 2026-11-16):
* There are no partial locks. A lock certifies only a step on the correct path to the full theorem
  that is kernel-proved as the actual true answer, so that the next step can build on it.
* Drifted, dummy, placeholder or stand-in types, names or categories are rejected.
* Cross-ontology connections are not rejected for looking unrelated. The kernel check, and whether
  the piece genuinely helps reach the full structured proof, decide.
* `paper_claim` is an independent transcription of the verbatim paper quote, never an alias of
  `formal_claim`, and the correspondence is never `rfl`/`Iff.rfl`.

Locked claim under review: jacobianDeg12_finrank_eq (dimension clause of Theorem thm:r12)

Why it is reopened:
* Partial lock. Only the dimension clause of Theorem thm:r12 (dim_ℚ R₁₂ = 1751) is locked. Its second clause ("the classes of the 1751 standard monomials of degree 12 form a basis of R₁₂") is not.
* The objects are real: the actual chain sextic F, its Jacobian ideal and the degree-12 piece of ℚ[x]/J. The step is genuine. The kernel audit's definitional-equality check hit its heartbeat cap (inconclusive); the alias, syntactic and transport checks passed.
* Scope: this is not the Hodge conjecture, for this fourfold or in general.

What would re-certify it: Re-lock the complete Theorem thm:r12, dimension and basis. Lean already has `stdMonomial_linearIndependent` and `jacobianDeg12_eq_span`.

## Re-lock (2026-11-16): full lock, certifying

With Benjamin Stanley Frohman's approval of 2026-11-16, the lock was replaced by a full lock:
Theorem thm:r12 in full: dim_ℚ R₁₂ = 1751 AND the classes of the 1751 standard monomials of degree 12 form a basis of R₁₂ (count, linear independence in R = ℚ[x]/J, span = R₁₂), with the standard monomials transcribed from the paper's definition as exponent vectors (not the repository's triples).

Previous main theorem(s): `Hodge.ChainSexticR12.jacobianDeg12_finrank_eq`. New main theorem(s): `Hodge.ChainSexticR12.jacobianDeg12_finrank_eq`, `Hodge.ChainSexticRank.stdTriples12_card`, `Hodge.ChainSexticR12.stdMonomial_linearIndependent`, `Hodge.ChainSexticR12.jacobianDeg12_eq_span`. `TRUTH_GATE.lock` is back to `"certifying": true`; the reopen record is kept under `reaudit_history`.
All rules still apply: no `sorry`/`admit`/`native_decide`/new axioms; only `propext`, `Classical.choice`, `Quot.sound`;
`paper_claim` is an independent transcription of the verbatim quote; the correspondence is substantive (not `rfl`/`Iff.rfl`)
and does not use the main theorems; a non-vacuity witness is proved in `Hodge/Semantics.lean`.
