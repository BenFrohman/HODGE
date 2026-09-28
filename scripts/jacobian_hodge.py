"""Jacobian-ring dimensions of a smooth sextic in P^5.

Author: Benjamin Stanley Frohman
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache-2.0

The partials of a smooth degree-6 form in six variables are a regular
sequence of degree 5, so

    sum dim R_k t^k = (1 - t^5)^6 / (1 - t)^6.

Griffiths identifies R_0, R_6, R_12, R_18, R_24 with the primitive
Hodge pieces of H^4. The class h^2 is the one non-primitive class.
"""

from math import comb


def dim(k: int) -> int:
    signs = [1, -6, 15, -20, 15, -6, 1]
    total = 0
    for i, c in enumerate(signs):
        m = k - 5 * i
        if m >= 0:
            total += c * comb(m + 5, 5)
    return total


def main() -> None:
    pieces = (0, 6, 12, 18, 24)
    for k in pieces:
        print(k, dim(k))
    primitive = sum(dim(k) for k in pieces)
    print("sum prim", primitive)
    print("plus h2", primitive + 1)


if __name__ == "__main__":
    main()
