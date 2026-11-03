# Primitive cohomology

**Author:** Benjamin Stanley Frohman  
**Copyright:** © 2026 Benjamin Stanley Frohman  
**License:** Apache-2.0

Primitive cohomology is what is left of \(H^m(X)\) after you remove every class that is a cup-product with the hyperplane class.

On a smooth projective variety the hyperplane class \(h\) (or the Kähler class \(\omega\)) defines the Lefschetz operator

\[
L\colon H^m(X)\to H^{m+2}(X),\qquad \alpha\mapsto h\cup\alpha.
\]

If \(X\) has complex dimension \(n\), Hard Lefschetz says that repeating this enough times is an isomorphism:

\[
L^{n-m}\colon H^m(X)\xrightarrow{\sim} H^{2n-m}(X).
\]

A class is called primitive when one more application of \(L\) kills it:

\[
P^m(X)=\ker\bigl(L^{n-m+1}\colon H^m(X)\to H^{2n-m+2}(X)\bigr).
\]

The Lefschetz decomposition says every class is uniquely a hyperplane power times a primitive class:

\[
H^m(X)=\bigoplus_{r\ge 0} L^r P^{m-2r}(X).
\]

So “primitive” means “not a multiple of \(h\).”

## The sextic fourfold

On a smooth sextic fourfold, \(n=4\) and middle degree is \(m=4\). Lefschetz gives \(H^2(X,\mathbb{Q})=\mathbb{Q}\,h\), and \(L(h)=h^2\neq 0\), so the primitive part of \(H^2\) is zero. The decomposition of middle cohomology collapses to two pieces:

\[
H^4(X,\mathbb{Q})=P^4(X,\mathbb{Q})\oplus\mathbb{Q}\,h^2.
\]

The non-primitive summand is the line \(\mathbb{Q}\,h^2\), not the single vector \(h^2\). That line has type \((2,2)\). The primitive piece \(P^4\) still carries the Hodge decomposition, and its \((2,2)\)-part is what the \(1751\) counts. Both integers sit on the same line:

\[
\dim_{\mathbb{C}} H^{2,2}(X)=1752
\qquad\text{and}\qquad
\dim_{\mathbb{C}} H^{2,2}_{\mathrm{prim}}(X)=1751.
\]

The extra \(1\) is \(h^2\), the class of a hyperplane section. It is algebraic. The \(1751\) is the complex dimension of what remains. It is not

\[
\dim_{\mathbb{Q}}\bigl(H^4(X,\mathbb{Q})\cap H^{2,2}(X)\bigr),
\]

and it is not a count of cycles. Subtracting the rank of \(\{h^2,[\Pi]\}\) from \(1751\) does not produce missed classes.

See also [JACOBIAN_PIECES.md](JACOBIAN_PIECES.md).
