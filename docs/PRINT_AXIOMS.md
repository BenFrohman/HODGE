# What `#print axioms` will actually list

Author: Benjamin Stanley Frohman (@BenFrohman).

Do not import `NoetherLefschetz` from this repo. Sister project.
There is no `lefschetz_one_one_theorem` and no `noether_lefschetz_vacuous_locus`.

After `lake build`, in a file that imports `Hodge.Fourfold`:

    #print axioms Hodge.HodgeConjecture.general_fourfold

Expected: `construct_of_codim_ge_two` (and standard logic axioms).
That is Row 2: a promise, not a construction.

    #print axioms Hodge.HodgeConjecture.classical_fourfolds

Expected: no `construct_of_codim_ge_two` if the islands go through `CycleSection`.

Codim 1: `#print axioms Hodge.hodgeConjecture_codim_one` lists whatever
`LefschetzOneOne` used — that class is a hypothesis in `Hodge/Frontier.lean`.

NL (other repo): `#print axioms NoetherLefschetz.no_extra_on_nl_locus`
lists `noether_lefschetz`.
