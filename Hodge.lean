/-
Copyright (c) 2026 Benjamin Stanley Frohman. Released under Apache-2.0.
Authors: Benjamin Stanley Frohman (@BenFrohman)

Core library. `import HodgeAttempt` pulls the sandbox root so `lake build Hodge`
typechecks it and `#print axioms` runs. It is not a Clay close.
Individual `import Hodge.Attempt.*` stays forbidden by CI.
-/
import Hodge.Basic
import Hodge.Frontier
import Hodge.Integral
import Hodge.Known
import Hodge.Examples
import Hodge.Fourfold
import Hodge.Classical
import Hodge.Klein
import Hodge.Geometry
import Hodge.Construct
import Hodge.Fermat
import Hodge.FermatQuintic
import Hodge.HostSplit
import Hodge.SpecialSextic
import Hodge.SpecialSexticMembership
import Hodge.HeadPlane
import Hodge.SpecialSexticJacobian
import Hodge.Hassett
import Hodge.NamedFamilies
import Hodge.SexticModuli
import Hodge.DerivedSurfaces
import Hodge.Verify
import HodgeAttempt

#print axioms Hodge.Attempt.GlobalClayFourfold
#print axioms Hodge.Attempt.fermat_pair_vanishing
#print axioms Hodge.Attempt.fermat_quartic_contains_Z1
