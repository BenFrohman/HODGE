"""Classify the 122 rational Hodge (2,2) Galois orbits of X (chain sextic) via the
Fermat cover X^4_30 --> X, (x_i, x_{i+3}) = (u_i^6/v_i, v_i^5)   [Shioda 1986 covering].

Pullback of the residue of x^a y^b (per pair) is, up to a constant, the residue of a
Fermat monomial with character  alpha = (6(a+1), -((a+1)-5(b+1)))  mod 30  per pair
(d(u^6/v) ^ d(v^5) = 30 u^5 v^3 du^dv).  So every Hodge class of X pulls back to the
eigenspace V_alpha of H^4_prim(X^4_30) (Shioda's character description [1,2]).

Criteria applied to alpha (all yield algebraic classes on X^4_30, then push down):
 D2  alpha splits into three pairs with a_i + a_j = 0 mod 30           [Shioda 1979; Ran 1980]
 D24 a pair a+b=0 plus a quadruple that is a Hodge surface character
     (sum <t beta>/30 = 2 for all t), algebraic by Lefschetz (1,1) through the
     Shioda-Katsura inductive structure                               [Shioda-Katsura 1979]
 D33 two zero-sum triples (product-of-curves (1,1) transport)         [arXiv:2608.18134 Thm 1.2, preprint]
Orbits meeting none of these are reported as 'not classified here' (NOT non-algebraic).
"""
import itertools, math, sympy as sp
from collections import Counter
x, y = sp.symbols('x y'); f = x**5*y + y**6
Gb = sp.groebner([sp.diff(f, x), sp.diff(f, y)], x, y, order='grevlex')
lead = [sp.Poly(g, x, y).monoms(order='grevlex')[0] for g in Gb.exprs]
basis = [(a, b) for a in range(12) for b in range(12) if not any(a >= la and b >= lb for la, lb in lead)]
assert len(basis) == 25
M = 30; U = [t for t in range(1, M) if math.gcd(t, M) == 1]
alpha_of = {m: ((6*(m[0]+1)) % M, (-((m[0]+1) - 5*(m[1]+1))) % M) for m in basis}
deg = {m: m[0]+m[1] for m in basis}
prim = {}
for ms in itertools.product(basis, repeat=3):
    d = sum(deg[m] for m in ms)
    if d % 6 == 0:
        prim[tuple(c for m in ms for c in alpha_of[m])] = d // 6
assert len(prim) == 2605
assert all(sum(a) % M == 0 for a in prim)
# pairs (x^4 -> alpha=(0,0)) carry trivial character; strip them (lower-dim Fermat piece)
red = lambda a: tuple(c for c in a if c)
# cross-check: Fermat Hodge type agrees with Griffiths type on X
for a, q in prim.items():
    if 0 not in a: assert sum(a) // M - 1 == q
def hodge(a, n):   # sum <t a>/M == n/2+1 for all units
    return all(sum((t*c) % M for c in a) == (n//2+1)*M for t in U)
def D2(a):
    a = list(a)
    if not a: return True
    for j in range(1, len(a)):
        if (a[0]+a[j]) % M == 0 and D2(a[1:j]+a[j+1:]): return True
    return False
def D24(a):
    if len(a) == 4: return hodge(a, 2)
    for i, j in itertools.combinations(range(len(a)), 2):
        if (a[i]+a[j]) % M == 0:
            r = [a[k] for k in range(len(a)) if k not in (i, j)]
            if hodge(r, 2): return True
    return False
def D33(a):
    if len(a) != 6: return False
    for T in itertools.combinations(range(6), 3):
        if 0 in T and sum(a[k] for k in T) % M == 0: return True
    return False
seen, res, total = set(), Counter(), 0
for a, q in prim.items():
    if a in seen: continue
    orb = {tuple((t*c) % M for c in a) for t in U}; seen |= orb
    if not all(prim[o] == 2 for o in orb): continue
    hc = all(hodge(red(o), len(red(o)) - 2) for o in orb); res['hodge_check_ok', 'dim'] += len(orb) * hc
    total += len(orb)
    r = red(a); res['reduced', 'dim'] += len(orb) * (len(r) < 6)
    k = 'D2' if D2(r) else 'D24' if D24(r) else 'D33' if D33(r) else 'unclassified'
    # else 'D24' if D24(a) else 'D33' if D33(a) else 'unclassified'
    res[k, 'orbits'] += 1; res[k, 'dim'] += len(orb)
print("total Hodge dim", total, "; of which with a trivial-character pair:", res['reduced','dim'])
print('dims passing Fermat Hodge test on reduced character:', res['hodge_check_ok','dim'])
for k in ['D2', 'D24', 'D33', 'unclassified']:
    print(f"{k:13s} orbits={res[k,'orbits']:4d} dim={res[k,'dim']:4d}")
