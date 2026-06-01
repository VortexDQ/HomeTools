<div align="center">

```
██╗  ██╗ ██████╗ ███╗   ███╗███████╗    ████████╗ ██████╗  ██████╗ ██╗     ███████╗
██║  ██║██╔═══██╗████╗ ████║██╔════╝    ╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██╔════╝
███████║██║   ██║██╔████╔██║█████╗         ██║   ██║   ██║██║   ██║██║     ███████╗
██╔══██║██║   ██║██║╚██╔╝██║██╔══╝         ██║   ██║   ██║██║   ██║██║     ╚════██║
██║  ██║╚██████╔╝██║ ╚═╝ ██║███████╗       ██║   ╚██████╔╝╚██████╔╝███████╗███████║
╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝       ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚══════╝
```

**A self-installing, self-updating OSINT & security toolkit launcher for Windows.**  
Double-click. Everything installs, updates, and runs — automatically.

[![Version](https://img.shields.io/badge/version-4.1-blue?style=for-the-badge&logo=github)](https://github.com/VortexDQ/HomeTools/releases)
[![Platform](https://img.shields.io/badge/platform-Windows%2010%2F11-0078D4?style=for-the-badge&logo=windows)](https://github.com/VortexDQ/HomeTools)
[![Python](https://img.shields.io/badge/Python-3.10%2B-3776AB?style=for-the-badge&logo=python)](https://python.org/downloads)
[![License](https://img.shields.io/badge/license-MIT-green?style=for-the-badge)](LICENSE)
[![Tools](https://img.shields.io/badge/tools-18-orange?style=for-the-badge)](#-tools-included)

---

[⚡ Quick Start](#-quick-start) · [🛠 Tools](#-tools-included) · [📦 How It Works](#-how-it-works) · [🎬 Boot Animation](#-boot-animation) · [🔧 Setup Guides](#-setup-guides) · [❓ FAQ](#-faq)

</div>

---

## ✨ What It Does

| Feature | Description |
|---|---|
| 🚀 **Auto-install** | Every tool clones from GitHub and installs into its own Python venv on first launch |
| 🔄 **Auto-update** | All tools `git pull` on every startup — always fresh |
| 🆙 **Self-update** | Checks GitHub for a new version of HomeTools itself — downloads and restarts automatically |
| 🩹 **Self-heal** | Broken virtual environments detected and rebuilt without losing your data |
| 🔒 **Secure** | Passwords masked with `SecureString`, cleared from memory after use, never logged |
| 🎬 **Boot animation** | Grim reaper slashes its scythe then transitions into the menu — every launch |
| 📋 **Command Center** | Built-in quick-reference for every tool's most useful commands |
| 🖱 **One file** | Entire toolkit is a single `.bat` — no installers, no admin rights needed |

---

## ⚡ Quick Start

### Requirements

| Requirement | Download | Used by |
|---|---|---|
| **Windows 10 or 11** | — | All tools |
| **Python 3.10+** | [python.org/downloads](https://python.org/downloads) ✅ **Add to PATH** | Most tools |
| **git** | [git-scm.com/download/win](https://git-scm.com/download/win) ✅ **Add to PATH** | All tools |
| **Java** | [adoptium.net](https://adoptium.net) | OWASP ZAP only |
| **Ruby + gem** | [rubyinstaller.org](https://rubyinstaller.org) | WPScan only |

### Steps

```
1. Download HomeTools.bat from this repo
2. Double-click it
3. Type  AGREE  to accept the legal notice (first launch only)
4. All tools install automatically — 5–20 min first time
5. Use the number menu to launch any tool
```

No command line knowledge needed.

---

## 🛠 Tools Included

### OSINT Tools (3–14)

| # | Tool | What It Does | Source |
|---|---|---|---|
| 3 | **SpiderFoot** | Automated OSINT framework with web UI at `http://127.0.0.1:5001` | [smicallef/spiderfoot](https://github.com/smicallef/spiderfoot) |
| 4 | **ExifTool** | Read, write and strip metadata from any file type | [exiftool.org](https://exiftool.org) |
| 5 | **Sherlock** | Find a username across 400+ social media sites | [sherlock-project/sherlock](https://github.com/sherlock-project/sherlock) |
| 6 | **Osintgram** | Instagram OSINT — followers, photos, locations, hashtags | [Datalux/Osintgram](https://github.com/Datalux/Osintgram) |
| 7 | **theHarvester** | Harvest emails, subdomains and names from a target domain | [laramies/theHarvester](https://github.com/laramies/theHarvester) |
| 8 | **Holehe** | Check if an email is registered on 120+ websites | [megadose/holehe](https://github.com/megadose/holehe) |
| 9 | **Maigret** | Deep username OSINT across 3000+ sites with HTML reports | [soxoj/maigret](https://github.com/soxoj/maigret) |
| 10 | **Photon** | Web crawler — extracts emails, URLs, API keys, JS secrets | [s0md3v/Photon](https://github.com/s0md3v/Photon) |
| 11 | **SQLMap** | Automated SQL injection detection and exploitation | [sqlmapproject/sqlmap](https://github.com/sqlmapproject/sqlmap) |
| 12 | **Scavenger** | Pastebin leak monitor and credential scraper | [rndinfosecguy/Scavenger](https://github.com/rndinfosecguy/Scavenger) |
| 13 | **LinkedIn Gatherer** | LinkedIn profile and network OSINT | [DisK0nn3cT/linkedin-gatherer](https://github.com/DisK0nn3cT/linkedin-gatherer) |
| 14 | **pwnedOrNot** | Email breach checker — finds exposed passwords via HIBP API | [thewhiteh4t/pwnedOrNot](https://github.com/thewhiteh4t/pwnedOrNot) |

### Advanced Tools (15–18)

| # | Tool | What It Does | Source | Notes |
|---|---|---|---|---|
| 15 | **GHunt** | Google account OSINT — email, Maps reviews, Drive, location | [mxrch/GHunt](https://github.com/mxrch/GHunt) | Run `ghunt login` on first use |
| 16 | **Recon-ng** | Modular web recon framework with interactive console | [lanmaster53/recon-ng](https://github.com/lanmaster53/recon-ng) | Type `help` inside |
| 17 | **ZAP by Checkmarx** | Web application security scanner — full GUI | [zaproxy/zaproxy](https://github.com/zaproxy/zaproxy) | Requires Java |
| 18 | **WPScan** | WordPress vulnerability scanner — CVEs, users, plugins, themes | [wpscanteam/wpscan](https://github.com/wpscanteam/wpscan) | Requires Ruby. Free for personal use |

> Tools 1–2 are optional local shortcuts (JLT Edge Wireless, antivirus scanners). Configure paths at the top of the `.bat` file.

---

## 📦 How It Works

### Install Locations

```
C:\OSINT\spiderfoot\          C:\OSINT\sherlock\
C:\OSINT\osintgram\           C:\OSINT\theHarvester\
C:\OSINT\holehe\              C:\OSINT\maigret\
C:\OSINT\Photon\              C:\OSINT\sqlmap\
C:\OSINT\scavenger\           C:\OSINT\linkedin-gatherer\
C:\OSINT\pwnedornot\          C:\OSINT\GHunt\
C:\OSINT\recon-ng\            C:\OSINT\wpscan\
C:\Tools\exiftool\            C:\Tools\ZAP\
```

All paths are configurable at the top of `HomeTools.bat`.

### Startup Sequence

```
1. Check internet, git, Python
2. Check GitHub for a new HomeTools version → auto-update if found
3. For each tool:
     Not installed?  →  git clone + python -m venv + pip install
     Already cloned? →  git pull --ff-only
     venv broken?    →  detect missing .health marker → rebuild deps
4. Grim reaper boot animation
5. Main menu
```

### Virtual Environment Health System

Each Python tool runs in its own `venv/`. A `.health` marker file inside the venv signals that dependencies are current. When a `git pull` brings in new commits, the marker is deleted — dependencies reinstall silently before the next launch.

### 🆙 Self-Update System

Every launch, HomeTools fetches its own source file from GitHub and reads the embedded version marker (`HOMETOOLS_VERSION:X.Y`). If a newer version exists:

1. Downloads `HomeTools.bat` to `%TEMP%\HT_update.bat`
2. Writes a tiny runner script that swaps the file while the current window closes
3. New version launches automatically

**No manual updates ever needed.**

---

## 🎬 Boot Animation

Every launch plays a 10-phase grim reaper animation:

```
Phase 1  →  Darkness
Phase 2  →  Lightning flashes (×3)
Phase 3  →  Grim reaper materialises
Phase 4  →  Scythe raises
Phase 5  →  Scythe swings
Phase 6  →  SLASH — red screen flash (×3)
Phase 7  →  HOME TOOLS title reveals line by line
Phase 8  →  Red → yellow → green progress bar
Phase 9  →  HOME TOOLS v4.1 ONLINE character reveal
Phase 10 →  Clean wipe → main menu
```

---

## 🔧 Setup Guides

### Menu Options

| Key | Action |
|---|---|
| `1`–`18` | Launch a tool |
| `R` | Repair — force re-run all installs and updates |
| `C` | Command Center — full command reference for every tool |
| `H` | Help — tool list, requirements, install locations |
| `I` | Set or update Instagram credentials for Osintgram |
| `Q` | Quit |

---

### 📸 Osintgram (Instagram OSINT)

> ⚠️ Use a **secondary / burner account** — never your personal one.  
> ⚠️ **2FA must be disabled** on the Instagram account.

1. Press `I` on the main menu (or choose `6` — prompts automatically if no credentials found)
2. Enter username and password
3. Password is **masked on screen** (SecureString) and never stored in plaintext
4. Credentials saved locally at `C:\OSINT\osintgram\config\credentials.ini`

---

### 🔍 GHunt (Google Account OSINT)

GHunt requires a one-time authentication setup:

1. Launch tool `15`
2. Type `email` and enter your target to start — OR run `ghunt login` first to authenticate
3. Follow the browser-based OAuth flow (uses your own Google account to query)
4. After login, all subcommands work: `email`, `gaia`, `drive`, `youtube`

---

### 🔗 LinkedIn Gatherer

> ⚠️ Use a **secondary account** — not your personal LinkedIn.  
> ⚠️ **Only research companies/people you have permission to investigate.**

Choose option `13`. If credentials aren't set, the setup prompt appears automatically. Credentials stored in `C:\OSINT\linkedin-gatherer\config.py`.

---

### 📧 pwnedOrNot (Email Breach Checker)

Get a free API key at **[haveibeenpwned.com/API/Key](https://haveibeenpwned.com/API/Key)** then enter it when prompted on first launch of tool `14`. Stored at `%USERPROFILE%\.config\pwnedornot\config.json`.

---

### 🌐 OWASP ZAP (Web App Scanner)

> Requires **Java** — download at [adoptium.net](https://adoptium.net)

ZAP is auto-downloaded from GitHub releases on first run and opens in its own GUI window. HomeTools checks for Java before launching and shows the download link if it's missing.

---

### 🔒 WPScan (WordPress Scanner)

> Requires **Ruby + gem** — download at [rubyinstaller.org](https://rubyinstaller.org)  
> **License:** Free for personal/non-commercial use. Commercial use requires a paid plan at [wpscan.com](https://wpscan.com)

WPScan installs via `gem install wpscan` automatically when Ruby is detected. Get a free API token at [wpscan.com](https://wpscan.com) for vulnerability data and pass it with `--api-token YOUR_TOKEN`.

---

## 📋 Example Workflows

<details>
<summary><strong>🕵️ Investigate a username</strong></summary>

```
[5]  Sherlock  →  johndoe          Check 400+ sites instantly
[9]  Maigret   →  johndoe          Deep scan + HTML report with account network graph
```
</details>

<details>
<summary><strong>📧 Research an email address</strong></summary>

```
[8]  Holehe      →  target@gmail.com    Which sites have an account for this email
[14] pwnedOrNot  →  target@gmail.com    Which breaches + leaked passwords
[15] GHunt       →  target@gmail.com    Google account info, location, Maps activity
```
</details>

<details>
<summary><strong>🌐 Recon a domain</strong></summary>

```
[7]  theHarvester  →  example.com    Emails, subdomains, employee names, IPs
[10] Photon        →  https://...    Crawl site, extract URLs, API keys, JS secrets
[3]  SpiderFoot    →  (web UI)       Automated multi-source OSINT scan
[16] Recon-ng      →  (console)      Modular framework, run specific recon modules
```
</details>

<details>
<summary><strong>🔒 Security testing a web app</strong></summary>

```
[17] ZAP      →  (GUI)              Automated + manual web vuln scanning
[11] SQLMap   →  http://site/p?id=1 SQL injection detection and exploitation
```
> Only test applications you own or have explicit written permission to test.
</details>

<details>
<summary><strong>🔑 WordPress security audit</strong></summary>

```
[18] WPScan  →  https://wp-site.com    Enumerate users, plugins, themes, CVEs
```
> Only scan WordPress sites you own or have permission to test.
</details>

<details>
<summary><strong>📁 Metadata analysis</strong></summary>

```
[4] ExifTool  →  photo.jpg    GPS coords, camera model, timestamps, software
                               Strip all: exiftool -all= photo.jpg
```
</details>

---

## ❓ FAQ

<details>
<summary><strong>First launch is slow — is something wrong?</strong></summary>

No. The first run clones 16 git repositories and installs Python dependencies. This takes **5–20 minutes** depending on your connection. Every launch after is fast — only `git pull` checks run.
</details>

<details>
<summary><strong>A tool shows [--] in the menu</strong></summary>

Not installed yet, or install failed. Press `R` (Repair) to re-run all installs. Make sure `git` and `python` are both in your PATH (`where git` and `where python` in cmd to verify).
</details>

<details>
<summary><strong>WPScan or ZAP show [--] even after installing Ruby/Java</strong></summary>

Close and reopen HomeTools after installing Ruby or Java so the new PATH entries are picked up. Then press `R` to repair.
</details>

<details>
<summary><strong>Can I add my own tools?</strong></summary>

Yes. Each tool follows a three-section flat `goto` pattern:

- `:SC_TOOLNAME` — startup check, auto-install/update
- `:INSTALL_TOOLNAME_FUNC` — `git clone` + venv + `pip install` + `copy nul venv\.health`
- `:LAUNCH_TOOLNAME` — `call :HEALTH_VENV` + inline `powershell -Command "..."` + `goto MENU`

Copy an existing set of three sections, add a path variable, a menu row, and a dispatch entry. See the Contributing section.
</details>

<details>
<summary><strong>Where are credentials stored?</strong></summary>

| Tool | Location |
|---|---|
| Instagram (Osintgram) | `C:\OSINT\osintgram\config\credentials.ini` |
| LinkedIn | `C:\OSINT\linkedin-gatherer\config.py` |
| HIBP API key (pwnedOrNot) | `%USERPROFILE%\.config\pwnedornot\config.json` |

All credentials are stored **locally on your machine only**. Nothing is sent externally by this launcher.
</details>

---

## 🤝 Contributing

Pull requests are welcome.

**Code style:** Flat `goto`-based pattern throughout — no nested CMD `if/else` blocks containing PowerShell code (CMD counts `(` `)` inside quoted PS strings as block delimiters and breaks parsing).

**Adding a new tool (checklist):**
1. `set "P_TOOL=C:\OSINT\toolname"` — path variable at the top
2. `set "S19=%RD%[--] %R%"` — status var + `if exist ... set "S19=..."` detection
3. Menu display row + dispatch `if /i "%CHO%"=="19" goto LAUNCH_TOOL`
4. `call :SC_TOOL` in `:STARTUP`
5. `:SC_TOOL` subroutine
6. `:INSTALL_TOOL_FUNC` — always end with `copy nul "path\venv\.health"`
7. `:LAUNCH_TOOL` — inline PS with `title` before/after + `goto MENU`

**Version bump:** Update `:: HOMETOOLS_VERSION:X.Y` (line 14) and `set "HT_VERSION=X.Y"` together — the auto-updater reads both.

---

## ⚖️ Legal Notice

These tools are for **authorized security research and educational use only**.

Only test systems you own or have **explicit written permission** to test. Unauthorized access is illegal under the CFAA, UK Computer Misuse Act, and equivalent laws worldwide. The author accepts no responsibility for misuse.

WPScan is free for personal/non-commercial use under the [WPScan Public Source License](https://github.com/wpscanteam/wpscan/blob/master/LICENSE). Commercial use requires a paid subscription.

---

## 💙 Credits

Made with love by [vortexdq.com](https://vortexdq.com)

---

## 🧪 Tested On

| OS | Python | git |
|---|---|---|
| Windows 10 22H2 | 3.11, 3.12 | 2.44+ |
| Windows 11 23H2 | 3.11, 3.12 | 2.44+ |
