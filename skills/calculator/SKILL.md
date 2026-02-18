---
name: calculator
description: "Perform math calculations. Use when: user asks 'what is 5+5', 'calculate ...', or needs unit conversions. Uses `bc` for precision."
metadata: { "openclaw": { "emoji": "🧮", "requires": { "bins": ["bc"] } } }
---

# Calculator Skill

Quick math using `bc`.

## Commands

### Calculate

```bash
# Calculate and print result
echo "scale=4; <expression>" | bc -l
```

### Examples

- `5 * 400`
- `(100 / 3)`
- `sqrt(100)`
