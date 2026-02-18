---
name: system-monitor
description: "Check the server's health status. Use when: user asks for 'status', 'uptime', 'health', 'load', 'disk space', or 'how are you doing'. Reports CPU load, memory usage, disk space, uptime, and OpenClaw service status."
metadata: { "openclaw": { "emoji": "📊", "requires": { "bins": ["uptime", "free", "df", "systemctl"] } } }
---

# System Monitor Skill

Get a quick health report of the server.

## Commands

### /status — Full System Report

```bash
echo "📊 **System Status**"
echo ""
echo "**Uptime:** $(uptime -p)"
echo "**Load:** $(uptime | awk -F'load average:' '{ print $2 }')"
echo ""
echo "**Memory:**"
free -h | grep -E 'Mem|Swap'
echo ""
echo "**Disk Usage:**"
df -h / | awk 'NR==1{print $0} NR==2{print $0}'
echo ""
echo "**OpenClaw Services:**"
systemctl --user is-active openclaw-gateway.service || echo "❌ openclaw-gateway: inactive"
```
