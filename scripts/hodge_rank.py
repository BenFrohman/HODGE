"""Exact rank of the rational Hodge classes in H^4_prim(X,Q) for
X = V(F), F = sum over pairs (x,y) of x^5 y + y^6  (Hodge/SpecialSextic.lean).

Method (Griffiths residues + diagonal symmetry, Shioda-style):
* H^{4-q,q}_prim(X) = R(F)_{6q}, R(F) = C[x]/J(F) = tensor of three copies of
  the Milnor algebra A of f = x^5 y + y^6 (variables separate).
* G = (Z/30)^3 acts diagonally: k in Z/30 acts on a pair by x -> z^k x, y -> z^(-5k) y
  (z = exp(2 pi i/30)); f is invariant.  The residue of m*Omega/F^(q+1),
  m = prod x^a y^b, is a G-eigenvector with character c = ((a+1) - 5(b+1)) mod 30
  per pair.  We check the character map is INJECTIVE on a monomial basis, so
  every eigenspace V_chi is 1-dimensional and of pure Hodge type.
* Gal(Q(z)/Q) = (Z/30)^* permutes eigenspaces chi -> t*chi and H^4_prim(X,Q) is
  defined over Q, so H^4_prim(X,Q) cap H^{2,2} has dimension
      sum of |orbit| over Galois orbits lying entirely in type (2,2).
All arithmetic is exact integer arithmetic.
"""
import itertools, math, sympy as sp

x, y = sp.symbols('x y')
f = x**5*y + y**6
Gb = sp.groebner([sp.diff(f, x), sp.diff(f, y)], x, y, order='grevlex')
lead = [sp.Poly(g, x, y).monoms(order='grevlex')[0] for g in Gb.exprs]
basis = [(a, b) for a in range(12) for b in range(12)
         if not any(a >= la and b >= lb for la, lb in lead)]
assert len(basis) == 25, len(basis)           # Milnor number (6-1)^2
char = {m: ((m[0]+1) - 5*(m[1]+1)) % 30 for m in basis}
assert len(set(char.values())) == 25           # injective -> multiplicity free
deg_of = {char[m]: m[0]+m[1] for m in basis}   # degree of the monomial with that character

prim = {}
for ms in itertools.product(deg_of, repeat=3):
    d = sum(deg_of[c] for c in ms)
    if d % 6 == 0:
        prim[ms] = d // 6                        # q, type (4-q, q)
counts = [sum(1 for q in prim.values() if q == k) for k in range(5)]
print("h^{4-q,q}_prim, q=0..4:", counts)
assert counts == [1, 426, 1751, 426, 1]

units = [t for t in range(1, 30) if math.gcd(t, 30) == 1]
seen, hodge, orbits = set(), 0, []
for chi in prim:
    if chi in seen: continue
    orb = {tuple((t*c) % 30 for c in chi) for t in units}
    assert orb <= prim.keys()                    # Galois-stable, sanity
    seen |= orb
    if all(prim[o] == 2 for o in orb):
        hodge += len(orb); orbits.append(len(orb))
print("dim H^4_prim(X,Q) cap H^{2,2} =", hodge, "from", len(orbits), "Galois orbits; sizes", sorted(set(orbits)))
print("rho(H^{2,2} cap H^4(X,Q)) =", hodge + 1)
