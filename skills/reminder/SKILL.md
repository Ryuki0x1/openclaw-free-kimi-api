---
name: reminder
description: "Manage a simple TODO list or reminders. Use when: user says 'remind me to...', 'add to todo', 'list tasks', 'what do I need to do'. This is a PASSIVE list, it does not alert you proactively."
metadata: { "openclaw": { "emoji": "🎗️", "requires": { "bins": ["date", "sed"] } } }
---

# Reminder Skill

Manage a simple TODO list.

## Data Location
stored in `~/.openclaw/todo.txt`

## Commands

### Add Task

```bash
echo "[ ] <task_description>" >> ~/.openclaw/todo.txt && echo "🎗️ Added to TODO list."
```

### List Tasks

```bash
if [ -s ~/.openclaw/todo.txt ]; then
    echo "📋 **Your TODO List:**"
    cat -n ~/.openclaw/todo.txt
else
    echo "🎉 No tasks in list!"
fi
```

### Mark Done (Remove by Line Number)

```bash
# Usage: remove line N
sed -i '<line_number>d' ~/.openclaw/todo.txt && echo "✅ Task removed."
```

### Clear All

```bash
> ~/.openclaw/todo.txt && echo "🗑️ All tasks cleared."
```
