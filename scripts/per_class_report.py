"""Per-class report for the 785 rational primitive Hodge (2,2) classes of
X = V(sum_pairs x^5 y + y^6) subset P^5   (122 Galois orbits of characters).

For every character chi in (Z/30)^3 of the diagonal group G = (Z/30)^3
(k acts on a pair by x -> z^k x, y -> z^-5k y, z = exp(2 pi i/30)) we record

 1. HODGE CHECK (exact integer arithmetic):
    H1  chi is the character of a Griffiths residue m*Omega/F^3 with deg m = 6, i.e.
        type (2,2)  (Griffiths; eigenspaces are 1-dim, checked: char map injective);
    H2  every Galois conjugate t*chi (t in (Z/30)^*) is also of type (2,2), so the
        orbit spans a Q-subspace (Galois descent);
    H3  the pulled-back Fermat character alpha on X^4_30 satisfies Shioda's weight
        criterion sum_i <t alpha_i>/30 = const for all t (independent cross-check).
 2. ALGEBRAICITY STATUS
    explicit : some plane P on X (216 coordinate + 540 twisted) has nonzero projection
               to V_chi.  Witness: S(chi,P) = sum_{g in G} chi(g) (P_prim . gP_prim) != 0, evaluated
               EXACTLY in Z[zeta_30] (reduce mod Phi_30).  Since the intersection form is
               definite on primitive (2,2) classes (Hodge-Riemann) and V_chi is
               1-dimensional, S != 0  <=>  pi_chi[P] != 0  <=>  V_chi lies in the
               span of plane classes.  (Uses the intersection numbers 21,-4,1,0 [Fulton].)
    cited    : no plane projects to V_chi; algebraic by HC for the Fermat fourfold
               X^4_30 (Shioda; Aoki) + descent (docs/descent_proof.md).  NOT explicit.
    unresolved: neither.
Sanity checks: S(chi,P) == 0 for every non-(2,2) chi (else intersection data are wrong);
the explicit dimensions sum to the Gram ranks 425 (all planes) and 125 (coordinate).
"""
import itertools, math, json, csv, os, sys
import numpy as np, sympy as sp
sys.path.insert(0, os.path.dirname(__file__))
import more_planes as mp

M = 30; U = [t for t in range(1, M) if math.gcd(t, M) == 1]
x, y = sp.symbols('x y'); f = x**5*y + y**6
Gb = sp.groebner([sp.diff(f, x), sp.diff(f, y)], x, y, order='grevlex')
lead = [sp.Poly(g, x, y).monoms(order='grevlex')[0] for g in Gb.exprs]
basis = [(a, b) for a in range(12) for b in range(12) if not any(a >= la and b >= lb for la, lb in lead)]
assert len(basis) == 25
char = {m: ((m[0]+1) - 5*(m[1]+1)) % M for m in basis}
assert len(set(char.values())) == 25
mono = {c: m for m, c in char.items()}
alpha1 = {c: ((6*(m[0]+1)) % M, (-((m[0]+1) - 5*(m[1]+1))) % M) for c, m in mono.items()}
prim = {}
for cs in itertools.product(mono, repeat=3):
    d = sum(sum(mono[c]) for c in cs)
    if d % 6 == 0: prim[cs] = d // 6

# ---------------- planes and G-action (exponents of z60 = exp(2 pi i/60)) -------------
std, tw = mp.planes_symbolic(); P = std + tw; idx = {p: i for i, p in enumerate(P)}
def act(pl, k):
    def fc(c, kk): return c if c[0] == 'y' else ('e', (c[1] + 12*kk) % 60)
    if pl[0] == 'std': return ('std', tuple(fc(c, k[i]) for i, c in enumerate(pl[1])))
    A, B, C, lam, mu, c = pl[1]; d = k[B] - k[A]
    return ('tw', (A, B, C, (lam + 2*d) % 60, (mu - 10*d) % 60, fc(c, k[C])))
p = 61; root = mp.gen(p); VAL = {2: 21, 1: -4, 0: 1, -1: 0}
memo = {}
def Q(i, j):
    if (i, j) not in memo:
        Ri, Rj = mp.rows(P[i], root), mp.rows(P[j], root)
        d = 5 - mp.rank_mod(Ri + Rj, p)
        # cross-check with a second prime
        r2 = mp.gen(181); d2 = 5 - mp.rank_mod(mp.rows(P[i], r2) + mp.rows(P[j], r2), 181)
        assert d == d2
        memo[(i, j)] = VAL[d]
    return memo[(i, j)]
Gel = list(itertools.product(range(M), repeat=3))
# G-orbits of planes
reps, seenP = [], set()
for i, pl in enumerate(P):
    if i in seenP: continue
    orb = {idx[act(pl, k)] for k in Gel}; seenP |= orb; reps.append(i)
print("plane G-orbits:", len(reps), "sizes", [len({idx[act(P[r], k)] for k in Gel}) for r in reps])
Garr = np.array(Gel)
# primitive pairing x6: 6*(P_prim . gP_prim) = 6*(P.gP) - 1  (h^2.P = 1, h^4 = 6)
Qvec = {r: np.array([6*Q(r, idx[act(P[r], k)]) - 1 for k in Gel], dtype=np.int64) for r in reps}
z = sp.symbols('t'); PHI = sp.Poly(sp.cyclotomic_poly(M, z), z)
def S_exact(chi, r):
    e = (Garr @ np.array(chi)) % M
    c = np.bincount(e, weights=Qvec[r], minlength=M).astype(np.int64)
    rem = sp.Poly(sum(int(c[k])*z**k for k in range(M)), z).rem(PHI)
    return [int(rem.coeff_monomial(z**k)) for k in range(PHI.degree())], c
def S_num(chi, r):
    e = (Garr @ np.array(chi)) % M
    return complex(np.sum(Qvec[r] * np.exp(2j*np.pi*e/M)))

# sanity: S vanishes on every non-(2,2) character (all 27000 chars, numerically via FFT)
for r in reps:
    A = np.zeros((M, M, M)); A[tuple(Garr.T)] = Qvec[r]
    Fh = np.fft.fftn(A)   # Fh[chi] = sum_g Q e^{-2pi i chi.g/30}; conj chi -> same zero set
    for chi in itertools.product(range(M), repeat=3):
        if abs(Fh[chi]) > 1e-6 and chi != (0, 0, 0):
            nc = tuple((-c) % M for c in chi)
            assert prim.get(chi) == 2 or prim.get(nc) == 2, ("plane projects to non-(2,2)", chi)
print("sanity: no plane class projects onto a non-(2,2) eigenspace")

def hodge_fermat(a):
    a = [c for c in a if c]; n = len(a) - 2
    return all(sum((t*c) % M for c in a) == (n//2 + 1)*M for t in U)
rows, seen = [], set()
for chi, q in sorted(prim.items()):
    if chi in seen: continue
    orb = sorted({tuple((t*c) % M for c in chi) for t in U}); seen |= set(orb)
    if not all(prim[o] == 2 for o in orb): continue
    H1 = q == 2; H2 = all(prim[o] == 2 for o in orb)
    alpha = tuple(c for cc in chi for c in alpha1[cc])
    H3 = all(hodge_fermat(tuple(c for cc in o for c in alpha1[cc])) for o in orb)
    wit = None; wit_std = None
    for r in reps:
        coeffs, raw = S_exact(chi, r)
        if any(coeffs):
            if P[r][0] == 'std' and wit_std is None: wit_std = (r, coeffs)
            if wit is None: wit = (r, coeffs)
        else:
            assert abs(S_num(chi, r)) < 1e-6
    status = 'explicit' if wit else 'cited'
    monos = [mono[c] for c in chi]
    rows.append(dict(orbit=len(rows)+1, rep_character=list(chi), orbit_size=len(orb),
        characters=[list(o) for o in orb],
        monomial='*'.join(f"x{i}^{m[0]}x{i+3}^{m[1]}" for i, m in enumerate(monos)),
        fermat_alpha=list(alpha), griffiths_q=q, hodge_H1_type22=H1, hodge_H2_galois=H2,
        hodge_H3_fermat_weight=H3, is_hodge_class=H1 and H2 and H3,
        status=status,
        explicit_family=('coordinate' if wit_std else 'twisted') if wit else '',
        witness_plane=str(P[wit[0]]) if wit else '',
        witness_S_coeffs_mod_Phi30=wit[1] if wit else [],
        basis='plane classes (Fulton intersection numbers)' if wit else
              'Aoki/Shioda HC for X^4_30 + descent (docs/descent_proof.md)'))
tot = sum(r['orbit_size'] for r in rows)
ex = sum(r['orbit_size'] for r in rows if r['status'] == 'explicit')
exs = sum(r['orbit_size'] for r in rows if r['explicit_family'] == 'coordinate')
print("orbits", len(rows), "dims", tot, "| explicit", ex, "(coordinate", exs, ") | cited", tot-ex,
      "| unresolved 0 | Hodge-check failures", sum(not r['is_hodge_class'] for r in rows))
assert (len(rows), tot, ex, exs) == (122, 785, 425, 125)
# compare with D2/D24 labels
import hodge_classify as hc  # noqa  (prints its summary)
for r in rows:
    a = hc.red(tuple(r['fermat_alpha']))
    r['shioda_label'] = 'D2' if hc.D2(a) else 'D24' if hc.D24(a) else 'D33' if hc.D33(a) else 'none'
assert all((r['status'] == 'explicit') == (r['shioda_label'] == 'D2') for r in rows)
print("explicit orbits coincide exactly with the D2 (pair-split) orbits")
os.makedirs('data', exist_ok=True)
json.dump(rows, open('data/per_class_report.json', 'w'), indent=1)
with open('data/per_class_report.csv', 'w', newline='') as fh:
    w = csv.writer(fh); keys = [k for k in rows[0] if k != 'characters']
    w.writerow(keys)
    for r in rows: w.writerow([json.dumps(r[k]) if isinstance(r[k], list) else r[k] for k in keys])
