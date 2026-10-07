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

Closed here: the complex numeral split.
Not closed here: the rational Hodge lattice. Rank 401 is literature
(Aljovín–Movasati–Villaflor), not a term in this file.
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

theorem Z_uncomputed : True := trivial

end HostSplit
end Hodge
