# HOME TOOLS — OSINT Launcher

A self-installing, self-updating OSINT toolkit launcher for Windows. Double-click and everything installs automatically.

---

## What it does

- **Auto-installs** every OSINT tool on first launch (git clone + Python venv)
- **Auto-updates** tools on every startup via `git pull`
- **Self-heals** broken virtual environments automatically
- **Single menu** to launch all tools — no command line knowledge needed
- **Command Center** built in — full command reference for every tool

---

## Requirements

| Requirement | Download |
|---|---|
| Windows 10 or 11 | — |
| Python 3.10+ | https://python.org/downloads — check **Add to PATH** |
| git | https://git-scm.com/download/win — check **Add to PATH** |

Both Python and git must be in your system `PATH` before running.

---

## Quick Start

1. Download `HomeTools.bat`
2. Double-click it
3. Type `AGREE` to accept the legal notice on first launch
4. Tools install automatically — takes 5–20 minutes first time
5. Use the number menu to launch any tool

---

## Tools Included

| # | Tool | What it does |
|---|---|---|
| 3 | **SpiderFoot** | Automated OSINT framework with web UI at `http://127.0.0.1:5001` |
| 4 | **ExifTool** | Read, write and strip metadata from any file type |
| 5 | **Sherlock** | Find a username across 400+ social media sites |
| 6 | **Osintgram** | Instagram OSINT — followers, photos, locations, hashtags |
| 7 | **theHarvester** | Harvest emails, subdomains and names from a domain |
| 8 | **Holehe** | Check if an email is registered on 120+ websites |
| 9 | **Maigret** | Deep username OSINT across 3000+ sites with HTML reports |
| 10 | **Photon** | Web crawler — extracts emails, URLs, API keys, phone numbers |
| 11 | **SQLMap** | Automated SQL injection detection and exploitation |

Tools 1–2 are optional local shortcuts (configure paths at the top of the `.bat` file).

---

## Install Locations

```
C:\OSINT\spiderfoot\
C:\OSINT\sherlock\
C:\OSINT\osintgram\
C:\OSINT\theHarvester\
C:\OSINT\holehe\
C:\OSINT\maigret\
C:\OSINT\Photon\
C:\OSINT\sqlmap\
C:\Tools\exiftool\
```

All paths are configurable at the top of `HomeTools.bat`.

---

## Menu Options

| Key | Action |
|---|---|
| `1`–`11` | Launch a tool |
| `R` | Repair — force re-run all installs and updates |
| `C` | Command Center — full command reference for every tool |
| `H` | Help |
| `I` | Set or update Instagram credentials for Osintgram |
| `Q` | Quit |

---

## Osintgram Setup

Osintgram requires an Instagram account to scrape targets.

- Use a **secondary / burner account** — not your personal one
- The account must have **2FA disabled**
- Press `I` on the main menu to enter credentials
- Password is masked while typing (never shown on screen)
- Credentials stored locally at `C:\OSINT\osintgram\config\credentials.ini`

---

## How Auto-Install Works

Each Python tool runs inside its own virtual environment (`venv/`). A `.health` marker file tracks whether dependencies are current. If missing (after an update or on first run), dependencies reinstall automatically before the tool launches.

**Startup sequence:**
1. Check internet connectivity and prerequisites (git, Python)
2. If tool not cloned → `git clone` the repo
3. If tool exists → `git pull --ff-only` for updates
4. Before each launch → verify venv + `.health`, auto-rebuild if broken

---

## Legal Notice

These tools are for **authorized security research and educational use only**.

Only test systems you own or have **explicit written permission** to test. Unauthorized access is illegal. The author accepts no responsibility for misuse.

---

## Contributing

Pull requests welcome. The code follows a flat `goto`-based pattern throughout (no nested CMD `if/else` blocks containing PowerShell code). Each tool has three paired sections:

- `SC_TOOLNAME` — startup check and auto-install/update
- `INSTALL_TOOLNAME_FUNC` — one-time clone and venv setup
- `LAUNCH_TOOLNAME` — pre-flight health check and `start powershell` loop

To add a new tool, copy these three sections and update the menu dispatch table and status variables.

---

## Credits

Made with love by [vortexdq.com](https://vortexdq.com)

---

## Tested On

- Windows 10 22H2, Windows 11 23H2
- Python 3.11, 3.12
- git 2.44+
