import itertools
v=(1,1,1,1,1,0)
A=[a for a in itertools.product(range(1,5),repeat=6) if sum(a)%5==0]
print("prim dim",len(A))
from collections import Counter
print("types",Counter(sum(a)//5-1 for a in A))
def cls(a): 
    out=set()
    for k in range(5):
        b=tuple((a[i]+k*v[i])%5 for i in range(6))
        if 0 not in b: out.add(b)
    return frozenset(out)
classes={cls(a) for a in A}
print("H-eigenspaces",len(classes), Counter(len(c) for c in classes))
def allhodge(c): return all(sum(tuple(t*x%5 for x in b))==15 for b in c for t in range(1,5))
H=[c for c in classes if allhodge(c)]
print("pencil-wide Hodge eigenspaces",len(H),"dim",sum(len(c) for c in H),Counter(len(c) for c in H))
# fermat hodge classes count
print("Fermat prim Hodge",sum(1 for a in A if all(sum(t*x%5 for x in a)==15 for t in range(1,5))))
# H-invariant part (character trivial): class of a where a ~ ... the eigenspace containing a; invariant = a proportional? characters of H trivial
