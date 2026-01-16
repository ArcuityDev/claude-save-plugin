#!/bin/bash
#===============================================================================
# Install Arcuity /save Plugin for Claude Code
#
# Usage: curl -sL https://raw.githubusercontent.com/ArcuityDev/claude-save-plugin/main/install.sh | bash
#===============================================================================

set -e

echo "Installing Arcuity /save plugin for Claude Code..."

# Create plugin directory
PLUGIN_DIR="$HOME/.claude/plugins/marketplaces/claude-plugins-official/plugins/arcuity-save"
mkdir -p "$PLUGIN_DIR/commands"

# Download plugin files
REPO_URL="https://raw.githubusercontent.com/ArcuityDev/claude-save-plugin/main"

curl -sL "$REPO_URL/arcuity-save/commands/save.md" -o "$PLUGIN_DIR/commands/save.md"
curl -sL "$REPO_URL/arcuity-save/README.md" -o "$PLUGIN_DIR/README.md"

# Register plugin
PLUGINS_JSON="$HOME/.claude/plugins/installed_plugins.json"
if [ -f "$PLUGINS_JSON" ]; then
    # Add to existing plugins
    python3 -c "
import json
with open('$PLUGINS_JSON', 'r') as f:
    data = json.load(f)
data['plugins']['arcuity-save'] = {
    'marketplace': 'claude-plugins-official',
    'version': '1.0.0',
    'installedAt': '$(date -u +%Y-%m-%dT%H:%M:%S.000Z)'
}
with open('$PLUGINS_JSON', 'w') as f:
    json.dump(data, f, indent=2)
" 2>/dev/null || echo '{"version":2,"plugins":{"arcuity-save":{"marketplace":"claude-plugins-official","version":"1.0.0"}}}' > "$PLUGINS_JSON"
else
    echo '{"version":2,"plugins":{"arcuity-save":{"marketplace":"claude-plugins-official","version":"1.0.0"}}}' > "$PLUGINS_JSON"
fi

echo ""
echo "✅ Arcuity /save plugin installed successfully!"
echo ""
echo "Restart Claude Code, then use: /save [commit message]"
echo ""
echo "Features:"
echo "  - Creates rollback point (git tag)"
echo "  - Pulls remote changes"
echo "  - Creates README.md & CODEMAP.md if missing"
echo "  - GPG-signed commits (key: 17A16D5C0BF3D268)"
echo "  - Pushes to GitHub"
echo ""
