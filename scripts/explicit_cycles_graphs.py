"""Graph surfaces Gamma_g = Psi(graph g) on X = V(sum x_i^5 x_{i+3} + x_{i+3}^6) (v1.3 search).
Psi(X;a,b,c) = (abcX0, bcX1, acX2, abX3, a^6bX3, ab^6X3): S5 x W -> X, S5 Fermat quintic surface,
W: c^5=a^30+b^30+w^30 in P(1,1,6,1). g = pi o q o sigma, q=(a^6:b^6:-c:w^6): 144 surfaces.
Exact criterion: Kunneth component (psi,theta) nonzero iff theta = (psi o tau)^-1. Negative result:
all hits are already-explicit (plane-span) orbits; 0 of the 45 cited orbits. See docs/EXPLICIT_CYCLES_SEARCH.md."""
import itertools, sys
sys.path.insert(0,__import__('os').path.dirname(__file__))
import sympy as sp
M=30
# X characters (as in per_class_report.py)
x,y=sp.symbols('x y'); f=x**5*y+y**6
Gb=sp.groebner([sp.diff(f,x),sp.diff(f,y)],x,y,order='grevlex')
lead=[sp.Poly(g,x,y).monoms(order='grevlex')[0] for g in Gb.exprs]
basis=[(p,q) for p in range(12) for q in range(12) if not any(p>=l0 and q>=l1 for l0,l1 in lead)]
char={m:((m[0]+1)-5*(m[1]+1))%M for m in basis}; mono={c:m for m,c in char.items()}
prim={}
for cs in itertools.product(mono,repeat=3):
    d=sum(sum(mono[c]) for c in cs)
    if d%6==0: prim[cs]=d//6
# torus T = T1 (e0..e3, X_i->z^{6e_i}X_i) x T2 (u,v,s: a->z^u a, b->z^v b, c->z^{6s} c)
def D(e,u,v,s):
    return [6*e[0]+u+v+6*s, 6*e[1]+v+6*s, 6*e[2]+u+6*s, 6*e[3]+u+v, 6*e[3]+6*u+v, 6*e[3]+u+6*v]
def chiX(chi,d):  # pullback character of residue m Omega/F^3 under diag d (exponents of z)
    m=[mono[c] for c in chi]; mm=[m[0][0],m[1][0],m[2][0],m[0][1],m[1][1],m[2][1]]
    cF=6*d[3]
    return (sum((mm[j]+1)*d[j] for j in range(6))-3*cF)%M
gens=[((1,0,0,0),0,0,0),((0,1,0,0),0,0,0),((0,0,1,0),0,0,0),((0,0,0,1),0,0,0),
      ((0,0,0,0),1,0,0),((0,0,0,0),0,1,0),((0,0,0,0),0,0,1)]
Dg=[D(*g) for g in gens]
table={}
for chi in prim:
    table.setdefault(tuple(chiX(chi,d) for d in Dg),[]).append(chi)
assert all(len(v)==1 for v in table.values())
psis=[b for b in itertools.product(range(1,5),repeat=4) if sum(b)%5==0]
# W = {c^5=a^30+b^30+w^30} in P(1,1,6,1); t2 as exponent vector on (a,b,c,w)
W8=(1,1,6,1)
def norm2(v):
    l=v[3]; return tuple((v[i]-W8[i]*l)%M for i in range(4))
def tau(pi,sg,t2):  # g = pi o q o sg ; returns S5 exponents (z units)
    # sg permutes positions of (a,b,w) = indices (0,1,3)
    pos=[0,1,3]; v=list(t2)
    w=v[:]; 
    for k in range(3): w[pos[sg[k]]]=v[pos[k]]
    w=norm2(w)
    qv=[6*w[0],6*w[1],w[2],6*w[3]]           # q(a,b,c,w)=(a^6,b^6,-c,w^6)
    out=[0]*4
    for k in range(4): out[pi[k]]=qv[k]
    return [o%M for o in out]
t2g=[(1,0,0,0),(0,1,0,0),(0,0,6,0)]
res={}
for pi in itertools.permutations(range(4)):
  for sg in itertools.permutations(range(3)):
    hits=set()
    for b in psis:
        # psi on T1 gens: 6*b_i ; theta = -(psi o tau) on T2 gens
        th=[(-sum(b[i]*tau(pi,sg,t)[i] for i in range(4)))%M for t in t2g]
        ea,eb,eT=th; ew=(-(ea+eb+eT))%M
        if 0 in (ea,eb,ew,eT): continue  # not in H^2_prim(W)
        assert eT%6==0
        key=tuple([(6*b[i])%M for i in range(4)]+th)
        if key in table:
            chi=table[key][0]; hits.add(chi)
    res[(pi,sg)]=hits
import json
rows=json.load(open(__import__('os').path.join(__import__('os').path.dirname(__file__),'..','data','per_class_report.json')))
orb={}
for r in rows:
    for c in r['characters']: orb[tuple(c)]=r['orbit']
bad=set(); cov={}
for k,h in res.items():
    for chi in h:
        nc=tuple((-c)%M for c in chi)
        o=orb.get(chi) or orb.get(nc)
        if o is None: bad.add(chi)
        else: cov.setdefault(o,set()).add(k)
print('non-(2,2) hits (must be empty):',len(bad))
st={r['orbit']:r['status'] for r in rows}; sz={r['orbit']:r['orbit_size'] for r in rows}
cited=[o for o in st if st[o]=='cited']
got=[o for o in cited if o in cov]
print('cited orbits hit',len(got),'dims',sum(sz[o] for o in got),'of',sum(sz[o] for o in cited))
print('explicit orbits hit',len([o for o in cov if st[o]=='explicit']))
from math import gcd
print('cited orbits whose rep alpha has a unit entry (blocks power-map/cone constructions):',sum(1 for r in rows if r['status']=='cited' and any(gcd(v,30)==1 for v in r['fermat_alpha'])),'of',len(cited))
assert not got
