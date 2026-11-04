# Dwork-type quintic fourfold, psi = 2: computations outside Lean

G = x0^5+...+x5^5 - 10*x0*x1*x2*x3*x4 (Singular 4.x via conda-forge; Python 3).

* `hilb.sing` -> `hilb.out`: Hilbert series of Q[x]/J(G) is 1,6,21,56,120,...,580,...,1
  (total 4096 = 4^6), and std(J+G) has dimension 0, i.e. smooth (independent of the Lean proof).
* `planes.sing` -> `planes.out`: Fano scheme of planes. A plane is the row space of a 3x6
  matrix with identity in pivot columns; S5 (permuting x0..x4) preserves G, so the 20 charts
  fall into two orbits, pivots {0,1,2} and {0,1,5}. Coefficients of G restricted to the plane
  give 21 equations in 9 unknowns; Groebner basis over Q (and mod 32003) is {1}
  (`dim -1`; note `dim` counts the 3 auxiliary variables s,t,u). Hence **X contains no plane**
  over C.
* `fermat.sing` -> `fermat_sanity.out`: same code on the Fermat quintic returns a
  nonempty, zero-dimensional Fano scheme (dim 3 = the s,t,u variables), so the code does detect planes.
* `chars.py` -> `chars.out`: character bookkeeping (see STATUS.md).
