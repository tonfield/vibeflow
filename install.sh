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

# 2. Copy agents
echo "Copying agents..."
cp "$TARGET_DIR"/*.md "$OPENCODE_CONFIG/agents/"

# 3. Copy plugin
echo "Copying plugin..."
mkdir -p "$OPENCODE_CONFIG/plugins"
cp "$TARGET_DIR/plugins/vibeflow.ts" "$OPENCODE_CONFIG/plugins/"

# 4. Update opencode.json to use vibeflow agents
echo "Updating opencode.json..."

# Backup
cp "$OPENCODE_JSON" "$OPENCODE_JSON.bak"

# Add vibeflow plugin if not present
if ! grep -q '"plugin"' "$OPENCODE_JSON"; then
    # No plugin section, add it
    sed -i 's/"default_agent": "build"/"plugin": ["vibeflow"],\n  "default_agent": "build"/' "$OPENCODE_JSON"
else
    # Plugin exists, ensure vibeflow is in it
    if ! grep -q '"vibeflow"' "$OPENCODE_JSON"; then
        sed -i 's/"plugin": \["/"plugin": ["vibeflow", "/' "$OPENCODE_JSON"
    fi
fi

# 5. Optional: Disable build/plan agents (uncomment to enable)
# echo "Disabling default build/plan agents..."
# sed -i 's/"build": {/"build": { "disable": true, /' "$OPENCODE_JSON" 2>/dev/null || true
# sed -i 's/"plan": {/"plan": { "disable": true, /' "$OPENCODE_JSON" 2>/dev/null || true

echo ""
echo "Done! Vibeflow installed to: $TARGET_DIR"
echo "Agents installed to: $OPENCODE_CONFIG/agents/"
echo "Plugin installed to: $OPENCODE_CONFIG/plugins/"
echo ""
echo "IMPORTANT: Review $OPENCODE_JSON and optionally disable build/plan agents"
echo "Restart OpenCode to use vibeflow!"
