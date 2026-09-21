# Lake targets

Copyright (c) 2026 Benjamin Stanley Frohman (@BenFrohman).

```
lake build          # default = Hodge (core). Does not import Attempt.
lake build Hodge    # same.
lake build HodgeAttempt   # sandbox sketches only.
```

`Hodge.lean` must not contain `import Hodge.Attempt`.
CI builds `Hodge` only.
