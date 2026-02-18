#!/usr/bin/env bash
# access-control.sh — Manage Telegram bot access whitelist
# Usage:
#   access-control.sh add    <telegram_user_id_or_username>
#   access-control.sh remove <telegram_user_id_or_username>
#   access-control.sh list
#   access-control.sh check  <telegram_user_id>

set -euo pipefail

WHITELIST_FILE="$HOME/.openclaw/access-whitelist.json"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Ensure whitelist file exists
if [ ! -f "$WHITELIST_FILE" ]; then
  echo '{"owner":"1963980883","allowed_users":[{"id":"1963980883","name":"ryuki","added_at":"'"$(date -Iseconds)"'"}]}' | python3 -m json.tool > "$WHITELIST_FILE"
fi

ACTION="${1:-help}"
TARGET="${2:-}"

case "$ACTION" in
  add)
    if [ -z "$TARGET" ]; then
      echo "❌ Usage: access-control.sh add <telegram_user_id> [display_name]"
      exit 1
    fi
    DISPLAY_NAME="${3:-$TARGET}"
    
    # Check if already in whitelist
    if python3 -c "import json; data=json.load(open('$WHITELIST_FILE')); exit(0 if any(u['id']=='$TARGET' for u in data['allowed_users']) else 1)" 2>/dev/null; then
      echo "ℹ️ User $TARGET is already whitelisted."
      exit 0
    fi
    
    # Add to whitelist file
    python3 -c "
import json, sys
from datetime import datetime
with open('$WHITELIST_FILE', 'r') as f:
    data = json.load(f)
data['allowed_users'].append({
    'id': '$TARGET',
    'name': '$DISPLAY_NAME',
    'added_at': datetime.now().isoformat()
})
with open('$WHITELIST_FILE', 'w') as f:
    json.dump(data, f, indent=2)
print(f'✅ Added user $TARGET ($DISPLAY_NAME) to whitelist.')
"
    
    # Approve in OpenClaw pairing system
    openclaw pairing approve telegram "$TARGET" 2>/dev/null && \
      echo "✅ Approved in OpenClaw pairing." || \
      echo "⚠️ Could not auto-approve in OpenClaw (user may need to send a message first to generate a pairing code)."
    ;;

  approve-code)
    CODE="$TARGET"
    if [ -z "$CODE" ]; then
      echo "❌ Usage: access-control.sh approve-code <code> [display_name]"
      exit 1
    fi
    DISPLAY_NAME="${3:-$CODE}"

    # Try to approve the code and capture the output (it usually prints the ID)
    OUT=$(openclaw pairing approve telegram "$CODE" 2>&1) || {
      echo "❌ Failed to approve code $CODE: $OUT"
      exit 1
    }
    
    # Extract ID from "Approved telegram sender 123456789"
    ID=$(echo "$OUT" | grep -oP 'sender \K\d+')
    if [ -z "$ID" ]; then
      echo "✅ Approved code $CODE, but could not extract User ID automatically."
      echo "ℹ️ Please add the user manually using: /add_access <user_id>"
    else
      # Now add to whitelist
      bash "$0" add "$ID" "$DISPLAY_NAME"
    fi
    ;;
    
  remove)
    if [ -z "$TARGET" ]; then
      echo "❌ Usage: access-control.sh remove <telegram_user_id>"
      exit 1
    fi
    
    # Check if this is the owner
    OWNER=$(python3 -c "import json; print(json.load(open('$WHITELIST_FILE'))['owner'])")
    if [ "$TARGET" = "$OWNER" ]; then
      echo "🚫 Cannot remove the owner ($OWNER) from the whitelist!"
      exit 1
    fi
    
    # Remove from whitelist file
    python3 -c "
import json
with open('$WHITELIST_FILE', 'r') as f:
    data = json.load(f)
before = len(data['allowed_users'])
data['allowed_users'] = [u for u in data['allowed_users'] if u['id'] != '$TARGET']
after = len(data['allowed_users'])
if before == after:
    print('⚠️ User $TARGET was not found in the whitelist.')
else:
    with open('$WHITELIST_FILE', 'w') as f:
        json.dump(data, f, indent=2)
    print('✅ Removed user $TARGET from whitelist.')
    print('ℹ️ Note: The user will also need a new pairing code to re-access the bot.')
"
    ;;
    
  list)
    echo "📋 Whitelisted users:"
    python3 -c "
import json
with open('$WHITELIST_FILE', 'r') as f:
    data = json.load(f)
owner = data.get('owner', '')
for u in data['allowed_users']:
    tag = ' 👑 (owner)' if u['id'] == owner else ''
    print(f\"  • {u['name']} (ID: {u['id']}){tag} — added {u.get('added_at', 'unknown')}\")
print(f\"\nTotal: {len(data['allowed_users'])} user(s)\")
"
    ;;
    
  check)
    if [ -z "$TARGET" ]; then
      echo "❌ Usage: access-control.sh check <telegram_user_id>"
      exit 1
    fi
    if python3 -c "import json; data=json.load(open('$WHITELIST_FILE')); exit(0 if any(u['id']=='$TARGET' for u in data['allowed_users']) else 1)" 2>/dev/null; then
      echo "✅ User $TARGET IS whitelisted."
    else
      echo "❌ User $TARGET is NOT whitelisted."
    fi
    ;;
    
  help|*)
    echo "🔐 Bot Access Control"
    echo ""
    echo "Commands:"
    echo "  add    <user_id> [name]  — Add user to whitelist + approve pairing"
    echo "  remove <user_id>        — Remove user from whitelist"
    echo "  list                    — Show all whitelisted users"
    echo "  check  <user_id>        — Check if a user is whitelisted"
    ;;
esac
