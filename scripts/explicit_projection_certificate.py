"""Exact finite certificate for docs/EXPLICIT_PROJECTION_CERTIFICATE.md.

Run from any directory: python3 scripts/explicit_projection_certificate.py
Requires SymPy. No floating point, numerical periods, orbit-report assumptions,
or numerical rank computation. Geometry uses the cited cycle-class theorem;
this program certifies its explicit polynomial inputs and character supports.
"""
import itertools
import re
from pathlib import Path
import sympy as s
from explicit_section_data import k, m, b, c, d, e, g, reduce_mod_m as M

ROOT = Path(__file__).resolve().parents[1]


def check(condition, message):
    if not condition:
        raise AssertionError(message)


def unit_at_every_root(p, name):
    """Check an actual Bezout identity, stronger than a nonzero remainder."""
    p = s.Poly(p, k, domain=s.QQ)
    aa, bb, gcd = s.gcdex(p, m)
    check(gcd == s.Poly(1, k, domain=s.QQ), name + ': not coprime to m')
    check(aa*p + bb*m == s.Poly(1, k, domain=s.QQ), name + ': invalid Bezout identity')


# Independently compare every coefficient with the checked-in Lean definitions.
lean = (ROOT/'Hodge/ExplicitCurve.lean').read_text()
for name, expected in zip(('sb', 'sc', 'sd', 'se', 'sg'), (b, c, d, e, g)):
    line = next(t for t in lean.splitlines() if t.startswith('def ' + name + ' '))
    terms = re.findall(r'\((-?\d+)/(\d+):K\)\*k\^(\d+)', line)
    check(bool(terms), 'could not parse ' + name)
    actual = sum(s.Rational(int(a), int(q))*k**int(n) for a, q, n in terms)
    check(s.expand(actual-expected) == 0, 'Lean coefficient mismatch: '+name)
line = next(t for t in lean.splitlines() if t.startswith('def m '))
check(s.Poly(s.sympify(line.split(':=')[1].replace('^', '**')), k) == m,
      'Lean modulus mismatch')

x, y, z, w = s.symbols('x y z w')
H = x*x + b*x*y + c*y*y
G = x**3 + d*x*x*y + e*x*y*y + g*y**3
section = s.Poly(s.expand(G*G-H**3-k*x**5*y-y**6), x, y)
check(all(M(t) == 0 for t in section.coeffs()), 'section identity')
check(m.eval(0) != 0, 'k must be nonzero at every root')

# W=det Jac(H,G); U=HW in the binary Jacobian quotient.
W = [M(3*b*g-2*c*e), M(6*g+b*e-4*c*d),
     M(4*e-b*d-6*c), M(2*d-3*b)]  # increasing powers of x
check(M(W[3]-k) == 0, 'leading W coefficient')
actual_W = s.Poly(s.expand(s.diff(H,x)*s.diff(G,y)-s.diff(H,y)*s.diff(G,x)), x, y)
check(all(M(actual_W.coeff_monomial(x**a*y**(3-a))-W[a]) == 0
          for a in range(4)), 'W derivative formula')
# x^4*y=0, x^5=-(6/k)y^5, y^6=0. The only x^5 term of HW has coefficient k.
U = [M(c*W[0]-6), M(b*W[0]+c*W[1]),
     M(W[0]+b*W[1]+c*W[2]), M(W[1]+b*W[2]+c*k)]
actual_HW = s.Poly(s.expand(H*sum(W[a]*x**a*y**(3-a) for a in range(4))), x, y)
for a in range(4):
    coeff = actual_HW.coeff_monomial(x**a*y**(5-a))
    if a == 0:
        coeff -= 6*actual_HW.coeff_monomial(x**5)/k
    check(M(coeff-U[a]) == 0, 'HW Jacobian reduction')
for name, arr in (('W', W), ('HW', U)):
    for a, coeff in enumerate(arr):
        unit_at_every_root(coeff, f'{name}[{a}]')
unit_at_every_root(M(b*b-4*c), 'quadratic discriminant')
B, C, D, E, T, t = s.symbols('B C D E T t')
res = s.resultant(t*t+B*t+C, t**3+D*t*t+E*t+T, t)
unit_at_every_root(M(res.subs({B:b,C:c,D:d,E:e,T:g})), 'H,G resultant')
print('Section and Lean coefficient consistency: PASS; 10 exact Bezout identities: PASS')

# Chain-rule factor in coordinates (H1,G1,H2,G2). The outer Jacobian
# contributes W1*W2, so no expanded giant determinant is being assumed.
h1, g1, h2, g2 = s.symbols('h1 g1 h2 g2')
Q = h2+h1
A = -(h2*h2-h2*h1+h1*h1)
C = g2+s.I*g1
B = g2-s.I*g1
check(s.expand(Q*A+C*B-(g1*g1-h1**3+g2*g2-h2**3)) == 0,
      'complete intersection decomposition')
mat = s.Matrix([[s.diff(p,v) for v in (h1,g1,h2,g2)] for p in (Q,A,C,B)])
check(s.expand(mat.det()-6*s.I*(h2-h1)) == 0, 'surface determinant factor')
f = lambda u,v: u**5*v+v**6
L = x+y
D0 = y*(x**4-x**3*y+x*x*y*y-x*y**3+y**4)
PL = s.Poly(s.diff(D0,y)-s.diff(D0,x),x,y)
check(s.expand(L*D0-f(x,y)) == 0, 'split-pair decomposition')
check([PL.coeff_monomial(x**a*y**(4-a)) for a in range(5)] == [6,-6,6,-6,1],
      'split-pair determinant')

# A seed twisted plane: z=i*x, w=i*y, and L=0 in the remaining pair.
u, v = z-s.I*x, w-s.I*y
A0 = w*sum(z**(4-j)*(s.I*x)**j for j in range(5))
B0 = (s.I*x)**5+sum(w**(5-j)*(s.I*y)**j for j in range(6))
check(s.expand(u*A0+v*B0-f(x,y)-f(z,w)) == 0, 'twisted-plane decomposition')
mat = s.Matrix([[s.diff(p,a) for a in (x,y,z,w)] for p in (u,A0,v,B0)])
Ptw = s.Poly(s.expand(mat.det()),x,y,z,w)


def normal_pair(a, b):
    factor = s.S.One
    while a >= 5:
        a -= 5
        b += 5
        factor *= -6
    if b >= 6 or (a >= 4 and b >= 1):
        return None
    return (a,b), factor


twisted = {}
for (a,b0,c0,d0), coeff in Ptw.terms():
    aa, bb = normal_pair(a,b0), normal_pair(c0,d0)
    if aa is None or bb is None:
        continue
    key = aa[0]+bb[0]
    twisted[key] = s.expand(twisted.get(key,0)+coeff*aa[1]*bb[1])
twisted = {mon:coeff for mon,coeff in twisted.items() if coeff != 0}
check(len(twisted) == 25, 'twisted-plane support length')
print('Split-pair, surface and twisted-plane determinant identities: PASS')

# Independent character enumeration from the actual 25-element Milnor basis.
basis = [(a,b0) for a in range(5) for b0 in range(6) if not(a == 4 and b0 >= 1)]
chi = lambda ab: (ab[0]-5*ab[1]-4)%30  # includes the volume-form character
check(len(basis) == len({chi(ab) for ab in basis}) == 25, 'simple binary characters')
# Check the claimed Groebner basis directly against the two partial derivatives.
gb = s.groebner([s.diff(f(x,y),x),s.diff(f(x,y),y)],x,y)
expected = s.groebner([x**4*y,x**5+6*y**5,y**6],x,y)
check(gb == expected, 'binary Jacobian Groebner basis')
alltypes = {}
for ms in itertools.product(basis,repeat=3):
    degree = sum(sum(ab) for ab in ms)
    if degree%6 == 0:
        ch = tuple(chi(ab) for ab in ms)
        check(ch not in alltypes, 'repeated primitive character')
        alltypes[ch] = degree//6
units = [a for a in range(30) if s.gcd(a,30) == 1]
hodge = {ch for ch,q in alltypes.items() if q == 2 and all(
    alltypes.get(tuple(a*c0%30 for c0 in ch)) == 2 for a in units)}
check([sum(q == j for q in alltypes.values()) for j in range(5)] == [1,426,1751,426,1],
      'primitive Hodge numbers')
check(len(hodge) == 785, 'rational Hodge character count')


def rotate(vals, j):
    return vals[j:]+vals[:j]


planes = {tuple(chi(ab) for ab in ms)
          for ms in itertools.product([(a,4-a) for a in range(5)],repeat=3)}
check(len(planes) == 125, 'coordinate plane support')
surfaces = set()
for j in range(3):
    for mon in twisted:
        for a in range(5):
            planes.add(tuple(chi(ab) for ab in rotate([(a,4-a),mon[:2],mon[2:]],j)))
    support = set()
    for d1,d2 in ((3,5),(5,3)):
        for a,b0,c0 in itertools.product(range(5),range(4),range(4)):
            support.add(tuple(chi(ab) for ab in rotate([(a,4-a),(b0,d1-b0),(c0,d2-c0)],j)))
    check(len(support) == 160, 'one surface support')
    check(not support & surfaces, 'different surface degree patterns overlap')
    surfaces |= support
check(len(planes) == 425 and len(surfaces) == 480, 'span support counts')
check(planes <= hodge and surfaces <= hodge, 'non-Hodge coordinate in a cycle class')
check(len(planes & surfaces) == 120, 'plane/surface overlap')
check(planes | surfaces == hodge, 'uncovered rational Hodge character')
# Do not use the D2/D24 labels to obtain this equality: the report is not an input.
print('Primitive Hodge numbers: 1,426,1751,426,1; rational Hodge support: 785')
print('Plane support: 425; surface supports: 160+160+160=480; overlap: 120')
print('Exact union: 425+480-120=785; uncovered Hodge characters: 0; PASS')
