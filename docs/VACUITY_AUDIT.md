# Vacuity audit (2026-11-10)

This audit checks the whole repository (`Hodge`, `HodgeAttempt`, `AxiomPrint`) for theorems that
are true for reasons that have nothing to do with geometry. Each finding below is **proved in
Lean**. Nothing in this repository proves the Hodge conjecture, for any variety. The audit
removes some apparent content; it adds none.

New files (the only Lean changes; every earlier `.lean` file is byte-identical):

| file | role |
|---|---|
| `Hodge/VacuityAudit.lean` | kernel-checked proofs of each vacuity in `Hodge` |
| `Hodge/Attempt/VacuityAudit.lean` | the same for the `HodgeAttempt` sandbox |
| `Hodge/HonestHosts.lean` | honest replacements: abstract cycle class map plus a named spanning hypothesis, non-vacuity, honestly named aliases, the legacy-name table |
| `Hodge/ChainSexticBridgeAudit.lean` | consistency check of the chain-sextic bridges; `R₁₂ ≠ 0` |

`Hodge.lean`, `HodgeAttempt.lean` and `AxiomAudit.lean` only gain import and `#print axioms`
lines. The earlier files are left byte-identical because published Zenodo records snapshot them.
Old names are not deprecated with `attribute [deprecated]`: Lean 4 rejects that attribute on a
declaration from an imported module, and adding it in place would change archived files.
Instead `Hodge.HonestHosts.Legacy` ties each old name to its honest name with a kernel-checked
`HEq` (27 equations).

## Findings

### (a) Geometric maps that are the identity: the "identity shadows"

`VacuityAudit.idShadow V N k` is the datum with `obstruction := 0` and `cl := LinearMap.id`.
In it every vector is both "Hodge" and "algebraic" (`idShadow_hodgeClasses`,
`idShadow_algebraicClasses`), so `HodgeConjecture` holds for every `V` (`idShadow_hodge`), for
example on a 2606-dimensional space (`shadow_rank_2606_hodge`). Each named host is this datum, by
`rfl`:

| host datum | file | equation |
|---|---|---|
| `Classical.projectiveFourSpace` | `Classical.lean` | `p4_is_idShadow` (`V = ℚ`) |
| `Classical.kleinQuadric` | `Classical.lean` | `klein_is_idShadow` (`ℚ×ℚ`) |
| `Classical.productOfPlanes` | `Classical.lean` | `product_is_idShadow` (`ℚ×ℚ×ℚ`) |
| `Fermat.fermatQuartic`, `Fermat.twoPlanes` | `Fermat.lean` | `fermatQuartic_is_idShadow`, `fermatTwoPlanes_is_idShadow` |
| `Hassett.planeSpan` | `Hassett.lean` | `hassett_is_idShadow` |
| `Cubic.veryGeneral` | `Cubic.lean` | `veryGeneralCubic_is_idShadow` |
| `SpecialSextic.planeSpan`, `threeSpan` | `SpecialSextic.lean` | `sexticPlaneSpan_is_idShadow`, `sexticThreeSpan_is_idShadow` |
| `k3Surface` | `Frontier.lean` | `k3_is_idShadow` (codim 1) |
| `Examples.trivialObstruction` | `Examples.lean` | `trivialObstruction_is_idShadow` (codim 0) |

So different "varieties" are literally equal (`distinct_hosts_are_equal`: Klein = Fermat two
planes = Hassett = sextic plane span; `P⁴` = Fermat quartic = very general cubic). And
`NamedFourfolds` ("Named (2,2) spans") unfolds to "four identity shadows satisfy
`HodgeConjecture`" (`namedFourfolds_unfolds`). The `CycleSection` bodies are the identity
function (`klein_section_is_id`).

**Affected theorems** (all true but vacuous as statements about varieties):
`Classical.{projectiveFourSpace,kleinQuadric,productOfPlanes}_hodgeConjecture`,
`Classical.classical_islands`, `Islands.islands_construct`,
`HodgeConjecture.{p4,klein,product,classical_fourfolds,named_fourfolds,frohman_two_two_spans}`,
`Geometry.*_hodge`, `Fermat.{twoPlanes_hodge,fermatQuartic_hodge}`, `Hassett.planeSpan_hodge`,
`Cubic.{veryGeneral_hodge,hassettC8_hodge}`,
`SpecialSextic.{planeSpan_hodge,threeSpan_hodge,special_NL_sextic_coefficient_shadow}`,
`k3Surface_hodge`, `Examples.trivialObstruction_hodge`, and downstream re-exports such as
`Skeleton` / `Release` lists.

`ChowData` puts no condition on its map, so `LinearMap.id` is a valid "cycle class"
(`chowData_id`).

### (b) Hypothesis classes whose field is the conclusion

`cycleConstructor_iff`, `lefschetzOneOne_iff`, `hardLefschetzComplement_iff`, `dimLeThree_iff`,
`zuckerCubic_iff`: each class is equivalent to `D.HodgeConjecture` (plus a codimension equation
for `LefschetzOneOne`). They are not the named theorems (Lefschetz (1,1), hard Lefschetz,
dimension ≤ 3, Zucker), and they are inhabited on the shadows by the shadow theorem
(`dimLeThree_on_p4`: `P⁴` is a fourfold, but the shadow is a `DimLeThree` instance;
`zuckerCubic_on_klein`: the Klein quadric is not a cubic, but the shadow is a `ZuckerCubic`
instance; `hardLefschetz_on_product`). Empty classes: `Cubic.IsCubicFourfold` holds for every datum
(`isCubicFourfold_any`), and `JacobianLength.PartialsRegular` / `HomogeneousCILength` are trivially
inhabited (`partialsRegular_trivial`, `homogeneousCILength_trivial`), so
`length_num_of_hyps` is the unconditional numeral fact `5^6 = 15625`
(`length_num_of_hyps_unconditional`).

### (c) Uninhabitable hypotheses

`NoShadow.GeometricCycleClassDischarged` is `False` (`geometricCycleClassDischarged_iff_false`).

### (d) Definitions that make Hodge-type statements trivial or empty

* `Clay.RationalHodgeCodimTwo` is a sentence about opaque constants with no properties. It
  has the shape `ClayShape` (`clay_is_shape`), and that shape is true under one interpretation
  and false under another (`clayShape_true`, `clayShape_false`). The Attempt version is the
  same (`Attempt.VacuityAudit.globalClay_is_shape`, `forall_shape_true_false`).
* The "refutations" (`Examples.not_every_codim_ge_two`, `Geometry.onVarieties_false_on_Rat`,
  `HodgeConjecture.ungated_codim_two_false`) use `Examples.zeroCycle`, where every class is
  "Hodge" and none is algebraic (`zeroCycle_all_hodge`, `zeroCycle_none_algebraic`). They refute
  the abstract interface, not any statement about varieties. A `Geometry.Variety` is a label, and
  any datum can be named `P^4` (`any_datum_labelled_P4`, `zeroGadget_is_label`).
  `Attempt.genericObstructedFourfold` is the same zero datum (`genericObstructed_eq_zeroCycle`).
* Attempt: `IsProjectiveFourfold` holds by fiat (`isProjectiveFourfold_by_fiat`: a degree-0
  "hypersurface" with `isSmooth := True`). `carriesFermatRecipe` reads a tag
  (`fermatRecipe_is_tag`).

### (e) Overclaiming names

* Theorems of type `True`: `SpecialSextic.jacobian_lock_is_not_general_fourfold`,
  `FermatQuintic.this_is_not_general_fourfold`, `JacobianLength.this_is_not_general_fourfold`,
  `Examples.zeroCycle_is_not_a_variety_sticker`, `Cubic.no_universal_cubic_section`
  (`true_typed_theorems`). The README's earlier sentence "No axiom, `sorry`, or `True` gadget" is
  therefore inaccurate for these declarations.
* Numeral reflexivities named as Hodge numbers: `HostSplit.sextic_r6/r12/r18`
  (`numeral_placeholders`). `ContainerSeparation`'s `Z_bounds`/`Z_status` are already labelled as
  placeholders and are superseded by `ChainSexticRank`.
* `Integral.rational_does_not_imply_integral` is a toy statement about `2r = q`, not about
  integral Hodge classes. `Chow.chow_not_shadow_name` and `NoShadow.shadow_ne_geometric_cl` are
  string inequalities.

### Checked and found to be real algebra

These are polynomial, determinant, combinatorial or linear-algebra facts proved in full. None of
them is a statement about cohomology. `SpecialSextic` polynomial lemmas; `ChainSexticRank`
layers 1–2; `SexticCombinatorics`; `SexticCertificates`; the `Explicit*` files; the
FermatCubic, Quintic, DeformedQuintic and DworkQuinticPsi2 hosts; `AlgebraicSpanChecks`.

## Fixes (`Hodge/HonestHosts.lean`)

* `SpanBridge D n` is a **named hypothesis**: `n` cycles whose classes under an *arbitrary*
  `D.cl` span `D.hodgeClasses`. `SpanBridge.hodgeConjecture` re-proves the conclusion from it.
  `p4_hodge_of_planeSpan` (n=1), `klein_hodge_of_schubertSpan` (n=2) and
  `product_hodge_of_kunnethSpan` (n=3) are the conditional host theorems. The spanning
  statement is a classical theorem for those varieties (cellular / Schubert / Künneth basis). It
  is **cited, not proved**, because Mathlib has no cycle class map.
* Non-vacuity: the hypothesis is satisfiable (`kleinModelBridge`), and the conclusion is not
  automatic. `zeroKlein` (same spaces, `cl = 0`) fails `HodgeConjecture` (`zeroKlein_not_hodge`)
  and admits no bridge (`zeroKlein_no_bridge`).
* Fermat quartic, Hassett, sextic: the only honest content is `named_span_le_algebraic`, which
  says the span of named cycle classes is algebraic. It holds for every datum. No claim about
  all Hodge classes of these varieties is made.
* Honest names: `p4_identityShadow`, `klein_identityShadow`, …, `namedFourfolds_identityShadows`,
  `classical_identityShadows`, `zeroDatum_refutes_*`. The table `HonestHosts.Legacy.legacy_*` maps
  each of the 27 old names to its honest name.

## Chain-sextic bridges (`Hodge/ChainSexticBridgeAudit.lean`)

* `one_le_finrank_jacobianDeg12`: `R₁₂ ≠ 0`. This is new and unconditional. The Jacobian ideal
  lies in the monomial ideal `(x_h⁴x_t, x_h⁵, x_t⁵)`, which does not contain `x0³x1³x3⁴x4²`.
* `hodgeBridge_model`: an explicit inhabitant of `ChainSexticHodgeBridge`, so `rho_bounds`
  (`2 ≤ ρ ≤ 1752`) is not vacuous. The model is linear algebra, **not** the cohomology of the
  sextic. In it `ρ = 1 + dim R₁₂` (`model_rho`), so the bridge alone does not determine `ρ`.
  `rho_not_automatic`: without the bridge fields, the rational rank can be `0`.
* `Hodge/ChainSexticCharacterCore.lean` (2026-11-11) shrinks the character bridge as above; it does not yet construct an inhabitant, so the non-vacuity gap recorded here still stands.
* `characterBridge_forces_R12`: every `ChainSexticCharacterBridge` forces
  `dim_ℚ R₁₂ = 1751` (`characterBridge_h22`: `h^{2,2} = 1752`). Lean proves only
  `1 ≤ dim R₁₂ ≤ 1751`. **So whether `rho_eq_786` is non-vacuous depends on the unformalized
  lower bound `dim R₁₂ ≥ 1751`.** No inhabitant of the character bridge is constructed.
* **Update (2026-11-10, `Hodge/ChainSexticR12.lean`).** The lower bound is now proved:
  `jacobianDeg12_finrank_eq : finrank ℚ jacobianDeg12 = 1751`. The necessary condition of
  `characterBridge_forces_R12` therefore holds (`ChainSexticR12Bridge.characterBridge_R12_obstruction_discharged`).
  This removes the one known obstruction; it is not a construction of an inhabitant, so
  `rho_eq_786` is still conditional on the character-bridge hypotheses.

## Axioms

`AxiomAudit.lean`: 646 `#print axioms` lines (522 before, plus 124 new). All use only `propext`,
`Classical.choice` and `Quot.sound`, or a subset of them. There are no `sorry`, `admit`,
`native_decide` or `axiom` declarations (`scripts/check_no_sorry.py`).
