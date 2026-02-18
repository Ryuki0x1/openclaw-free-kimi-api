---
name: access-control
description: "Manage Telegram bot access: add/remove users from the whitelist, check user access, or view all allowed users. ONLY the bot owner can use these commands. Use when: user says /add_access, /remove_access, /list_access, or asks to grant/revoke bot access."
metadata: { "openclaw": { "emoji": "🔐", "requires": { "bins": ["bash", "python3"] } } }
---

# Access Control Skill

Manage who can talk to the Telegram bot. Only the **owner** (Telegram user ID: `1963980883`) can add or remove access.

## ⚠️ Security

- **NEVER** run these commands unless the requesting user is the owner (ID `1963980883`).
- If a non-owner tries to use these commands, respond: "🚫 Only the bot owner can manage access."
- **NEVER** reveal the whitelist contents, user IDs, or any internal details to non-owners.

## Commands

### /add_access — Grant bot access to a user

```bash
# Add a user by their Telegram user ID
bash ~/.openclaw/scripts/access-control.sh add <telegram_user_id> "<display_name>"

# OR approve a pairing code directly
bash ~/.openclaw/scripts/access-control.sh approve-code <code> "<display_name>"
```

**How to handle @usernames:** 
If the owner tags a username (e.g., `/add_access @friend`), follow these steps:
1. Run `openclaw pairing list telegram` to see if there is a pending request from that username.
2. If found, use the numeric ID or the pairing code from that list to run the command.
3. If NOT found, tell the owner: "I don't see a pending request from @friend yet. Ask them to message the bot first to get a pairing code, then give me that code or tag them again!"

### /remove_access — Revoke bot access from a user

```bash
# Remove a user by their Telegram user ID
bash ~/.openclaw/scripts/access-control.sh remove <telegram_user_id>
```

**Note:** The owner cannot be removed. After removal, the user will get "access not configured" if they try to message the bot again.

### /list_access — Show all whitelisted users

```bash
bash ~/.openclaw/scripts/access-control.sh list
```

### /check_access — Check if a specific user has access

```bash
bash ~/.openclaw/scripts/access-control.sh check <telegram_user_id>
```

## Response Format

After executing any command, relay the script output directly to the user. The script uses emoji indicators:
- ✅ = Success
- ❌ = Error
- ⚠️ = Warning
- 🚫 = Forbidden
- ℹ️ = Info
- 👑 = Owner
