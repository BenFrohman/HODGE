<!--
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache-2.0 license as described in the file LICENSE.
Author: Benjamin Stanley Frohman
-->

# Copyright and license — never dropped

Author: Benjamin Stanley Frohman
Copyright (c) 2026 Benjamin Stanley Frohman
License: Apache-2.0

Every file in this repository, and every commit that adds or changes a file, carries:

    Copyright (c) 2026 Benjamin Stanley Frohman
    License: Apache-2.0

## Required header (markdown / Lean / text)

Markdown and Lean files open with:

    Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
    Released under Apache-2.0 license as described in the file LICENSE.
    Author: Benjamin Stanley Frohman

The body also names the author and Apache-2.0 on the first screen.

## Required footer of every commit message

    Author: Benjamin Stanley Frohman
    License: Apache-2.0

## LICENSE

The tree root `LICENSE` is Apache-2.0 with
`Copyright 2026 Benjamin Stanley Frohman`.
Do not replace it with MIT or an empty file.

## What is a drop

- A new file with no author line.
- A new file with no license line.
- A commit that strips the header from an existing file.
- A sister-repo copy that ships without this copyright.

Those are integrity defects. Put the header back in the next commit.
