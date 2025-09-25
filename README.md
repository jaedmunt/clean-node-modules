<div align="center">

# Clean Node Modules

> **Free up storage by recursively deleting node_modules with PowerShell or Linux Bash Shell**

[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux-blue.svg)](https://github.com/yourusername/clean-node-modules)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Shell](https://img.shields.io/badge/Shell-PowerShell%20%7C%20Bash-orange.svg)]()

![Clean Node Modules](images/hero.webp)

</div>

---

## 📥 Quick Download

Download the scripts directly without cloning the repo:

**Windows (PowerShell):**
```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jaedmunt/clean-node-modules/main/Clean-NodeModules.ps1" -OutFile "Clean-NodeModules.ps1"
```

**Linux (Bash):**
```bash
curl -O "https://raw.githubusercontent.com/jaedmunt/clean-node-modules/main/clean-node-modules.sh"
chmod +x clean-node-modules.sh
```

---

## Free up storage by recursively deleting node_modules, with Powershell or Linux Bash Shell.

These utility scripts delete all `node_modules` folders under a given path. These can be reinstalled using your package.js folder, so often they clog up space unnecessarily. 

Useful for freeing disk space when working with many JavaScript/TypeScript projects.

It is recommended to only use this in your github folder where we assume changes are tracked, but it should be fine elsewhere also. 

---

## Why?
`node_modules` can become huge. For example, one cleanup freed **13.57 GB** from a single GitHub folder.

---

## Features

- Recursively finds and deletes node_modules
- Estimates space before deletion
- Shows per-folder progress and total freed
- Prints summary with total space saved and time taken

---

## Windows (PowerShell)

1. Save `Clean-NodeModules.ps1`.

2. Open PowerShell and run:

```powershell
.\Clean-NodeModules.ps1 -RootPath "C:\Users\<YourUsername>\Documents\GitHub"
```
If you omit `-RootPath`, you'll be prompted interactively.

## Linux (Bash)

1. Save clean-node-modules.sh and make it executable:

```bash
chmod +x clean-node-modules.sh
```

Run:

```bash
./clean-node-modules.sh ~/github
```
As with Powershell, if you omit the path, you'll be asked to provide it interactively.