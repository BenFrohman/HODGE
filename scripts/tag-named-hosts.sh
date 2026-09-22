#!/usr/bin/env bash
# Stamp the current main tip as a named-hosts snapshot.
# Does not claim Clay. Author: Benjamin Stanley Frohman. Apache-2.0.
set -euo pipefail
TAG="${1:-named-hosts-2026-09-22}"
MSG="Named-host release: classical_fourfolds + named_fourfolds. general_fourfold uninhabited."
git checkout main
git pull --ff-only origin main
git tag -a "$TAG" -m "$MSG"
echo "Created tag $TAG at $(git rev-parse --short HEAD)"
echo "Push with: git push origin $TAG"
