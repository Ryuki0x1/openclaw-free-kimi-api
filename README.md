# MightyRaju — OpenClaw Personal Assistant Template

A fully configured [OpenClaw](https://github.com/google-deepmind/openclaw) setup for a personal AI assistant on a Linux server. Includes custom skills for system monitoring, reminders, notes, and more.

## Features

- **Custom Skills**:
  - `system-monitor`: Check server health (CPU, RAM, disk).
  - `reminder`: Simple TODO list management.
  - `notes`: Quick scratchpad.
  - `daily-briefing`: Morning report with weather + system status.
  - `calculator`: Quick math via `bc`.
  - `network-tools`: Ping, IP check, speedtest.
  - `access-control`: Secure Telegram whitelist management.
- **Server Hardening**:
  - Includes scripts and configs for a secure, headless setup.
- **Telegram Integration**:
  - Pre-configured for Kimi (Moonshot AI) or any OpenAI-compatible model.

## Setup

1. **Install OpenClaw**:
   ```bash
   npm install -g openclaw
   ```

2. **Clone & Configure**:
   ```bash
   git clone <your-repo-url>
   cd mightyraju
   
   # Copy examples to real config paths
   mkdir -p ~/.openclaw/scripts ~/.openclaw/skills
   cp -r scripts/* ~/.openclaw/scripts/
   cp -r skills/* ~/.openclaw/skills/
   
   cp openclaw.json.example ~/.openclaw/openclaw.json
   cp access-whitelist.example.json ~/.openclaw/access-whitelist.json
   ```

3. **Edit Config**:
   - Updates `~/.openclaw/openclaw.json` with your:
     - Telegram Bot Token
     - AI Provider API Key
     - Gateway Token
   - Update `~/.openclaw/access-whitelist.json` with your Telegram User ID.

4. **Install Dependencies**:
   ```bash
   sudo apt install ripgrep bc curl wget jq
   ```

5. **Start MightyRaju**:
   ```bash
   openclaw daemon start
   ```

## Skills Usage

| Skill | Command Example |
|---|---|
| 📊 Monitor | "System status" |
| 🎗️ Reminder | "Remind me to buy milk" |
| 📝 Notes | "Add a note: check logs" |
| 🌅 Briefing | "Good morning" |
| 🧮 Calc | "Calculate 5 * 100" |
| 🌐 Network | "What is my IP?" |

## License
MIT
