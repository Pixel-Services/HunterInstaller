# 🛡️ Hunter Installer

A lightweight script to automatically block known malicious IPs on Linux servers using `ipset` and `iptables`.

This tool is based on [PebbleHost's Hunter](https://github.com/pebblehost/hunter), which maintains a honeypot-driven IP blacklist.

## 🚀 Quick Install

Run the following commands in your terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/Pixel-Services/HunterInstaller/refs/heads/main/hunter-installer.sh -o hunter-installer.sh
chmod +x hunter-installer.sh
./hunter-installer.sh
```

## 🔧 During Setup

You'll be prompted to configure:
- **Update frequency** (in minutes)
- **Target iptables chain**: `DOCKER-USER` (for Docker) or `INPUT` (default firewall)

## ✅ What It Does

- Fetches the latest IP blocklist from PebbleHost's Hunter project
- Applies blocks using `ipset` and `iptables`
- Sets up a `systemd` timer to auto-update regularly

## 📋 Check Status
```bash
systemctl status blocklist-update.timer
```

## 📕 Check Logs
```bash
journalctl -u blocklist-update.service
```

## 🗑️ Uninstalling

Run the following one-liner to get rid of hunter and it's files and configurations:

```bash
curl -fsSL https://raw.githubusercontent.com/Pixel-Services/HunterInstaller/refs/heads/main/hunter-uninstall.sh | bash
```
