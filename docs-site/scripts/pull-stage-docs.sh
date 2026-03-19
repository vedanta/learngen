#!/usr/bin/env bash
# Pull stage docs from a feature branch without checking it out.
# Usage: ./pull-stage-docs.sh <branch-name>
# Example: ./pull-stage-docs.sh feature/01-components

set -euo pipefail

BRANCH="${1:?Usage: $0 <branch-name>}"
DOCS_DIR="$(cd "$(dirname "$0")/../docs" && pwd)"

# Read stage metadata from the branch
STAGE_JSON=$(git show "$BRANCH:docs/stage.json" 2>/dev/null) || {
  echo "Error: Could not read docs/stage.json from branch '$BRANCH'"
  echo "Make sure the branch exists and has docs/stage.json"
  exit 1
}

STAGE_NUM=$(echo "$STAGE_JSON" | python3 -c "import sys,json; print(f'{json.load(sys.stdin)[\"number\"]:02d}')")
STAGE_TITLE=$(echo "$STAGE_JSON" | python3 -c "import sys,json; print(json.load(sys.stdin)['title'])")

OUT_DIR="$DOCS_DIR/stage-${STAGE_NUM}"
mkdir -p "$OUT_DIR"

echo "Pulling Stage $STAGE_NUM: $STAGE_TITLE from $BRANCH"

# Pull each doc file (readme.md maps to index.md, rest keep their names)
FILES="readme.md:index.md changelog.md:changelog.md steps.md:steps.md walkthrough.md:walkthrough.md architecture.md:architecture.md exercises.md:exercises.md troubleshooting.md:troubleshooting.md"

for pair in $FILES; do
  src="docs/${pair%%:*}"
  dest="${pair##*:}"
  if git show "$BRANCH:$src" > "$OUT_DIR/$dest" 2>/dev/null; then
    echo "  ✓ $src → stage-${STAGE_NUM}/$dest"
  else
    echo "  ✗ $src not found on $BRANCH (skipped)"
    rm -f "$OUT_DIR/$dest"
  fi
done

echo ""
echo "Done! Files written to: stage-${STAGE_NUM}/"
echo ""
echo "Next steps:"
echo "  1. Add a sidebar entry in docs/.vitepress/config.mjs"
echo "  2. Update landing page and overview"
echo "  3. Commit and push to main to deploy"
