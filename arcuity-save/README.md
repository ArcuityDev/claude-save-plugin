# Arcuity Save Command Plugin

Universal save command for joe@arcuity.com that works across all projects.

## Commands

### `/save [message]`

Performs a complete save operation:

1. **Creates rollback point** - Git tag with timestamp for easy rollback
2. **Pulls remote changes** - Syncs with remote before committing
3. **Updates documentation** - Creates README.md and CODEMAP.md if missing
4. **Stages all changes** - Adds all modified and new files
5. **GPG-signed commit** - Signs commit with key 17A16D5C0BF3D268
6. **Pushes to remote** - Pushes to the current branch

## Usage

```
/save                           # Auto-generates commit message
/save Fixed the login bug       # Uses provided message
/save Added new dedup module    # Uses provided message
```

## Rollback

After running `/save`, you can rollback to the previous state:

```bash
git reset --hard $(cat .last_rollback_commit)
```

Or use the tag:
```bash
git reset --hard rollback-YYYYMMDD-HHMMSS
```

## Configuration

- **GPG Key:** 17A16D5C0BF3D268
- **Email:** joe@arcuity.com
- **User:** joesalvati68

## Requirements

- Git repository
- GPG key installed (falls back to unsigned if unavailable)
- Remote configured (for push)
