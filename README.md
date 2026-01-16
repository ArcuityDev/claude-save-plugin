# Arcuity /save Plugin for Claude Code

Universal save command for Claude Code that creates rollback points, updates documentation, commits with GPG signing, and pushes to GitHub.

## Quick Install

```bash
curl -sL https://raw.githubusercontent.com/ArcuityDev/claude-save-plugin/main/install.sh | bash
```

Then restart Claude Code.

## Manual Install

```bash
# Create plugin directory
mkdir -p ~/.claude/plugins/marketplaces/claude-plugins-official/plugins/arcuity-save/commands

# Download files
curl -sL https://raw.githubusercontent.com/ArcuityDev/claude-save-plugin/main/arcuity-save/commands/save.md \
  -o ~/.claude/plugins/marketplaces/claude-plugins-official/plugins/arcuity-save/commands/save.md
curl -sL https://raw.githubusercontent.com/ArcuityDev/claude-save-plugin/main/arcuity-save/README.md \
  -o ~/.claude/plugins/marketplaces/claude-plugins-official/plugins/arcuity-save/README.md
```

## Usage

```
/save                              # Auto-generated commit message
/save Fixed the login bug          # Custom commit message
/save Added new feature            # Custom commit message
```

## What /save Does

1. **Creates rollback point** - Git tag with timestamp (`rollback-YYYYMMDD-HHMMSS`)
2. **Pulls remote changes** - Syncs with remote using rebase
3. **Updates documentation** - Creates README.md and CODEMAP.md if missing
4. **Stages all changes** - `git add -A`
5. **GPG-signed commit** - Signs with key `17A16D5C0BF3D268`
6. **Pushes to remote** - Pushes current branch

## Rollback

After running `/save`, rollback to previous state:

```bash
git reset --hard $(cat .last_rollback_commit)
```

## Configuration

Default configuration for joe@arcuity.com:

| Setting | Value |
|---------|-------|
| GPG Key ID | `17A16D5C0BF3D268` |
| Email | `joe@arcuity.com` |
| User | `joesalvati68` |

To customize, edit `~/.claude/plugins/marketplaces/claude-plugins-official/plugins/arcuity-save/commands/save.md`

## License

MIT
