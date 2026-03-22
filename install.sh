#!/bin/bash
set -e

VIBEFLOW_SOURCE="$HOME/projects/vibeflow"
OPENCODE_CONFIG="$HOME/.config/opencode"
TARGET_DIR="$OPENCODE_CONFIG/vibeflow"
OPENCODE_JSON="$OPENCODE_CONFIG/opencode.json"

echo "Installing Vibeflow..."

# 1. Copy vibeflow folder
echo "Copying vibeflow to $TARGET_DIR..."
mkdir -p "$TARGET_DIR"
cp -r "$VIBEFLOW_SOURCE"/* "$TARGET_DIR/"

# 2. Copy agents (exclude README.md)
echo "Copying agents..."
for f in "$TARGET_DIR"/*.md; do
    if [ "$(basename "$f")" != "README.md" ]; then
        cp "$f" "$OPENCODE_CONFIG/agents/"
    fi
done

# 3. Copy plugin
echo "Copying plugin..."
mkdir -p "$OPENCODE_CONFIG/plugins"
cp "$TARGET_DIR/plugins/vibeflow.ts" "$OPENCODE_CONFIG/plugins/"

# 4. Update opencode.json - manual step needed
echo ""
echo "IMPORTANT: Add to your opencode.json agent section:"
echo '  "build": { "disable": true },'
echo '  "plan": { "disable": true },'
echo '  "learn": { "disable": true },'
echo ""

echo "Done! Vibeflow installed to: $TARGET_DIR"
echo "Restart OpenCode to use vibeflow!"
