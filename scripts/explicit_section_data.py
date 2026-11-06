"""Exact section coefficients, shared by the exploratory and projection checks.

No numerical root selection is needed: all operations are over QQ[k]/(m).
The independent projection check also compares these with ExplicitCurve.lean.
"""
import sympy as sp

k = sp.symbols("k")
m=sp.Poly(k**24 + 66081312000*k**18 - 4811512860000*k**12 + 1167566400000*k**6 + 583200000,k)
B=sp.Poly(-722487197*k**19/183091906523168640000 - 159143006270106241*k**13/610306355077228800 + 21430060790263809*k**7/1130196953846720 - 174160669504533*k/56509847692336,k)
C=sp.Poly(24042395351*k**20/2197102878278023680000 + 8826405713420672683*k**14/12206127101544576000 - 2143524127385205629*k**8/40687090338481920 + 3380935656389167*k**2/226039390769344,k)

def reduce_mod_m(p):
    return sp.Poly(sp.expand(p), k, domain=sp.QQ).rem(m).as_expr()

b, c = B.as_expr(), C.as_expr()
d = reduce_mod_m((k + 3*b)/2)
e = reduce_mod_m((3*c + 3*b*b - d*d)/2)
g = reduce_mod_m((b**3 + 6*b*c - 2*d*e)/2)
