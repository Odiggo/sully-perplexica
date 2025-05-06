#!/bin/bash

set -euo pipefail

FORK_REMOTE=${1:-origin}
UPSTREAM_REMOTE=${2:-upstream}
BASE_BRANCH=${3:-master}
NEW_BRANCH_NAME="sync-$(date +%Y%m%d-%H%M%S)"

echo "🔄 Fetching latest from upstream..."
git fetch "$UPSTREAM_REMOTE"

echo "🔀 Checking out local $BASE_BRANCH..."
git checkout "$BASE_BRANCH"

echo "🧬 Rebasing onto $UPSTREAM_REMOTE/$BASE_BRANCH..."
git rebase "$UPSTREAM_REMOTE/$BASE_BRANCH"

echo "🌱 Creating new branch: $NEW_BRANCH_NAME"
git checkout -b "$NEW_BRANCH_NAME"

echo "☁️ Pushing new branch to $FORK_REMOTE..."
git push -u "$FORK_REMOTE" "$NEW_BRANCH_NAME"

echo ""
echo "✅ Rebase complete. Open a PR from:"
echo "    $FORK_REMOTE/$NEW_BRANCH_NAME → $FORK_REMOTE/$BASE_BRANCH"
