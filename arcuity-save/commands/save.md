---
allowed-tools: Bash(git:*), Bash(find:*), Bash(wc:*), Bash(cat:*), Bash(date:*), Read, Write, Edit, Glob, Grep
description: Complete save with rollback point, documentation update, GPG-signed commit, and push
---

## Context

- Current git status: !`git status`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -5`
- Repository root: !`git rev-parse --show-toplevel`
- Python file count: !`find . -name "*.py" -not -path "./.git/*" -not -path "./archived/*" -not -path "./.venv/*" 2>/dev/null | wc -l`

## User Configuration

- **Name:** joesalvati68
- **Email:** joe@arcuity.com
- **GPG Key ID:** 17A16D5C0BF3D268

## Your Task

Perform a complete /save operation with these EXACT steps:

### 1. Create Rollback Point
```bash
ROLLBACK_TAG="rollback-$(date '+%Y%m%d-%H%M%S')" && git rev-parse HEAD > .last_rollback_commit && echo "$ROLLBACK_TAG" > .last_rollback_tag && git tag -f "$ROLLBACK_TAG"
```

### 2. Sync with Remote
```bash
BRANCH=$(git branch --show-current) && git stash push -m "save-temp" 2>/dev/null; git pull --rebase origin "$BRANCH" 2>/dev/null; git stash pop 2>/dev/null
```

### 3. Update Documentation
- If README.md is missing or empty, create it with:
  - Repository name and description
  - Statistics (Python files, lines of code)
  - Quick start section
  - Build instructions placeholder

- If CODEMAP.md is missing or empty, create it with:
  - Directory structure (max 3 levels deep)
  - File statistics table
  - Architecture overview section

### 4. Stage All Changes
```bash
git add -A
```

### 5. Create GPG-Signed Commit
Use the commit message provided by the user, or generate one based on the changes.
Add the co-author line.

```bash
git commit -S --gpg-sign=17A16D5C0BF3D268 -m "$(cat <<'EOF'
{COMMIT_MESSAGE}

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
EOF
)"
```

If GPG signing fails, fall back to unsigned commit:
```bash
git commit -m "{COMMIT_MESSAGE}

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"
```

### 6. Push to Remote
```bash
git push origin $(git branch --show-current)
```

### 7. Report Summary
After completing all steps, report:
- Rollback tag name (from .last_rollback_tag)
- Number of files changed
- Current branch
- Push status (success/failed)
- How to rollback: `git reset --hard $(cat .last_rollback_commit)`

## Important Notes
- Always try GPG signing first (key 17A16D5C0BF3D268)
- If no commit message provided, use: "Auto-save: {timestamp}"
- Create README.md and CODEMAP.md only if they don't exist or are empty
- Don't modify existing documentation content, only create new files
