<div align="center">

```
██╗  ██╗ ██████╗ ███╗   ███╗███████╗    ████████╗ ██████╗  ██████╗ ██╗     ███████╗
██║  ██║██╔═══██╗████╗ ████║██╔════╝    ╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██╔════╝
███████║██║   ██║██╔████╔██║█████╗         ██║   ██║   ██║██║   ██║██║     ███████╗
██╔══██║██║   ██║██║╚██╔╝██║██╔══╝         ██║   ██║   ██║██║   ██║██║     ╚════██║
██║  ██║╚██████╔╝██║ ╚═╝ ██║███████╗       ██║   ╚██████╔╝╚██████╔╝███████╗███████║
╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝       ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚══════╝
```

**A self-installing, self-updating OSINT toolkit launcher for Windows.**  
Double-click and everything installs, updates, and launches — automatically.

[![Version](https://img.shields.io/badge/version-3.2-blue?style=for-the-badge&logo=github)](https://github.com/VortexDQ/HomeTools)
[![Platform](https://img.shields.io/badge/platform-Windows%2010%2F11-0078D4?style=for-the-badge&logo=windows)](https://github.com/VortexDQ/HomeTools)
[![Python](https://img.shields.io/badge/Python-3.10%2B-3776AB?style=for-the-badge&logo=python)](https://python.org/downloads)
[![License](https://img.shields.io/badge/license-MIT-green?style=for-the-badge)](LICENSE)
[![Tools](https://img.shields.io/badge/tools-14-orange?style=for-the-badge)](#-tools-included)

---

[⚡ Quick Start](#-quick-start) · [🛠 Tools](#-tools-included) · [📦 How It Works](#-how-it-works) · [🔧 Setup Guides](#-setup-guides) · [❓ FAQ](#-faq)

</div>

---

## ✨ What It Does

| Feature | Description |
|---|---|
| 🚀 **Auto-install** | Every tool clones from GitHub and installs into its own Python venv on first launch |
| 🔄 **Auto-update** | Tools `git pull` on every startup — always fresh |
| 🆙 **Self-update** | Checks GitHub for a new version of HomeTools itself — downloads and restarts automatically |
| 🩹 **Self-heal** | Broken virtual environments are detected and rebuilt without touching your data |
| 🔒 **Secure** | Passwords masked with `SecureString`, cleared from memory after use, never logged |
| 📋 **Command Center** | Built-in quick-reference guide for every tool's most useful commands |
| 🖱 **One file** | Entire toolkit is a single `.bat` file — no installers, no admin rights needed |

---

## ⚡ Quick Start

### Requirements

| Requirement | Download |
|---|---|
| **Windows 10 or 11** | — |
| **Python 3.10+** | [python.org/downloads](https://python.org/downloads) — ✅ check **Add to PATH** |
| **git** | [git-scm.com/download/win](https://git-scm.com/download/win) — ✅ check **Add to PATH** |

> Both `python` and `git` must be available in your system `PATH` before running.

### Steps

```
1. Download HomeTools.bat from this repo
2. Double-click it
3. Type  AGREE  to accept the legal notice (first launch only)
4. All tools install automatically — takes 5–20 min on first run
5. Use the number menu to launch any tool
```

That's it. No command line knowledge needed.

---

## 🛠 Tools Included

| # | Tool | What It Does | Source |
|---|---|---|---|
| 3 | **SpiderFoot** | Automated OSINT framework with web UI at `http://127.0.0.1:5001` | [smicallef/spiderfoot](https://github.com/smicallef/spiderfoot) |
| 4 | **ExifTool** | Read, write and strip metadata from any file type | [exiftool.org](https://exiftool.org) |
| 5 | **Sherlock** | Find a username across 400+ social media sites | [sherlock-project/sherlock](https://github.com/sherlock-project/sherlock) |
| 6 | **Osintgram** | Instagram OSINT — followers, photos, locations, hashtags | [Datalux/Osintgram](https://github.com/Datalux/Osintgram) |
| 7 | **theHarvester** | Harvest emails, subdomains and names from a target domain | [laramies/theHarvester](https://github.com/laramies/theHarvester) |
| 8 | **Holehe** | Check if an email is registered on 120+ websites | [megadose/holehe](https://github.com/megadose/holehe) |
| 9 | **Maigret** | Deep username OSINT across 3000+ sites with HTML reports | [soxoj/maigret](https://github.com/soxoj/maigret) |
| 10 | **Photon** | Web crawler — extracts emails, URLs, API keys, phone numbers | [s0md3v/Photon](https://github.com/s0md3v/Photon) |
| 11 | **SQLMap** | Automated SQL injection detection and exploitation | [sqlmapproject/sqlmap](https://github.com/sqlmapproject/sqlmap) |
| 12 | **Scavenger** | Pastebin leak monitor and credential scraper | [rndinfosecguy/Scavenger](https://github.com/rndinfosecguy/Scavenger) |
| 13 | **LinkedIn Gatherer** | LinkedIn profile and network OSINT | [DisK0nn3cT/linkedin-gatherer](https://github.com/DisK0nn3cT/linkedin-gatherer) |
| 14 | **pwnedOrNot** | Email breach checker — finds exposed passwords via HIBP API | [thewhiteh4t/pwnedOrNot](https://github.com/thewhiteh4t/pwnedOrNot) |

> Tools 1–2 are optional local shortcuts (JLT Edge Wireless device manager, antivirus scanners).  
> Configure their paths at the top of the `.bat` file.

---

## 📦 How It Works

### Install Locations

```
C:\OSINT\spiderfoot\
C:\OSINT\sherlock\
C:\OSINT\osintgram\
C:\OSINT\theHarvester\
C:\OSINT\holehe\
C:\OSINT\maigret\
C:\OSINT\Photon\
C:\OSINT\sqlmap\
C:\OSINT\scavenger\
C:\OSINT\linkedin-gatherer\
C:\OSINT\pwnedornot\
C:\Tools\exiftool\
```

All paths are configurable at the top of `HomeTools.bat`.

### Startup Sequence

```
1. Check internet, git, Python
2. Check GitHub for new HomeTools version → auto-update if found
3. For each tool:
     - Not cloned?  →  git clone + python -m venv + pip install
     - Already cloned?  →  git pull --ff-only
     - venv broken / .health missing?  →  rebuild / reinstall deps
4. Show main menu
```

### Virtual Environments & Health Markers

Each Python tool runs in its own `venv/`. A `.health` marker inside the venv signals that dependencies are current. If the marker is missing (first run, or after a `git pull` brought in changes), dependencies reinstall before the next launch — invisibly and automatically.

### 🆙 Auto-Update (HomeTools itself)

Every time you launch, HomeTools fetches its own source file from GitHub and reads the version number. If a newer version is found, it:

1. Downloads the new file to `%TEMP%\HT_update.bat`
2. Writes a tiny runner script that copies the new file over the current one
3. Starts the runner, closes itself
4. The runner waits 2 seconds, swaps the file, and relaunches fresh

**No manual updates ever needed.**  You'll always be on the latest version automatically.

---

## 🔧 Setup Guides

### Menu Options

| Key | Action |
|---|---|
| `1`–`14` | Launch a tool |
| `R` | Repair — force re-run all installs and updates |
| `C` | Command Center — full command reference for every tool |
| `H` | Help |
| `I` | Set or update Instagram credentials for Osintgram |
| `Q` | Quit |

---

### 📸 Osintgram (Instagram OSINT)

Osintgram requires an Instagram account to authenticate with.

> ⚠️ **Use a secondary / burner account — never your personal one.**  
> ⚠️ **2FA must be disabled** on the account.

**Setup:**
1. Press `I` on the main menu (or choose option `6` — it prompts automatically if no credentials are found)
2. Enter your Instagram username and password
3. Password is masked on screen (SecureString) and never stored in plaintext
4. Credentials are saved locally at `C:\OSINT\osintgram\config\credentials.ini`

---

### 🔗 LinkedIn Gatherer

LinkedIn Gatherer requires your LinkedIn account credentials, stored in `config.py`.

> ⚠️ **Use a secondary account** — not your personal LinkedIn.  
> ⚠️ **Only gather information about people/companies you have permission to research.**

**Setup:** Choose option `13` and credentials will be prompted automatically if not set.

> **Note:** This is a Python 2 tool. HomeTools auto-patches it for Python 3 compatibility every launch.

---

### 📧 pwnedOrNot (Email Breach Checker)

pwnedOrNot uses the [Have I Been Pwned API](https://haveibeenpwned.com/API/Key).

> 💡 A free API key is available at: **https://haveibeenpwned.com/API/Key**

**Setup:** Choose option `14` and enter your API key when prompted. It's saved at `%USERPROFILE%\.config\pwnedornot\config.json`.

---

## 📋 Example Workflows

<details>
<summary><strong>🕵️ Investigate a username</strong></summary>

```
Menu → [5] Sherlock
  Username: johndoe
  → Checks 400+ sites, shows which ones have that username

Menu → [9] Maigret
  Username: johndoe
  → Deep scan across 3000+ sites, generates HTML report
```
</details>

<details>
<summary><strong>📧 Research an email address</strong></summary>

```
Menu → [8] Holehe
  Email: target@example.com
  → Lists every site where that email has an account

Menu → [14] pwnedOrNot
  Email: target@example.com
  → Checks known data breaches, shows any exposed passwords
```
</details>

<details>
<summary><strong>🌐 Recon a domain or website</strong></summary>

```
Menu → [7] theHarvester
  Domain: example.com
  → Harvests emails, subdomains, employee names

Menu → [10] Photon
  URL: https://example.com
  → Crawls the site, extracts emails, URLs, API keys, JS files

Menu → [3] SpiderFoot
  → Opens web UI at http://127.0.0.1:5001
  → Run automated scans across dozens of OSINT sources
```
</details>

<details>
<summary><strong>📁 Strip metadata from files</strong></summary>

```
Menu → [4] ExifTool
  File: photo.jpg
  → Shows GPS coordinates, camera model, timestamps, software used
  → Can strip all metadata: exiftool -all= photo.jpg
```
</details>

---

## ❓ FAQ

<details>
<summary><strong>First launch is slow — is something wrong?</strong></summary>

No — the first run clones 12 git repositories and installs their Python packages. This takes **5–20 minutes** depending on your internet speed. Every launch after that is fast (just `git pull` checks).
</details>

<details>
<summary><strong>A tool shows [--] in the menu</strong></summary>

The tool hasn't been installed yet, or the install failed. Press `R` (Repair) to re-run all installs. If it still fails, make sure `git` and `python` are both in your PATH.
</details>

<details>
<summary><strong>Osintgram says "login required" or crashes</strong></summary>

Instagram credentials need to be set or refreshed. Press `I` on the menu to re-enter them. Make sure:
- You're using a burner/secondary account
- 2FA is **disabled** on that account
- The username/password are correct
</details>

<details>
<summary><strong>Can I add my own tools?</strong></summary>

Yes. Each tool follows a flat `goto`-based pattern with three paired sections:
- `:SC_TOOLNAME` — startup check, auto-install/update
- `:INSTALL_TOOLNAME_FUNC` — one-time `git clone` + venv setup (include `copy nul venv\.health`)
- `:LAUNCH_TOOLNAME` — pre-flight health check + `start powershell` launch loop

Copy an existing set of three sections, update the paths and menu dispatch table, and add a status variable to the menu display. See the Contributing section below.
</details>

<details>
<summary><strong>Where are credentials stored?</strong></summary>

| Credential | Location |
|---|---|
| Instagram (Osintgram) | `C:\OSINT\osintgram\config\credentials.ini` |
| LinkedIn | `C:\OSINT\linkedin-gatherer\config.py` |
| HIBP API key (pwnedOrNot) | `%USERPROFILE%\.config\pwnedornot\config.json` |

All credentials are stored locally on your machine only. Nothing is sent to any external service except the tool itself when you run it.
</details>

---

## 🤝 Contributing

Pull requests are welcome.

The code follows a **flat `goto`-based pattern** throughout — no nested CMD `if/else` blocks that contain PowerShell code (CMD counts `(` `)` inside quoted PS strings as block delimiters, which breaks parsing).

**To add a new tool:**

1. Add a `set "P_TOOL=C:\OSINT\toolname"` path variable at the top
2. Add a status variable `S15` and display row in `:MENU`
3. Add a dispatch line `if /i "%CHO%"=="15" goto LAUNCH_TOOL` in the menu
4. Add `:SC_TOOL` — startup check (handles install + git pull)
5. Add `:INSTALL_TOOL_FUNC` — `git clone` + `python -m venv` + `pip install` + `copy nul venv\.health`
6. Add `:LAUNCH_TOOL` — `call :HEALTH_VENV` + `start powershell` + `pause >nul` + `goto MENU`
7. Add `call :SC_TOOL` in the `:STARTUP` section

**Version bump:**
- Update `:: HOMETOOLS_VERSION:X.Y` (line 13) and `set "HT_VERSION=X.Y"` simultaneously — the auto-updater reads both.

---

## ⚖️ Legal Notice

These tools are for **authorized security research and educational use only**.

Only test systems you own or have **explicit written permission** to test. Unauthorized access to computer systems is illegal under the Computer Fraud and Abuse Act (CFAA), UK Computer Misuse Act, and equivalent laws worldwide. The author accepts no responsibility for misuse.

---

## 💙 Credits

Made with love by [vortexdq.com](https://vortexdq.com)

---

## 🧪 Tested On

| OS | Python | git |
|---|---|---|
| Windows 10 22H2 | 3.11, 3.12 | 2.44+ |
| Windows 11 23H2 | 3.11, 3.12 | 2.44+ |
