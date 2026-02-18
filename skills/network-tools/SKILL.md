---
name: network-tools
description: "Diagnose network connectivity. Use when: user asks 'is internet working', 'what is my IP', 'ping google', or checks connectivity."
metadata: { "openclaw": { "emoji": "🌐", "requires": { "bins": ["ping", "curl", "ip"] } } }
---

# Network Tools Skill

Diagnose connectivity.

## Commands

### Check Public IP

```bash
curl -s ifconfig.me && echo ""
```

### Check Local IPs

```bash
ip -br addr show | grep -v 'lo'
```

### Ping Host

```bash
ping -c 3 <hostname_or_ip>
```

### Quick Internet Check (is online?)

```bash
ping -c 1 8.8.8.8 >/dev/null 2>&1 && echo "✅ Online (Google DNS reachable)" || echo "❌ Offline"
```
