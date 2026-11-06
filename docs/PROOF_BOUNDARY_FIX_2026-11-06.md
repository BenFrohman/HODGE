# Proof-boundary and workflow corrections

`primHodge` now returns zero for negative Griffiths degree before natural-number subtraction can truncate it to zero. Regression theorems check `primHodge 5 0 = 0` and `primHodge 5 4 = 0`; existing cubic, quintic and sextic positive-degree computations are unchanged. These checks and the generic negative-degree lemma are included in both axiom audit entry points.

The old `quintic_h40_zero` arithmetic-inequality theorem is retained for compatibility. The new boundary theorem checks the counting function itself. Counting is not an implementation of the quotient graded algebra or of Griffiths residue theory.

The sextic paper corrects the Griffiths Jacobian degree for `(2,2)` to 12. Its proposed explicit surfaces retain their containment certificates and their pen-and-paper projection argument. A detailed identification of the correspondence and cone-pushforward nonvanishing on the relevant character summands remains to be supplied or independently certified; containment alone does not prove spanning. This is a precise unresolved bridge, not a claim that nonformalized mathematics is false. The cited Fermat-degree-30 descent route does not require that explicit-projection step.

Both tag workflows retain artifact generation with `contents: read` but no longer create or update GitHub Releases. This avoids triggering external auto-archiving through a release. No tags or releases are created by this change. Existing releases and archived work are untouched.
