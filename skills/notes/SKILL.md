---
name: notes
description: "Quick scratchpad for thoughts, ideas, or temporary info. Use when: user says 'note that...', 'add a note', 'remember this', or asks for 'my notes'. Ideal for short-term memory capture."
metadata: { "openclaw": { "emoji": "📝", "requires": { "bins": ["date", "tail"] } } }
---

# Notes Skill

A simple append-only scratchpad.

## Data Location
stored in `~/.openclaw/notes.txt`

## Commands

### Add Note

```bash
echo "- $(date '+%Y-%m-%d %H:%M') | <note_content>" >> ~/.openclaw/notes.txt && echo "📝 Note saved."
```

### Read Recent Notes

```bash
# Show last 10 notes
[ -f ~/.openclaw/notes.txt ] && tail -n 10 ~/.openclaw/notes.txt || echo "📝 No notes found."
```

### Search Notes

```bash
[ -f ~/.openclaw/notes.txt ] && grep -i "<search_term>" ~/.openclaw/notes.txt || echo "📝 No matching notes found."
```

### Clear Notes

```bash
> ~/.openclaw/notes.txt && echo "🗑️ Notes cleared."
```
