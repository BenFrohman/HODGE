/-
Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman).
Released under the Apache License, Version 2.0.
Author: Benjamin Stanley Frohman.
-/

/-!
# Host split

`V(F5)` and the chain sextic `V(F)` are different hosts.
Numeral identities only. The sextic remainder `Z` is not computed.
`T_F` is not redefined.

Closed here: the numeral split.
Not closed here: rational Hodge. The Fermat lattice rank 401 is literature.
-/

namespace Hodge
namespace HostSplit

theorem quintic_h31 : (126 : Nat) - 6 = 120 := by decide
theorem quintic_h22 : (580 : Nat) + 1 = 581 := by decide
theorem quintic_b4 : (0 : Nat) + 120 + 581 + 120 + 0 = 821 := by decide

theorem sextic_r6 : (426 : Nat) = 426 := rfl
theorem sextic_r12 : (1751 : Nat) = 1751 := rfl
theorem sextic_r18 : (426 : Nat) = 426 := rfl
theorem sextic_h22 : (1751 : Nat) + 1 = 1752 := by decide
theorem sextic_b4 : (1 : Nat) + 426 + 1752 + 426 + 1 = 2606 := by decide
theorem sextic_length : (5 : Nat) ^ 6 = 15625 := by decide

theorem containers_differ : (120 : Nat) ≠ 426 := by decide

/-- Exponent sum of the AMV elementary divisors. Not the lattice theorem. -/
theorem amv_exponent_sum : (166 : Nat) + 174 + 54 + 7 = 401 := by decide

theorem Z_uncomputed : True := trivial

end HostSplit
end Hodge
