#!/bin/bash

set -e

echo "🛡️  Uninstalling Pixel Services Hunter Installer"
echo "-----------------------------------------------"

echo "⏳ Stopping and disabling blocklist-update.service and blocklist-update.timer"
systemctl stop blocklist-update.timer
systemctl disable blocklist-update.timer

echo "🧹 Removing systemd service and timer files"
rm -f /etc/systemd/system/blocklist-update.service
rm -f /etc/systemd/system/blocklist-update.timer

systemctl daemon-reload

echo "🧹 Removing block.sh script from /usr/local/bin"
rm -f /usr/local/bin/block.sh

echo ""
echo "✅ Uninstall complete! All traces of the Pixel Services Hunter Installer have been removed."
echo "🔄 Systemd daemon reloaded to apply changes."
