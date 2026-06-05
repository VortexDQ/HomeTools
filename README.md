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

[![Version](https://img.shields.io/badge/version-6.2-blue?style=for-the-badge&logo=github)](https://github.com/VortexDQ/HomeTools/releases)
[![Platform](https://img.shields.io/badge/platform-Windows%2010%2F11-0078D4?style=for-the-badge&logo=windows)](https://github.com/VortexDQ/HomeTools)
[![Python](https://img.shields.io/badge/Python-3.10%2B-3776AB?style=for-the-badge&logo=python)](https://python.org/downloads)
[![License](https://img.shields.io/badge/license-MIT-green?style=for-the-badge)](LICENSE)
[![Tools](https://img.shields.io/badge/tools-35-orange?style=for-the-badge)](#-tools-included)

---

[⚡ Quick Start](#-quick-start) · [🛠 Tools](#-tools-included) · [📦 How It Works](#-how-it-works) · [🔧 Setup Guides](#-setup-guides) · [❓ FAQ](#-faq)

</div>

---

## ✨ What It Does

| Feature | Description |
|---|---|
| 🚀 **Auto-install** | Every tool downloads from GitHub and installs on first launch |
| 🔄 **Auto-update** | All tools git pull on every startup — always fresh |
| 🆙 **Self-update** | Checks GitHub for HomeTools updates — downloads and restarts automatically |
| 🩹 **Self-heal** | Broken venvs detected and rebuilt automatically without losing data |
| 🔒 **Secure** | Passwords masked with SecureString, never logged, cleared after use |
| 🎬 **Boot animation** | Grim reaper animation plays on every launch |
| 📋 **Command Center** | Built-in quick-reference for every tool's most useful commands |
| 🖱 **One file** | Entire toolkit is a single `.bat` — no installers, no admin rights needed |

---

## ⚡ Quick Start

### Requirements

| Requirement | Download | Used by |
|---|---|---|
| **Windows 10 or 11** | — | All tools |
| **Python 3.10+** | [python.org/downloads](https://python.org/downloads) ✅ **Add to PATH** | Most Python tools |
| **git** | [git-scm.com/download/win](https://git-scm.com/download/win) ✅ **Add to PATH** | All cloned tools |
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

## 🛠 Tools Included (35 Tools)

### LOCAL TOOLS
| # | Tool | Purpose |
|---|---|---|
| 1 | **JLT Edge Wireless** | OemDrv device manager (optional local tool) |
| 2 | **Scanners** | ESET / F-Secure / HitmanPro shortcuts (optional local tools) |
| 4 | **ExifTool** | Read, write, and strip file metadata |

### NETWORK DISCOVERY
| # | Tool | Purpose | Source |
|---|---|---|---|
| 19 | **Amass** | Deep subdomain enumeration | [OWASP Amass](https://github.com/owasp-amass/amass) |
| 21 | **Shodan CLI** | Find internet-exposed services and devices | [Shodan CLI](https://cli.shodan.io) |
| 25 | **Subfinder** | Passive subdomain discovery | [Subfinder](https://github.com/projectdiscovery/subfinder) |
| 28 | **Nmap** | Port scanning, service detection, NSE scripting | [nmap.org](https://nmap.org) |
| 29 | **RustScan** | Extremely fast host scanner (pairs with Nmap) | [RustScan](https://github.com/RustScan/RustScan) |

### OSINT - PEOPLE & SOCIAL
| # | Tool | Purpose | Source |
|---|---|---|---|
| 5 | **Sherlock** | Username hunt across 400+ social media sites | [Sherlock Project](https://github.com/sherlock-project/sherlock) |
| 6 | **Osintgram** | Instagram OSINT collector | [Osintgram](https://github.com/Datalux/Osintgram) |
| 9 | **Maigret** | Deep username OSINT + relationship graph | [Maigret](https://github.com/soxoj/maigret) |
| 13 | **LinkedIn Gatherer** | LinkedIn profiles and company OSINT | [LinkedIn Gatherer](https://github.com/DisK0nn3cT/linkedin-gatherer) |
| 15 | **GHunt** | Google account OSINT — email, Maps, Drive, YouTube | [GHunt](https://github.com/mxrch/GHunt) |
| 20 | **Phoneinfoga** | Phone number carrier, region, and OSINT sources | [Phoneinfoga](https://github.com/sundowndev/phoneinfoga) |

### OSINT - EMAIL & CREDENTIALS
| # | Tool | Purpose | Source |
|---|---|---|---|
| 8 | **Holehe** | Email registered on which 120+ sites | [Holehe](https://github.com/megadose/holehe) |
| 12 | **Scavenger** | Pastebin leak monitor and credential scraper | [Scavenger](https://github.com/rndinfosecguy/Scavenger) |
| 14 | **pwnedOrNot** | Email breach checker — shows leaked passwords | [pwnedOrNot](https://github.com/thewhiteh4t/pwnedOrNot) |

### OSINT - INFRASTRUCTURE
| # | Tool | Purpose | Source |
|---|---|---|---|
| 3 | **SpiderFoot** | Automated multi-source OSINT framework (web UI) | [SpiderFoot](https://github.com/smicallef/spiderfoot) |
| 7 | **theHarvester** | Harvest emails, subdomains, IPs from domain | [theHarvester](https://github.com/laramies/theHarvester) |
| 10 | **Photon** | Web crawler — extracts URLs, keys, secrets | [Photon](https://github.com/s0md3v/Photon) |
| 16 | **Recon-ng** | Modular recon framework with API modules | [Recon-ng](https://github.com/lanmaster53/recon-ng) |
| 22 | **Maltego** | Visual link analysis and relationship mapping | [Maltego](https://www.maltego.com) (Manual download) |

### WEB APPLICATION SECURITY
| # | Tool | Purpose | Source |
|---|---|---|---|
| 11 | **SQLMap** | SQL injection detection and exploitation | [SQLMap](https://github.com/sqlmapproject/sqlmap) |
| 17 | **OWASP ZAP** | Web app security scanner with GUI | [ZAP](https://github.com/zaproxy/zaproxy) |
| 18 | **WPScan** | WordPress scanner — plugins, themes, CVEs, users | [WPScan](https://github.com/wpscanteam/wpscan) |
| 23 | **Nuclei** | Template-based vulnerability scanner | [Nuclei](https://github.com/projectdiscovery/nuclei) |
| 24 | **ffuf** | Fast web fuzzer — dirs, vhosts, parameters | [ffuf](https://github.com/ffuf/ffuf) |
| 31 | **Katana** | Modern web crawler from ProjectDiscovery | [Katana](https://github.com/projectdiscovery/katana) |
| 32 | **httpx** | Fast host and web service enumeration | [httpx](https://github.com/projectdiscovery/httpx) |

### NETWORK TESTING
| # | Tool | Purpose | Source |
|---|---|---|---|
| 26 | **Netexec** | SMB / WinRM / LDAP / SSH auth testing | [NetExec](https://github.com/Pennyw0rth/NetExec) |
| 34 | **Impacket** | AD protocols, admin utils, and exploitation | [Impacket](https://github.com/fortra/impacket) |
| 35 | **Wireshark** | Network traffic analysis and packet capture | [Wireshark](https://www.wireshark.org) |

### CONTAINER SECURITY
| # | Tool | Purpose | Source |
|---|---|---|---|
| 30 | **Trivy** | Container/image scanning for vulnerabilities | [Trivy](https://github.com/aquasecurity/trivy) |

### RED TEAM INFRASTRUCTURE
| # | Tool | Purpose | Source |
|---|---|---|---|
| 33 | **Sliver** | Command and control framework | [Sliver](https://github.com/BishopFox/sliver) |

### UTILITIES
| # | Tool | Purpose | Source |
|---|---|---|---|
| 27 | **CyberChef** | Encode / decode / hash / parse — offline | [CyberChef](https://github.com/gchq/CyberChef) |

---

## 📦 How It Works

### Install Locations

```
C:\OSINT\*                  All Python OSINT tools
C:\Tools\*                  Binary tools, ZAP, ExifTool
C:\Program Files\Nmap\      Nmap (via winget)
C:\Program Files\Wireshark\ Wireshark (via winget)
```

All paths are configurable at the top of `HomeTools.bat`.

### Startup Sequence

```
1. Check internet, git, Python
2. Check GitHub for HomeTools updates → auto-update if found
3. For each tool:
     Not installed?  →  git clone + venv + pip install, OR GitHub release download
     Already cloned? →  git pull --ff-only
     venv broken?    →  detect + rebuild dependencies silently
4. Grim reaper boot animation
5. Main menu with organized category view
```

### Virtual Environment Health System

Each Python tool runs in its own `venv/`. When `git pull` brings new commits, dependencies auto-reinstall.

### Self-Update System

Every launch checks GitHub for newer HomeTools version. If found, downloads and restarts automatically.

---

## 🔧 Setup Guides

### Menu Options

| Key | Action |
|---|---|
| `1`–`35` | Launch a tool |
| `R` | Repair — force re-run all installs and updates |
| `C` | Commands — quick-reference for every tool |
| `D` | Dictionary — glossary of OSINT & security terms |
| `H` | Help — detailed tool list and requirements |
| `I` | Instagram — set Osintgram credentials |
| `Q` | Quit |

---

### 📸 Osintgram (Instagram OSINT)

⚠️ Use a **secondary / burner account** — never your personal one.  
⚠️ **2FA must be disabled** on the Instagram account.

1. Press `I` on main menu (or launch tool `6`)
2. Enter username and password
3. Password is masked (SecureString) and never stored plaintext
4. Credentials saved locally at `C:\OSINT\osintgram\config\credentials.ini`

---

### 🔍 GHunt (Google Account OSINT)

1. Launch tool `15`
2. Type `email` and enter target — OR run `ghunt login` first
3. Follow browser-based OAuth flow
4. Subcommands: `email`, `gaia`, `drive`, `youtube`

---

### 📧 pwnedOrNot (Email Breach Checker)

Get a free API key at [haveibeenpwned.com/API/Key](https://haveibeenpwned.com/API/Key), then enter when prompted on first launch of tool `14`.

---

### 🌐 OWASP ZAP (Web App Scanner)

Requires **Java** ([adoptium.net](https://adoptium.net))  
Downloads on first run, opens in its own GUI window.

---

### 🔒 WPScan (WordPress Scanner)

Requires **Ruby + gem** ([rubyinstaller.org](https://rubyinstaller.org))  
**License:** Free for personal use. Commercial use requires paid plan at [wpscan.com](https://wpscan.com)

---

## 🎯 Use Cases

### Reconnaissance
1. **[28] Nmap** — Port scan the target IP range
2. **[29] RustScan** — Faster re-confirmation
3. **[19] Amass** — Deep subdomain enumeration
4. **[21] Shodan** — Find exposed services

### OSINT on Person/Username
1. **[5] Sherlock** — Quick 400+ site scan
2. **[9] Maigret** — Deep dive + HTML report
3. **[13] LinkedIn Gatherer** — Professional network mapping

### OSINT on Email
1. **[8] Holehe** — Which sites the email is on
2. **[14] pwnedOrNot** — Check breach databases
3. **[12] Scavenger** — Monitor pastes

### Web Application Testing
1. **[11] SQLMap** — SQL injection detection
2. **[31] Katana** — Crawl and map the app
3. **[32] httpx** — Enumerate live hosts
4. **[23] Nuclei** — Scan for known CVEs
5. **[24] ffuf** — Fuzz directories and parameters
6. **[17] ZAP** — Full GUI app scanner

### Network Security Testing
1. **[26] Netexec** — Domain/SMB authentication tests
2. **[34] Impacket** — Protocol exploitation
3. **[35] Wireshark** — Packet capture and analysis

---

## ✅ Version History

| Version | Date | Changes |
|---|---|---|
| **6.2** | June 2026 | Fixed Wireshark multi-path detection and Maltego manual download messaging |
| **6.1.2** | June 2026 | Added proper menu spacing between tool names and descriptions |
| **6.1** | June 2026 | Fixed UI formatting, tool install checks, Impacket/Wireshark support |
| **6.0** | June 2026 | Added 8 new tools (Nmap, RustScan, Trivy, Katana, httpx, Sliver, Impacket, Wireshark); reorganized menu by security discipline |
| **5.9** | June 2026 | Fixed Amass/Phoneinfoga tar.gz handling, Netexec binary install, CyberChef v11 structure |

---

## 📝 Legal

**Disclaimer:** These tools are for **authorized security research only**. Unauthorized access to computer systems is illegal. Only test systems you own or have explicit written permission to test. The author accepts no responsibility for misuse.

---

## 📜 License

MIT  See [LICENSE](LICENSE)

---

**Made with ❤️ by vortexdq.com**
