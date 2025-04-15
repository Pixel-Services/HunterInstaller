# 🛡️ Hunter Installer

A lightweight script to automatically block known malicious IPs on Linux servers using `ipset` and `iptables`.

This tool is based on [PebbleHost's Hunter](https://github.com/pebblehost/hunter), which maintains a honeypot-driven IP blacklist.

## 🚀 Quick Install

Run this one-liner as root:

```bash
curl -fsSL https://raw.githubusercontent.com/Pixel-Services/HunterInstaller/refs/heads/main/hunter-installer.sh | bash
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
