---
name: daily-briefing
description: "Start the day with a briefing. Use when: user says 'good morning', 'start my day', or 'briefing'. Checks weather, system status, and pending reminders."
metadata: { "openclaw": { "emoji": "🌅", "requires": { "bins": ["date", "curl", "uptime"] } } }
---

# Daily Briefing Skill

## Commands

### Execute Briefing

```bash
echo "🌅 **Good Morning, Ryuki.**"
echo "---"
echo "📅 **$(date '+%A, %B %d, %Y')**"
echo ""

# Weather (London default, change if needed)
echo "🌤️ **Weather:**"
curl -s "wttr.in/London?format=%l:+%c+%t+(feels+like+%f),+%w+wind" || echo "  Unable to fetch weather."
echo ""

# System
echo "📊 **System Health:**"
echo "  • Uptime: $(uptime -p)"
# Extract load average
echo "  • Load: $(uptime | awk -F'load average:' '{ print $2 }' | xargs)"
echo ""

# Reminders
if [ -s ~/.openclaw/todo.txt ]; then
    echo "🎗️ **Pending Tasks:**"
    cat ~/.openclaw/todo.txt | head -5
    COUNT=$(wc -l < ~/.openclaw/todo.txt)
    if [ "$COUNT" -gt 5 ]; then echo "  ...and $(($COUNT - 5)) more."; fi
else
    echo "🎉 No pending tasks!"
fi
```
