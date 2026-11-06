"""Exploratory section algebra and an illustrative numerical containment check.

H,G satisfy G^2-H^3=k X^5 Y+Y^6. The optional elliptic interpretation
uses C_k: t^6=-(k x^5+1), isomorphic after rescaling to C_1.
This script's coefficient and orbit-coverage checks alone are NOT a projection
proof. The exact surface-class determinant, ideal hypotheses and rank proof
are in docs/EXPLICIT_PROJECTION_CERTIFICATE.md and
scripts/explicit_projection_certificate.py. No numerical output here is used
by that independent certificate. The section identity and trivial-pair cone
containment are checked in ExplicitCurve.lean.
"""
import sympy as sp, json, random
k,X,Y,x=sp.symbols('k X Y x')
from explicit_section_data import m, B, C, b, c, d, e, g
print('m irreducible:',len(sp.factor_list(m.as_expr())[1])==1, flush=True)
def M(p): return sp.Poly(sp.expand(p),k).rem(m).as_expr()
H=X**2+b*X*Y+c*Y**2; G=X**3+d*X**2*Y+e*X*Y**2+g*Y**3
D=sp.Poly(sp.expand(G**2-H**3-(k*X**5*Y+Y**6)),X,Y)
print('G^2-H^3 == k X^5 Y + Y^6 mod m:', all(M(cf)==0 for cf in D.coeffs()), flush=True)
h=sp.Poly(H.subs({X:x,Y:1}),x); gg=sp.Poly(G.subs({X:x,Y:1}),x)
num=sp.Poly(sp.Rational(5,3)*k*x**4,x)*h-h.diff(x)*sp.Poly(k*x**5+1,x)
# long division by monic gg with coefficients reduced mod m
rem=[M(cf) for cf in reversed(num.all_coeffs())]  # index = power
gc=[M(cf) for cf in reversed(gg.all_coeffs())]
q=[0]*4
for p in range(6,2,-1):
    co=rem[p]; q[p-3]=co
    for i in range(4): rem[p-3+i]=M(rem[p-3+i]-co*gc[i])
print('division exact:',all(sp.simplify(z)==0 for z in rem), flush=True)
assert all(sp.simplify(z)!=0 for z in q); print('R coeffs nonzero in Q(k): True')

# orbit coverage: each cited orbit has a character with one trivial/split pair and the
# other two pairs = (holomorphic A-type, antiholomorphic A-type)
Hh={(6,19),(12,13),(18,7),(24,1)}; An={(6,29),(12,23),(18,17),(24,11)}
rows=json.load(open('data/per_class_report.json')); cov=0; dims=0
for r in rows:
    if r['shioda_label']!='D24': continue
    a=r['fermat_alpha']; p=[tuple(a[0:2]),tuple(a[2:4]),tuple(a[4:6])]; ok=False
    for t in [1,7,11,13,17,19,23,29]:
        q2=[tuple((t*c)%30 for c in pp) for pp in p]
        for i in range(3):
            o=[q2[j] for j in range(3) if j!=i]
            if q2[i][0]%6==0 and (q2[i][0]+q2[i][1])%30==0 and ((o[0] in Hh and o[1] in An) or (o[1] in Hh and o[0] in An)): ok=True
    assert ok, r['orbit']; cov+=1; dims+=r['orbit_size']
print('D24 orbits covered by the elliptic-correspondence construction:',cov,'dims',dims)
assert (cov,dims)==(45,360)
# numeric containment on X at a random point of the cone (trivial pair 2)
kr=[z for z in sp.Poly(m,k).nroots(n=40) ][3]
sub=lambda e_: complex(sp.N(sp.sympify(e_).subs(k,kr),40))
bn,cn,dn,en,gn=map(sub,(b,c,d,e,g)); kn=complex(kr)
rho=kn**0.2; mu=complex(sp.N(sp.exp(sp.I*sp.pi/6)))
import cmath
Hn=lambda X_,Y_: X_**2+bn*X_*Y_+cn*Y_**2; Gn=lambda X_,Y_: X_**3+dn*X_**2*Y_+en*X_*Y_**2+gn*Y_**3
X1,Y1=0.37+0.2j,1.0
# solve H(X2,Y2)=mu^2 H1, G(X2,Y2)=mu^3 G1 for (X2,Y2) by Newton
import mpmath as mp
f=lambda u,v:[Hn(u,v)-mu**2*Hn(X1,Y1),Gn(u,v)-mu**3*Gn(X1,Y1)]
sol=mp.findroot(lambda u,v:f(u,v),(mu*X1+0.01,mu*Y1))
X2,Y2=complex(sol[0]),complex(sol[1])
pt=[rho*X1,rho*X2,0.5+0.1j,Y1,Y2,0]
F=sum(pt[i]**5*pt[i+3]+pt[i+3]**6 for i in range(3))
print('numeric |F| on lifted point:',abs(F)); assert abs(F)<1e-8
