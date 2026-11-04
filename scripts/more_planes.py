"""More planes on X = V(f0+f1+f2), f(x,y) = x^5 y + y^6, pairs A=(x0,x3),(x1,x4),(x2,x5).

New family ("twisted planes", analogue of the non-standard linear cycles on Fermat varieties):
for an ordered pair of pairs (A,B) and third pair C:
   x_B = lam*x_A,  y_B = mu*y_A,  L_C = 0,
with mu^6 = -1, lam^5*mu = -1 (so f_A + f_B = 0) and L_C one of the 6 linear factors
y_C, x_C - eta*y_C (eta^5=-1) of f_C.  Exactly f_A+f_B and f_C vanish, so the plane is in X.
(A,B) and (B,A) give the same planes (inverse lam, mu), so we take A<B.

Intersection numbers on a smooth sextic fourfold (as in plane_intersections.py):
  same plane 21, meet in a line -4, meet in a point 1, disjoint 0; h^2.h^2=6, h^2.Pi=1.
Plane meets plane in projective dim 5 - rank(6x6 stacked equations).
Linear algebra is done over F_p for primes p = 1 mod 60 (all needed roots of unity exist);
the dimension pattern is required to agree for several primes AND with a complex
floating check, and the Gram rank is computed exactly over Q.
"""
import itertools, cmath, sympy as sp
from sympy.polys.matrices import DomainMatrix
PAIRS = [(0, 3), (1, 4), (2, 5)]

def planes_symbolic():
    """roots as exponents of z = exp(2 pi i/60): eta=z^(6+12k), mu=z^(5+10j), lam: lam^5 = -1/mu"""
    std = []
    facs = [('y',)] + [('e', 6 + 12*k) for k in range(5)]   # eta^5 = z^(30+60k) = -1
    for ch in itertools.product(facs, repeat=3):
        std.append(('std', ch))
    tw = []
    for A, B in [(0, 1), (0, 2), (1, 2)]:
        C = 3 - A - B
        for j in range(6):
            mu = 5 + 10*j                    # mu^6 = z^(30+60j) = -1
            lams = [l for l in range(60) if (5*l + mu - 30) % 60 == 0]
            assert len(lams) == 5
            for lam in lams:
                for fc in facs:
                    tw.append(('tw', (A, B, C, lam, mu, fc)))
    return std, tw

def rows(pl, root):
    """3 linear forms (length-6 vectors) cutting the plane; root(e) = z^e in the field"""
    R = []
    def fac(i, fc):
        a, b = PAIRS[i]; v = [0]*6
        if fc[0] == 'y': v[b] = 1
        else: v[a] = 1; v[b] = -root(fc[1])
        return v
    if pl[0] == 'std':
        return [fac(i, fc) for i, fc in enumerate(pl[1])]
    A, B, C, lam, mu, fc = pl[1]
    (xa, ya), (xb, yb) = PAIRS[A], PAIRS[B]
    v1 = [0]*6; v1[xb] = 1; v1[xa] = -root(lam)
    v2 = [0]*6; v2[yb] = 1; v2[ya] = -root(mu)
    return [v1, v2, fac(C, fc)]

def rank_mod(M, p):
    M = [r[:] for r in M]; r = 0
    for c in range(len(M[0])):
        piv = next((i for i in range(r, len(M)) if M[i][c] % p), None)
        if piv is None: continue
        M[r], M[piv] = M[piv], M[r]; inv = pow(M[r][c], p-2, p)
        M[r] = [x*inv % p for x in M[r]]
        for i in range(len(M)):
            if i != r and M[i][c] % p:
                t = M[i][c]; M[i] = [(x - t*y) % p for x, y in zip(M[i], M[r])]
        r += 1
    return r

def gen(p):
    g = next(g for g in range(2, p) if all(pow(g, (p-1)//q, p) != 1 for q in sp.primefactors(p-1)))
    z = pow(g, (p-1)//60, p); return lambda e: pow(z, e % 60, p)

def complex_rank(M):
    import numpy as np
    return int(np.linalg.matrix_rank(np.array(M, dtype=complex), tol=1e-8))


if __name__ == '__main__':
    import numpy as np
    std, tw = planes_symbolic(); P = std + tw
    print("standard planes", len(std), "; twisted planes", len(tw))
    # membership in X, exact over Q(z): substitute parametrization symbolically
    z = sp.symbols('z'); cyc = sp.cyclotomic_poly(60, z)
    s = sp.symbols('s0:3')
    def F(v): return sum(v[a]**5*v[b] + v[b]**6 for a, b in PAIRS)
    for pl in tw:
        if pl[0] == 'tw':
            A, B, C, lam, mu, fc = pl[1]; v = [None]*6
            (xa, ya), (xb, yb), (xc, yc) = PAIRS[A], PAIRS[B], PAIRS[C]
            v[xa], v[ya] = s[0], s[1]; v[xb], v[yb] = z**lam*s[0], z**mu*s[1]
            if fc[0] == 'y': v[xc], v[yc] = s[2], 0
            else: v[xc], v[yc] = z**fc[1]*s[2], s[2]
            assert sp.rem(sp.expand(F(v)), cyc, z) == 0
    print("membership in X verified exactly (mod Phi_60) for all", len(tw), "twisted planes")
    VAL = {2: 21, 1: -4, 0: 1, -1: 0}
    pats = []
    for p in (61, 181, 241):
        root = gen(p); Rs = [rows(pl, root) for pl in P]
        pats.append([[5 - rank_mod(Rs[i] + Rs[j], p) for j in range(len(P))] for i in range(len(P))])
    assert pats[0] == pats[1] == pats[2]
    w = cmath.exp(2j*cmath.pi/60); Rc = [rows(pl, lambda e: w**e) for pl in P]
    pc = [[5 - complex_rank(Rc[i] + Rc[j]) for j in range(len(P))] for i in range(len(P))]
    assert pc == pats[0], "char-p vs complex mismatch"
    assert all((pc[i][j] == 2) == (i == j) for i in range(len(P)) for j in range(len(P))), 'duplicate planes'
    n = len(P); G = sp.zeros(n+1, n+1); G[0, 0] = 6
    for i in range(n):
        G[0, i+1] = G[i+1, 0] = 1
        for j in range(n): G[i+1, j+1] = VAL[pc[i][j]]
    def qrank(M): return DomainMatrix.from_Matrix(M).convert_to(sp.QQ).rank()
    r_std = qrank(G[:len(std)+1, :len(std)+1])
    r_all = qrank(G)
    print("rank <h^2, 216 standard> =", r_std, "-> primitive", r_std - 1)
    print("rank <h^2, standard + twisted> =", r_all, "-> primitive", r_all - 1)
