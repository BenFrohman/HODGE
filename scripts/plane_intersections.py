"""Exact intersection matrix of planes on X = V(F) ⊂ P^5,
F = x0^5 x3 + x3^6 + x1^5 x4 + x4^6 + x2^5 x5 + x5^6  (Hodge/SpecialSextic.lean).

Each pair (x, y) = (x0,x3), (x1,x4), (x2,x5) contributes f(x,y) = y(x^5+y^5),
which splits into 6 linear forms: y and x - eta*y with eta^5 = -1.
A plane is a choice of one linear form per pair (6^3 = 216 planes over C).
The 8 "diagonal" planes Pi_abc use only y (a=0) or x+y (a=-1) per pair (defined over Q).

Two planes differing in k pairs meet in a linear space of dim 2-k:
  k=0: [Pi]^2 = c2(N_{Pi/X}), c(N) = (1+h)^6 / ((1+h)^3 (1+6h))   -> 21
  k=1: line, excess formula  Pi.Pi' = deg c1(N_{Pi/X})|_L - deg N_{L/Pi'} = -3 - 1 = -4
  k=2: one point, transverse (tangent planes span P^4)            -> 1
  k=3: disjoint                                                    -> 0
Also h^2.h^2 = 6, h^2.Pi = 1.  All arithmetic exact (sympy).
"""
import itertools, sympy as sp
from sympy.polys.matrices import DomainMatrix

def qrank(M):
    """exact rank over Q (fraction-free, DomainMatrix over ZZ)"""
    return DomainMatrix.from_Matrix(M).convert_to(sp.QQ).rank()


x = sp.symbols('x0:6'); h = sp.symbols('h')
F = x[0]**5*x[3]+x[3]**6+x[1]**5*x[4]+x[4]**6+x[2]**5*x[5]+x[5]**6
PAIRS = [(0, 3), (1, 4), (2, 5)]

# self-intersection from Chern classes
cN = sp.series((1+h)**3/(1+6*h), h, 0, 3).removeO()
SELF = sp.Poly(cN, h).coeff_monomial(h**2)
C1 = sp.Poly(cN, h).coeff_monomial(h)
LINE = C1 - 1
VAL = {0: SELF, 1: LINE, 2: 1, 3: 0}
assert (SELF, LINE) == (21, -4)

def lies_on_X(choice):
    """choice[i] = 0 -> y=0, else eta -> x = eta*y. Substitute and check F == 0 exactly."""
    s, t = sp.symbols('s0:3'), sp.symbols('t0:3')
    sub = {}
    for i, (a, b) in enumerate(PAIRS):
        if choice[i] == 'y':
            sub[x[b]] = 0; sub[x[a]] = s[i]
        else:
            sub[x[b]] = s[i]; sub[x[a]] = choice[i]*s[i]
    return sp.expand(F.subs(sub)) == 0

def gram(planes):
    n = len(planes)
    M = sp.zeros(n+1, n+1); M[0, 0] = 6
    for i in range(n):
        M[0, i+1] = M[i+1, 0] = 1
        for j in range(n):
            k = sum(p != q for p, q in zip(planes[i], planes[j]))
            M[i+1, j+1] = VAL[k]
    return M

def prim_rank(M):
    # project off h^2: v -> v - (v.h^2/6) h^2 ; rank of primitive span = rank(M) - 1
    return qrank(M) - 1

if __name__ == '__main__':
    diag = list(itertools.product(['y', -1], repeat=3))
    assert all(lies_on_X(c) for c in diag)
    M8 = gram(diag)
    print("8 diagonal planes, order a,b,c in {0,-1}:", [tuple(0 if c=='y' else -1 for c in p) for p in diag])
    sp.pprint(M8[1:, 1:])
    print("rank <Pi_abc> =", qrank(M8[1:, 1:]), "; rank <h^2, Pi_abc> =", qrank(M8),
          "; primitive rank =", prim_rank(M8), "; det(8x8) =", M8[1:, 1:].det())
    # all 216 planes: eta is a root of e^5+1; check F vanishes modulo e^5+1 exactly
    e, s0 = sp.symbols('e s0')
    f_pair = lambda X, Y: X**5*Y + Y**6
    assert sp.expand(f_pair(s0, 0)) == 0
    assert sp.rem(sp.expand(f_pair(e*s0, s0)), e**5+1, e) == 0
    lab = ['y'] + list(range(5))
    allp = list(itertools.product(lab, repeat=3))
    MA = gram(allp)
    print("216 planes over C: rank <h^2, planes> =", qrank(MA),
          "; primitive rank =", qrank(MA) - 1)
