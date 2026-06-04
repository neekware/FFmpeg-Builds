#!/usr/bin/env bash
set -euo pipefail

# Sync this fork from upstream while ensuring upstream GitHub Actions workflows
# never run under neekware and burn build minutes.
#
# Usage:
#   ./neekware/sync-upstream.sh
#   git push origin master

UPSTREAM_REMOTE="${UPSTREAM_REMOTE:-upstream}"
UPSTREAM_BRANCH="${UPSTREAM_BRANCH:-master}"
TARGET_BRANCH="${TARGET_BRANCH:-master}"

if ! git remote get-url "$UPSTREAM_REMOTE" >/dev/null 2>&1; then
  git remote add "$UPSTREAM_REMOTE" https://github.com/BtbN/FFmpeg-Builds.git
fi

git fetch "$UPSTREAM_REMOTE" --prune
git checkout "$TARGET_BRANCH"
git merge --no-edit "$UPSTREAM_REMOTE/$UPSTREAM_BRANCH"

# Critical: never keep upstream Actions in our fork.
rm -rf .github/workflows

git add -A
if ! git diff --cached --quiet; then
  git commit -m "Sync upstream and keep GitHub Actions disabled"
else
  echo "No changes after upstream sync/workflow removal."
fi

echo "Ready. Review, then push with: git push origin $TARGET_BRANCH"
