# Full geometric formalization: bounded first-stage assessment

This is a local work record, not a claim of full formalization, publication,
external peer review, or validation of every mathematical argument.

## Exact baseline and target

Inspected merged HODGE main `dc713e7a0d7d0561c1eac219368643f14c98c916`.
`lean-toolchain` pins Lean 4.22.0; `lake-manifest.json` and the actual installed
mathlib checkout both give `79e94a093aff4a60fb1b1f92d9681e407124c2ca`.
No remote writes are made in this stage.

The full target, stated mathematically rather than with fictitious Lean APIs:
for the actual complex projective hypersurface X cut out by
`sum_j (x_j^5 y_j+y_j^6)=0`, every rational Betti cohomology class in degree
four whose complex comparison image has Hodge type (2,2) is the Betti cycle
class of a rational combination of actual codimension-two subvarieties of X.
Equivalently, the actual `CH^2(X) tensor Q -> H_B^4(X(C),Q)` is surjective
onto rational Hodge classes. Other codimensions follow from genuine Lefschetz
results, not the abstract interface. Individual subvarieties need not be
Q-defined. No integral or general HC statement is intended.

There is not yet a genuine Lean expression for this target in this repository.
`HodgeConjecture` on caller-supplied vector spaces is not that expression.
For surjectivity it is possible to work first with the free Q-vector space on
actual codimension-two subvarieties and their actual topological cycle classes;
constructing the entire Chow ring is not logically necessary. That shortcut
must still construct genuine cycle classes and prove their Hodge type.

## Dependency DAG and present status

```
A actual homogeneous polynomial/graded quotient -> actual projective X
A -> B actual scheme/analytic smoothness and projectivity
B -> C complex manifold/analytic comparison, Betti cohomology, Hodge structure
A+G -> D actual surface ideals -> regular sequence -> reducedness/saturation
C+D -> E geometric cycle classes and Villaflor Loyola residue-class theorem
A -> F actual Jacobian quotient, basis, partial derivatives and determinants
F -> G eight coefficient + discriminant/resultant Bezout nonvanishing proofs
F -> H tensor characters and finite support union
C+F -> I Griffiths identification and geometric group action/eigencharacters
H+I -> J multiplicity-one Fourier orbit-span and rational Galois descent
D+E+G+J -> actual cycle classes span rational Hodge cohomology
```

### A/B: useful algebra and scheme foundations, but no instantiated X bridge

- HODGE `Hodge/SpecialSextic.lean:32-43` defines a scalar-valued polynomial
  expression F. Lines 109-154 prove the gradient has only the origin as zero.
  Those are genuine ring statements, **not** a constructed projective scheme
  with an `AlgebraicGeometry.IsSmooth` proof.
- Pinned mathlib has actual schemes and projective spectra:
  `Mathlib/AlgebraicGeometry/ProjectiveSpectrum/Scheme.lean:833` constructs Proj.
  `Mathlib/AlgebraicGeometry/Morphisms/Smooth.lean:58-61` defines smoothness of
  actual scheme morphisms. Smoothness APIs have limitations explicitly
  described at lines 23-30. These are useful foundations, not a ready-made
  smoothness theorem for this X.

### C/E: principal missing geometric/analytic bridge

- `Hodge/Basic.lean:27-40,49-79`: Datum supplies arbitrary vector spaces,
  obstruction and cycle-class maps as inputs. The generation theorem is
  sound abstract linear algebra but does not instantiate them geometrically.
- `Hodge/Geometry.lean:40-68`: algebraic cycles/cohomology are abbreviations
  for caller spaces; Variety is a string, dimension and Datum, not a scheme.
- `Hodge/Chow.lean:24-26`: ChowData supplies an arbitrary linear map; it does
  not construct cycles modulo rational equivalence or a Betti cycle class.
- `Hodge/SpecialSextic.lean:162-173`: planeSpan/threeSpan use obstruction zero
  and identity cycle-class maps. They are coefficient models, not a substitute
  for the missing geometric realization.
- Pinned mathlib does have real singular chains/homology:
  `Mathlib/AlgebraicTopology/SingularHomology/Basic.lean:32-45`.
  This is not a projective algebraic variety's Betti/Hodge comparison theorem.
- Bounded whole-tree text searches for Hodge structures, Chow groups, cycle
  classes, Betti cohomology, de Rham, Griffiths and Villaflor found no relevant
  implemented comparison/residue theorem. The few hits were unrelated
  comments or nonabelian cocycle classes. This is scoped source evidence,
  not a proof that no alternate formalization could exist elsewhere.
- Consequently Villaflor's theorem remains external classical input; the
  same is true of the required Griffiths/Hodge comparison here. Adding their
  conclusions as fields or hypotheses would not complete formalization.

### D: actual ideal geometry remains open in Lean

- Pinned mathlib has ideals, radical ideals, quotients, polynomial derivatives
  and regular sequences, notably
  `Mathlib/RingTheory/Regular/RegularSequence.lean:134-174`.
- The actual ideals `(Q,C)` and `(L,Q,C)` are not yet constructed and proved
  reduced/saturated in this repository. The classical argument uses finite
  maps, generic smoothness, Cohen--Macaulay/unmixedness and saturation; those
  specific connections are not discharged in Lean. A bounded search found
  no Cohen--Macaulay implementation under that name in the pinned library.
- A direct exact radical/saturation certificate might bypass general CM
  infrastructure; it still must prove equality of actual polynomial ideals,
  not replace the scheme with a chosen abstract object.

### F/G/H: the most tractable incremental work

- Existing `Hodge/ExplicitCurve.lean:19-26,43-87` genuinely proves the section
  relations/containment, not the cohomological formula.
- Existing `Hodge/SexticCertificates.lean:44-66` proves scalar identities
  representing ideal combinations/S-pairs. Lines 70-78 count standard
  monomials. Inspecting statements shows that these are not yet an actual
  quotient-vector-space basis theorem. The comments at 21-23 explicitly
  leave Buchberger/basis consequences external.
- `Hodge/SexticCombinatorics.lean:181-242` proves finite character/list counts
  by kernel computation. Translating those counts into geometric Hodge
  dimensions still needs I. The new Python residue-support/Bézout certificate
  is exact but is not a Lean proof.
- First local implementation: `Hodge/ExplicitResidueAlgebra.lean` proves
  the actual split polynomial factorization, the two-pair factorization,
  the 4x4 determinant factor, and actual formal polynomial differentiation
  giving the W coefficients. It also proves that a root k of the specific
  modulus is nonzero and hence the actual leading W coefficient is nonzero,
  using the existing checked section data. Seven other coefficient
  nonvanishing proofs and the two geometric nondegeneracies remain to port.
- Further finite algebra targets: verify the ten explicit Bezout identities
  as polynomial equalities; prove actual quotient reductions/basis and
  the 480/425/120 support-set equality in Lean. No native-decision trust
  shortcut is needed: identities and finite statements can have kernel proofs.

### I/J: Fourier foundations exist; the geometric representation is missing

- Pinned mathlib `Analysis/Fourier/FiniteAbelian/Orthogonality.lean:56-82`
  proves orthogonality and independence of finite abelian characters.
- `RepresentationTheory/Maschke.lean:114-126` provides equivariant averaging;
  `RepresentationTheory/Character.lean:48-81` supplies representation characters.
- These permit a genuine finite-dimensional orbit-span lemma; none alone
  identifies the representation with this X's actual primitive Betti cohomology.
  Rational extension-of-scalars/Galois-orbit descent also has to be connected
  to that actual rational representation and its Hodge decomposition.

## Scope, effort and next milestone

The first stage is finite algebra, not a geometric HC theorem. The largest
bottleneck is C/E/I, not the finite rank-785 calculation: a genuine Hodge/Betti
comparison and geometric residue-cycle theorem cannot be obtained by checking
more arithmetic or by inhabiting Datum. Full formalization needs a substantial
foundational development project with multiple milestones. No defensible
completion date follows from this bounded inventory; it is not a few routine
PRs. Local ring identities are short work; that does not imply a comparable
schedule for the missing geometry/analysis.

Next narrowly testable milestone: finish the actual polynomial derivative and
Jacobian-quotient algebra, port all ten exact Bezout certificates, and prove
finite support coverage/orbit-span with clearly separated realization
obligations. In parallel, choose a real geometric foundation path for Betti,
Hodge and cycle-class comparison. Do not call a theorem with those realization
obligations still assumed a fully formalized proof of HC for X.

## Completed bounded tests

- `lake env lean Hodge/ExplicitResidueAlgebra.lean`: passes.
- `lake build Hodge.ExplicitResidueAlgebra`: passes (7084 build targets).
- Separate seven-declaration `#print axioms` audit: all depend only on
  `propext`, `Classical.choice`, `Quot.sound` (some use fewer).
- `python3 scripts/check_no_sorry.py`: passes.
- No new axioms, admitted goals, native-decision shortcuts, hypothesis changes
  or arbitrary geometry objects were introduced. The new module is built
  explicitly; it is not silently claimed to be imported by the release root.
- Audit source/output and the original section source snapshot are retained in
  `/workspace/hodge-formal-stage1-evidence-20261106/`.
- This stage changes no existing mathematical source and makes no remote
  writes, new PR, merge, tag, release or submission.
