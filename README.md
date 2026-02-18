# 🦞 Build Your Own "Jarvis" with OpenClaw & Free Kimi 2.5 API (MightyRaju)

Turn an idle Linux server (or Raspberry Pi) into a powerful, always-on AI assistant named **MightyRaju**.

This project uses [OpenClaw](https://github.com/google-deepmind/openclaw) as the agent framework and the **free tier of Moonshot AI's Kimi k2.5 model** (via NVIDIA NIM) to create a smart, responsive assistant that can:
- 📊 **Monitor your server health** (CPU, RAM, Disk, Uptime)
- 🌤️ **Give you daily briefings** (Weather + Agenda)
- 📝 **Take notes & manage reminders**
- 🔐 **Securely chat via Telegram** (Whitelist-only access)
- 🧠 **Remember context** across conversations

## 🚀 Why This Stack?

- **OpenClaw**: The most capable open-source agent runtime. It runs locally, owns its data, and uses "skills" (simple scripts) to do real work.
- **Kimi k2.5 (NVIDIA NIM)**: A massive 128k context model that rivals GPT-4 class models, available for **free** (at the time of writing) via NVIDIA's API catalog.
- **Telegram**: The perfect mobile interface for a secure, always-on bot.
- **Linux**: Runs on anything from a cheap VPS to an old laptop or Raspberry Pi.

---

## 🛠️ Prerequisites

- A Linux machine (Debian/Ubuntu recommended)
- [Node.js](https://nodejs.org/) v20+ (managed via `nvm` is best)
- A [Telegram Bot Token](https://t.me/BotFather) (Free)
- An [NVIDIA NIM API Key](https://build.nvidia.com/moonshot-ai/kimi-k2-5) (Free)
- Basic terminal knowledge

---

## 📥 Installation

### 1. Install System Tools
On Debian/Ubuntu:
```bash
sudo apt update
sudo apt install -y curl git ripgrep bc jq
```
*`ripgrep` is needed for memory search, `bc` for the calculator skill.*

### 2. Install OpenClaw
```bash
# Install nvm if you haven't
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.bashrc
nvm install 22
nvm use 22

# Install OpenClaw globally
npm install -g openclaw
```

### 3. Clone This Repo
```bash
git clone https://github.com/Ryuki0x1/openclaw-free-kimi-api.git mightyraju
cd mightyraju
```

### 4. Setup Configuration
Copy the template files to your OpenClaw directory:

```bash
# Create directories
mkdir -p ~/.openclaw/scripts ~/.openclaw/skills

# Copy skills & scripts
cp -r scripts/* ~/.openclaw/scripts/
cp -r skills/* ~/.openclaw/skills/

# Copy config templates
cp openclaw.json.example ~/.openclaw/openclaw.json
cp access-whitelist.example.json ~/.openclaw/access-whitelist.json
```

---

## ⚙️ Configuration

### 1. Edit `openclaw.json`
Open `~/.openclaw/openclaw.json` and fill in your keys:

- **`apiKey`**: Your NVIDIA NIM key (starts with `nvapi-`).
- **`botToken`**: Your Telegram Bot Token.
- **`token`** (under gateway): Generate a random string (e.g., `openssl rand -hex 16`) for local auth.

### 2. Edit `access-whitelist.json`
Open `~/.openclaw/access-whitelist.json`:
- Replace `YOUR_TELEGRAM_USER_ID` with your numeric Telegram ID (get it from `@userinfobot`).
- **Start Securely**: By default, this config blocks **everyone** except the whitelist.

### 3. Start the Daemon
```bash
openclaw daemon start
```
Check status: `openclaw daemon status`

---

## 🧠 Custom Skills (The "MightyRaju" Suite)

This repo includes custom skills that give the AI real-world powers.

| Skill | Command / Trigger | What it does |
|---|---|---|
| **📊 System Monitor** | "System status", "Health check" | Checks CPU load, free RAM, disk space, and uptime. |
| **🌅 Daily Briefing** | "Good morning", "Briefing" | Shows date, London weather (configurable), system health, and top 5 todo tasks. |
| **📝 Notes** | "Add a note...", "Search notes" | Appends to `~/.openclaw/notes.txt`. A simple second brain. |
| **🎗️ Reminder** | "Remind me to...", "Show todo" | Manages a simple todo list in `~/.openclaw/todo.txt`. |
| **🧮 Calculator** | "Calculate 5 * 12" | Uses `bc` for math. |
| **🌐 Network Tools** | "What is my IP?", "Ping Google" | Checks connectivity & public IP. |
| **🔐 Access Control** | `/add_access <id>`, `/list_access` | **Owner-only** commands to manage who can talk to the bot on Telegram. |

---

## 🛡️ Security Hardening

This setup is designed for **maximum security**:

- **Whitelist Only**: The bot ignores messages from strangers.
- **Local Binding**: The Gateway listens on `127.0.0.1` by default.
- **Sanitized Config**: Secrets are never checked into git (thanks to `.gitignore`).

To add a friend/family member:
1. Ask them to chat with the bot (they will get a 'pairing code' or access denied).
2. You (the owner) run: `/add_access <their_id> "Friend Name"` in Telegram.

---

## 🤝 Contributing

Feel free to fork this repo and add your own skills! Skills are just markdown files with simple bash scripts embedded in them.

## 📄 License

MIT
